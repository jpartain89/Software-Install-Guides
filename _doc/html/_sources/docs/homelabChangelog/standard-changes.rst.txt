=================
Standard Changes
=================

These are the same changes/updates/modifications I always make to my systems, almost universally across all OS's. If there's any deviation per-OS, I'll make sure to have it notated.


After Installation
===================

Immediately after installing any OS, I sign in first, as I do not have any pre-seeding - or MDM for Apple devices - setup for any of my OS's at this time. 

I make sure to have my personal user account, `jpartain89`, created and at least present on the system. 

I then create a `sudoers` file at `/etc/sudoers.d/jpartain89` using the line:

.. code-block:: bash

  sudo su
  nano /etc/sudoers.d/jpartain89

that contains the following:

.. code-block:: bash

  jpartain89 ALL=(ALL) NOPASSWD: ALL

After saving the file, I then use `chown root:root /etc/sudoers.d/jpartain89` to confirm the appropriate ownership, else it could bork all of sudoers, and end up borking the entire OS. 

SSH Keys
=========

I then exit the system, and copy over my `ssh` keys from whichever computer I am using at the time, which is typically just my MacBook Air.

.. code-block:: bash

  rsync -avhP ~/.ssh/ ${new_computer}:~/.ssh/
  ssh ${new_computer}

The 2nd line is to test out if my copying of my keys worked.

Ansible
=======

This then paves the way for my ansible playbooks to run.
