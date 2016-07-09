# Use External USB Stick for Raspberry Pi OS

## Find the USB Drive

If you're using a simple low-powered thumb drive, simply plug it into the Raspberry Pi. If you're planning on using a larger, HDD-like drive, I would suggest you use an externally powered USB hub device. To help power the external drive and not draw too much from the Raspberry Pi.

Next, type `lsusb` to see a basic break down of what your RPI can see. It doesn't exactly get you a lot of info, but it doesn't hurt to start here.

Usually, I see:

```bash
Bus 001 Device 004: ID 0930:6545 Toshiba Corp. Kingston DataTraveler 102 Flash Drive / HEMA Flash Drive 2 GB / PNY Attache 4GB Stick
Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp. SMSC9512/9514 Fast Ethernet Adapter
Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

The top line being the flash drive that I have plugged in. But, you'll notice, it doesn't give you the nice pretty `/dev/sd[x]` that we're needing here.

Now, the website I'm using as a guide for this instructional -  [Adafruit.com](https://learn.adafruit.com/external-drive-as-raspberry-pi-root/hooking-up-the-drive-and-copying-slash) - suggests using `dmesg` as a way to find your device. Though this can be messy because `dmesg` is basically your systems "this is what I'm doing and seeing all the time" kind of messaging service. Anytime a USB device is plugged or unplugged, anytime you start, stop or restart your machine, or any number of events occurring, it adds itself to `dmesg`. So, don't get flustered if you can't find your USB device.

If the last thing you did was insert your USB, it should be the last item appearing on `dmesg`

`sudo dmesg` should show:

```bash
[  459.896922] usb 1-1.2: new high-speed USB device number 4 using dwc_otg
[  460.018734] usb 1-1.2: New USB device found, idVendor=0930, idProduct=6545
[  460.026951] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  460.035530] usb 1-1.2: Product: TransMemory-Mx
[  460.041271] usb 1-1.2: Manufacturer: TOSHIBA
[  460.046801] usb 1-1.2: SerialNumber: 60A44C429E6BED81F000ED00
[  460.055140] usb-storage 1-1.2:1.0: USB Mass Storage device detected
[  460.064034] scsi host0: usb-storage 1-1.2:1.0
[  461.068295] scsi 0:0:0:0: Direct-Access     TOSHIBA  TransMemory-Mx   PMAP PQ: 0 ANSI: 6
[  461.081327] sd 0:0:0:0: [sda] 60929280 512-byte logical blocks: (31.2 GB/29.1 GiB)
[  461.093654] sd 0:0:0:0: [sda] Write Protect is off
[  461.100343] sd 0:0:0:0: [sda] Mode Sense: 45 00 00 00
[  461.101667] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesnt support DPO or FUA
[  461.114459] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  463.171778]  sda: sda1
[  463.182905] sd 0:0:0:0: [sda] Attached SCSI removable disk
```

You'll notice the `sda` monikers there. That would be the `/dev/sda` that we're looking for. So, the newest USB device has been assigned `/dev/sda` on my machine. Now, of course, yours might be different. You never know.

Or, if you're `dmesg` is stupidly long and you can't find it quickly, you can always `sudo dmesg | grep sd[a-z]`. `grep` being a searching program and the `sd[a-z]` being whats called a "regex" search. Basically, grep takes `sd` then adds each letter from a-z to the end and searches for those terms. It then will present you with the information, making it easier for you to find things. The same thing works with `[0-9]` as well. I like to use it to delete a large amount of log files that tend to build up inside of `/var/log`. `sudo rm ./*.[0-9].*` or what have you.

## Install Adafruit's USB Program

Next, to continue the USB bootable instructional.... You want to add Adafruit's Linux Repo to your apt-get stuffs. You can either:

`curl -sLS https://apt.adafruit.com/add | sudo bash`

which will automatically add their repo and do a `sudo apt-get update` for you. Or, you can go the long way round:

First, adding the repo to your `sources.list`

`echo "deb http://apt.adafruit.com/raspbian/ wheezy main" | sudo tee --append /etc/apt/sources.list`

Then, grabbing their gpg key:

`wget -O - -q https://apt.adafruit.com/apt.adafruit.com.gpg.key | sudo apt-key add -`

And then run `sudo apt-get update`.

Next, you'll want to install:

`sudo apt-get install adafruit-pi-externalroot-helper`

Thats their program for having your RPI run off of an external USB.

Then, to run the program:

`sudo adafruit-pi-externalroot-helper -d /dev/sda`

replacing the `/dev/sda` with whatever your USB drive is sitting at. Make SURE you get this right, as you don't want to really wipe your SD card. Though I'm fairly certain not only would that not work, it luckily is an easy fix to get your RPI software back on it again.... Unless you've been using it a while.

This program does take at least a few minutes to run through. You'll need to restart your RPI as well once its finished.

It will give you a series of messages once its done. Make sure to read through them, in case there are any errors. It also tells you how to make sure it worked:

```bash
[boot config] Ok, your system should be ready. You may wish to check:
[boot config]   /mnt/etc/fstab
[boot config]   /boot/cmdline.txt
[boot config] Your new root drive is currently accessible under /mnt.
[boot config] In order to restart with this drive at /, please type:
[boot config] sudo reboot
```

The key lines are:

```bash
Ok, your system should be ready. You may wish to check:
    /mnt/etc/fstab
    /boot/cmdline.txt
```

It really means you need to check `/etc/fstab`. Not sure why they included the extra `/mnt` in there.

My `/etc/fstab` now shows:

```bash
/dev/mmcblk0p1 /boot vfat defaults 0 2
#/dev/mmcblk0p2 / ext4 errors=remount-ro,noatime,nodiratime,commit=120 0 1
tmpfs /tmp tmpfs defaults,nodev,nosuid 0 0
/dev/disk/by-uuid/94551cfd-d0fc-42df-b742-b7a6434c0d8a    /   ext4    defaults,noatime  0       1
```

Notice the commented out line `#/dev/mmcblk0p2`

That was the original line for the sd card. The line prior was also there before, as the SD card was both the boot media and the OS media. But, now the SD is ONLY the boot, and the external USB is the OS media.

You can also `df -h`. This shows your filesystem stuffs. The `-h` being human readable format on the sizes.

```bash
Filesystem      Size  Used Avail Use% Mounted on
/dev/root        29G  1.2G   26G   5% /
devtmpfs        483M  4.0K  483M   1% /dev
none            4.0K     0  4.0K   0% /sys/fs/cgroup
tmpfs           487M     0  487M   0% /tmp
none             98M  232K   98M   1% /run
none            5.0M     0  5.0M   0% /run/lock
none            487M     0  487M   0% /run/shm
cgmfs           100K     0  100K   0% /run/cgmanager/fs
none            100M     0  100M   0% /run/user
/dev/mmcblk0p1   61M   36M   26M  58% /boot
tmpfs            98M     0   98M   0% /run/user/1000
```

`/dev/root` being the USB drive now. And, it shows the large size of the USB drive as well.

### Recovering from a failed boot

If the RPI should ever not wanna work correctly with the USB drive this way, you can always take the SD card out of your RPI, plug it into your regular machine that you used to install the OS.

Then, open the first partition and find the file `cmdline.txt`. Replace the text `root=PARTUUID=....rootdelay=5` with `root=/dev/mmcblk0p2`, which will point the root partition back to the 2nd partition of your SD card. It should roughly look like this:

`dwc_otg.lpm_enable=0 console=ttyAMA0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline rootwait fbcon=map:10 fbcon=font:VGA8x8`

Place the SD card back into the RPI, and it should boot normally.
