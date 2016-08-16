.. _plexpy:

PlexPy [HTPC-PlexPy]_
=====================

PlexPy is specifically for monitoring Plex. Plus, you can setup notifications so you can see when Plex adds files, has updates, items are played and stopped and what not, as well as if you have any friends or family who have access.

It also gives you a breakdown of what is played the most, how many concurrent streams have played at the same time, and a bunch of other things as well.

Prerequisites
---------------

Python2.7 is the biggy here.

Next, is ``git-core``

Thats all that DrZoidberg33's wiki tells us.

Clone the Repo
------------------

.. include:: ../gitreponote.rst

So, of course, you can amend the ending to the below code to wherever you want the repo to sit inside your system.

.. code-block:: bash

  git clone https://github.com/drzoidberg33/plexpy.git ~/git/plexpy

Edit Startup Files
--------------------

Now, you want to:

.. code-block:: bash

  sudo touch /etc/default/plexpy

That will make sure to stop any possible errors or warnings. It also is where you need to make any changes, in case you don't use the default settings that are in the various init scripts. You can see the options inside of ``./plexpy/init-scripts/init.ubuntu`` if you're using ubuntu.

Create PlexPy User
-----------------------

Next, I do like to create and use a seperate, ``plexpy`` user for running plexpy.

Of which, read up on :ref:`user_management`

.. code-block:: bash

  sudo adduser --system --no-create-home plexpy

If you want the breakdown of this line of code, see :ref:`user_management`

Change Ownerships and Symlink
---------------------------------------

First, we will change the ownership of the original location we stuck the repo at.

.. code-block:: bash

  sudo chown -R plexpy:nogroup ~/git/plexpy

Next, we symlink from our ``git`` location to ``/opt``.

``/opt`` seems to be the favorite location to install the directories for WebApps in general - CouchPotato, NzbDrone (aka sonarr), userify, HTPCManager - all like this location. Its a comfy place to have these files.

.. code-block:: bash

  sudo ln -s ~/git/plexpy /opt/plexpy

AutoStart System Files
---------------------------

Next, we will perform a few different commands on system autostart files.

Make init file Executable
___________________________

First, we need to make the init file executable by the system. This basically changes the way the script is called, while still being a bash shell script. Its how the system can use ``/etc/init.d`` files without having to use ``bash`` or ``sh`` in the terminal command.

.. code-block:: bash

  sudo chmod +x ~/git/plexpy/init-scripts/init.ubuntu

Then, link the ``init.ubuntu`` file to ``/etc/init.d``. Notice that, in the ``/etc/init.d`` part, we changed the final filename!

``sudo ln -s ~/git/plexpy/init-scripts/init.ubuntu /etc/init.d/plexpy``

And now, we add plexpy to the autostart system that ubuntu uses, ``update-rc.d`` being the command to add it. If you want to remove it, you run ``sudo update-rc.d plexpy remove`` AFTER deleting the ``plexpy`` file from ``/etc/init.d``.

.. code-block:: bash

  sudo update-rc.d plexpy defaults
  sudo service plexpy start

Now, you can access the web interface at `http://localhost:8181 <http://localhost:8181>`_ with ``8181`` being the port it is running on.

.. [HTPC-PlexPy] These instructions are copied, mostly, from `DrZoidberg33's GitHub Repo <https://github.com/drzoidberg33/plexpy.git>`_
