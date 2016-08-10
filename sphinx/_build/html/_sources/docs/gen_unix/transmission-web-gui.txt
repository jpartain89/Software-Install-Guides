# Alternate Transmission Web GUI

The command line tools for transmission also come with a directory that runs a web-based GUI for Transmission. Not only does this allow running a torrent program on a headless server, but say you have hardware that the graphics card isn't too quick. Rather than install the GUI Desktop version, install the command line version! Plus, if you run a reverse proxy web server in front of it, you can access it from anywhere!

## Using Kettu's Web GUI for Transmission

First, clone [endor/kettu custom-built web GUI][35c77f0a].

```bash
git clone https://github.com/endor/kettu.git ~/git/kettu
```

!!! note
    I keep all of my cloned git repos inside of one, singular directory:

    `~/git`

    This way, I don't have to hunt all over my system for where my repo's are and it makes it easier to keep them updated. Then, I symlink the library to wherever either the developer wants/requires it or where is easiest.

    The other way of handing this is to clone your PROGRAMS into the /opt directory - so /opt/couchpotato, /opt/NzbDrone, /opt/plexpy and so on. Then clone your working repos for projects into ~/git/[repo]

So, for the above final location, stick it where ever you would like.

## Transmission Web GUI File Locations

Next, we need to put the files in the spot that Transmission expects. Since I don't care for the look of the web GUI that comes with the tool, I just delete the entire directory, then symlink the github repo in its place, but naming it `web`.



!!! note
    Transmission's web GUI is located at `/usr/share/transmission/web` in unix systems.

    If you're using macOS and their main Transmission App downloaded from their site - the Transmission GUI app, NOT the Command Line tool - the web files are located at `/Applications/Transmission.app/Contents/Resources/web/`. Because even their full-fledged desktop tool comes with a web GUI.

First, before making any changes, its always a good idea to stop transmission before doing ANYTHING to it. It not only will revert any changes made to its `config` file if its still running, but if it does that, who knows how mad it'll get over its web GUI files going missing!

```bash
sudo service transmission-daemon stop
```

Then, we remove the existing `web` directory, and then symlink-in the replacement.

```bash
sudo rm -r /usr/share/transmission/web
sudo ln ~/git/kettu /usr/share/transmission/web
sudo service transmission-daemon start
```

Then, of course, confirm that the web interface has changed over. Of which, it usually is running at [http://localhost:9091](http://localhost:9091)

  [35c77f0a]: https://github.com/endor/kettu.git "endor/kettu"
