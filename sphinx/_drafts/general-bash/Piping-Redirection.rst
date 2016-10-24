============================================
Piping and Redirection [Piping-Redirection]_
============================================

There are, basically, three different pieces of information to or from the terminal in linux.

#. `stdin` - all input (not just the keyboard) - this can be a wide variety of places for input as well
#. `stdout` - this is typically 'the screen', but is, in general, all of the information output from programs outside of error messages, specifically
#. `stderr` - this is, specifically, error messages. And thats seperate mostly for logging and info clarity.

And Redirection, basically, is you directing those pieces of information to a different spot. Whether that be a file, another command, program or into another script.

These three items also have numerical denotations, as most of linux does. These would be `0` for `stdin`, `1` for `stdout`, and `2` for `stderr`. For the ability to "assign" more variables to a "saved spot", numbers 3 through 9 are also available.

Lots of Redirection Examples
============================

.. code-block:: bash

  COMMAND_OUTPUT >
      # One single `>`
      # Redirect stdout to what you denote after the `>`
      # Creates the file if not present, otherwise overwrites it.

      ls -lR > dir-tree.list
          # Creates a file containing a listing of the directory tree.

.. [Piping-Redirection] The code blocks are mostly copied over from `Advanced Bash-Scripting Guide <http://www.tldp.org/LDP/abs/html/io-redirection.html>`_
