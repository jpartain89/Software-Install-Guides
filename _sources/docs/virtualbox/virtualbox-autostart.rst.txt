====================
VirtualBox AutoStart
====================

You should have a ``default`` file inside of ``/etc/default`` for virtualbox.

 ``sudo nano /etc/default/virtualbox``

If this is your first time editing this file, it should be blank. This file is sourced by any number of VirtualBox's autostart files/scripts/etc. that the program utilizes at any one time.

Then you will insert:

.. code-block:: bash

  VBOXAUTOSTART_DB=/etc/vbox
  VBOXAUTOSTART_CONFIG=/etc/vbox/autostart.cfg

- ``VBOXAUTOSTART_DB`` which contains an absolute path to the autostart database directory
- ``VBOXAUTOSTART_CONFIG`` which contains the location of the autostart config settings.

------------------
AutoStart.cfg File
------------------

Linux Autostart
================

As we referenced above inside of your ``/etc/default/virtualbox`` file, we need a corresponding ``/etc/vbox/autostart.cfg`` file now, as well as a directory at ``/etc/vbox``

If ``/etc/vbox`` is not created:

.. code-block:: bash

  sudo mkdir -p /etc/vbox

And then:

.. code-block:: bash

  sudo nano /etc/vbox/autostart.cfg

Now, the ``autostart.cfg`` file that we are creating here is specifically geared towards managing user permissions in relation to if the VirtualMachines will autostart upon that specific user logging into the system. So, if you have more than one user, and they don't use VirtualBox, or you don't WANT them to autostart boxes, you can deny them that access.

VirtualBox states that its best to have a "Deny by Default" setup. Even with just one single user on your machine, its basically a nice, peace of mind that, even if you ever add another user, nothing hanky will occur with VirtualBox.

And, of course, you can also use ``allow`` in lieu of ``deny``, if you so choose.

.. code-block:: bash

  default_policy = deny

  berto = {
      allow = true
      startup_delay = 30
  }

The ``startup_delay`` line is a means of controlling whether your Virtual Machines attempt to start exactly with the system or delayed, in seconds, afterwards. Which, I have it set to a 30 second delay, so it isn't competing with the rest of the bulk of the startup items.

And, of course, make sure to change ``berto`` to the username on your system that the VirtualMachines are running under.

-----------------
File Permissions
-----------------

And now, we need to go through and make sure the different files permissions are set properly.

Linux File Permissions
======================

.. code-block:: bash

  sudo chgrp vboxusers /etc/vbox
  sudo chmod 1775 /etc/vbox

Then, for each username you will be using for the AutoStart:

.. code-block:: bash

  sudo usermod -aG vboxusers $USER

-----------------------
``VBoxManage modifyvm``
-----------------------

Now we need to run ``VBoxManage`` to change the settings for the VirtualMachines that we want to start at boot.

Which, there is almost a **literal** ton of settings, commands and options you can set through the command line, of which the large majority of them you'll never see in the GUI program. Why? I have no clue.

Make sure the guest machine you're changing settings on is not currently running, and enable the "autostart" option.

.. code-block:: bash

  VBoxManage modifyvm "$VM_NAME" --autostop-type acpishutdown
  VBoxManage modifyvm "$VM_NAME" --autostart-enabled on

#. The first line specifies how VirtualBox should try to shut the machines down, if they are still running when the system starts shutting itself down. ``acpishutdown`` corresponds to sending the machine a ``acpipowerbutton`` shutdown command. Which is to say, the normal means of properly shuttin the actual option for telling VirtualBox that "this VirtualMachine we want to autostart."
#. And make sure to replace ``$VM_NAME`` with your VirtualMachines registered names.

--------
Testing
--------

Finally, we can now test our configs without having to restart our machine.

.. note::

  Before running this, make sure your machines are turned off, so you can watch them turn on.

.. code-block:: bash

  sudo service vboxautostart-service start

At this point, your configured guest VM's should begin running. You can test what VM's are running by the command:

.. code-block:: bash

  VBoxManage list runningvms
