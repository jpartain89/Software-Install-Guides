.. _apt-get:

==========================
Adding Extra apt-get Lists
==========================

With Ubuntu, there are many different ways to add additional apt-get lists, either directly by ``sudo nano ...``, ``sudo add-apt-repository ppa:nginx/main``, etc.

-------------------------------
The `apt-key` deprecated fiasco
-------------------------------

.. note:: tl;dr

  ``curl -sS <url to the key to download> | gpg --dearmor | sudo tee /usr/share/keyrings/<program/repo name>.gpg``

As of, I believe, the start of 2022 or 2023, everyone started getting a wonderful ``Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).`` message when updating their systems. The manual didn't provide a simple solution, for sure, and there were little to no how-to's online on what to do to mitigate this issue.

Now, though, there are a ton of "how-to's" that may or may not be accurate in handling this, as well as a few different ways to "properly" handle the signing keys that are required with installing through ``apt`` and its variants.

I have modified the rest of this document, and included explicit directions on how to download and properly list the apt repositories in your lists.

The ways
--------

Lets start with the proper way to add the key to your Debian/Ubuntu system. We'll use `Brave`_'s install directions as an example:

First, you make sure you have curl installed

.. code-block:: bash

  sudo apt install curl

Then, using curl, you pipe the URL at the end to the file location under ``/usr/share/keyrings/``.

.. note::

  There will be plenty of sites and how-to's that say you can use ``/etc/apt/keyrings`` to store your keys. While its not the "preferred" spot, its not against the rules, so to speak, so you're allowed the freedom of personal preference/whatever you find easiest.

This is only one way of downloading the key. And we're using sudo due to the file location we're dropping the gpg key to.

.. code-block:: bash

  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

Next, with this format, you have to include the "[signed-by=...]" bit in the ``apt-get`` .list file. And, it has to point to the downloaded file from above.

.. code-block:: bash

  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

  sudo apt update && sudo apt install brave-browser

Dearmor the Key... Sometimes?
------------------------------

Sometimes you have to ``dearmor`` the apt-key, if its in the incorrect format. Using the example from `itsfoss`_'s site:

.. code-block:: bash

  curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/spotify.gpg

`itsfoss`_'s site has a nifty, and detailed, way of taking keys that you add via ``apt-key``, and then export it to a file location. That was the process I used earlier for an older repo that I was trying to install from, that neither of the above methods worked for.

First, I went ahead and used the apt-key add command:

.. code-block:: bash

  curl -sS  https://download.opensuse.org/repositories/home:/Hezekiah/xUbuntu_20.04/Release.gpg | sudo apt-key add -

Then, I exported the key to its own file. first by finding the keyid:

.. code-block:: bash

  sudo apt-key list

Which gave this output:

.. code-block:: bash

  pub   rsa2048 2020-07-02 [SC] [expires: 2025-01-26]
      9D8C 3420 2C34 5C69 8A70  BF52 C609 6B07 DE3A E8C0
  uid           [ unknown] home:Hezekiah OBS Project <home:Hezekiah@build.opensuse.org>

The info we need is the last eight characters from the second line above: DE3A E8C0
Copy and paste that into the following command:

.. code-block:: bash

  sudo apt-key export DE3AE8C0 | sudo gpg --dearmour -o /usr/share/keyrings/Cockpit-Samba-AD-DC.gpg

Then, if you havent yet created the .list file, enter:

.. code-block:: bash

  echo "deb [signed-by=/usr/share/keyrings/Cockpit-Samba-AD-DC.gpg] https://download.opensuse.org/repositories/home:/Hezekiah/xUbuntu_20.04 ./" | sudo tee /etc/apt/list.d/Cockpit-Samba-AD-DC.list

And then update and install the software you want to use.

----------------------
Release-Specific Lists
----------------------

When adding an ``apt-get`` list to your system, one nice way to save your code in your notes or to automate through scripting is not by specific system names, like Ubuntu's ``Xenial``, and Debian's ``Jessie`` release names; but rather to insert code into your ``echo`` so that it works for you!

Using `NGINX`_'s directions for adding their repo to your linux server (I wont include all of the directions, as you can visit the link to see the full details):

.. code-block:: bash
  :emphasize-lines: 3

  curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

  echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/ubuntu $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list

You'll notice the use of ``$(lsb_release -cs)`` in this example, which utilizes the program ``lsb_release`` in Debian/Ubuntu in order to get the desired verbiage for your particular OS.

There are a few other means of getting the desired info, all depending on that repo's specific requirements and layout that they have chosen.

Breakdown
---------

#. Most all apt-get ``.list`` lines begin with ``deb`` or ``deb-src``
#. Then, you need to include the key's file location: ``[signed-by=/usr/share/keyrings/<filename>.gpg]`` or ``[signed-by=/etc/apt/keyring.d/<filename>.gpg]``
#. Then, the html address of the library
#. Next, usually the name of the release you are using, such as ``xenial`` for 16.04 Ubuntu or ``jessie`` for Debian 8, which in Debian/Ubuntu world is usually accessible via ``lsb_release -cs``
#. And last, there are names for the various extra sections you can discern between - ``main``, ``extras`` or whatever else the library maintainer uses.

.. note::

  The key text is ``$(lsb_release -sc)``.

.. note::

  When you input ``$( )``, it tells bash to execute the command inside the parenthesis, and use the output inside the echo text.

----
PPA
----

or more of Ubuntu's Shenanigans
-------------------------------

Ubuntu seems to have a small habit of taking industry- and community-standardized processes, libraries, and applications, and putting - or sometimes shoving - their own special twist on things.

Take Ubuntu's `PPA`_ system: as a developer on Ubuntu's Launchpad website, you get your own PPA address, apt repository, and a central means of distributing your code to Ubuntu Users.

Its super simple to add these repo's to Ubuntu:

.. code-block:: bash

  sudo add-apt-repository ppa:nginx/main
  sudo apt-get update && sudo apt-get install $application

You'll want to always run ``apt-get update`` to pull the lists of available programs to install, and then install the additional program or to upgrade existing programs already installed.

------------------
Personal Standards
------------------

When I add ``apt-get`` lists that are seperate from the standard - or even non-standard - Ubuntu Lists and Libraries, such as NGINX's lists, nodesource lists for Node and NPM, etc., I keep them in seperate, short file ``.lists``.

The directory tree breakdown is as follows:

::

  /etc/apt/sources.list
  /etc/apt/sources.list.d/
  ├── nginx-amplify.list  <------------------- NGINX`s ``Amplify``_ monitoring program
  ├── nginx-ubuntu-development-xenial.list <-- NGINX's Development repo for Ubuntu's Xenial
  ├── nodesource.list <----------------------- NPM's Repo
  └── ondrej-ubuntu-php-xenial.list <--------- `Ondrej\`s`_ PHP Repo for Ubuntu's Xenial

This way, removing specific repo items is MUCH easier.

.. _PPA: https://help.launchpad.net/Packaging/PPA
.. _Brave: https://brave.com/linux/?ref=itsfoss.com
.. _itsfoss: https://itsfoss.com/apt-key-deprecated/#you-haven-t-added-the-external-keys-yet
.. _NGINX: https://nginx.org/en/linux_packages.html#Ubuntu
.. _Amplify: https://amplify.nginx.com/
.. _Ondrej's: https://launchpad.net/~ondrej/+archive/ubuntu/php
