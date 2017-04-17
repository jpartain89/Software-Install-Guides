============================
Bash Conditional Expressions
============================

Conditional Expressions are signals - also called primaries - that bash uses as a means of performing tests, using the info you provide.

Lets say you are wanting to copy over a file from one location to another, but don't need to do this if the file already exists in the final location. This is one way to test for that!

.. code-block:: bash

  if [[ ! -e /etc/foo ]]; then
    echo "Looks like /etc/foo doesn't exist"
  fi

Breakdown
---------

#. ``[[ ]]`` So, the double brackets here are necessary for ``#!/bin/bash``, of which, to be honest, using the double brackets as the standard setup seems to be what makes the most sense.
#. ``!`` The exclamation point is how you negate expressions through a lot of bash in general. So, here, its testing if ``/etc/foo`` exists.
#. ``-e`` True if File Exists. Its a very broad testing flag.
#. After the brackets are closed, you use ``;`` to tell bash that your expression line is finished.
#. Then, you do whatever you need to do.
#. ``fi`` then, the ``fi`` is what tells bash that ``if`` is finished.

Conditional Expression Primaries
================================

The following test flags go with:

.. code-block:: bash

  if [[ -e /bin/bash ]]; then ...
    <some code>
  elif [[ ! -e /bin/dash ]]; then
    <some code>
  fi

Use ``[[ ]]`` with double ``==`` and use ``[ ]`` with ``=``

The first line, ``-e /bin/bash`` is the positive side of the ``-e FILE`` test.

There are a LOT of ways to test things, using either ``if-then-else``, ``case`` or ``while`` loops.

.. csv-table:: Test Expressions - Simple Flags

  :header: "Flag", "Explainer"
  :widths: auto
  :align: center

"-a FILE", "True if file exists"
"-b FILE", "True if file exists and is a block special file"
"-c FILE", "True if file exists and is a character special file"
"-d FILE", "True if file exists and is a directory"
"-e FILE", "True if file exists"
"-f FILE", "True if file exists and is a regular file"
"-g FILE", "True if file exists and its set-group-id bit is set"
"-h FILE", "True if file exists and is a symbolic link"
"-k FILE", "True if file exists and its "sticky" bit is set"
"-p FILE", "True if file exists and is a named pipe (FIFO)"
"-r FILE", "True if file exists and is readable"
"-s FILE", "True if file exists and has a size greater than zero"
"-t FD", "True if file descriptor 'fd' is open and refers to a terminal"
"-u FILE", "True if file exists and its set-user-id bit is set"
"-w FILE", "True if file exists and is writable"
"-x FILE", "True if file exists and is executable"
"-G FILE", "True if file exists and is owned by the effective group id"
"-L FILE", "True if file exists and is a symbolic link"
"-N FILE", "True if file exists and has been modified since it was last read"
"-O FILE", "True if file exists and is owned by the effective user id"
"-S FILE", "True if file exists and is a socket"
"-o OPTNAME", "True if the shell option ``optname`` is enabled [1]_"
"-z FILE or STRING", "True if STRING or FILE is null"
"-n STRING", "True if the length of string is NON-zero, as in the reverse of above"
"-v $VARNAME", "True if the shell variable ``$VARNAME`` is set (has been assigned a value) [2]_ "
"-R $VARNAME", "True if the shell variable ``$VARNAME`` is set and is a *name reference*"

.. csv-table:: Test Expressions - File Comparison (1)

  :header: "Compare Flags", "Explainer"
  :widths: auto
  :align: center

"file1 -nt file2", "True if file1 *exists* and is *newer* than file2"
"file1 -ot file2", "True if file1 *exists* and is *older* than file2"
"file1 -ef file2", "True if file1 and file2 *exist* and refer to the *same file*"

.. csv-table:: Test Expressions - File Comparison (2) Detailed

  :header: "Compare Strings", "Explainer"
  :widths: auto
  :align: center

"s1 == s2", "True if strings ``s1`` and ``s2`` are *equal*"
"- or -", "When used with ``[[ ]]`` (/bin/bash specific) or ``[ ]`` (/bin/sh specific)"
"s1 =  s2", "this performs pattern matching, rather than maths"
"s1 != s2", "True if strings ``s1`` and ``s2`` are *not* equal"
"s1 <  s2", "True if string ``s1`` comes *before* ``s2`` based on the binary value of their characters"
"s1 >  s2", "True if string ``s1`` comes *after* ``s2`` based on the binary value of their characters"

.. csv-table:: Test Expressions - File Comparison (3) MATH SPECIFIC

  :header: "Compare Strings", "Explainer"
  :widths: auto
  :align: center

"n1 -eq n2", "True if the integers ``n1`` and ``n2`` are algebraically equal"
"n1 -ne n2", "True if the integers ``n1`` and ``n2`` are not algebraically equal"
"n1 -gt n2", "True if the integer ``n1`` is algebraically greater than the integer"
"n1 -ge n2", "True if the integer ``n1`` is algebraically greater than or equal to the integer ``n2``"
"n1 -lt n2", "True if the integer ``n1`` is algebraically less than the integer ``n2``"
"n1 -le n2", "True if the integer ``n1`` is algebraically less than or equal to the integer ``n2``"

.. note::

  See ``man test`` for more explanations.

.. [1] Shell Option ``optname``: The list of options appears in the description of the -o option to the set builtin. (see The Set Builtin)

.. [2] ``$VARNAME`` is replaceable with ANY **VARIABLE** name needed
