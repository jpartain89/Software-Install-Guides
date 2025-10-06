====================
Random Code Snippets
====================

If you want to delete all of the docker images by iterating through the list of image IDs:

... code-block:: bash

  docker rmi $(docker images -q)

or

... code-block:: bash

  docker image ls --format "{{.ID}}" | xargs -r docker image rmi
