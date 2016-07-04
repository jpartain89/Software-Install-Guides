# Transmission's Web GUI

## Using Kettu's Web GUI for Transmission

First, clone [Kettu's web GUI](https://github.com/endor/kettu.git)

`git clone https://github.com/endor/kettu.git`

Clone it into whatever location you would like, I personally prefer to keep all of my git repo's in one directory behind my home directory. Specifically `~/git`

## Transmission web GUI Locations

Next, I just prefer to remove the old Transmission Web GUI files and then symlink over the git repo of kettu's GUI.

Transmission's web GUI is located at `/usr/share/transmission/web` in linux systems.

If you're using OS X and the main Transmission App downloaded from their site, - the Transmission GUI app - the web files are located at `/Applications/Transmission.app/Contents/Resources/web/`

```
sudo service transmission-daemon stop
sudo rm -r /usr/share/transmission/web
sudo ln -s ~/git/kettu /usr/share/transmission/web
sudo service transmission-daemon start
```

Next, check the web interface to make sure it is actually working.
