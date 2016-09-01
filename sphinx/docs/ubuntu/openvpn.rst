=======================
OpenVPN [PIA-VPN]_
=======================

OpenVPN is basically the defacto standard for open source VPN software. You are able to both connect to other VPN servers OR make your own, private VPN service.

Install
=========

.. code-block:: bash

  sudo apt-get install openvpn unzip

PIA OpenVPN Files
==================

PIA is `Private Internet Access <https://www.privateinternetaccess.com>`_, a widely used and referenced VPN service for the fact that they advertise themselves as one of the more secure and anonymous VPN services on the internet. `This page <https://www.privateinternetaccess.com/pages/browse-anonymously/>`_ is a good jump-off point for explaining their services and why you need a VPN.

The OpenVPN files are configuration files tailored to be used with OpenVPN for PIA, making that ENTIRE setup SO much easier!

Download and uncompress the PIA OpenVPN profiles:

.. code-block:: bash

  wget https://www.privateinternetaccess.com/openvpn/openvpn.zip
  unzip openvpn.zip -d openvpn

Make sure you include the ``-d`` flag, as it'll just uncompress into the current directory, flinging files all over it.

Copy the Files
===============

Copy the PIA OpenVPN certificates and profile to the OpenVPN configuration location.

.. note::

  I'm using `Japan.ovpn` as an example location. You can/should change that to whichever location you want to use.

.. code-block:: bash

  sudo cp openvpn/ca.rsa.2048.crt openvpn/crl.rsa.2048.pem /etc/openvpn/
  sudo cp openvpn/Japan.ovpn /etc/openvpn/Japan.conf

You'll notice I changed the file extension from ``.ovpn`` to ``.conf``. OpenVPN likes ``.conf`` files.

Create the Login File
===================

Create ``/etc/openvpn/login`` containing only your username and password, one per line. Of which, PIA randomly creates your username and password, which is extra-awesome for both security and anonymity ::

  user12345678
  MyGreatPassword

Change the permissions on this file so only the root user can read it, keeping anyone else from snooping. ::

  sudo chmod 600 /etc/openvpn/login

Edit the Config File
==================

Setup OpenVPN to use your stored username and password by editing the the config file for the VPN location, as well as our ``ca`` and ``crl`` files.::

  sudo nano /etc/openvpn/Japan.conf

Change the following lines:

==================  ======
From This            To This
==================  ======
ca ca.crt            ca /etc/openvpn/ca.rsa.2048.crt
auth-user-pass      auth-user-pass /etc/openvpn/login
crl-verify crl.pem  crl-verify /etc/openvpn/crl.rsa.2048.pem
==================  ======

Test VPN
===========

At this point you should be able to test that the VPN actually works.

Running it this way outputs the program info, as its running, into the terminal prompt. This way, you see up front without hunting in the logs for if/when/where there is any issues.::

  sudo openvpn --config /etc/openvpn/Japan.conf

If all is well, you'll see something like: ::

  sudo openvpn --config /etc/openvpn/Japan.conf
  Sat Oct 24 12:10:54 2015 OpenVPN 2.3.4 arm-unknown-linux-gnueabihf [SSL (OpenSSL)] [LZO] [EPOLL] [PKCS11] [MH] [IPv6] built on Dec  5 2014
  Sat Oct 24 12:10:54 2015 library versions: OpenSSL 1.0.1k 8 Jan 2015, LZO 2.08
  Sat Oct 24 12:10:54 2015 UDPv4 link local: [undef]
  Sat Oct 24 12:10:54 2015 UDPv4 link remote: [AF_INET]123.123.123.123:1194
  Sat Oct 24 12:10:54 2015 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
  Sat Oct 24 12:10:56 2015 [Private Internet Access] Peer Connection Initiated with [AF_INET]123.123.123.123:1194
  Sat Oct 24 12:10:58 2015 TUN/TAP device tun0 opened
  Sat Oct 24 12:10:58 2015 do_ifconfig, tt->ipv6=0, tt->did_ifconfig_ipv6_setup=0
  Sat Oct 24 12:10:58 2015 /sbin/ip link set dev tun0 up mtu 1500
  Sat Oct 24 12:10:58 2015 /sbin/ip addr add dev tun0 local 10.10.10.6 peer 10.10.10.5
  Sat Oct 24 12:10:59 2015 Initialization Sequence Completed

With the ``Initialization Sequence Completed`` being the most important.

Exit this with ``ctrl+C``

Setup OpenVPN's Autostart Configuration
===========================================

Edit the ``/etc/default/openvpn`` file::

  sudo nano /etc/default/openvpn

Next, since I use only the one ``.conf`` file,  I uncomment the ``AUTOSTART-"all"`` line. If you have a different setup, go through and make those changes.

Then, to start the service: ::

  sudo service openvpn start

Then, to check that my public-facing IP address has changed - since I usually am running this on a headless machine as a downloader - I have an alias assigned in one of my dotfiles. Of which, my breakdown of dotfiles is:

  - aliases
  - bash_profile
  - bashrc
  - exports
  - functions
  - gitconfig
  - gitignore
  - profile

So, my ``.aliases`` file is, well, my aliases that I use. So, for checking my public-facing IP address: ::

  alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"

Add that to either your ``.aliases`` or ``.bash_profile`` or ``.bashrc`` file, whichever you are currenty using, and source the file. It adds the alias entry to the active session.

Then, type ``pubIP`` and hit enter. You should get your public IP address.

.. [PIA-VPN] Copied from the bottom half of `Superjamie's gist <https://gist.github.com/superjamie/ac55b6d2c080582a3e64>`_
