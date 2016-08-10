## File sharing FROM Linux TO OS X

Using Netatalk, since Samba can be a real pain in the ass....

```
sudo apt-get update
sudo apt-get install netatalk
```

To configure, you'll edit `AppleVolumes.default`. This file includes a ton of lines of explanations on what the file does and all that. Basically the man file inside of the config file. I personally would keep all of the instructions there, just in case you might want to read them at some point.

```
sudo service netatalk stop
sudo nano /etc/netatalk/AppleVolumes.default
```

Next, drop to the bottom of the file, and you'll see one of two uncommented lines:

`:DEFAULT: options:upriv,usedots`
and
`~/                      "Home Directory"`

The `:DEFAULT:` line is where you can set, well, Default directives, such as: `rw` for read/write, and `tm` for TimeMachine support. There are others, I have no doubt. Look through the directions at the top of the file (why I said no need to delete all of it!)

Below the `~/` is where you can add more paths to share to the network. Obviously, `~/` is the home directory of the current user.

Most people like to mount their USB items to the `/media` directory. AKA `/media/USB1`. If that is you, and you would like to share your USB drives, you can either add `/media` and have one lump share of all mounted USB drives or you can add each one individually. Up to you. Make sure to name each item as well. Makes life easier.

```
~/                      "Home Directory"
/media                      "USB Drives"
/media/USB1                      "USB1"
```

Now, if you have your file configured the way you like, go ahead and save it and start up netatalk.

`sudo service netatalk start`

Obviously make sure the user you use to login with has access to those directories you've decided to share, otherwise it'll be kinda pointless....

If your external USB is a large HDD with files already on it, with already-setup permissions, you obviously don't really wanna screw with those too much. So, its usually easier to add your current user to the group of whoever owns the files on the USB drive.

`sudo usermod -aG [group] [user]`

where [group] is obviously the group name, and [user] is the username.

`sudo usermod -aG sudo $USER`

will add your $USER to the group sudo.

Now, on your Finder in OS X, you should see your Linux Boxes name under `Devices > [Your Mac] > Network > [Name of your Linux]`. Then, once the connection failed, hit `connect as` and enter your Linux username and password. It should login almost immediately, and begin showing whatever directories you decided to share!
