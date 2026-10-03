===============
OS Edition Name
===============

For when you are wanting to add a specific, custom apt sources list item (because its best to have custom items in their own, specific ``.list`` file) and the string asks for the Ubuntu/Debian codename (for example, ``jammy`` or ``noble``), you are able to run commands within the ``echo`` line.

.. code-block:: bash

  sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu $(lsb_release -sc)-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list'

Lets break that down:

`sudo sh -c`

When you use this specific starting command, and then wrap everything after in apostrophes, it "sudos" that entire block of commands. This is awesome for when you're wanting to redirect with `>` or `>>` to a file or location that requires sudo.

`$(lsb_release -sc)`

1. `lsb_release`- this prints distribution-specific info
2. `-sc`-  the `-s` is "short", the `-c` is "codename"

So, almost all apt sources addresses have the distribution's code name as one of the options, so using this really helps out in programatic coding.

Modern alternative using ``/etc/os-release``:

.. code-block:: bash

  . /etc/os-release
  echo "${VERSION_CODENAME:-$UBUNTU_CODENAME}"

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Updated release examples from EOL-era codenames to modern codename framing.
  - Added ``/etc/os-release`` codename retrieval as a modern alternative.

Reason for Change
  Keep codename substitution guidance aligned with current Debian/Ubuntu releases and tooling.

Compatibility Notes
  Supports both ``lsb_release`` and ``/etc/os-release`` codename workflows.

Tested On
  Documentation review only (commands not executed in this repo).
