==========================
Upgrade Paperless Database
==========================

When using Paperless with a PostgreSQL database, it may be necessary to upgrade the database schema when upgrading Paperless itself. This guide provides steps to safely perform the upgrade.

.. note::

  For more details, see: `Paperless broken after upgrade`_.

Correct Version:
================

Ensure you are using the correct version of PostgreSQL as required by the version of Paperless you are upgrading to. Refer to the `Paperless-NGX Official Changelog`_ for version requirements. Though, as of the writing of this post - 10/6/2025 - the latest version of Paperless-NGX requires PostgreSQL 13 or higher.

I personally am running PostgreSQL 17 via docker compose. Previously, I was running PostgreSQL 12, which is no longer supported. Luckily there are a couple of ways to upgrade the database! Either via a: dump and then restore of the database [PostgresStackOverflow_Dump]_; via the pg_upgrade tool [docker-pgautoupgrade]_; or by exporting and then importing through Paperless-NGX itself [Paperless-NGXExportImport]_.

Database Dump/Restore
=====================

I am currently using `solariz.de - Tech & Thoughts`_ blog post `Paperless broken after upgrade`_ for the bulk of this section. Big kudos goes to them on helping me out with this issue!

Step 1: Stop Your Containers!
-----------------------------

Make sure and stop the corresponding containers that helps Paperless run.

:command:`cd` into the directory that holds your Paperless `compose` file and 

.. code-block:: bash

  docker compose down

Step 2: Start and Dump Just Your Database
-------------------------------------------

Start the old database container and then dump it to a file

.. note::

  it helps if your database container is ONLY for Paperless. If you're using a PostgreSQL container for multiple purposes, then this is not going to cover something that complicated

Also, the containers in my :file:`compose` file match the directions from the official `Paperless-NGX Github`_.

While still :command:`cd`'d into your `compose` directory:

.. code-block:: bash

  docker compose up -d db
  docker compose exec db pg_dumpall -U paperless | old_paperless_db.sql
  docker compose down

Step 3: Update Your :file:`docker-compose.yml` File
---------------------------------------------

Next, we will be changing the `db` container from PostgreSQL 12 or 13 to 17, while also changing the directory the database is saving itself to.

Since we're upgrading via the dump and restore method, we have to start the new database with a new directory, else the new database will simply error out and fail to start at all.

Now, I have a habit of taking my own routes when it comes to naming my volumes in my compose files, so my `db` directory for version 17 is named :file:`pgdata_17`. :file:`/your/directory/location/paperless/pgdata_17:/var/lib/postgresql/data`.

.. code-block:: yaml

  db:
    image: postgres:17
    container_name: db
    restart: unless-stopped
    volumes:
      - ${MEDIA_ROOT}/Paperless-NG/pgdata_17:/var/lib/postgresql/data
    env_file:
      - .env
    environment:
      POSTGRES_DB: ${PAPERLESS_DBNAME}
      POSTGRES_USER: ${PAPERLESS_DBUSER}
      POSTGRES_PASSWORD: ${PAPERLESS_DBPASS}
    networks:
      - paperless

Step 4: Start the New DB, Import the Old DB and Update the Paperless User
-------------------------------------------------------------------------

Again, start just the `db` container, and since your container's environment included the :confval:`db`, :confval:`user` and :confval:`password` line items, the database should include the paperless user.

Not sure? Lets check it!

.. code-block:: bash

  docker compose up db -d
  docker compose exec db psql -U paperless -d paperless -c '\du'

And the result should show:

.. code-block:: bash

   List of roles
   Role name |                         Attributes
  -----------+------------------------------------------------------------
   paperless | Superuser, Create role, Create DB, Replication, Bypass RLS

If you got the above, then lets go ahead and perform a password reset on that user, since I and several other people have reported an issue where PostgreSQL fails to have the user with the password you chose in your compose file.

The errors we ended up seeing were this:

.. code-block:: bash

  db-1         | 2025-08-29 07:45:44.175 UTC [34] FATAL:  password authentication failed for user "paperless"
  db-1         | 2025-08-29 07:45:44.175 UTC [34] DETAIL:  User "paperless" does not have a valid SCRAM secret.
  db-1         |  Connection matched file "/var/lib/postgresql/data/pg_hba.conf" line 128: "host all all all scram-sha-256"

Now, you might be tempted to try and mess with :file:`/var/lib/postgresql/data/pg_hba.conf`, but that would introduce a security hole that is not necessary.

Make sure the password you use here is the same as what you used in your docker-compose file:

.. code-block:: bash

  docker compose exec db psql -U paperless -d postgres -c "ALTER ROLE paperless WITH PASSWORD '${PAPERLESS_DBPASS}';"

.. confval:: PAPERLESS_DBPASS
  :type: ``string`` (a *password*)

  This is the password you need to make sure matches your :file:`docker-compose.yml` file.

Step 5: Restore Your Database Dump
----------------------------------

.. code-block:: bash

  cat old_paperless_db.sql | docker compose exec -T db psql -U paperless

Step 6: Restart 'em All!
------------------------

.. code-block:: bash

  docker compose down && \
    docker compose up -d && \
    docker compose logs

You should now have a super quick output of all the logs of all of the containers related to your Paperless container. Or you can simply add :option:`-f db` to the end of the `docker compose logs` line to watch the output of your `db` container.

.. option:: -f db

  This will "follow the log output", as in it streams the log lines as they are generated, rather than just displaying the logs that were already created and then stopping.

Lastly, don't just go deleting the old directory just yet. Open Paperless, make sure its all working as expected. Then, after thorough testing and you're comfy with the outcome, then and only then can you even CONTEMPLATE removing the directory. If anything, move it to your backup folder for posterity's sake, or as a point-in-time backup that wont ever be deleted, along with the rest of your Paperless directory. 

.. _Paperless broken after upgrade: https://solariz.de/posts/25/paperless-broken-after-upgrade-postgress/
.. _Paperless-NGX Official Changelog: https://docs.paperless-ngx.com/changelog/
.. _solariz.de - Tech & Thoughts: https://solariz.de/about/
.. _Paperless-NGX Github: https://github.com/paperless-ngx/paperless-ngx/blob/main/docker/compose/docker-compose.postgres-tika.yml

.. [Paperless-NGXExportImport] https://docs.paperless-ngx.com/usage/export-import/
.. [PostgresStackOverflow_Dump] https://stackoverflow.com/a/29913462
.. [docker-pgautoupgrade] https://github.com/pgautoupgrade/docker-pgautoupgrade

