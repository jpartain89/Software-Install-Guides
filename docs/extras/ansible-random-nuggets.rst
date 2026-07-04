=======================
Ansible Random Nuggets
=======================

Setting a default to a variable, in order to test if its set or not:

.. code-block:: bash

  when: secret_gmail_passwd is defined and secret_gmail_passwd is not none

This will allow the task to run if and only if the variable ``secret_gmail_passwd`` is both defined and not ``None``.

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Replaced legacy default-based ``when`` test with explicit ``is defined`` and ``is not none`` checks.

Reason for Change
  Use clearer modern Ansible conditional style and avoid ambiguous None checks.

Compatibility Notes
  Compatible with modern Ansible/Jinja conditional evaluation.

Tested On
  Documentation review only (commands not executed in this repo).
