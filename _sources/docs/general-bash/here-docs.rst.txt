=========
Here Docs
=========

.. code-block:: bash

  cat << EOF > filename.sh
    #!/bin/bash
    set -o errexit
    set -o pipefail
    set -o nounset

    # bunch of scripty stuff
    ##

    EOF

The ``EOF`` at the start is you telling bash that that will be the text you use to end your "HERE DOC", which is why it also appears at the bottom of the block of text.

Use a quoted delimiter when you do not want variable expansion inside the body:

.. code-block:: bash

  cat << 'EOF' > literal-output.sh
  PATH_LITERAL=$PATH
  EOF

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Replaced ``#!/bin/bash -e`` example with explicit shell safety options.
  - Added quoted here-doc delimiter example to prevent variable expansion.

Reason for Change
  Improve reliability and clarify common here-doc expansion behavior.

Compatibility Notes
  Examples target Bash behavior on modern Linux/macOS systems.

Tested On
  Documentation review only (commands not executed in this repo).
