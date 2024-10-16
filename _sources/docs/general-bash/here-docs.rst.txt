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
