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

  sudo nano /etc/sudoers.d/jpartain89

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

TODO: Complete the ansible documentation

3/6/2026: Installing SmallStep:

.. code-block:: bash

  sudo sh -c 'apt-get update && apt-get install -y --no-install-recommends curl gpg ca-certificates
  curl -fsSL https://packages.smallstep.com/keys/apt/repo-signing-key.gpg -o /etc/apt/keyrings/smallstep.asc
  cat << EOF > /etc/apt/sources.list.d/smallstep.sources
  Types: deb
  URIs: https://packages.smallstep.com/stable/debian
  Suites: debs
  Components: main
  Signed-By: /etc/apt/keyrings/smallstep.asc
  EOF
  chmod 644 /etc/apt/keyrings/smallstep.asc /etc/apt/sources.list.d/smallstep.sources
  apt-get update && apt-get -y install step-cli step-ca'

Then, add a step-ca system user:

.. code-block:: bash

  sudo useradd --user-group --system --home /etc/step-ca --shell /bin/false step


.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Page reviewed for modernization baseline and footer standardization setup.

Reason for Change
  Standardize per-page change tracking and prepare for phased documentation modernization.

Compatibility Notes
  Not Applicable (administrative documentation footer addition).

Tested On
  Documentation review only.
