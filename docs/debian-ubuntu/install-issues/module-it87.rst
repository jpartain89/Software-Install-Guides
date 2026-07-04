===========
Module it87
===========

I was having the worst time since upgrading to Ubuntu 24.04 with trying to install the `it87`_ module for my motherboard. I was getting the error message:

.. code-block:: bash

  Skipping BTF generation for /home/jpartain89/git/it87/it87.ko due to unavailability of vmlinux

And for the life of me, I was unable to figure out where vmlinux had disappeared to or how to get it back again!

Then, I stumbled upon `Proxmoxs Forum Post`_ about a similar issue, that said to:

.. code-block:: bash

  sudo apt install dwarves
  sudo apt install build-essential dkms
  cp /sys/kernel/btf/vmlinux /usr/src/linux-headers-$(uname -r)/build

And that was it! I was able to install the module without any issues after that.

.. _it87: https://github.com/frankcrawford/it87
.. _Proxmoxs Forum Post: https://forum.proxmox.com/threads/kernel-module-not-found-when-compile-skipping-btf-generation.100974/#post-440473

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
