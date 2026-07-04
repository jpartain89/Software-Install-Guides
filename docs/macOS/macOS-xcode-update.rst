==================================
Updating Xcode After macOS Updates
==================================

-------
tl;dr
-------

.. Reminder::

  After major macOS upgrades, confirm your developer toolchain is still installed and selected.

.. code-block:: bash

  xcode-select --install

And for full Xcode app updates, use App Store.

You can also verify active developer path:

.. code-block:: bash

  xcode-select -p

----------
The Story
----------

After big macOS updates, build tools can appear missing even when your shell/profile is fine.
Running ``xcode-select --install`` usually restores required Command Line Tools quickly.

Moral of the story: verify Xcode and CLI tools early when compile errors appear right after OS upgrades.

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Updated wording and title to modern Xcode naming and workflows.
  - Added guidance for App Store updates and ``xcode-select -p`` verification.

Reason for Change
  Keep macOS developer-tool troubleshooting accurate for current systems.

Compatibility Notes
  Applies to modern macOS releases using Xcode and Command Line Tools.

Tested On
  Documentation review only (commands not executed in this repo).
