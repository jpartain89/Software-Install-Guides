====================
Random Code Snippets
====================

If you want to delete all of the docker images by iterating through the list of image IDs:

.. code-block:: bash

  docker rmi $(docker images -q)

or

.. code-block:: bash

  docker image ls --format "{{.ID}}" | xargs -r docker image rmi

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
  Documentation review only (commands not executed in this repo).
