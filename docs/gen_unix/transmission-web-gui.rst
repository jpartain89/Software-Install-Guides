# Alternate Transmission Web GUI

## Using Kettu's Web GUI for Transmission

First, clone [Kettu's web GUI](https://github.com/endor/kettu.git)

```bash
git clone https://github.com/endor/kettu.git
```

!!! note
    I keep all of my cloned git repos inside of one, singular directory: `~/git`. This way, I don't have to hunt all over my system for where my repo's are and it makes it easier to keep them updated. Then, I link the library to wherever either the developer wants/requires it or where is easiest.

## Transmission Web GUI File Locations

Next, I just prefer to remove the old Transmission Web GUI files and then symlink over the git repo of kettu's GUI.

!!! note
    Transmission's web GUI is located at `/usr/share/transmission/web` in linux systems.
    And if you're using OS X and the main Transmission App downloaded from their site, - the Transmission GUI app - the web files are located at `/Applications/Transmission.app/Contents/Resources/web/`

```bash
sudo service transmission-daemon stop
sudo rm -r /usr/share/transmission/web
sudo ln ~/git/kettu /usr/share/transmission/web
sudo service transmission-daemon start
```

Then, of course, confirm that the web interface has changed over.
