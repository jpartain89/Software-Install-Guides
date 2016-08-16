.. _ddclient:

DDClient [DDCLIENT-Source]_
==============================

Preface
----------

This guide is a bit more hands on, but is not only a good lesson to get through and learn, but ends up building a nice, very useful and light weight program!

DDClient, specifically, is a Dynamic DNS program. Through its config files, it listens for public IP address changes on the machine its running on - IPv4 specifically - and then relays that information back to your Domain Name Host - `domains.google.com <domains.google.com>`_ for example - so that, if you are self-hosting stuff attached to your url name, and its hosting from an IP address that likes to change - which consumer-based internet access will change that IP address - this handles that issue.

Plus, `domains.google.com <domains.google.com>`_ also has a specific, easier-to-use config setup for DDClient, so it makes your life just that much easier.

Software Requirements
-----------------------------

Most of what is needed usually comes with Ubuntu, like Perl and CPAN.

But, one program that is needed is ``libio-socket-ssl-perl``, specifically to assist with SSL encryptions of the ddclient traffic.

.. code-block:: bash

  sudo apt-get install libio-socket-ssl-perl

Clone the Github Repo
-------------------------

Lets start off by cloning the github repo, so you have the most up-to-date code to build with.

.. include:: ../gitreponote.rst

.. code-block:: bash

  git clone https://github.com/wimpunk/ddclient.git ~/git/ddclient

Or, like with couchpotato, you are welcome to save the git directory where ever works best for you.

Copying Files and Creating Directories
----------------------------------------------

Next, its a matter of sticking the ddclient program into the right place, creating its directories, backing up the existing configs and all that jazz.

.. code-block:: bash

  cd ~/git/ddclient/
  sudo cp ddclient /usr/sbin/
  sudo mkdir /etc/ddclient/
  sudo mkdir /var/cache/ddclient

#. So the first ``cp`` is the actual  program itself, thus why its going inside of ``/usr/sbin/``.
#. Then, creating ``/etc/ddclient`` because thats where it expects its config file.
#. Then, ``/var/cache/ddclient`` in order to save the programs caching files.

``ddclient.conf`` file
------------------------

If you already have a ``ddclient.conf`` file made - like  `domains.google.com <domains.google.com>`_, since their support files explain exactly how to make a config file just for their service - copy that over to:

``/etc/ddclient/ddclient.conf``

But, if you don't have a starting point yet, if you look in the DDClient repo files, there are several sample files of all creeds and uses. This is a good chance for you to poke around a bit and see what each one is meant for and look through your specific config file, since it will have a billion and one explanations for everything. If, you're interested.

Otherwise, most likely the service you have your URL hosted with will have a how-to specific for their service on configuring DDClient.

Then, once you have a good config file you like, save it into a github repo of your own so you have it saved, sourced, and backed up to a cloud server if anything goes awry.

Autostart
-------------

Since we're on Ubuntu, copy the ``init.d`` file over and set it up to **always** autostart:

.. code-block:: bash

  sudo cp sample-etc_rc.d_init.d_ddclient.ubuntu /etc/init.d/ddclient
  sudo chmod +x /etc/init.d/ddclient
  sudo update-rc.d ddclient defaults

So, we're copying a sample file - specifically the ``init.d_ddclient.ubuntu`` file. Obviously if you wanted to run DDClient in another fashion - like with the cron file or with the specific wrapper ``.sh`` script - you could if you were so inclined.

Then, the ``chmod +x`` makes the file executable by the sytem, and ``update-rc.d`` adds it to upstart for autostarting.

Perl/CPAN
--------------

Now, DDClient is dependent on some Perl Libraries to help it run. So, the specific Perl Library Management tool we'll be using is CPAN.

And, I believe if I am correct, Perl is a tool that comes with Ubuntu Server, along with CPAN. But, if your system isn't allowing the  ``cpan`` command to run, you can do a ``apt-cache search cpan`` and it'll show the various programs that might include it.

If Perl completely isn't installed, then

``sudo apt-get install perl``

Then, once thats done, you'll want to install the library DDClient requires:

``sudo cpan install Data::Validate::IP``

Since I don't know hardly anything about Perl other than I need it, I simply press enter through the various questions CPAN asks, since it will autofill with the defaults.

Running DDClient
-----------------------

Once you have all that taken care of, you can run ``sudo ddclient`` and it'll run it once, it'll talk to the server you have configured, and respond with output. For me, it usually tells me that my IP address is unchanged, and to run DDClient unneccessarily is considered abusive.

Which is why we use Upstart, systemctl or the wrapper script or cron job!

Now, since we added this to Upstart, type ``sudo service ddclient start`` and that script will take over the management!

.. [DDCLIENT-Source] These directions are liberally copied from `Wimpunk/DDClient's github <https://github.com/wimpunk/ddclient>`_
