=========================
Random Collection of Info
=========================

This page is a decent place for me to put my collection of information like shell scripting one liners, or little nuggets of "this-isn't-enough-to-warrant-an-entire-solo-page-but-is-important-enough-to-document" type of ites.

Using ``find`` to ``chmod`` multiple files
===========================================

When you find yourself needing to change a plethora of items within the current working directory - but only the files or directories and not both - one way is to use ``find``

.. code-block:: bash

  find . -type f -exec chmod 644 {} \;

Break Down
----------

#. ``find`` - this is obviously the specific program/command here. It is an incredibly useful tool, but we're only covering a small portion of its abilities here.
#. ``.`` - the ``.`` signifies we're searching in the current working directory, or if you typed ``pwd``, its the same idea. You can change this to any location in your directory you so choose.
#. ``-type f``
