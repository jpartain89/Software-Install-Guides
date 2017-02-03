======================================
Auto-starting VirtualBox VMs on macOS
======================================

First, we need to copy - or rather, link - over the VirtualBox-provided default .plist file - aka: what macOS uses as their "services" files. Or, in comparison, like Linux's /etc/init.d/ files or the like.

This how-to was lightly copied over from `ReidRansom's Gist <https://sh.jpcdi.com/2k8DdmM>`_.

Linking The .plist
==================

.. code-block:: bash

  sudo ln -s  \
    "/Application/VirtualBox.app/Contents/MacOS/org.virtualbox.vboxautostart.plist" \
    /Library/LaunchDaemons/

There is another directory that has similar files - ``/Library/Application Support/VirtualBox/LaunchDaemons/`` - but those don't seem to like to work properly... So, we're ignoring those.

.. note::

  In case you aren't sure, the extra  - \ - is how you tell the linux command line "Don't run this code yet, even though I am pressing enter or return!". Its basically a newline-signifier. You'll notice it way way more often in how-to's, where it is an attempt to break up the code so its easier to see, visually, for you.

Edit The .plist
===============

And next we make our edits to ``/Library/LaunchDaemons/org.virtualbox.vboxautostart.plist``

The default option ``Disabled`` is set to ``true``, so even if launchctl loads it mistakenly, it wont work. So, therefore, that needs to be changed to ``false`` to activate it.

#. Set ``Disabled`` to ``false``
#. Adding ``KeepAlive`` and ``<true/>``
#. Adding ``<string>--start</string>`` after the ``.sh`` line
#. Set ``RunAtLoad`` to ``true``
#. Set ``LaunchOnlyOnce`` to ``true`` - which this one is probably the 2nd most self-explanatory line.

My personal .plist file looks like this:

.. code-block:: bash

  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
  <dict>

    <key>Disabled</key>
    <false/>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>org.virtualbox.vboxautostart</string>
    <key>ProgramArguments</key>
    <array>
      <string>/Applications/VirtualBox.app/Contents/MacOS/VBoxAutostartDarwin.sh</string>
      <string>--start</string>
      <string>/usr/local/etc/vbox/autostart.cfg</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>LaunchOnlyOnce</key>
    <true/>

  </dict>
  </plist>


AutoStart.cfg File
==================

Now, different online how-to's  elsewhere often say to make a directory within your ``/etc`` directory. But, if you are a user of Homebrew, you'll likely know that, often times, the better location for user-used files of most any kind would prefer to reside inside of ``/usr/local``. The reason for this, as the directory names suggest, is more geared towards the users specific files, binaries, configuration files, etc.

Often times, on a mac system, programs that normally on a Linux machine would stick their files within ``/etc``, instead, use the ``/usr/local/etc`` location. One reason for this is the more lax permissions set for these locations. Plus, Apple has publicly stated that this directory is more or less hands off from their constant meddling when it comes to updates for the system. Therefore, your files are much more likely to remain untouched by the OS.

Now, the ``autostart.cfg`` file that we are creating here is specifically geared towards managing user permissions in relation to if the VirtualMachines will autostart upon that specific user logging into the system. So, if you have more than one user, and they don't use VirtualBox, or you don't WANT them to autostart boxes, you can deny them that access.

So, first, create the ``vbox`` directory: ``mkdir /usr/local/etc/vbox``

And then:

.. code-block:: bash

  nano /usr/local/etc/vbox/autostart.cfg

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

File Permissions
================

And now, we need to go through and make sure the different files permissions are set properly.

.. code-block:: bash

  sudo chmod +x /Applications/VirtualBox.app/Contents/MacOS/VBoxAutostartDarwin.sh
  sudo chown -R root:wheel /usr/local/etc/vbox
  sudo chown -R root:wheel /Library/LaunchDaemons/org.virtualbox.startup.plist

.. note::

  You'll notice I used the ``-R`` flag for the final item, even though it itself is just a file. But, remember, its a linked file, which do not change their permissions on the linked location without the ``-R`` flag.

VBoxManage modifyvm
===================

And, now we need to run ``VBoxManage`` to change the settings for the VirtualMachines that we want to start at boot.

Which, there is almost a literal ton of settings, commands and options you can set through the command line, of which the large majority of them you'll never see in the GUI program. Why? I have no clue.

.. code-block:: bash

  VBoxManage modifyvm "$VM_NAME" --autostop-type acpishutdown
  VBoxManage modifyvm "$VM_NAME" --autostart-enabled on

#. The first line specifies how VirtualBox should try to shut the machines down, if they are still running when the system starts shutting itself down. ``acpishutdown`` corresponds to sending the machine a ``acpipowerbutton`` shutdown command. Which is to say, the normal means of properly shutting down a machine. You can also select ``disabled``, ``savestate`` or ``poweroff``.
#. The second line is the actual option for telling VirtualBox that "this VirtualMachine we want to autostart."

And make sure to replace ``$VM_NAME`` with your VirtualMachines registered names.

Testing
========

Finally, we can now test our configs without having to restart our machine.

.. note::

  Before running this, make sure your machines are turned off, so you can watch them turn on.

.. code-block:: bash

  sudo launchctl load /Library/LaunchDaemons/org.virtualbox.startup.plist

At this point, it should begin running, which you should be able to watch from within your Activity Monitor.
