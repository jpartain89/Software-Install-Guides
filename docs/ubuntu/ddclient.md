# Clone the Github repo

!!! note:
    I keep all of my cloned git repos inside of one, singular directory: `~/git`. This way, I don't have to hunt all over my system for where my repo's are and it makes it easier to keep them updated. Then, I link the library to wherever either the developer wants/requires it or where is easiest.

```bash
git clone https://github.com/wimpunk/ddclient.git ~/git/ddclient
```

# Copying Files and Creating Directories

Next, its a matter of sticking the ddclient program into the right place  and creating its directories.

```bash
cd ~/git/ddclient/
sudo cp ddclient /usr/sbin/
sudo mkdir /etc/ddclient/
sudo mkdir /var/cache/ddclient
```

# ddclient.conf

If you already have a `ddclient.conf` file made, say, using [domains.google.com](domains.google.com)'s support directions, copy that over to:

```bash
/etc/ddclient/ddclient.conf
```

Otherwise, copy over the repo's default `.conf` file.

```bash
sudo nano /etc/ddclient/ddclient.conf
```

It doesn't hurt to try to familiarize yourself with the different options. There's a TON of information, so its most likely easier to do one of the following:

1. Find the specific service you plan to use for your own setup
2. Make a new `ddclient.conf` file, rename the current one to `ddclient.conf.copy` and move from there

# Autostart

Now, copy the `init.d` file over and set it up to _always_ run:

```bash
sudo cp sample-etc_rc.d_init.d_ddclient.ubuntu /etc/init.d/ddclient
sudo chmod +x /etc/init.d/ddclient
sudo update-rc.d ddclient defaults
```

That sets up the auto-running and registers it as a proper service.

# Perl/CPAN

Make sure you have `cpan` installed, that's one of Perl's installation management systems, like `Pip` or `apt-get`.

`which cpan` - when you add `which` before any program's `cli` command, linux responds with where in the directory setup that program file is located. If it doesn't respond, then no program installed.

If no `cpan`:

```bash
sudo apt-get install perl cpan
```

Next:

```bash
sudo cpan install Data::Validate::IP
```

Since I don't know hardly anything about Perl other than I need it, the first question that appears asks:

"Would you like to configure as much as possible automatically? [yes]"

To which, I type "yes" and hit enter. If you know what you're doing and wanna fudge with stuff, you're welcome to. Thats just beyond my abilities.

* * *

These instructions are liberally copied from [wimpunk/ddclient's github page.](https://github.com/wimpunk/ddclient)
