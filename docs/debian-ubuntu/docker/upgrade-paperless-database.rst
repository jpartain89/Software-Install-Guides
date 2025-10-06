==========================
Upgrade Paperless Database
==========================

When using Paperless with a PostgreSQL database, it may be necessary to upgrade the database schema when upgrading Paperless itself. This guide provides steps to safely perform the upgrade.

.. note::

  For more details, see: `Paperless broken after upgrade`_.

Correct Version:
================

Ensure you are using the correct version of PostgreSQL as required by the version of Paperless you are upgrading to. Refer to the `Paperless-NGX Official Changelog`_ for version requirements. Thought, as of the writing of this post - 10/6/2025 - the latest version of Paperless-NGX requires PostgreSQL 13 or higher.

I personally am running PostgreSQL 17 via docker compose. Previously, I was running PostgreSQL 12, which is no longer supported. Luckily there are a couple of ways to upgrade the database! Either via a: dump and then restore of the database [PostgresStackOverflow_Dump]_; via the pg_upgrade tool [docker-pgautoupgrade]_; or by exporting and then importing through Paperless-NGX itself [Paperless-NGXExportImport]_.

Database Dump/Restore
=====================

I am currently using `solariz.de - Tech & Thoughts`_ blog post `Paperless broken after upgrade`_ for the bulk of this section. Big kudos goes to them on helping me out with this issue!

Step 1: Stop Your Containers!
-----------------------------

Make sure and stop the corresponding containers that helps Paperless run.

`cd` into the directory that holds your Paperless `compose` file and `docker compose down`.

Step 2: Startup and Dump Just Your Database
-------------------------------------------

Start the old database container and then dump it to a file (it helps if your database container is ONLY for Paperless. If you're using a PostgreSQL container for multiple purposes, then this is not going to cover something that complicated). Also, the containers in my `compose` file match the directions from the official `Paperless-NGX Github`_.

While still `cd`'d into your `compose` directory:

.. bash::

  docker compose up -d db
  docker compose exec db pg_dumpall -U paperless > old_paperless_db.sql
  docker compose down



.. _Paperless broken after upgrade: https://solariz.de/posts/25/paperless-broken-after-upgrade-postgress/
.. _Paperless-NGX Official Changelog: https://docs.paperless-ngx.com/changelog/
.. _solariz.de - Tech & Thoughts: https://solariz.de/about/
.. _Paperless-NGX Github: https://github.com/paperless-ngx/paperless-ngx/blob/main/docker/compose/docker-compose.postgres-tika.yml

.. [Paperless-NGXExportImport] https://docs.paperless-ngx.com/usage/export-import/
.. [PostgresStackOverflow_Dump] https://stackoverflow.com/a/29913462
.. [docker-pgautoupgrade] https://github.com/pgautoupgrade/docker-pgautoupgrade

