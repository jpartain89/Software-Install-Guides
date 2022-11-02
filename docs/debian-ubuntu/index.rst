===============
Debian / Ubuntu
===============

My old guides have now been archived, since I've moved on to using Docker for most everything at this stage.

I'm still in the process of rewritting my how-to's around my use of docker.

Take the rest of these with the knowledge that they are old.

I have this section broken down further into specific area's of interest:

#. :ref:`webapps` - These are programs that you have to use in the web browser to do anything with them. Normally you cannot use the terminal to run these programs, and normally they don't include a typical GUI - or to run from the desktop.

#. :ref:`web_server_stuff` - This is for setting up the actual web server backend. This is the reverse proxy stuff so you can map your port numbers to web addresses for easy typing and remote access.

#. :ref:`apt` - These guides are specifically geared towards Debian's ``apt-get``-based installation systems, including ``dpkg``

.. toctree::

  apt-dpkg/index
  web-server/index
  extras/index
  ubuntu_user
