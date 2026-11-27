=======================================
Docker Container Formatting for the CLI
=======================================

.. code-block:: bash

  docker container ls --format='{{json .Names}} {{json .State}} {{json .ID}}'

Outputs:

.. csv-table:: Docker Container List
  :header: "Name", "State", "ID"
  :widths: 30, 10, 20

  "your_spotify", "running", "4f477f1d6c61"
  "mongox", "running", "79927585f45a"
  "scrypted", "running", "2053e58f2518"
  "wyze-bridge", "running", "9b5949ce128f"
  "scrutiny-collector-1", "running", "8496c8c7464f"
  "scrutiny", "running", "9b0de876703d"
  "scrutiny_influxdb", "running", "97d69fd96522"
  "plex", "running", "c952b1223e5a"
  "hoarder-workers-1", "running", "47c8d6de9eeb"
  "hoarder-web-1", "running", "02ba6b21ef1b"

The key to this specific format is the ``--format='{{json .Names}} {{json .State}} {{json .ID}}'`` portion. You can change what is displayed by changing what is inside the curly braces. You can find a full list of options over at `Dockers Reference Pages`_.

.. _Dockers Reference Pages: https://docs.docker.com/reference/cli/docker/container/ls/#format
