.. _lvm:

==========
LVM How To
==========

This how to, for now - like all the others - is more for my remembering how to do something, and as I learn more about ``LVM``, I'll try to add those nuggets here.

---------------
Old Hard Drive?
---------------

Do you have an old drive that you need to erase and reformat? There are several ways to erase a disk on debian-based systems, but we'll use good old :program:`fdisk` for this one.

Like above, you wanna run ``sudo lsblk`` or ``sudo fdisk -l`` to find where your drive is located. Then, use that designation for the next commands:

.. code-block:: bash

  sudo fdisk /dev/<drive_label>

Next, you'll want to use :kbd:`d` to delete all of the partitions, using the command for as many partitions are on the drive.

.. image:: images/fdisk-delete.png
  :alt: fdisk Delete Command
  :align: center
  :scale: 50%

Then, you can use the :kbd:`p` command to print the current table.

------------------
Cleaned Hard Drive
------------------

These steps are for a fresh hard drive, either brand new or freshly erased, and we'll be using :program:`fdisk` once again.

.. code-block:: bash

  sudo fdisk -l

This command lists the hard drives that the OS can find, whether actually mounted or not. And, it outputs a LOT of information. An alternative command  you can use, that I usually prefer:

.. code-block:: bash

  sudo lsblk

This one is really great for if you already have drives mounted somewhere, so you can keep your bearings on which drives are what. Example output below:

.. code-block:: bash

  NAME                MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
  sda                   8:0    0   1.8T  0 disk
  └─sda1                8:1    0   1.8T  0 part /media/server1
  sdb                   8:16   0   1.8T  0 disk
  └─sdb1                8:17   0   1.8T  0 part /media/server2
  sdc                   8:32   0 465.8G  0 disk
  ├─sdc1                8:33   0   456G  0 part /
  └─sdc2                8:34   0   9.8G  0 part [SWAP]
  sdd                   8:48   0   1.8T  0 disk
  └─sdd1                8:49   0   1.8T  0 part
    └─mdusa-externals 252:0    0   2.7T  0 lvm  /media/mdusa
  sde                   8:64   0 931.5G  0 disk
  └─sde1                8:65   0 931.5G  0 part
    └─mdusa-externals 252:0    0   2.7T  0 lvm  /media/mdusa
  sr0                  11:0    1  1024M  0 rom

Next, you'll use the ID of the drive in the command:

.. code-block:: bash

  sudo fdisk /dev/<disk_id>

This starts :program:`fdisk` with your disk selected. If you want to see all of the commands, :kbd:`m` is the help option.

We are wanting to add a new partition, so type :kbd:`n` and press enter, and then select :kbd:`p` for ``primary``.  Next, it'll ask for the sector locations of where you want the partitions to exist. You'll notice that the program gives you a default selection to choose from. For the sector locations, you can choose the default options that :program:`fdisk` provides, pressing :kbd:`enter` to keep going.

Next, you'll use the :kbd:`t` option, which changes the partition type/id. In here, there is a super long list of options, and how you select the id can change from version to version, so you'll need to list the options.

.. include:: fdisk-l.rst
  :code: bash

The id you're wanting to pick from here is ``Linux LVM``, which with the above options is :kbd:`8e`.

And, finally, use :kbd:`w` to write all of these changes to the drive, and then :program:`fdisk` exits you out.

------------
LVM Commands
------------

Now, we start using the actual commands for ``LVM``.

LVM Physical Volume
===================

First, before we make the ``Volume Group``, we need to finish working on the freshly wiped hard drive.  You'll need to run :command:`pvcreate` to finish that off.

.. code-block:: bash

  sudo pvcreate /dev/<disk_id>

It'll most likely throw a warning saying that an ``existing ext4 signature was detected. Are you sure you want to continue?`` Enter :kbd:`y` to confirm, and it formally formats it correctly for you to be able to use it in an LVM Volume Group.

Volume Group
=============

We need to create the ``Volume Group`` first:

.. code-block:: bash

  sudo vgcreate <pool_name> /dev/<disk_label>

Replace the ``<pool_name>`` with the name you want to use. I like to use the computer's host name as the volume name, as I usually only have one volume on my systems.

Logical Volume
==============

Next, we create the logical volume that LVM will use. This is the individual volumes within the group, like partitions on a hard drive.

.. code-block:: bash

  sudo lvcreate -l 100%FREE -n <volume_name> <pool_name>

Lets break this down a bit:

#. :kbd:`-l` : This option is for selecting the size of the volume. There are several different options not only within the :kbd:`-l` flag, but there is also a :kbd:`-L` flag for using a specific size, like ``3G`` for 3 GBs. To get a handle on this info, its best to start looking at :program:`lvcreate` s :program:`man` page. The :kbd:`100%FREE` option here is telling the program to use all available free space.
#. :kbd:`-n` : this is  for saving the volume's name.
#. Then, you finish it off with the ``<pool_name>`` from earlier.

Filesystem
==========

And, finally, we have to format an actual file system inside the volume.

.. code-block:: bash

  sudo mkfs -t <filesystem> /dev/<pool_name>/<volume_name>

Here, the location of the Volume Group and Logical Volume are within the ``/dev`` directory. But, the first time you run this command, the normal bash-completion might not yet have this location ready for you, so you'll need to type out the entire location.

Mount Point
===========

Now, create the mount point and mount the volume!

.. code-block:: bash

  sudo mkdir <your_mount_point>
  sudo mount /dev/<pool_name>/<volume_name> <your_mount_point>

So, from now on, you are able to reference just the ``volume_name`` for however many hard drives you place within your volume.
