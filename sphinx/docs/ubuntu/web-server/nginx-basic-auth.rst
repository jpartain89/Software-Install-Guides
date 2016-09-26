=========================
NGINX Basic Password Auth
=========================

This sets up a basic authorization popup, blocking access to either the entire NGINX server or specific locations, depending on where you put the calling options in your NGINX configuration.

Install the ``htpasswd`` program
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
