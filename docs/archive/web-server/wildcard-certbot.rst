=========================
Certbot WildCard SSL Cert
=========================

.. include:: ../../old-or-outdated.rst

This how-to is specific for grabbing a wildcard certificate for your domain using `Certbot`_ and `Letsencrypt`_, with `Certbot`_'s dns system. Specifically using their manual system.

It is fairly difficult to find an all-in-one how-to for getting a wildcard cert manually using `Certbot`_.

Installation
=============

Depending on the route you'd like to take, there's plenty of ways to install `Certbot`_ for use. Even the installer script listed on their site is self-updating and, obviously, the most up-to-date way to use it.

I, currently, am using the ``Stretch-Backports`` installation route rather than downloading the binary directly. Installation through the ``apt`` system sets up a few behind-the-scenes steps for automating your renewal.

Debian
--------

.. code-block:: bash

  sudo apt-get install python3-certbot-nginx

If you are using a DNS provider that has a wonderful API, like Cloudflare (which I use), you can choose to install the plugin for that API as well!

.. code-block:: bash

  sudo apt-get install python3-certbot-dns-cloudflare

This will install `Certbot`_, along with the ``nginx`` plugins through python, along with the manual DNS flag that we're planning on using here.

Setup
=======

Most everything online will give you stupidly long command lines with a TON of flags and what not. I'd much rather use a nice configuration file!

.. code-block:: bash

  # This `cli.ini` is for manually getting a wildcard cert
  manual
  preferred-challenges = dns
  cert-name = jpcdi.com
  rsa-key-size = 4096
  email = email@address.com
  logs-dir = /etc/letsencrypt/logs/
  keep-until-expiring
  expand
  # Use the ACME v2 staging URI for testing things
  #server = https://acme-staging-v02.api.letsencrypt.org/directory
  # Production ACME v2 API endpoint
  server = https://acme-v02.api.letsencrypt.org/directory
  domains = *.jpcdi.com, jpcdi.com

So, to break all that down:

Break Down
-----------

#. ``manual`` - means to run with the ``--manual`` flag that you will see in a ton of commands online
#. ``preferred-challenges`` - This is the challenge you're wanting certbot to use, which for this how to is ``dns``
#. ``cert-name`` - This is specifically referencing the SSL Certs name for the Directories themselves. If you don't pick a name here, you'll end up with A TON of directories, with a ton of numbers and names. (Unless you want that, of course. This helps with automation)
#. ``rsa-key-size`` - is just what it says, how big you want your key to be. ``2048`` or ``4096``, with ``2048`` being the default.
#. ``email`` - this is an administrative need, to stop the program from asking interactively to give them your email and what not
#. ``logs-dir`` - your logs directory
#. ``keep-until-expiring`` - Makes sure to not create a bunch of duplicate certs
#. ``expand`` - if a prior certificate already existed with one of your requested addresses, rather than overwriting that cert, it expands it with the new names you've requested to add.
#. ``server`` - This one is more specific to our DNS address requesting, as a way to make sure we are getting a wildcard certificate. They are only available through the V2 Acme Protocol, so you have to specify the address to use. I've included the testing address as well, if you want to run certbot a bunch of times and not let it count against your weekly alotment.
#. ``domains`` - This is where you include the domain addresses you want to use. Make sure you don't JUST include the wildcard, but the root of the domain as well.

Running Certbot
=================

When you use the manual DNS system, it will give you an address and TXT record that you'll need to add to your main DNS Server's addressing. It'll be a good idea to make sure you're logged into their website, or have the configuration pulled up to where you can make the addition and have it propogate out.

Luckily, the system is good and patient, willing to wait for you to take a while to get that TXT record setup.

.. _Certbot: https://certbot.eff.org/
.. _Letsencrypt: https://letsencrypt.org/
