=========================
NGINX Basic Password Auth
=========================

This sets up a basic authorization popup, blocking access to either the entire NGINX server or specific locations, depending on where you put the calling options in your NGINX configuration.

There are a couple of options for the authentication process, using either the simple, htpasswd process or installing/compiling an extra module to tie into another authentication system.

------------
``htpasswd``
------------

Install the ``htpasswd`` Program
================================

First, the program we will be using is inside of the ``apache2-utils`` item on apt. I know, I know... We are using NGINX to try to stay away from Apache2, or at least thats my general mindset - one day I'll accept Apache, and use NGINX as the proxy in front of it... BUT, the ``apache2-utils`` only installs what we are needing, and not the general apache server.

.. code-block:: bash

  sudo apt-get install apache2-utils

Creating/Adding Usernames/Passwords
===================================

Then, you want to call ``htpasswd``, which will create a file that will include, per line:

.. code-block:: bash

  username:hashedpassword

The passwords in this file are hashed in a specific way through ``htpasswd``, so even if someone has access to seeing the contents, can't see the password. So, when you input the password in the popup box, it hashes that password, and compares that info. THATS why a complicated password is IMPORTANT...

So, we will:

.. code-block:: bash

  sudo htpasswd -c /etc/nginx/.htpasswd username

The ``-c`` flag tells it that you are creating a new file, in that specific location and with the name ``.htpasswd``

Then, to add more usernames, or alternative CaSeS of usernames (because evidently htpasswd is case-sensitive...) you would call it thusly

.. code-block:: bash

  sudo htpasswd /etc/nginx/.htpasswd UserName

Making sure you use the existing filename, so you are adding onto whats already there.

Updating NGINX Configuration
============================

There are two lines you want to add to your nginx configurations:

.. code-block:: bash

  auth_basic "Enter whatever you want here";
  auth_basic_user_file /etc/nginx/.htpasswd;

#. So, the text after ``auth_basic`` can be whatever you want, but this will show on the popup for the username/password.
#. Then, the ``auth_basic_user_file`` is where and which ``htpasswd`` file you want to be using.

I put these lines in specific ``location`` blocks, so I can block off certain areas and apps. You can place these lines in the general ``server`` block, to block off your enter site. And, this pops before any other loading occurs in NGINX. As in, any proxy loads don't occur yet. Only the call to .htpasswd occurs, after entering your username and password.

--------
Auth Pam
--------

There are a series of `modules`_ that exist for NGINX, built by either NGINX themselves or by the community at-large, that are all amazing!

This one, `ngx_http_auth_pam_module`_, is one I've been using myself on my own server, and ties in with my instructions on :ref:`nginx-from-source`.

First Steps
===========

First, you want to clone their git repo locally, either in your traditional ``~/git/`` location or within the ``/tmp`` directory you use to build the rest of your NGINX program.

When compiling NGINX, make sure to include an ``--add-module=$PATH_TO_MODULE`` option, pointing at the git repo's directory - not the ``.c`` file itself - to compile this into your NGINX build. At which point you proceed through the make and install steps.

Configuration
=============

There are two directives you use with this module:

- ``auth_pam``: This is whats called the "Authentication Realm". Like other parts of NGINX (cache, and what not) you can use different so-called "realms" for different things. Essentially, a name goes here.
- ``auth_pam_service_name``: This is the pam-specific service name, by default its ``nginx``

Examples
--------

For this, I will be liberally copying and pasting from `sto's github page`_:

To protect everything under ``/secure`` you will add the following to the nginx.conf file:

... code-block:: bash

  location /secure {
      auth_pam "Secure Zone";
      auth_pam_service_name "nginx";
      }

.. Note::
  The module runs as the web server user, so the PAM modules used must be able to authenticate the users without being root; that means that if you want to use the ``pam_unix.so`` module to autenticate users you need to let the web server user to read the ``/etc/shadow`` file, if that does not scare you (on Debian like systems you can add the ``www-data`` user to the shadow group).

I personally have a separate, so-called "snippets" file that I have this configuration block saved into:

.. code-block:: bash

  # Using Pam Auth
  auth_pam "Secure Zone";
  auth_pam_service_name "nginx";

  allow 10.0.100.0/24;
  allow 192.168.1.0/24;
  satisfy any;

And to use it, I use NGINX's `include`_ directive:

.. code-block:: bash

   include /etc/nginx/snippets/basic-auth.conf;

inside of any part that I want behind a password, such as:

.. code-block:: bash

  /anysite {
      .. code goes here ..;
      include /etc/nginx/snippets/basic-auth.conf;
  }

That then puts ``/anysite`` behind the basic HTTP authentication pop-up, but utilizing the ID's and Passwords saved on the local OS.

.. _modules: https://www.nginx.com/resources/wiki/modules/
.. _ngx_http_auth_pam_module: https://github.com/sto/ngx_http_auth_pam_module
.. _include: http://nginx.org/en/docs/ngx_core_module.html#include
.. _sto's github page: https://github.com/sto/ngx_http_auth_pam_module#Examples
