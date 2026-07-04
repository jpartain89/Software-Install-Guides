=========================
Some Basic Linux Commands
=========================

------------------
SSH or Remote Use
------------------

To connect to another system from your current machine, you use ``ssh <user>@<ipaddress>``.

My username I use is ``jpartain89``, so ``ssh jpartain89@192.168.1.10``.

It will ask for your users password, if your ssh keys are not setup.

--------
SSH Keys
--------

SSH-Key Generate
================

To generate SSH keys, use ``ssh-keygen -t ed25519``.

If you need RSA for compatibility with older systems, use ``ssh-keygen -t rsa -b 4096``.

It will ask for location, hit :kbd:`enter` for the standard default location.

If you want a password on this key, for extra extra security, you can type that in with the next option. Or, for no passphrase, just hit :kbd:`enter`.

Hit :kbd:`enter` again for confirmation, or retype the password if you wanted one.

Then, it'll output the key 'randomart' image, which doesn't mean much. But, the default location is :file:`~/.ssh`. It'll tell you where.

.. admonition:: SSH Key Location

  The private key is like your front door key on your keyring.
  Only you have it.
  The public key is like the tumblers inside the lock.
  Anyone can see it, but cannot access without your private key.

SSH-Copy-ID or Sending Your Public Key
=======================================

The public key is copied to the servers that you want to access without password input. There is a program to do that: ``ssh-copy-id``. macOS and Linux should already have it installed.

To send your public keys, you use ``ssh-copy-id <username>@<address>``.

When run for the first time, it'll most likely ask for the remote machine's password, then copy over the keys currently loaded into SSH's keyring.

----------------------
Restarting the Machine
----------------------

``sudo reboot`` is the simplest standard command to restart.

.. note::

  If you need scheduled restart behavior, use ``shutdown -r <time>``

------------------
Updating the Apps
------------------

.. code-block:: bash
  :caption: update.example.sh
  :name: update.example.sh

  sudo apt update && sudo apt upgrade -y

Breakdown:

#. ``apt`` is the common interactive package command on modern Debian/Ubuntu systems.
#. ``update`` tells apt to download/create a cache of package metadata.

#. the ``&&`` means ``run this stuff after the last one succeeds successfully``
#. ``upgrade`` - this actually takes installed programs and upgrades them.
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

.. rubric:: Update Changelog

Changed On
  2026-07-04

Summary of Updates
  - Updated SSH key generation guidance to modern ``ed25519`` defaults.
  - Added a compatibility RSA example using ``rsa -b 4096``.
  - Replaced ``shutdown -r now`` with ``reboot`` for clarity.
  - Replaced ``apt-get`` update/upgrade examples with ``apt`` usage.

Reason for Change
  Align core Linux command examples with current security and package-management best practices.

Compatibility Notes
  Commands are aligned with modern Debian/Ubuntu releases; RSA fallback is included for legacy SSH compatibility.

Tested On
  Documentation review only (commands not executed in this repo).
