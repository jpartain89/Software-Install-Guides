==================================
Updating Xcode After macOS Updates
==================================

-------
tl;dr
-------

.. note::

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
