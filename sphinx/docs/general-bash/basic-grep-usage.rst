Use grep Output as if-else Conditional
==========================================

This was my notation of how to use grep's standard output as an ``if-else`` conditional in a shell script.

Basically, just about all programs have at least two outputs; the textual output that it sends to ``STDOUT``, the stuff that you read and a basic ``0`` ``1`` or more, for use in shell scripts, ``if-else`` conditionals or loops, etc.

The ``if-else`` conditionals or ``for`` loops or what have you like to use simple numbers, ``0`` ``1`` etc. for, say, when searching for ``openvpn`` being installed, it says ``0`` for yes, ``1`` for no or error. Therefore, you can make a conditional that says ``if 0, yes, then do not attempt install. If NOT 0, then attempt install!``

Basic Use of grep in if-else
-------------------------------------

This would be a simple layout of how you could potentially use this in a shell script.

.. code-block:: bash

  #!/bin/bash

  dpkg -l | grep openvpn &> /dev/null
  if [[ $? == 0 ]]; then
    echo "matched"
  else
    echo "Not Matched"
  fi

So, lets break that down
------------------------------

1. ``dpkg -l`` - this, by itself, will output all installed programs that dpkg manages.
2. ``|`` - this is the ``pipe`` command.

  - What this says is:
    take the outputted text from the last thing and use it as input for the next thing
  - So, the entire list of installed apps then is searched using ``grep`` for ``openvpn``

3. ``&> /dev/null`` - this is a redirection of the output, negating any textual output, leaving only the ``1`` or ``0`` or more outputs to use
4. ``$?`` - this basically says ``take the numbered output, whatever it is, and stick it here``
5. So, when you do ``$? == 0`` you're saying ``if the output was 0, then do this command``

AND be careful, 0 might not always be yes or confirm. Make sure to check the programs MAN pages for clarification
