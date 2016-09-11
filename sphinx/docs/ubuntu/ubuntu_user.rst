.. _user_management:

User Management
---------------

Technically, for proper security and the Linux Way, you're supposed to have specific, security-neutered, non-home-directory-having users running these different programs. Helps stop any random, drive-by-login attempts, or rogue access if your password or keys were to ever get out.

So, if we want to go the right way, we would create a user that has no shell access, isn't allowed to actually log in, but is able to run programs.

.. code-block:: bash

  sudo adduser --system --group <program-name> --home <default/program-files/location> <username>

the ``<>`` blocks, replace the text and <> with your info.

So, lets break that down:

#. ``--system`` dictates that this is a system-type user account, which means that, by default, this user is:

  - placed into the ``nogroup`` group by default
  - a home directory is normally created for this user with the same rules as a normal user.
  - the new user will have the shell ``/bin/false`` set
  - and the user will have logins disabled by default.

#. ``--group`` - the man document states: "When combined with --system, a group with the same name and ID as the system user is created."
#. ``--home`` states that the location following the flag is the users home directory, which, if you already have the files there, it will display a **non-fatal** error. You can ignore it for now.

Then, after creating that user, you want to make sure the program files are owned by that user.

.. code-block:: bash

  sudo chown -R <user>:<group> /opt/files

The ``-R`` means its recursively applied. To all files.

The other thing we also want to pay attention to is whether we have external drives mounted on our system. If we are running our Linux Software in a VirtualMachine, thus changing the way items might be mounted; and we need to pay attention to what users/groups are assigned to those external drives/directories that we might need access to, in order to process/watch/download/etc. properly!

So, for running this inside of a VirtualBox instance locally, using folder mounting through VBox, they have a custom group for the file ownership in the machine, **vboxsf**. So, to allow users to have access to read-write on these directories:

.. code-block:: bash

  sudo usermod -aG vboxsf $USER

So, the -aG part is adding a user to a group by addition, not replacing. Then, the first name is the group, and the 2nd is the user.

Usually in order to have the addition take in the filesystem, you would log the user out then back in, but the system users normally don't have login/out abilities. So, its best to just restart the actual virtual machine.
