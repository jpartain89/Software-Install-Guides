=======================================
CouchPotato Movie Downloader [HTPC-CP]_
=======================================

.. include:: ../../donotuse.rst

CouchPotato is a web program, built on python, specifically tailored towards automating Movie Downloads, either through public or private torrent sites or using Usenet Services.

I honestly don't even use CouchPotato anymore, as it became a huge process hog and super slow to do everything. I personally use :ref:`Radarr`.

---------
Shoutout
---------

First, I'd like to go ahead and say that I wouldn't have been able to learn as much as I have as quickly or easily without the help of HTPCGuide's  `CP-HowTo`_.

They are an amazing site, they are slowly getting larger, and they are the real, awesome source.

-------------------
Base Requirements
-------------------

First, lets install the basic required programs to help run all-the-things

.. code-block:: bash

  sudo apt-get install git-core libffi-dev libssl-dev zlib1g-dev libxslt1-dev libxml2-dev python python-pip python-dev build-essential -y
  sudo pip install --upgrade lxml cryptography pyopenssl

.. note::

  When running pip with sudo, that then installs those specified programs globally, so the entire system has access.

  If you are using a more shared environment - where your pip install might interfere with another users python programs - its best to invoke virtualenv from within the directory you are going to save and run the main CouchPotato program from.

  This creates a virtual-like environment for installing your python programs within JUST that directory. So, if there are differing versions elsewhere, they wont clash.

  Currently, I am not using virtualenv, so that is currently outside the scope of this document.

---------------
Clone the Repo
---------------

Now, to really kick things off, we're going to first clone the github repo, as this is the - well, only way right now - to install and run the software.

But, the other big plus to this is that for running updates, not only does the program have the ability to simply run ``git pull`` or what have you from within itself, but if that isn't pulling a fresher update due to other various settings it has, YOU are able to go in and just run ``git pull`` on the CouchPotato directory.

Which, is why...

.. include:: ../../gitreponote.rst

Now, onto the cloning:

.. code-block:: bash

  git clone https://github.com/RuudBurger/CouchPotatoServer ~/git/couchpotato
  sudo ln -s ~/git/couchpotato /opt/couchpotato

Which, again, your other option is to:

.. code-block:: bash

  git clone https://github.com/RuudBurger/CouchPotatoServer /opt/couchpotato

.. note::

  See :ref:`user_management` for notes on adjusting user permissions with regards to programs and allowing the web access to your machines.

-----------------
Test if it Works
-----------------

Now, we'll run the python program just within the Command Line output, which shows all the text output, including any errors and what not.

.. code-block:: bash

  sudo python /opt/couchpotato/CouchPotato.py

This will run only as long as you allow it directly inside the terminal, and it will also give each step that the program runs, so you can see if it gives any errors or what else might need to be changed.

Then, to stop the CL output and control, hit ``ctrl-C`` to quit the program.

----------------------
Copy/Edit Default File
----------------------

.. note::

  The ``/etc/default`` is generally where a lot of programs like to keep their default settings files. Its a nice, centrally located spot that init or systemctl program files can reference when wanting a central place that a user can amend different settings, like the user that is running the program, or the directory location of different files.

So, we want to copy over the defaut ``/etc/default`` file from the github location, and then make any necessary changes.

.. code-block:: bash

  sudo cp /opt/couchpotato/init/ubuntu.default /etc/default/couchpotato
  sudo nano /etc/default/couchpotato

The below code field is not the entire file, but rather just an excerpt of items of interest.

.. include:: couchpotato_default
  :code: bash

#. ``CP_USER`` would be the system account we created earlier.
#. ``CP_HOME`` is where it runs from
#. ``CP_DATA`` is where it stores files like the metadata for your movie directory. This one I like to have stored on a mounted, shared drive. This way, if I ever need to reinstall CouchPotato, or the VM fraks up and needs to be spun fresh, the big time stuff is saved elsewhere. So, mine is ``/media/sf_Ext1/shared/couchpotato``

-----------------------------
Copy or Edit the init.d File
-----------------------------

Now, if you're running Ubuntu, the ``./init/ubuntu`` script gets copied and amended thusly:

.. code-block:: bash

  sudo cp /opt/couchpotato/init/ubuntu /etc/init.d/couchpotato
  sudo chmod +x /etc/init.d/couchpotato
  sudo update-rc.d couchpotato defaults

So the ``chmod +x`` makes the file executable - instead of running a bash script as ``bash ./script.sh``,  when you ``chmod +x`` it, you're able to just say ``./script`` and remove the .sh from the file name as well. Then, the system pulls the language from the first line, ``#!/bin/bash`` or ``#!/bin/sh`` etc.

Then, the ``update-rc.d`` inputs the startup script into the actual upstart, startup system, telling ubuntu to run it on boot - if the script wants that.

Then, you can run ``sudo service couchpotato start``, and so long as it doesn't output errors, you can now access it at `<http://127.0.0.1:5050>`_

I will have reverse-proxying stuff posted in the future, but for now you can look at `HTPCGuides <https://htpcguides.com>`_ as they have a lot of those specific how-to's.

.. [HTPC-CP] These directions were liberally copied from HTPCGuides's `CP-HowTo <https://www.htpcguides.com/install-couchpotato-ubuntu/>`_

.. _CP-HowTo: https://www.htpcguides.com/install-couchpotato-ubuntu/
