=========================
Some Basic Linux Commands
=========================

------------------
SSH or Remote Use
------------------

To connect to another system from your current machine, you use ``ssh``

.. code-block:: bash

  ssh user@ipaddress

My username I use is ``jpartain89``, so :

.. code-block:: bash

  ssh jpartain89@192.168.1.10

It will ask for your users password, if your ssh keys are not setup.

--------
SSH Keys
--------

SSH-Key Generate
================

To generate SSH keys:

.. code-block:: bash

  ssh-keygen -t rsa -b 2096

It will ask for location, hit ``enter`` for the standard default location.

If you want a password on this key, for extra extra security, you can type that in with the next option. Or, for no passphrase, just hit ``enter``.

Hit ``enter`` again for confirmation, or retype the password if you wanted one.

Then, it'll output the key 'randomart' image, which doesn't mean much. But, the default location is ``~/.ssh``. It'll tell you where.

SSH Key Location
================

The private key is like your front door key on your keyring. Only you have it. The public key is like the tumblers. Anyone can see it, but cannot access without your private key.

SSH-Copy-ID or Sending Your Public Key
=======================================

The public key is copied to the servers that you want to access without password input. There is a program to do that. ``ssh-copy-id``. On macOS, ``brew install ssh-copy-id``. Linux should already have it installed.

To send your public keys, you use

.. code-block:: bash

  ssh-copy-id jpartain89@192.168.1.10

Or ``ssh-copy-id`` is the program, then ``your username @ the ip address of the computer``. It'll ask for your password, then copy the keys. Then, ``ssh jpartain89@192.168.1.10`` and it should no longer ask for your password!

----------------------
Restarting the Machine
----------------------

.. code-block:: bash

  sudo shutdown -r now

So, breakdown:

#. ``shutdown`` - obviously is the shutdown program
#. ``-r`` - the -r flag is for restarting.
#. ``now`` - tells it to do it now, rather than wait. You can set times before it shutsdown or restarts, in case other users are on the machine.

------------------
Updating the Apps
------------------

.. code-block:: bash

  sudo apt-get update && sudo apt-get upgrade -y

Breakdown:

#. ``apt-get`` is the installing program that debian/ubuntu uses. Its a super simple means of installing in the terminal.
#. ``update`` - obviously runs an update. This means it downloads a list or a cache of the version numbers and states of the programs in apt-get's lists.
#. the ``&&`` means ``run this stuff after the last one succeeds successfully``
#. ``upgrade`` - this actually takes the programs installed by apt-get, and upgrades them.
#. ``-y`` - basically means ``yes, do this without asking like normal``

.. include:: ./bash-logging.rst


--------------------------
Deprecation of ``apt-key``
--------------------------

As of Ubuntu 22.04, ``apt-key`` is now warning you - very explicitly - that it is deprecated, no longer considered "secure" in its main job: making sure the apt-repos that we utilize are who they claim to be. And that the apps contained within them are "the" apps, and not hijacked by someone with ill-intent.

But, with this goes out the window the ability to easily, quickly, programmatically download all those lovely keys from their corresponding GPG Key servers out there in the cloud.

Or does it?

I finally found `this snippet on Gitlab`_ the other day, and it works wonderfully!

.. raw:: html

  <script src="https://gitlab.com/-/snippets/2320252.js"></script>

------------------------
Using DD for Backup
------------------------

.. code-block:: bash

  export DISKNAME=PUT_NAME_HERE; \
  export BLOCKSIZE=$(sudo blockdev --getsize64 /dev/sdc) && \
  sudo dd if=/dev/sdc bs=1MB | pv -s $BLOCKSIZE | gzip -9 > $DISKNAME.img.gz

.. _this snippet on Gitlab: https://gitlab.com/-/snippets/2320252
