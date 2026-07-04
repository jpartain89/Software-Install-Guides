====================
dbus Calls on Update
====================

I've recently had issues with the `dbus` service randomly not wanting to allow connections through its socket connection, for whatever reason... But one error that always annoyed me was when I tried running `apt-get update`, while the dbus issues were occurring, I'd get a `Failed to Connect` error message with no way of knowing what its trying to connect to!

The following logs show what `apt`, `apt-get`, `dpkg` or whatever is doing on that step:

.. code-block:: bash

  jpserver systemd[1]: Starting apt-news.service - Update APT News...
  jpserver systemd[1]: Starting esm-cache.service - Update the local ESM caches...
  jpserver systemd[1]: apt-news.service: Deactivated successfully.
  jpserver systemd[1]: Finished apt-news.service - Update APT News.
  jpserver systemd[1]: esm-cache.service: Deactivated successfully.
  jpserver systemd[1]: Finished esm-cache.service - Update the local ESM caches.
  jpserver dbus-daemon[1272]: [system] Activating via systemd: service name='org.freedesktop.PackageKit' unit='packagekit.service' requested by ':1.746' (uid=0 pid=23791 comm="/usr/bin/gdbus call --system --dest org.freedeskto" label="unconfined")
  jpserver systemd[1]: Starting packagekit.service - PackageKit Daemon...
  jpserver PackageKit: daemon start
  jpserver dbus-daemon[1272]: [system] Successfully activated service 'org.freedesktop.PackageKit'
  jpserver systemd[1]: Started packagekit.service - PackageKit Daemon.

Now if I could only figure out why `dbus` is being so temperamental on this system... :/

Update
======

For some reason, the `dbus-org.freedesktop.network1.service` service file was missing from `/lib/systemd/system`.

This file is actually a symlink to `systemd-networkd.service`, essentially creating the required file that `dbus` needs to operate, which is just a link to `systemd-networkd.service`. Which is exactly the point of the file! It's a D-Bus system service that exposes the functions of `systemd-networkd` through the D-Bus interface that allows for applications to commununicate with the network management service without needing to directly know about `systemd-networkd` itself.

Fix!
====

In order to fix the issue, I:

.. code-block:: bash

  cd /lib/systemd/system
  sudo ln -svf systemd-networkd.service dbus-org.freedesktop.network1.service

  # You have to run daemon-reload because we just introduced a change to systemd itself,
  # so it requires a "reload" to catch the change
  sudo systemctl daemon-reload

  # The "enable" option obviously is to "enable" the service, but the "--now" flag
  # is to cause the "start" command to run along with it.
  sudo systemctl enable --now dbus-org.freedesktop.network1.service

And then, for good measure, also restarted `dbus` itself:

.. code-block:: bash

  sudo systemctl restart dbus.service && sudo systemctl status dbus.service

and... it worked...!

Now, how and or why this happened...?

of course I haven't done the proper research to figure this one out!

I'm also documenting this around about a couple weeks after accomplishing the above task in the first place! So, either it'll be today that I'll do a litte research on the issue, or it'll be a few weeks before I think about it again. Or I'll suddenly get in the zone of doing a TON of research that gets me no where, but spending a few hours to all day on the issue... I'll get back to you on that...

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Page reviewed for modernization baseline and footer standardization setup.

Reason for Change
  Standardize per-page change tracking and prepare for phased documentation modernization.

Compatibility Notes
  Not Applicable (administrative documentation footer addition).

Tested On
  Documentation review only.
