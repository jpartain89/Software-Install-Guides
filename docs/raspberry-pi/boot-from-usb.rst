===========================================
Boot your Raspberry Pi from an External USB
===========================================

Tired of using an SD card for your raspberry pi? Have you found them to be incredibly unstable, forcing you to reinstall the OS from scratch all the time? Using write-intensive tasks, such as running a database, or a webserver with a ton of logfiles??

Got unused hard drives laying around?

Then stop using that SD Card and start using an external hard drive!

------------
First Steps
------------

Basically, you're going to run through most of these steps just like you would the SD Card: hooking it up to a computer, copying over the OS's files (through, say, DD or DDRescue), plugging it into your Raspberry Pi and powering up.

Some OS's sometimes need a little bit of extra TLC to make the hard drive approach work correctly, tho, and can be a pain to get right.

Debian/Raspbian OS's
====================

When using Debian or Raspbian OS's, its the simplest of processes, as you can follow the same steps as the SD Card steps.

First, you'll want to `Download the version you want to use`_. Their website now has three different versions posted, two with the Desktop stuff (GUI) and one that they call `Lite`, or command line-only - essentially the server version, which is the one I use.

Next, their `Basic Installation`_ steps say to download and use `balenaEtcher`_ to copy the files, but I"m not sure if it'll work with an external hard drive instead of an SD Card. Otherwise, there are specific steps depending on the OS you are using to download and copy.

Linux/Unix-Based OS



.. _Download the version you want to use: https://www.raspberrypi.org/downloads/raspbian/

.. _Basic Installation: https://www.raspberrypi.org/documentation/installation/installing-images/README.md

.. _balenaEtcher: https://www.balena.io/etcher/
