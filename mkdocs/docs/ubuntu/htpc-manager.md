# HTPC-Manager Installation

HTPC Manager is a simple, web front-end that aims to bring the different, other web front-end GUI's into one place, for ease of use across your entire home-server system.

It currently has already-coded-access to programs like CouchPotato, Sonarr, NZBGet, Transmission, Plex; as well as adding in the ability to view your hardware's performance as well!

## Install Dependencies

As usual, there are a few, pre-needed programs in order to make sure it builds and runs smoothly.

And, on the `vnstat` program. If you're installing HTPC-Manager on, say, a VM but you'd like to see stats for your HARDWARE device instead, you're in luck! Instead of installing vnStat on the same machine as HTPC-Manager, install it on the machine thats the actual hardware. You can remotely, over your network, view other vnStat instances inside of HTPC-Manager.

```bash
sudo apt-get install build-essential git python-imaging python-dev python-setuptools python-pip python-cherrypy vnstat -y
sudo pip install --upgrade psutil
```

## Cloning and Starting

[HellowLoL's Version][e69f24f4] of HTPC-Manager is the one that I prefer to use, but its not the original fork. So, if you were to poke around a bit on GitHub, you might see some other forks and versions as well.

!!! note "Custom Repo Location"
    I keep all of my cloned git repos inside of one, singular directory:

    `~/git`

    This way, I don't have to hunt all over my system for where my repo's are and it makes it easier to keep them updated. Then, I symlink the library to wherever either the developer wants/requires it or where is easiest.

    The other way of handing this is to clone your PROGRAMS into the /opt directory - so /opt/couchpotato, /opt/NzbDrone, /opt/plexpy and so on. Then clone your working repos for projects into ~/git/[repo]

So, as always, on the code below that includes locations for git, you can change as much as you want.

First, the cloning:

```bash
git clone https://github.com/Hellowlol/HTPC-Manager ~/git/htpcmanager
```

Notice, in the location string at the end, I changed the formatting of `./htpcmanager` to a nicer, easier-to-type lowercase and without dashes. This simply tends to make your Command Line Life easier in the long run if you try to manage directories in that manner. Or at least, one that works for your fingers.

Next, I symlink the `~/git` location to `/opt`, and make sure the files are assigned to my primary user.

Now, like in the CouchPotato how-to, the proper, secure-linux way of handling this is to have a locked down system account manage this. So, its up to you.

```bash
sudo ln -s ~/git/htpcmanager /opt/htpcmanager
sudo chown -R $USER:$USER /opt/htpcmanager
sudo chown -R $USER:$USER ~/git/htpcmanager
```

And, we `python /opt/htpcmanager/Htpc.py` for the first time-running of the program. This way we get the verbose output and see up front if there are any big errors or anything missing.

```bash
sudo python /opt/htpcmanager/Htpc.py
```

Which, you can 

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

  [e69f24f4]: https://github.com/Hellowlol/HTPC-Manager.git "hellowlol/github"
