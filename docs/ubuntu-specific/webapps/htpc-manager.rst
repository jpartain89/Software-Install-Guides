=============================
HTPC-Manager [HTPC-htpc]_
=============================

HTPC Manager is a simple, web front-end that aims to bring the different, other web front-end GUI's into one place, for ease of use across your entire home-server system.

It currently has already-coded-access to programs like CouchPotato, Sonarr, NZBGet, Transmission, Plex; as well as adding in the ability to view your hardware's performance as well.

Install Dependencies
======================

As usual, there are a few, pre-needed programs in order to make sure it builds and runs smoothly.

And, on the ``vnstat`` program. If you're installing HTPC-Manager on, say, a VM but you'd like to see stats for your HARDWARE device instead, you're in luck! Instead of installing vnStat on the same machine as HTPC-Manager, install it on the machine thats the actual hardware. You can remotely, over your network, view other vnStat instances inside of HTPC-Manager.

.. code-block:: bash

  sudo apt-get install build-essential git python-imaging python-dev python-setuptools python-pip python-cherrypy vnstat -y
  sudo pip install --upgrade psutil

Cloning and Starting
====================

HellowLoL's Git Fork
--------------------

HellowLoL's `Version`_ of HTPC-Manager is the one that I prefer to use, but its not the original fork. So, if you were to poke around a bit on GitHub, you might see some other forks and versions as well.

.. include:: ../../gitreponote.rst

So, as always, on the code below that includes locations for git, you can change as much as you want.

First, the cloning
-----------------------

.. code-block:: bash

  git clone https://github.com/Hellowlol/HTPC-Manager ~/git/htpcmanager

Notice, in the location string at the end, I changed the formatting of ``./htpcmanager`` to a nicer, easier-to-type lowercase and without dashes. This simply tends to make your Command Line Life easier in the long run if you try to manage directories in that manner. Or at least, one that works for your fingers.

Next, the Symlink
-------------------

Next, I symlink the ``~/git`` location to ``/opt``, and make sure the files are assigned to my primary user.

.. note::

  See :ref:`user_management` for notes on adjusting user permissions with regards to programs and allowing the web access to your machines.

But, either way, make sure the files are owned by the correct account. Both the symlinked, ``/opt`` location and the Original Repo, ``~/git`` location.

.. code-block:: bash

  sudo ln -s ~/git/htpcmanager /opt/htpcmanager
  sudo chown -R $USER:$USER /opt/htpcmanager
  sudo chown -R $USER:$USER ~/git/htpcmanager

Finally, Running the Program
----------------------------

And, we ``python /opt/htpcmanager/Htpc.py`` for the first time we run the program. This way we get the verbose output and see up front if there are any big errors or anything missing.

.. code-block:: bash

  sudo python /opt/htpcmanager/Htpc.py

Make sure to pay attention to the output in your terminal. And, I'd suggest you go ahead and open up your browser to view HTPCManager and poke around. This way you can also watch the output in the terminal.

The address to access is either `http://localhost:8085`_ or ``http://<ipaddress>:8085`` and exchange your machines ip address.

.. note::

  If you see any RED TEXT CherryPy errors in your terminal, those aren't death. Those are just, nicely, STANDING OUT for you to see what needs to be done.

Make sure you hit ``ctrl-C`` to stop the program in your terminal. This will send a ``SIGHUP`` signal to terminate the program as nicely as possible.

Autostart ``init.d`` Copy and Edit
==================================

You can link over the standard ``init.d`` file from the git repo directory to ``/etc/init.d`` directory location. Or you can just copy it over without the link, in case the git repo updates ever modify that file and you make your own mods.

.. code-block:: bash

  sudo cp /opt/HTPCManager/initscripts/initd /etc/init.d/htpcmanager
  sudo nano /etc/init.d/htpcmanager

Change ``APP_PATH`` to match the path of where you stuck HTPC Manager.

.. code-block:: bash

  ############### EDIT ME ##################
  # path to app
  APP_PATH=/opt/HTPCManager

Then, make the file executable and add to the ``update-rc.d`` autostart program.

.. code-block:: bash

  sudo chmod +x /etc/init.d/htpcmanager
  sudo update-rc.d htpcmanager defaults

Then, you can run ``sudo service htpcmanager start``, and access it  at `http://127.0.0.1:8085`_

.. [HTPC-htpc] Directions copied fairly liberally from HTPC Guides' `HTPC Manager Instructions`_

.. _HTPC Manager Instructions: http://www.htpcguides.com/install-htpc-manager-ubuntu-linux/
.. _Version: https://github.com/Hellowlol/HTPC-Manager.git
