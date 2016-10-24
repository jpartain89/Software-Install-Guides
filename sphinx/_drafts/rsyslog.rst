=======
Rsyslog
=======

This guide is on how to setup and use rsyslog to create a central logging server for your computers, routers - basically anything IT that saves logs that you have root access to.

Why do this? So you have all of your logs in one, central place! This way, yuo don't have to log into each individual machine to view logs, or even to see if something is wrong! If you simply peruse the logs every so often, or even install a program or sign up for a cloud service to monitor logs for you, you can often cut off a potentially catastrophic issue at the head.

Installation
============

I believe that rsyslog comes installed on most linux distributions, but don't quote me on that one...

.. code-block:: bash

  sudo apt-get install rsyslog

Central Host
============

To setup your rsyslog receiving server, you have to tell it to accept the messages on a certain port (which, for rsyslog you don't really wanna change, since things like routers don't always allow you to adjust that.) and to where you want those logs saved at.

.. code-block:: bash

  sudo nano /etc/rsyslog.conf

Then, the second section should be ``MODULES``. I have ``imuxsock`` and ``imklog`` uncommented, along with ``imudp`` ``imudp port=514`` which is the receiving parts for UDP ports, and then the TCP ports are next with ``imtcp`` and ``imtcp port=514``.

Then, above the global section, these three lines set to where you want your logs saved.

.. code-block:: bash

  $template RemoteLogs,"/media/sf_Ext1/syslog/%HOSTNAME%/%PROGRAMNAME%.log" *
  *.* ?RemoteLogs
  & ~

For the global section, I have RepeatedMsgReduction on.

And thats it for the central server.

Sender Machines
===============

For the machines sending in the logs, I'll be adding just two lines, at the bottom of the file:

.. code-block:: bash

  #Defining the Central Log Server
  *.* @<receiver_IP>:514

The address can either be a local IP, or even a FQDN of a local or remote server
