===========
Changelog
===========

Ran my ansible `linux.yml` playbook.

Baseline for this log: Ubuntu 24.04 LTS (Noble) unless otherwise stated.

Install `hishtory`_ using:

.. code-block:: bash

  curl https://hishtory.dev/install.py | python3 -
  hishtory init $YOUR_HISHTORY_SECRET


2025-07-05: jpserver:

.. code-block::bash

  sudo apt install libpam-ssh-agent-auth
  Reading package lists... Done
  Building dependency tree... Done
  Reading state information... Done
  The following NEW packages will be installed:
    libpam-ssh-agent-auth
  0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
  Need to get 110 kB of archives.
  After this operation, 249 kB of additional disk space will be used.
  Get:1 http://us.archive.ubuntu.com/ubuntu noble/universe amd64 libpam-ssh-agent-auth amd64 0.10.3-8 [110 kB]
  Fetched 110 kB in 1s (87.0 kB/s)
  Selecting previously unselected package libpam-ssh-agent-auth:amd64.
  (Reading database ... 209083 files and directories currently installed.)
  Preparing to unpack .../libpam-ssh-agent-auth_0.10.3-8_amd64.deb ...
  Unpacking libpam-ssh-agent-auth:amd64 (0.10.3-8) ...
  Setting up libpam-ssh-agent-auth:amd64 (0.10.3-8) ...
  Processing triggers for man-db (2.12.0-4build2) ...
  Scanning processes...
  Scanning processor microcode...
  Scanning linux images...

  Running kernel seems to be up-to-date.

  The processor microcode seems to be up-to-date.

  No services need to be restarted.

  No containers need to be restarted.

  No user sessions are running outdated binaries.

  No VM guests are running outdated hypervisor (qemu) binaries on this host.


.. code-block:: bash

  sudo visudo

.. note::

  Added to `visudo` file:
  Defaults env_keep += "SSH_AUTH_SOCK"

.. code-block:: bash

  sudo nano /etc/pam.d/sudo

.. note::

  Added to `/etc/pam.d/sudo` file:
  auth sufficient pam_ssh_agent_auth.so

.. _hishtory: https://hishtory.dev/

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Added explicit Ubuntu baseline version context for this changelog.

Reason for Change
  Reduce ambiguity about which distro/version this changelog entry applies to.

Compatibility Notes
  Entries are primarily based on Ubuntu 24.04 LTS behavior.

Tested On
  Documentation review only.
