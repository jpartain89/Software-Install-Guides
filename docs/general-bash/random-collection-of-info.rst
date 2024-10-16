=========================
Random Collection of Info
=========================

- :ref:`find-chmod-files`: Use ``find`` to ``chmod`` ONLY files
- :ref:`awk_out`: Using ``awk`` to manipulate some output - small amount of examples
- :ref:`using-forwardslash`: Example of using the ``\`` to signify a return carriage to a line of commands - IE keep processing as if its one line
- :ref:`shell_script_self`: bash line to assign the current location of the bash script to a variable.
- :ref:`sed_edit` : Using ``sed`` to update the same text in multiple files.

This page is a decent place for me to put my collection of information like shell scripting one liners, or little nuggets of "this-isn't-enough-to-warrant-an-entire-solo-page-but-is-important-enough-to-document" type of ites.

.. _find-chmod-files:

--------------------------------------------
Using ``find`` to ``chmod`` multiple files
--------------------------------------------

When you find yourself needing to change a plethora of items within the current working directory - but only the files or directories and not both - one way is to use ``find``

.. code-block:: bash

  find . -type f -exec chmod 644 {} \;

Break Down
==========

#. ``find`` - this is obviously the specific program/command here. It is an incredibly useful tool, but we're only covering a small portion of its abilities here.
#. ``.`` - the ``.`` signifies we're searching in the current working directory, or if you typed ``pwd``, its the same idea. You can change this to any location in your directory you so choose.
#. ``-type f``

.. _awk_out:

------------------------------
Using ``awk`` to Modify Output
------------------------------

When a program outputs information in a standardized way, like ``pip freeze`` or ``pip list``, you can manipulate that output to fit your wants and needs.

So, lets take ``pip list``, below is a truncated output.

.. code-block:: bash

  alabaster (0.7.9)
  ansible (2.2.0.0)
  appnope (0.1.0)
  argh (0.26.2)
  astroid (1.4.8)
  Babel (2.3.4)

You can also see ``pip freeze`` has its own means of outputting info. Each command has its own reasons.

.. code-block:: bash

  alabaster==0.7.9
  ansible==2.2.0.0
  appnope==0.1.0
  argh==0.26.2
  astroid==1.4.8
  Babel==2.3.4

But, lets say we want to pipe all of that to a :ref:`pip-requirements-file` for easy updating/reinstallation. If you're using said file for updates/upgrades, having the included version numbers would not help at all here, since ``pip install -r requirements`` would install those specific versions.

So, what do we do?

.. code-block:: bash

  pip list | awk '{ print $1 }'``

or

.. code-block:: bash

  pip freeze | awk -F'==' '{ print $1 }'``

--------------------------
Remove text, like Commas
--------------------------

tl;dr

.. code-block:: bash

  awk -F'[, ]' '{print $2}'

Where what is inside the ``[]`` is what you want removed.

Breakdown
==========

#. the ``pip freeze`` and ``pip list`` we've established.
#. ``awk`` - is a language in and of itself, as complicated and large and useful as a language as well.
#. ``-F`` - this says "use the following text inside the ' ' as the break point or escape character to seperate out all of the info."
#. ``\`{ print $1 }\``` - this tells awk to show the first column of information only.

If you were to say ``pip list | awk `{print $1,$2}``` you would get the original information once again. Why? becuase the (#.#.#) is ``$2`` or option 2 or what have you. The ``,`` says "insert space". Without the comma, no space.

Again, ``awk`` is a massive language. This is a simple explainer here.

.. _using-forwardslash:

------------------------
Using ``\`` as New Lines
------------------------

Often times, you'll see ``\`` used at the end of code lines and you've wondered what on EARTH thats about??

Well, those are used as so-called ``next line`` signifiers, or on the naked command line, it tells the system to keep expecting more text/code input on the next line.

.. _shell_script_self:

----------------------
Shell Script Location
----------------------

Are you wanting an easy way for your shell script to know where its at in the plethora of unix directories? Use the below line!

.. code-block:: bash

  "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

Its able to give you that info, no matter where its called from, which is a typical issue with almost all other so-called "one-liners".

-----------------------
Random Number Generator
-----------------------

.. tl;dr::

  Using the following code gets you a ``Random Number`` between ``0 and 3600`` :guilabel:`&Plus` ``3600`` or ``1 hour``

.. code-block:: bash

  SLEEP="$(($RANDOM%3600+3600))"

Details
=======

The ``$RANDOM`` bash variable is a builtin variable for generating random numbers, random options between :guilabel:`&True` and :guilabel:`&False`, mimic rolling a dice, drawing cards, etc.

its a nice and simple way to use a randomized :guilabel:`&Sleep` length, or anything else you want randomized thats not reliant upon anything security-wise. (Its no where near random enough for using with security needs)

.. _sed_edit:

-----------------------------
Using ``sed`` to Make Updates
-----------------------------

If you are wanting to make the same change in multiple files, ``sed`` is the way to go!

.. code-block:: bash

  sed -i 's/brightyellow/,yellow/g' /usr/share/nano-syntax-highlighting/*.nanorc

or, if you are on a mac, you have to add ``''`` after the ``-i``, and before the text to replace.

.. code-block:: bash

  sed -i '' 's/brightyellow/,yellow/g' /usr/share/nano-syntax-highlighting/*.nanorc

A great website to go look at for a plethora of how-tos is `tldp_randomvar`_.

.. _tldp_randomvar: https://tldp.org/LDP/abs/html/randomvar.html
