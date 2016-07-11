# Install Transmission on Ubuntu

## Linux apt-get Repo

Add the most up-to-date repo for transmission:

```bash
echo "deb http://ppa.launchpad.net/transmissionbt/ppa/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/transmission-bt.list
echo "deb-src http://ppa.launchpad.net/transmissionbt/ppa/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/transmission-bt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 365C5CA1
```

## Then, install

```bash
sudo apt-get install transmission-daemon transmission-cli -y
sudo service transmission-daemon stop
```

The last line, stopping the service, is necessary for you to be able to edit the `settings.conf` file. That file is silently rewritten by the `transmission-daemon` service, if that service is still running.

## User Account Modifications

Add the Transmission group to your regular user account, as well ass the group that owns the directory that you will be saving the downloaded files, as this will - hopefully - prevent permission issues.

```bash
sudo usermod -aG debian-transmission $USER
sudo usermod -aG debian-transmission root
```

> If you are running this inside of a VirtualBox Linux Guest, and using VirtualBox's Folder Syncing Feature... You'll notice that the group owner of those mounts is `vboxsf`. Thats only inside of your Guest OS, but will futz with transmission's ability to save anything to those directories. Make sure to also include `vboxsf` with the above commands.

## Editing the `settings.conf` file

```bash
sudo nano /etc/transmission-daemon/settings.json
```

The settings file is quite long with lots of options. The Most Important parts are:

`"rpc-whitelist": "0.0.0.0", ` This blocks off all but only the IP listed from accessing....

`"rpc-whitelist-enabled": true, ` This is the boolean to turn whitelisting on/off. Doesn't always take for some reason.....

```
"rpc-whitelist": "*.*.*.*",
"rpc-whitelist-enabled": false,
```


You can also change the IP address to "192.168.*.*" or whatever your home IP address ranges are, depending on what your personal security wants are.

```
"rpc-password": "password",
"rpc-username": "username",
```

Change the download-dir to where ever you want it....

`"download-dir": "/var/lib/transmission-daemon/downloads", `

This is the amount of items being downloaded at once. I usually stay at 5 max, no matter what machine I'm using.

`"download-queue-size": 5,`

For the seeding queue, I honestly lower it down to 5 as well, since I like to double the upload amount.

`"seed-queue-size": 5,`

Set umask to 002 to avoid permission issues...

`"umask": 002,`

I set the blocklist up as well.

```
"blocklist-enabled": true,
"blocklist-url": "http://john.bitsurge.net/public/biglist.p2p.gz",
```

> Taken from [GiulioMac's Personal Blog](https://giuliomac.wordpress.com/2014/02/19/best-blocklist-for-transmission)

Save the file, and restart the service.

`sudo service transmission-daemon restart`

Then, access the web GUI at `http://localhost:9091` unless you changed that as well.

* * *

Copied from [HTPC-Guides](http://www.htpcguides.com/install-transmission-bittorrent-client-on-ubuntu-15-x) and [StackExchange's Raspberry Pi Forum on Transmission Permissions](http://raspberrypi.stackexchange.com/questions/4378/transmission-permission-denied-on-usb-disk)
