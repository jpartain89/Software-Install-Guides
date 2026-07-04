=======================
My Rough Configuration
=======================

For adding in the IT87 driver to Ubuntu, you want to use the `it87`_ kernel module.

For using your graphics card inside Docker, start with the NVIDIA Container Toolkit docs (`nvidia-docker`_ legacy name).

I cannot think of much anything else currently that I need to manually modify.... Just look over your starred github repos for inspiration...

.. _it87: https://github.com/frankcrawford/it87
.. _nvidia-docker: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Updated GPU-container wording to current NVIDIA Container Toolkit terminology.

Reason for Change
  Reduce confusion from deprecated ``nvidia-docker`` naming.

Compatibility Notes
  Guidance targets current NVIDIA Container Toolkit workflows.

Tested On
  Documentation review only (commands not executed in this repo).
