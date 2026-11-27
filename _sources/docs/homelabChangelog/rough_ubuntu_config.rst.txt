=======================
My Rough Configuration
=======================

Dell Desktop
============

Running my `linux.yml` ansible playbook, initially, against `commit e489da0dc2dc949e2d668064773c424f67574fd0 <https://gitlab.com/jpartain89/first-steps_linux/-/commit/e489da0dc2dc949e2d668064773c424f67574fd0>`_.

Installed tailscale using ``curl -fsSL https://tailscale.com/install.sh | sh`` and then started it with an auth key, then enabled ssh.

Blocking all traffic other than tailscale from entering the system with 


For my "Behemouth"
==================

For adding in the IT87 driver to Ubuntu, you want to use the `it87`_ kernel module.

For using your graphics card inside Docker, start with the NVIDIA Container Toolkit docs (`nvidia-docker`_ legacy name).

I cannot think of much anything else currently that I need to manually modify.... Just look over your starred github repos for inspiration...

.. _it87: https://github.com/frankcrawford/it87
.. _nvidia-docker: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
