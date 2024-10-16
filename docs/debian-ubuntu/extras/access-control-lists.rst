=====================
Access Control Lists
=====================

OR

--------------------
Default Permissions
--------------------

This is a how-to specifically for whats called ACL's or Access Control Lists. These dictate the default Username, Groupname, and/or permissions that apply to the top directory and back down, as you so choose. This is awesome for when you mount secondary hard drives, or will be using a directory as a shared folder and need unified permissions.

-----
tl;dr
-----

.. code-block:: bash

  sudo setfacl -Rdm u:usernamehere:rwx /path/to/file
  sudo setfacl -Rm u:usernamehere:rwx /path/to/file
  sudo setfacl -Rdm g:groupnamehere:rwx /base/path/members/
  sudo setfacl -Rm g:groupnamehere:rwx /base/path/members/

:command:`setfacl` is to set the acl.
:command:`-R` is for recursively acting on all files from ``/whatever/file`` down
:command:`d` is for default, setting the defaults first time round
:command:`m` is for "modifying" the acl

Then, to make sure all files, recursively, receive the update, run it again without the d
    