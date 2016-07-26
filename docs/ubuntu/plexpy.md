## PlexPy Instructions

As always, I keep my git repo's inside of one single, easily found directory, `~/git`. Thus:

```bash
git clone https://github.com/drzoidberg33/plexpy.git ~/git/plexpy
```

Then:

```bash
sudo touch /etc/default/plexpy
```

That will make sure to stop any possible errors or warnings. It also is where you need to make any changes, in case you don't use the default settings that are in the various init scripts. You can see the options inside of `~/git/plexpy/init-scripts/init.ubuntu` if you're using ubuntu.

Next, I use the plexpy user.

```bash
sudo adduser --system --no-create-home plexpy
sudo chown -R plexpy:nogroup ~/git/plexpy
sudo ln -s ~/git/plexpy /opt/plexpy
sudo chmod +x ~/git/plexpy/init-scripts/init.ubuntu
sudo ln -s ~/git/plexpy/init-scripts/init.ubuntu /etc/init.d/plexpy
sudo update-rc.d plexpy defaults
sudo service plexpy start
```

Access the web interface at `<your ip>:8181`
