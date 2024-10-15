=============================================
Boot your Raspberry Pi from an External USB
=============================================

Tired of using an SD card for your raspberry pi? Have you found them to be incredibly unstable, forcing you to reinstall the OS from scratch all the time? Using write-intensive tasks, such as running a database, or a webserver with a ton of logfiles??

Got unused hard drives laying around?

Then stop using that SD Card and start using an external hard drive!

------------
First Steps
------------

Basically, you're going to run through most of these steps just like you would the SD Card: hooking it up to a computer, copying over the OS's files (through, say, `dd` or `ddrescue`), plugging it into your Raspberry Pi and powering up.

Some OS's sometimes need a little bit of extra TLC to make the hard drive approach work correctly, though, and can be a pain to get right. Make sure to do your homework as to which OS's are available for your particular Pi and if they can even be installed on an external drive.

Debian/Raspberry Pi OS's
============================

When using Debian or Raspberry Pi OS's, its the simplest of processes, as you can follow the same steps as the SD Card steps.

First, you'll want to `Download the version you want to use`_. Their website now has three different versions posted, two with the Desktop stuff (GUI) and one that they call `Lite`, or command line-only - essentially the server version, which is the one I use.

Next, their `Basic Installation`_ steps say to download and use `Raspberry Pi Imager`_ to to install the OS onto whatever medium you want to install it on.

.. _Download the version you want to use: https://www.raspberrypi.com/software/operating-systems/

.. _Basic Installation: https://www.raspberrypi.com/documentation/computers/getting-started.html

.. _Raspberry Pi Imager: https://www.raspberrypi.com/software/
