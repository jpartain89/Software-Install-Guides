# HTPC-Manager Installation

## Install Dependencies

!!! note
    The `--upgrade` part for `pip psutil` is in case you already have `psutil` installed. This way, it will go ahead and run the upgrade.

```bash
sudo apt-get install build-essential git python-imaging python-dev python-setuptools python-pip python-cherrypy vnstat -y
sudo -H pip install --upgrade psutil
```

## Cloning and Starting

[Hellowlol's](https://github.com/Hellowlol/HTPC-Manager.git) fork of HTPC-Manager is the one that I prefer to use.

!!! note
    I keep all of my cloned git repos inside of one, singular directory: `~/git`. This way, I don't have to hunt all over my system for where my repo's are and it makes it easier to keep them updated. Then, I link the library to wherever either the developer wants/requires it or where is easiest.

Make sure that the HTPC Manager files and directories are owned by your user.

```bash
git clone https://github.com/Hellowlol/HTPC-Manager ~/git/htpcmanager
sudo ln -s ~/git/htpcmanager /opt/htpcmanager
sudo chown -R $USER:$USER /opt/htpcmanager
sudo chown -R $USER:$USER ~/git/htpcmanager
sudo python /opt/htpcmanager/Htpc.py
```

!!! note
    If you see any RED TEXT CherryPy errors, those aren't death. Those are just, nicely, STANDING OUT for you to see what needs to be done.

Make sure you hit `Ctrl-C` to stop the program.

## Autostart init.d Copy and Edit

You can link over the standard `init.d` file from the repo to `/etc/init.d`.

```bash
sudo cp /opt/HTPCManager/initscripts/initd /etc/init.d/htpcmanager
sudo nano /etc/init.d/htpcmanager
```

Change `APP_PATH` to match the path of where you stuck HTPC Manager.

```bash
############### EDIT ME ##################
# path to app
APP_PATH=/opt/HTPCManager
```

Then, make the file executable and add to the `update-rc.d` autostart program.

```bash
sudo chmod +x /etc/init.d/htpcmanager
sudo update-rc.d htpcmanager defaults
```

Then, you can run `sudo service htpcmanager start`, and access it  at [http://127.0.0.1:8085](http://127.0.0.1:8085)

* * *

Directions copied fairly liberally from [HTPC Guides' HTPC Manager Instructions](http://www.htpcguides.com/install-htpc-manager-ubuntu-linux/)
