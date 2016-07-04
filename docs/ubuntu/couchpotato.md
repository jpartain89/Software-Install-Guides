# Base Requirements:

```bash
sudo apt-get install git-core libffi-dev libssl-dev zlib1g-dev libxslt1-dev libxml2-dev python python-pip python-dev build-essential -y
sudo -H pip install --upgrade lxml cryptography pyopenssl
```

# Clone the Repo

!!! note
    I keep all of my cloned git repos inside of one, singular directory: `~/git`. This way, I don't have to hunt all over my system for where my repo's are and it makes it easier to keep them updated. Then, I link the library to wherever either the developer wants/requires it or where is easiest.

```bash
git clone https://github.com/RuudBurger/CouchPotatoServer ~/git/couchpotato
sudo ln -s ~/git/couchpotato /opt/couchpotato
```

Then, make sure that BOTH your `~/git/couchpotato` and `/opt/couchpotato` locations are under your main user's ownership.

```bash
sudo chown -R $USER:$USER ~/git/couchpotato
sudo chown -R $USER:$USER /opt/couchpotato
```

## Test if it works:

```bash
sudo python /opt/couchpotato/CouchPotato.py
```

This will run only as long as you allow it directly inside the terminal, and it will also give each step that the program runs, so you can see if it gives any errors or what else might need to be changed.

Hit `Ctrl-C` to quit the program.

## Copy/Edit Default File

Next, copy over the defaut `/etc/default` file, and then make any necessary changes.

```bash
sudo cp /opt/couchpotato/init/ubuntu.default /etc/default/couchpotato
sudo nano /etc/default/couchpotato
```

The below code field is not the entire file, but rather just an excerpt.

```bash
# COPY THIS FILE TO /etc/default/couchpotato
# Accepted variables with default values -if any- in parentheses:

# username to run couchpotato under (couchpotato)
CP_USER= < your main login >
# directory of CouchPotato.py (/opt/couchpotato)
CP_HOME=/opt/couchpotato

# directory of couchpotato's db, cache and logs (/var/opt/couchpotato)
CP_DATA=/var/opt/couchpotato
# full path of couchpotato.pid (/var/run/couchpotato/couchpotato.pid)
CP_PIDFILE=/var/run/couchpotato/couchpotato.pid
# full path of the python binary (/usr/bin/python)
PYTHON_BIN=/usr/bin/python
```

Next, copy the default CouchPotato init.d file:

```bash
sudo cp /opt/couchpotato/init/ubuntu /etc/init.d/couchpotato
```

Make it executable and run on boot

```bash
sudo chmod +x /etc/init.d/couchpotato
sudo update-rc.d couchpotato defaults
```

Then, you can run `sudo service couchpotato start`, and access it at [http://127.0.0.1:5050](http://127.0.0.1:5050)

* * *

Directions copied from [HTPC-Guides](http://www.htpcguides.com/install-couchpotato-ubuntu)
