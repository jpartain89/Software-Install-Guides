Compiling NGINX From Source
=========================

.. Add NGINX's ppa:repo::

```bash
sudo add-apt-repository ppa:nginx/stable
```

Then, go in and remove the comment from the `deb-src` line inside the `apt/sources.list.d/nginx.list` file. The file most likely will be named something else.

Then update:

```bash
sudo apt-get update
```

# Get the Source Package of NGINX

First we'll get the source package and any needed system dependencies:

```bash
# Install package creation tools
sudo apt-get install dpkg-dev -y

sudo mkdir /opt/rebuildnginx
cd /opt/rebuildnginx

# Get Nginx  source files
sudo apt-get source nginx

# Install the build dependencies
sudo apt-get build-dep nginx
```

If the current, main NGINX build doesn't have the specific modules that you are needing, you can add them into a specific file inside the build directory.

The detailed instructions for that specialized need is at [ServersForHackers.com](https://serversforhackers.com/compiling-third-party-modules-into-nginx).

Next, compile and install!

```bash
cd /opt/rebuildnginx/nginx-{release}
sudo dpkg-buildpackage -uc -b
```

This will take around a few minutes.

# Install NGINX

Once the build is complete, we'll find a bunch of `.deb` files added in `/opt/rebuildnginx`. We can use these to install NGINX.

The 'full' package, quite aptly, has the most pre-built modules. So, if thats what you're needing, concentrate on those files.

Next, you'll want to check if you're on 64bit or otherwise. If you're on 64bit, most likely you wanna use `amd64` files. Also, the `dbg` is specifically for debugging tools.

Do you have the file you wanna use? Lets install it then!

```bash
sudo dpkg --install nginx-full_{ release }+trusty0_amd64.deb
```

Now, you can run `nginx -V` (capital V) and it'll show you the flags and modules and whatnot compiled with NGINX.

Next, mark NGINX to be blocked from further apt-get updates.

```bash
sudo dpkg --get-selections | grep nginx
```

and for every nginx component listed run

```bash
sudo apt-mark hold {component}
```

And from now on, make sure to watch [NGINX's](nginx.org) web page for anymore updates, and perform the same steps again.

* * *

These instructions are happily borrowed from [ServersForHackers.com](https://serversforhackers.com/compiling-third-party-modules-into-nginx)
