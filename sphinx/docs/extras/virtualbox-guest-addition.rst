VirtualBox Guest Additions
===========================

## Ubuntu Guest Machine

```bash
sudo apt-get install dkms make gcc -y
```

You need to make sure that `dkms` is installed before any other VirtualBox-like software is installed.
> Now, its not 100% the end of the world if you went outta order. Its just easier this way.

Now, on the GUI interface of your VirtualBox running instance, hit `Devices` and you **_should_** see at the bottom of the menu, `Insert Guest Additions CD Image.`

Hit, that, then go back to your running VM.

```bash
sudo mount /dev/cdrom /media/cdrom
```

It'll alert you to the fact that the mounted filesystem is read only. You're good to ignore that, and cd into the mounted location, and run the installer.

```bash
cd /media/cdrom
sudo sh ./VBoxLinuxAdditions.run
```

That **will** take a hot second at least to run the installer. But, once its finished, and there were no error messages, go ahead and restart your machine. Of course, make sure that, any settings that required the Additions be installed, are fully setup before the reboot. Like, any shared folders.

Now, you'll need to add the group name `vboxsf` to all of the different system and user accounts. `vboxsf` is VirtualBoxes way of mounting these directories.

If you have any services with custom user/group names, like `transmission-daemon`, stop those services before the next step please.

```bash
sudo usermod -aG vboxsf jpartain89
sudo usermod -aG vboxsf debian-transmission
sudo usermod -aG vboxsf root
```

Then, it doesn't really hurt to restart your device. Just to make sure all accounts have signed out and back in again, so they can access any `vboxsf` group items.
