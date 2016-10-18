==========================
Default Optional Agruments
==========================

If you are needing to set an optional argument in a shell script, say if something has a default, therefore doesn't have to be included as an optional argument, you can use:

.. code-block:: bash

  foo=${1:-foo}

Where ``$1`` is the position after the program name. So the ``1`` means "grab the item from position 1" and then ``:foo`` would be the defaulted option. As in "if no item in position 1, then use foo instead."

So, lets say:

.. code-block:: bash

  portnumber=${1:-22}

That says "take the port number from position 1 OR if empty, use the number 22."

Here's the direct-from-manual info:

  If parameter is unset or null, the expansion of word is substituted. Otherwise, the value of parameter is substituted.

Here's the info if you omit the colon ``:``

  Omitting the colon results in a test only for a parameter that is unset. Put another way, if the colon is included, the operator tests for both parameter’s existence and that its value is not null; if the colon is omitted, the operator tests only for existence.
