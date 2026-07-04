======================
dpkg -l Package States
======================

This is specifically in reference to the flags at the start of each line when you perform ``dpkg -l``.

Example output (left-most status column):

.. code-block:: text

  ii  bash        5.2.21-2ubuntu4   amd64   GNU Bourne Again SHell
  rc  oldpackage  1.0.0-1           amd64   (removed, config files remain)

The first two letters (for example ``ii`` or ``rc``) are the key status flags referenced below.

-----------
Definitions
-----------

===========  ====================  ===============
1st Letter   2nd Letter            Opt. 3rd Letter
===========  ====================  ===============
u - unknown  n - not-installed     r - reinst-required
i - install  i - installed
r - remove   c - config-files
p - purge    u - unpacked
h - hold     f - half-configured
.            h - half-installed
.            w - triggers-awaited
.            t - triggers-pending
===========  ====================  ===============

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Replaced stale screenshot dependency with a text-based ``dpkg -l`` status example.
  - Clarified where to read ``ii``/``rc`` style status flags in command output.

Reason for Change
  Keep the page accurate and maintainable without relying on outdated image captures.

Compatibility Notes
  Status-flag reference is compatible with modern ``dpkg`` output.

Tested On
  Documentation review only (commands not executed in this repo).
