==============
NGINX from PPA
==============

The PPA is Ubuntu's way of trying to make it easier to add extra repo's to the apt-get installer system. It auto-adds auth keys, along with repo addresses. And it adds a means of verifying what programs and whatnot are inside of the repo as well, since you can look up the info on Canonical's `Website`_.

NGINX's PPA
============

.. note::

  For the ``$nginx`` variable at the end of the first code line, replace it with either ``stable`` for their Stable line or ``development`` for their Mainline.
  Mainline is what they consider their "beta" line. Stable being their, well, "stable" line.

.. code-block:: bash

  sudo add-apt-repository ppa:nginx/$nginx
  sudo apt-get update && sudo apt-get install nginx

I will create a NGINX configuration "How-To" at some point in the future.

You can set the server address either inside of ``/etc/ansible/hosts`` or in a hostfile in the repo. Then, change the name of the host inside of your ansible-playbook as well.

.. _Website: https://launchpad.net
