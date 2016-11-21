======================
Domotz on Raspberry Pi
======================

Domotz is the new owner of Fingbox, the popular program that made IP detection on your network super super simple. Domotz has been slowly adding additional features to their service as well. [DOM-PI]_

Install Domotz
==============

To install the Domotz agent onto the monitoring hardware:

.. code-block:: bash

  wget https://portal.domotz.com/download/agent_packages/domotz-raspberry-armhf-1.1.2-276.deb
  sudo dpkg -i domotz-raspberry-armhf-1.1.2-276.deb

Since we're installing onto a pi, it honestly will take a bit, up to several minutes, for it to build, configure, and get started.

Once its done, it'll show you the port number you can hit up the activation page on.

Activation
===========

You're also able to use the iPhone app, if on the same network, to add the device to your account as well. Super Easy!

.. [DOM-PI] See `Domotz.com <domotz.com>`_ for more info.
