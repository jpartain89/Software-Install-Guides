=========
Here Docs
=========

.. code-block:: bash

  cat << EOF > filename.sh
    #!/bin/bash -e

    # bunch of scripty stuff
    ##

    EOF

The ``EOF`` at the start is you telling bash that that will be the text you use to end your "HERE DOC", which is why it also appears at the bottom of the block of text. 

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
