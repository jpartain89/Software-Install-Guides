=====================
Access Control Lists
=====================

OR

--------------------
Default Permissions
--------------------

This is a how-to specifically for 'ACL's or 'Access Control Lists'. These dictate the default Username, Groupname, and/or permissions that apply to the top directory and back down, as you so choose. This is awesome for when you mount secondary hard drives, or will be using a directory as a shared folder and need unified permissions beyond the built-in simple linux permissions.

-----
tl;dr
-----

.. code-block:: bash

  sudo setfacl -Rdm u:usernamehere:rwx /path/to/file
  sudo setfacl -Rm u:usernamehere:rwx /path/to/file
  sudo setfacl -Rdm g:groupnamehere:rwx /path/to/file
  sudo setfacl -Rm g:groupnamehere:rwx /path/to/file

:command:`setfacl` is to set the acl.
:command:`-R` is for recursively acting on all files from ``/path/to/dir`` down
:command:`d` is for default, setting the defaults first time round
:command:`m` is for "modifying" the acl

Setting the ``default`` flag first changes the default behavior of new files or directories to be created below the directory you're modifying.

.. code-block:: bash

  sudo setfacl -Rdm u:usernamehere:rwx /path/to/file
  sudo setfacl -Rdm g:groupnamehere:rwx /path/to/file

Then, to make sure all files, recursively, receive the update, run it again without the ``d`` option in the command flag.

.. code-block:: bash

  sudo setfacl -Rm u:usernamehere:rwx /path/to/file
  sudo setfacl -Rm g:groupnamehere:rwx /path/to/file

And to read the ACL, you simply use ``getfacl /path/to/file``.

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Page reviewed for modernization baseline and footer standardization setup.

Reason for Change
  Standardize per-page change tracking and prepare for phased documentation modernization.

Compatibility Notes
  Not Applicable (administrative documentation footer addition).

Tested On
  Documentation review only.
