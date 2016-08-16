..  _transmission:

Transmission [TRANS-HTPC]_
=============================

Transmission is my personal fav of all the Torrent Downloaders. For one, its the easiest I've found to use and setup. For two, it has a headless program for running on a server - and comes standard with a GUI interface that way. And three, its super light weight.

Add Repo and Install
---------------------------

Add the most up-to-date repo for transmission:

.. code-block:: bash

  echo "deb http://ppa.launchpad.net/transmissionbt/ppa/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/transmission-bt.list
  echo "deb-src http://ppa.launchpad.net/transmissionbt/ppa/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/transmission-bt.list
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 365C5CA1

  sudo apt-get update && sudo apt-get install transmission-daemon transmission-cli -y

  sudo service transmission-daemon stop

The last line, ``stopping the service``, is necessary for you to be able to edit the ``settings.conf`` file. That file is silently rewritten by the ``transmission-daemon`` service, if that service is still running.

.. note::
  
  See :ref:`user_management` for notes here.

User Account Modifications
----------------------------------

Add the Transmission group to your regular user account, as well as the group that owns the directory that you will be saving the downloaded files, as this will - hopefully - prevent permission issues.

.. code-block:: bash

  sudo usermod -aG debian-transmission $USER
  sudo usermod -aG debian-transmission root

.. note::

  If you are running this inside of a VirtualBox Linux Guest, and using VirtualBox's Folder Syncing Feature... You'll notice that the group owner of those mounts is `vboxsf`. Thats only inside of your Guest OS, but will futz with transmission's ability to save anything to those directories. Make sure to also include `vboxsf` with the above commands.

Editing the ``settings.conf`` file
-----------------------------------

.. code-block:: bash

  sudo nano /etc/transmission-daemon/settings.json

The settings file is quite long with lots of options. The Most Important parts are:

``"rpc-whitelist": "0.0.0.0",`` This blocks off all but only the IP listed from accessing....

``"rpc-whitelist-enabled": true,`` This is the boolean to turn whitelisting on/off. Doesn't always take for some reason.....

.. code-block:: bash

  "rpc-whitelist": "*.*.*.*",
  "rpc-whitelist-enabled": false,

You can also change the IP address to ``192.168.1.0/34`` or whatever your home IP address ranges are, depending on what your personal security wants are.

.. code-block:: bash

  "rpc-password": "password",
  "rpc-username": "username",

Change the download-dir to where ever you want it....

``"download-dir": "/var/lib/transmission-daemon/downloads",``

This is the amount of items being downloaded at once. I usually stay at 5 max, no matter what machine I'm using.

``"download-queue-size": 5,``

For the seeding queue, I honestly lower it down to 5 as well, since I like to double the upload amount.

``"seed-queue-size": 5,``

Set umask to 002 to avoid permission issues...

``"umask": 002,``

I set the blocklist up as well. [TRANS-BlockList]_

.. code-block:: bash

  "blocklist-enabled": true,
  "blocklist-url": "http://john.bitsurge.net/public/biglist.p2p.gz",

Save the file, and restart the service.

``sudo service transmission-daemon restart``

Then, access the web GUI at `http://localhost:9091 <http://localhost:9091>`_ unless you changed that as well.

.. [TRANS-HTPC] Copied from `HTPC-Guides <http://www.htpcguides.com/install-transmission-bittorrent-client-on-ubuntu-15-x>`_ and `StackExchange's Raspberry Pi Forum on Transmission Permissions <http://raspberrypi.stackexchange.com/questions/4378/transmission-permission-denied-on-usb-disk>`_

.. [TRANS-BlockList] Transmission BlockList from 'GiulioMac's Personal Blog <https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission>'_
