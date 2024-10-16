=============================================
Tautulli (previously PlexPy) [HTPC-Tautulli]_
=============================================

.. include:: ../../donotuse.rst

Tautulli is specifically for monitoring Plex. Plus, you can setup notifications so you can see when Plex adds files, has updates, items are played and stopped and what not, as well as if you have any friends or family who have access.

It also gives you a breakdown of what is played the most, how many concurrent streams have played at the same time, and a bunch of other things as well.

---------------
Prerequisites
---------------

Python2.7 is the biggy here.

.. code-block:: bash

  sudo apt-get install python2.7 python-pip python-dev git git-core

--------------
Clone the Repo
--------------

.. include:: ../../gitreponote.rst

So, of course, you can amend the ending to the below code to wherever you want the repo to sit inside your system.

.. code-block:: bash

  git clone https://github.com/Tautulli/Tautulli ~/git/tautulli

.. note::

  If you previously installed this git repo before, you'll notice that the entire repo and app name has changed from PlexPy to Tautulli. Both python scripts exist in the beta line of the repo. (Plexpy.py and Tautulli.py) So its really up to you on which naming scheme you want to use, currently. This info - obviously - will change in a future (unknown) update.

---------------------
Edit the Default File
---------------------

Now, you want to:

.. code-block:: bash

  sudo touch /etc/default/tautulli

The ``/etc/default`` directory is where a LOT of programs like to store files that make adjustments from the defaulted norm of their programs. Items like the User that the system will run the program under. Or where the program will store ``.pid`` files, log files, etc.

That will make sure to stop any possible errors or warnings. It also is where you need to make any changes, in case you don't use the default settings that are in the various init scripts. You can see the options inside of ``./tautulli/init-scripts/init.ubuntu`` if you're using Ubuntu.

---------------------
Create Tautulli User
---------------------

Next, I do like to create and use a seperate, ``tautulli`` user for running Tautulli.

.. note::

  See :ref:`user_management` for notes on adjusting user permissions with regards to programs and allowing the web access to your machines.

  But, use the ``adduser`` line below instead of from the :ref:`user_management` doc

.. code-block:: bash

  sudo adduser --system --group tautulli --no-create-home tautulli

---------------------------------
Change Ownerships and Symlink
---------------------------------

First, we will change the ownership of the original location we stuck the repo at.

.. code-block:: bash

  sudo chown -R tautulli:tautulli ~/git/tautulli

Next, we symlink from our ``git`` location to ``/opt``.

.. note::

  ``/opt`` seems to be the favorite location to install the directories for WebApps in general - CouchPotato, NzbDrone (aka sonarr), userify, HTPCManager - all like this location. Its a comfy, familiar place to have these files.

.. code-block:: bash

  sudo ln -s ~/git/tautulli /opt/tautulli

-------------------------
Testing the Program First
-------------------------

First, we want to, basically, blindly run ``tautulli`` to see if any settings files need adjusting or anything in our systems.

So, we do:

.. code-block:: bash

  sudo python /opt/tautulli/Tautulli.py

This will start Tautulli where it will output all of its startup functions, like when you turn on a linux machine, to the console so you can see any errors right there.

----------------------
AutoStart System Files
----------------------

Next, we will perform a few different commands to add Tautulli to Ubuntu's autostart system - so that the program starts at boot correctly, and runs nicely in the system.

init.d
=======

The ``/etc/init.d`` directory is where the autostart scripts are stored. Thus, why I call them the ``init.d`` files. There is also a ``/etc/init`` location for Upstart scripts, which... Ubuntu seems to like to change their autostart programs every so often. And to add ontop of that, the base Debian system has THEIR own means, that is even useable inside Ubuntu - systemctl.

But, in most programs that you use git to install on your system, AND they include autostart files for you, often times the ``init.d`` based scripts will be referenced as just ``init``, making the whole thing slightly more complex. The best way to know for sure if its ``init.d`` or ``init`` based? Just edit the file and take a look!

If the file looks like this:

.. include:: sonarr_init.txt
  :code: bash

then its an ``init.d`` file. Specifically with the ``###### BEGIN INIT INFO`` block of text.

But, if it looks like this:

.. include:: tautulli-upstart
  :code: bash

Then thats an ``init`` upstart file. Much shorter, and without all that required text at the top.

But, for now, we use ``/etc/init.d`` and the commands ``sudo service`` since its what I know to how to use.

Make ``init.d`` file Executable
---------------------------------

First, we need to make the ``init.d`` file executable by the system. This basically changes the way the script is called, while still being a bash shell script. Its how the system can use ``/etc/init.d`` files without having to use ``bash`` or ``sh`` in the terminal command - or even ANY file thats technically a script without first calling the scripts program/compiler in the command line.

.. code-block:: bash

  sudo chmod +x ~/git/tautulli/init-scripts/init.ubuntu

The ``chmod`` is modifing the access flags for the file. The ``+x`` means 'add the executable flag'. There is also ``+w`` and ``+r`` which is write and read, in that order. And, there is another way to change that information as well. But thats for another document.

Link or Copy
--------------

Then, link the ``init.ubuntu`` file to ``/etc/init.d``. Notice that, in the ``/etc/init.d`` part, we changed the files name.

.. code-block:: bash

  sudo ln -s ~/git/tautulli/init-scripts/init.ubuntu /etc/init.d/tautulli

Update Ubuntu's Autostart Program
---------------------------------

And now we add Tautulli to the autostart system that Ubuntu uses, ``update-rc.d`` being the command to add it. If you want to remove it, you run ``sudo update-rc.d tautulli remove`` AFTER deleting the ``tautulli`` file from ``/etc/init.d``.

.. code-block:: bash

  sudo update-rc.d tautulli defaults
  sudo service tautulli start

SystemCTL
=========

If you want to use Ubuntu/Debian's newest startup system, SystemCTL (`systemctl` being the command), follow these instructions.

.. note::

  I am in no way fully learned in how to utilize this newest startup system, nor do I know all of the proper places to store these startup files. But what follows is what has worked for me.

These files do not need to be flagged as executable, as the ``init.d`` scripts did from above. I believe, in fact, that it possibly will throw an error message if you do so.

If you want to look at some example files, the ``/lib/systemd/system`` directory is where the files are stored.

Link or Copy
--------------

Tautulli's premade ``systemd`` script is located at ``~/git/tautulli/init-scripts/init.systemd``. Of which, there are some items you'll probably want to change, depending on your setup.

With ``systemd``, you are able to include using a ``defaults`` file, like the ``init.d`` files from above, but I was unable to get that to work properly here.

To link the existing file from Tautlli's repo on your filesystem:

.. code-block:: bash

  sudo ln -s ~/git/tautulli/init-scripts/init.systemd /lib/systemd/system/tautulli.service

making sure to add the ``.service`` to the end of the name.

Update ``SystemCTL``'s Autostart Program
------------------------------------------

And now, adding the service file to ``systemctl`` system, you use:

.. code-block:: bash

  sudo systemctl daemon-reload
  sudo systemctl enable tautulli.service

The ``systemctl`` command has a bunch of command line options. If you want to dive into how to use it, you can ``man systemctl`` to start you down the rabit hole.

The above command will actually create another symlink from ``/lib/systemd/system`` to ``/etc/systemd/system``, which enables the service script to run.

Accessing
=========

Now, you can access the web interface at `http://localhost:8181 <http://localhost:8181>`_ with ``8181`` being the port it is running on.

.. [HTPC-Tautulli] These instructions were copied, mostly, from the original DrZoidberg33's GitHub Repo, but he no longer manages this, it seems. So, you can look at `Tautulli's Github <https://github.com/Tautulli/Tautulli>`_
