=======================
Ansible Random Nuggets
=======================

Setting a default to a variable, in order to test if its set or not:

.. code-block:: bash

  when: secret_gmail_passwd|default(None) != None

This will allow the task to run if and only if the variable ``secret_gmail_passwd`` is NOT None. 

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Page reviewed for modernization baseline and footer standardization setup.

Reason for Change
  Standardize per-page change tracking and prepare for phased documentation modernization.

Compatibility Notes
  Not Applicable (administrative documentation footer addition).

Tested On
  Documentation review only.
