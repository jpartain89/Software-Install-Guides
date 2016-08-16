.. _nginx_from_source:

Compiling NGINX From Source
===========================

The way listed here uses apt-get to our advantage. By adding the NGINX PPA repo, we get a baseline of required files, configuration files, and other things that make this much easier for us all! [NGINX-Copied]_

Add NGINX PPA
------------------

For the ``$nginx`` variable at the end of the first code line, replace it with either ``stable`` for their Stable line or ``development`` for their Mainline.

.. note::

  Mainline is what they consider their "beta" line. Stable being their, well, "stable" line.

.. code-block:: bash

  sudo add-apt-repository ppa:nginx/$nginx

Then, go in and remove the comment from the `deb-src` line inside the `apt/sources.list.d/nginx.list` file. The file most likely will be named something else.

Then update apt-get.

.. code-block:: bash

  sudo apt-get update

Download Source Packages
---------------------------------

Prerequisites
________________

First, we install the pre-requisites. AKA the package creation tools. This helps in building from source using apt.

.. code-block:: bash

  sudo apt-get install dpkg-dev -y

Build Directory
________________

The directory ``/opt/rebuildnginx`` is simply a potential, central location for all of the building files that we are wanting to use. You can stick it anywhere you want, name it anything you want.

.. code-block:: bash

  sudo mkdir /opt/rebuildnginx
  cd /opt/rebuildnginx

Source Files Download
_________________________

Next, running ``apt-get source`` rather than ``apt-get install`` installs the source files for the program you've listed.

.. code-block:: bash

  sudo apt-get source nginx

Install Build Dependencies
______________________________

.. code-block:: bash

  sudo apt-get build-dep nginx

If the current, main NGINX build doesn't have the specific modules that you are needing, you can add them into a specific file inside the build directory.

The detailed instructions for that specialized need is at `ServersForHackers.com <https://serversforhackers.com/compiling-third-party-modules-into-nginx>`_

Compile and Install
_____________________

.. code-block:: bash

  cd /opt/rebuildnginx/nginx-{release}
  sudo dpkg-buildpackage -uc -b

This will take around a few minutes.

Install NGINX
----------------

Once the build is complete, we'll find a bunch of ``.deb`` files added in ``/opt/rebuildnginx``. We can use these to install NGINX.

The ``full`` package, quite aptly, has the most pre-built modules. So, if thats what you're needing, concentrate on those files.

Next, you'll want to check if you're on 64bit or otherwise. If you're on 64bit, most likely you wanna use ``amd64`` files. Also, the ``dbg`` is specifically for debugging tools.

Do you have the file you wanna use? Lets install it then!

.. code-block:: bash

  sudo dpkg --install nginx-full_{ release }+trusty0_amd64.deb

Now, you can run ``nginx -V`` (capital V) and it'll show you the flags and modules and whatnot compiled with NGINX.

Block NGINX from Auto-Update
--------------------------------------

Next, mark NGINX to be blocked from further apt-get updates, as this potentially will remove the modules  you added.

.. code-block:: bash

  sudo dpkg --get-selections | grep nginx

and for every nginx component listed run:

.. code-block:: bash

  sudo apt-mark hold {component}

And from now on, make sure to watch `NGINX's <www.nginx.org>`_ opensource web page for more updates, and perform the same steps again.

.. [NGINX-Copied] These instructions are happily borrowed from `ServersForHackers.com <https://serversforhackers.com/compiling-third-party-modules-into-nginx>`_
