===============
Debian / Ubuntu
===============

I use Docker heavily now, but these Debian/Ubuntu guides remain useful for host-level administration, package management, and troubleshooting.

These pages are being actively modernized for current Debian/Ubuntu workflows.

Chapters
=========

I have this section broken down further into specific area's of interest:

#. :ref:`web_server_stuff` - This is for setting up the actual web server backend. This is the reverse proxy stuff so you can map your port numbers to web addresses for easy typing and remote access.

.. note::

  This section is in need of a major overhaul, as I have changed up my NGINX processes since this was written last.

#. :ref:`apt` - These guides are specifically geared towards Debian/Ubuntu ``apt``-based installation systems, including ``dpkg``

.. toctree::

  apt-dpkg/index
  extras/index
  ubuntu_user
  docker/index
  install-issues/index

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Reframed section intro to reflect active modernization instead of legacy-only status.
  - Updated package-management wording from ``apt-get`` framing to modern ``apt`` framing.

Reason for Change
  Improve reader confidence and align section framing with current maintenance reality.

Compatibility Notes
  Section scope now explicitly targets current Debian/Ubuntu administration workflows.

Tested On
  Documentation review only (commands not executed in this repo).
