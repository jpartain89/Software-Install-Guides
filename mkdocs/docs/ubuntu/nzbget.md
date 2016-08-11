# NZBGet

NZBGet is a Usenet downloading program, which I definitely  prefer over SabNZBD, not only for ease-of-setup and use, but also for the fact that its lighter in resources.

## Installing

Sadly, this seems to be one of the only programs in existence that I'm currently unable to find a PPA:repo with the most up-to-date version available. But, on their [github wiki instructionals](https://github.com/nzbget/nzbget/wiki/Installation-on-Linux), they provide a nice, simple-to-copy "one-liner" to download and install the latest nzbget.

```bash
wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
sed -n "s/^.*stable-download.*: \"\(.*\)\".*/\1/p" | \
wget --no-check-certificate -i - -O nzbget-latest-bin-linux.run
```

It grabs a `.json` file that has links and what not, processes the download through wget into `nzbget-latest-bin-linux.run`. Once its downloaded, run:

```bash
sudo bash ./nzbget-latest-bin-linux.sh --destdir /usr/share/nzbget
```

The `--destdir` changes the installation location, as the `.sh` file wants to install into the current directory.

## AutoStart

I use monit to start up my programs, rather than using the init.d, Upstart or systemd to start the program, as I have yet to find a good script for this. 
