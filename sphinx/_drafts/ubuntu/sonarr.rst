.. _sonarr:

Sonarr Installation
====================

Sonarr (old name was NzbDrone, which you will still see everywhere. Even in their startup file...) is, honestly, my favorite of all of the HTPC Apps. Even moreso than Plex because Plex can really be a huge resource hog.

The day that Sonarr really hopped into my all time fav basket was when I had began downloading a TV show outside of Sonarr. Then, when I had started adding it to Sonarr, it started searching through my directories I had inputted into its settings as a possible final download location, found the files, moved them into their correct, final spot, renamed and everything. Without missing a beat.

Its not without its issues, of course. But they often get fixed quickly, or they aren't with this program, but another site or service.

.. _base_requirements:

Base Requirements
-----------------------------

Make sure apt-transport-https is installed:

.. code-block:: bash

  sudo apt-get install apt-transport-https

.. _add_apt_source_install:

Add the Apt Source and Install
-----------------------------------

Luckily, here, they have a repo we can add to our apt-get lists (of which I always have seperate list files for the "outside of ubuntu/debian" standards) so we get to have easy updates and whatnot.

First, gotta add the key, then the repo, and then update and install!

.. code-block:: bash

  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
  echo "deb https://apt.sonarr.tv/ master main" | sudo tee -a /etc/apt/sources.list.d/sonarr.list

  sudo apt-get update && sudo apt-get install nzbdrone -y

Now, you'll notice there was a TON of apps installing here... Don't panic. This is because Sonarr - aka NzbDrone here - is actually ran using an .exe file! Can you believe it?!? But, there is an open source program called mono that, I believe if the program is compiled for it only, can we run .exe's here! So that was all the Mono modules installing.

But, now we need to run Sonarr, with it outputting the actual output to your shell. This way, you can easily spot any errors, read when it tells you to fix something. Plus, its honestly cool to watch that output live as you click around in a program.

.. code-block:: bash

  sudo mono /opt/NzbDrone/NzbDrone.exe

Next, make the autostart file...

```bash
sudo nano /etc/init.d/nzbdrone
```

```bash
#! /bin/sh
### BEGIN INIT INFO
# Provides: NzbDrone
# Required-Start: $local_fs $network $remote_fs
# Required-Stop: $local_fs $network $remote_fs
# Should-Start: $NetworkManager
# Should-Stop: $NetworkManager
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: starts instance of NzbDrone
# Description: starts instance of NzbDrone using start-stop-daemon
### END INIT INFO

############### EDIT ME ##################
# path to app
APP_PATH=/opt/NzbDrone

# user
RUN_AS=<Your UserName>

# path to mono bin
DAEMON=$(which mono)

# Path to store PID file
PID_FILE=/var/run/nzbdrone/nzbdrone.pid
PID_PATH=$(dirname $PID_FILE)

# script name
NAME=nzbdrone

# app name
DESC=NzbDrone

# startup args
EXENAME="NzbDrone.exe"
DAEMON_OPTS=" "$EXENAME

############### END EDIT ME ##################

NZBDRONE_PID=`ps auxf | grep NzbDrone.exe | grep -v grep | awk '{print $2}'`

test -x $DAEMON || exit 0

set -e

#Look for PID and create if doesn't exist
if [ ! -d $PID_PATH ]; then
    mkdir -p $PID_PATH
    chown $RUN_AS $PID_PATH
fi

if [ ! -d $DATA_DIR ]; then
    mkdir -p $DATA_DIR
    chown $RUN_AS $DATA_DIR
fi

if [ -e $PID_FILE ]; then
    PID=`cat $PID_FILE`
    if ! kill -0 $PID > /dev/null 2>&1; then
        echo "Removing stale $PID_FILE"
        rm $PID_FILE
    fi
fi

echo $NZBDRONE_PID > $PID_FILE

case "$1" in
    start)
    if [ -z "${NZBDRONE_PID}" ]; then
        echo "Starting $DESC"
        rm -rf $PID_PATH || return 1
        install -d --mode=0755 -o $RUN_AS $PID_PATH || return 1
        start-stop-daemon -d $APP_PATH -c $RUN_AS --start --background --pidfile    $PID_FILE --exec $DAEMON -- $DAEMON_OPTS
    else
        echo "NzbDrone already running."
    fi
    ;;
    stop)
        echo "Stopping $DESC"
        echo $NZBDRONE_PID > $PID_FILE
        start-stop-daemon --stop --pidfile $PID_FILE --retry 15
    ;;
    restart|force-reload)
        echo "Restarting $DESC"
        start-stop-daemon --stop --pidfile $PID_FILE --retry 15
        start-stop-daemon -d $APP_PATH -c $RUN_AS --start --background --pidfile $PID_FILE --exec $DAEMON -- $DAEMON_OPTS
    ;;
    status)
        # Use LSB function library if it exists
        if [ -f /lib/lsb/init-functions ]; then
            . /lib/lsb/init-functions
            if [ -e $PID_FILE ]; then
                status_of_proc -p $PID_FILE "$DAEMON" "$NAME" && exit 0 || exit $?
            else
                log_daemon_msg "$NAME is not running"
                exit 3
            fi
        else
            # Use basic functions
            if [ -e $PID_FILE ]; then
                PID=`cat $PID_FILE`
                if kill -0 $PID > /dev/null 2>&1; then
                    echo " * $NAME is running"
                    exit 0
                fi
            else
                echo " * $NAME is not running"
                exit 3
            fi
        fi
    ;;
    *)
        N=/etc/init.d/$NAME
        echo "Usage: $N {start|stop|restart|force-reload|status}" >&2
        exit 1
        ;;
    esac

exit 0
```

Then, make executable and add to autostart.

```bash
sudo chmod +x /etc/init.d/nzbdrone
sudo update-rc.d nzbdrone defaults
```

Access at http://localhost:8989

Directions copied from [HTPC-Guides.com](http://www.htpcguides.com/install-nzbdrone-ubuntu)
