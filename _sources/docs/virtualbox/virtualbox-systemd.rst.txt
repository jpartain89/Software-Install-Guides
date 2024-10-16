==================
VirtualBox Systemd
==================

To control the start/stop of your VM's with systemd, and use systemd to auto start and stop them on system boot. 

Run ``sudo systemctl edit vbox@.service --full --force`` and paste the following content in, updating User and Group to your username.

.. code-block:: bash

    [Unit]
    Description=Virtual Box Guest %I
    After=network.target vboxdrv.service
    Before=runlevel2.target shutdown.target

    [Service]
    User=USERNAME
    Group=GROUPNAME
    Type=forking
    Restart=no
    TimeoutSec=5min
    IgnoreSIGPIPE=no
    KillMode=process
    GuessMainPID=no
    RemainAfterExit=yes

    ExecStart=/usr/bin/VBoxManage startvm %i --type headless
    ExecStop=/usr/bin/VBoxManage controlvm %i acpipowerbutton

    [Install]
    WantedBy=multi-user.target

Then, reload systemd: ``sudo systemctl daemon-reload``

Get a list of your VM's:

.. code-block:: bash

    VBoxManage list vms
    "Ubuntu" {1ba32309-d4c4-420a-a9c8-a38177f00bc4}
    "Windows" {573df054-0e33-4389-896a-1234f10e25ad}

Use the name returned in step 3 to manage the VM via systemd. For example, to manage the "Ubuntu" VM you would run:

.. code-block:: bash

    sudo systemctl start vbox@Ubuntu     # Start the VM
    sudo systemctl enable vbox@Ubuntu    # Start the VM on boot
