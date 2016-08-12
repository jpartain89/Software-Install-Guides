.. _sonarr:

Sonarr Installation
====================

Sonarr (old name was NzbDrone, which you will still see everywhere. Even in their startup file...) is, honestly, my favorite of all of the HTPC Apps. Even moreso than Plex because Plex can really be a huge resource hog.

The day that Sonarr really hopped into my all time fav basket was when I had began downloading a TV show outside of Sonarr. Then, when I had started adding it to Sonarr, it started searching through my directories I had inputted into its settings as a possible final download location, found the files, moved them into their correct, final spot, renamed and everything. Without missing a beat.

Its not without its issues, of course. But they often get fixed quickly, or they aren't with this program, but another site or service.

Base Requirements
-----------------------------

Make sure apt-transport-https is installed:

.. code-block:: bash

  sudo apt-get install apt-transport-https

Add the Apt Source and Install
-----------------------------------

Luckily, here, they have a repo we can add to our apt-get lists (of which I always have seperate list files for the "outside of ubuntu/debian" standards) so we get to have easy updates and whatnot.

First, gotta add the key, then the repo, and then update and install!

.. code-block:: bash

  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
  echo "deb https://apt.sonarr.tv/ master main" | sudo tee -a /etc/apt/sources.list.d/sonarr.list

  sudo apt-get update && sudo apt-get install nzbdrone -y

Now, you'll notice there was a TON of apps installing here... Don't panic. This is because Sonarr - aka NzbDrone here - is actually ran using an .exe file! Can you believe it?!? But, there is an open source program called mono that, I believe if the program is compiled for it only, can we run .exe's here! So that was all the Mono modules installing.

But, now we need to run Sonarr, with it outputting the actual output to your shell. This way, you can easily spot any errors, read when it tells you to fix something. Plus, its honestly cool to watch that output live as you click around in a program.

First Run
-------------

.. code-block:: bash

  sudo mono /opt/NzbDrone/NzbDrone.exe

Now, to stop the program, `ctrl-C` sends the SIGHUP signal to try to gracefully quit the program.

Create Autostart init.d File
-------------------------------

Now, we need to make the autostart file, of which one is not supplied by the installer. I also didn't have much luck with the ones listed on their `github site <https://github.com/Sonarr/Sonarr/wiki/Autostart-on-Linux>`_. But the text below was coped from `HTPCGuides.com site <http://www.htpcguides.com/install-nzbdrone-ubuntu/>`_, [HTPC-Sonarr]_ which has served me very well.

First, use your fav text editor on:

.. code-block:: bash

  sudo nano /etc/init.d/nzbdrone

You'll notice the big `EDIT ME` text in there. Take a looksee, make your edits as you see fit.

.. include:: sonarr_init.txt
  :code: bash

.. include:: ubuntu_user.rst

Add to Autostart Program
--------------------------------

Then, make the script executable and add to your autostart program. In the below example, its using Ubuntu's ``system <program> start`` program.

.. code-block:: bash

  sudo chmod +x /etc/init.d/nzbdrone
  sudo update-rc.d nzbdrone defaults

Final Steps
--------------

Then, start the program with ``sudo service nzbdrone start`` and if you see no error codes - which for some reason Ubuntu 16 wont always show on init.d scripts... Check your HTOP processes to see if its running. If not, ``sudo service nzbdrone status`` - then the program should be running.

You can see it at `http://localhost:8989 <http://localhost:8989>`_ if its running on the same machine as your browser. Otherwise put in the machines IP address instead of ``localhost``.

.. [HTPC-Sonarr] These directions were liberally copied from `HTPCGuides.com <http://www.htpcguides.com/install-nzbdrone-ubuntu>`_
