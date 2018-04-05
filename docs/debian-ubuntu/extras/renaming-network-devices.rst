.. _renaming-network-devices:

========================
Renaming Network Devices
========================

So, as of Ubuntu 16.04, or rather 15 something, they changed up their naming schemes for the network devices, coming up with some crazy names.

.. code-block:: bash

  en3p0b or something.....

Not easy like the old school ``eth0`` was...

Well, I found the specific info from `AskUbuntu`_ specifying how to change this!

How To
=======

First, get your devices MAC address, by running ``ip link``

The output will show something similar to:

.. code-block:: bash

  3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DORMANT group default qlen 1000
        link/ether 20:68:9d:xx:xx:xx brd ff:ff:ff:ff:ff:ff

The important info is after ``link/ether``, with 5 ``:`` between 6 sets of 2 numbers. Thats the devices MAC address.

.. code-block:: bash

  20:68:9d:xx:xx:xx

Next, we need to create a new file, ``/etc/udev/rules.d/10-network.rules``.

.. note::

  Obviously, if you are already using other ``.rules`` inside of ``/etc/udev/rules.d/``, you know - hopefully - what naming schemes are needed or know where to look. This info is beyond this current page.

So, use your fav text editor:

.. code-block:: bash

  sudo nano /etc/udev/rules.d/10-network.rules

Add the following line, replacing ``aa:bb:cc:dd:ee:ff`` after ``ATTR{address}`` with your devices MAC address and ``etho`` after ``NAME`` with the name that YOU want to use, in lieu of what the devices name is currently.

.. code-block:: bash

  SUBSYSTEM=="net", ACTION=="add", ATTR{address}=="aa:bb:cc:dd:ee:ff", NAME="eth0"

Then, the best way to make it appear is to simply restart your machine.

.. _AskUbuntu: http://askubuntu.com/a/690603
