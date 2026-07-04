.. _pip-requirements-file:

=====================
pip Requirements File
=====================

.. tl;dr::

  a pip Requirements File is a list of programs "required" to be installed. Lets say you have a program you wrote that has required python programs, you'd include them here.

Use the requirements file as an environment-specific ``install/upgrade`` list.

.. warning::

  Avoid ``sudo pip`` for system Python installs. Modern Python environments (PEP 668) can block or break global installs.

Recommended flow:

.. code-block:: bash

  python3 -m venv .venv
  source .venv/bin/activate
  python -m pip install --upgrade pip
  python -m pip install --upgrade -r requirements.txt

For command-line tools that should be installed outside a project environment, use ``pipx``.

.. code-block:: bash

  pipx install <tool-name>
  pipx upgrade <tool-name>

This file is much more detailed and expansive than I care to currently go into.

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Replaced unsafe ``sudo -H pip install`` guidance with a virtual environment workflow.
  - Added a warning about modern system Python protections (PEP 668).
  - Added ``pipx`` guidance for global CLI tool installation.

Reason for Change
  Prevent system Python breakage and align installation guidance with current Python packaging standards.

Compatibility Notes
  Compatible with Python 3 on modern Debian/Ubuntu and macOS environments using ``venv`` and ``pipx``.

Tested On
  Documentation review only (commands not executed in this repo).
