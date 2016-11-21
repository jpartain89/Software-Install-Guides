==================
Ratom [RATOM-src]_
==================

Basically, this is a way of using the text editor, `Atom.io <atom.io>`_ remotely to edit files.

Say you are working from your regular computer, and remotely ``ssh`` into another machine, and you need to edit a text file, and you just know deep down that if you were able to use a full text editor, rather than VIM or NANO in the terminal, it'd be SO MUCH EASIER!

Thats where ratom comes in.

First, when you SSH, instead of the normal commands, you forward a port from the remote machine to your local machine. In the case of ratom, its ``52698``. Then, you would run the prior installed ``ratom`` command on the remote machine, on the text file you want to edit. ``ratom /etc/init.d/couchpotato`` At which point it then opens that file remotely from the server to your local machine inside of Atom, as if it was local!

Installing Ratom
================

First, in order to pipe the text file over that port into your local atom, you have to install a program to handle it on the remote machine.

.. code-block:: bash

  sudo curl -o /usr/local/bin/ratom https://raw.githubusercontent.com/aurora/rmate/master/rmate
  sudo chmod +x /usr/local/bin/ratom

SSHing with Forwarded Ports
===========================

Then, exit that ssh session, and then reconnect with the port forwarded:

.. code-block:: bash

  ssh -R 52698:localhost:52698 user@example.com

What this line is saying is:

1. ``-R`` - Forward the following port FROM the remote machine to my local machine

  - the opposite would be an ``-L`` flag

2. ``52698:localhost:52698`` - map the remote 52698 port to my local 52698 port, from the remotes ``localhost``, and not another address.
3. and then your username and server address.

Running ratom on the Server
===========================

Once you're reconnected, you can open the file from the remote system onto your local Atom by:

.. code-block:: bash

  ratom /etc/init.d/couchpotato

So, the ``ratom`` command is the program, and then the text file.

.. [RATOM-src] These directions are copied from `randy3k/remote-atom <https://github.com/randy3k/remote-atom>`_
