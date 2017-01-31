===============
Ubuntu Specific
===============

These guides are tested and used often by me on my personal Ubuntu 16.04 Server VM's. But, since Ubuntu is based off of Debian, it wouldn't take much to be able to use these as a more generalized guide for most Debian-based systems.

I have this section broken down further into specific area's of interest:

1. :ref:`webapps` - These are programs that you have to use in the web browser to do anything with them. Normally you cannot use the terminal to run these programs, and normally they don't include a typical GUI - or to run from the desktop.
2. :ref:`downloaders` - These are guides to setup your downloading programs, such as for torrents or Usenet services. This also has my OpenVPN guide, as this is the specific machine that would need to have encrypted traffic.

  - PS. the OpenVPN guide is for setting up a client, not a server.

3. :ref:`web-server-stuff` - This is for setting up the actual web server backend. This is the reverse proxy stuff so you can map your port numbers to web addresses for easy typing and remote access.

.. toctree::

  webapps/index
  downloader/index
  web-server/index
  extras/index
  ubuntu_user
