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
