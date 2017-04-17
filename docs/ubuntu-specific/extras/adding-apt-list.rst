.. _apt-get:

==========================
Adding Extra apt-get Lists
==========================

With Ubuntu, there are many different ways to add additional apt-get lists, either directly by ``sudo nano ...``, ``sudo add-apt-repository ppa:nginx/main``, etc.

Release-Specific Lists
======================

When adding an ``apt-get`` list to your system, one nice way to save your code in your notes or to automate through scripting is not by specific system names, like Ubuntu's ``xenial``,  and Debian's ``Jessie`` release names; but rather to insert code into your ``echo`` so that it works for you!

.. code-block:: bash

  echo "deb https://packages.cisofy.com/community/lynis/deb $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/cisofy-linus.list

Breakdown
----------

#. Most all apt-get ``.list`` lines begin with ``deb`` or ``deb-src``
#. Then, the html address of the library
#. Next, usually the name of the release you are using, such as ``xenial`` for 16.04 Ubuntu or ``jessie`` for Debian 8.
#. And last, there are names for the various extra sections you can discern between - ``main``, ``extras`` or whatever else the library maintainer uses.

.. note::

  The key text is ``$(lsb_release -sc)``. When you input ``$( )`` it tells bash to execute the command inside the parenthesis, and use the output inside the echo text.

PPA
===
or more of Ubuntu's Shenanigans
-------------------------------

Ubuntu seems to have a small habit of taking industry- and community-standardized processes and libraries and applications and putting - or sometimes shoving - their own special twist on things.

Take Ubuntu's `PPA`_ system. As a developer on Ubuntu's Launchpad website, you get your own PPA address, apt repository, and a central means of distributing your code to Ubuntu Users.

Its super simple to add these repo's to Ubuntu:

.. code-block:: bash

  sudo add-apt-repository ppa:nginx/main
  sudo apt-get update && sudo apt-get install $application

You'll want to always run ``apt-get update`` to pull the lists of available programs to install, and then install the additional program or to upgrade existing programs already installed

Personal Standards
==================

When I add apt-get lists that are seperate from the standard or even non-standard Ubuntu Lists and Libraries, such as NGINX's lists, nodesource lists for Node and NPM, etc., I have them in seperate, short lists.

The directory tree breakdown is as follows:

.. code-block:: bash

  /etc/apt/sources.list
  /etc/apt/sources.list.d/
  ├── mono-xamarin.list
  ├── nginx-amplify.list
  ├── nginx-ubuntu-development-xenial.list
  ├── nodesource.list
  └── ondrej-ubuntu-php-xenial.list

This way, removing specific items is MUCH easier.

.. _PPA: https://help.launchpad.net/Packaging/PPA
