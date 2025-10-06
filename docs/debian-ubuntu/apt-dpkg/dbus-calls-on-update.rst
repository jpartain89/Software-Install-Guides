====================
dbus Calls on Update
====================

I've recently had issues with the `dbus` service randomly not wanting to allow connections through its socket connection, for whatever reason... But one error that always annoyed me was when I tried running `apt-get update`, while the dbus issues were occurring, I'd get a `Failed to Connect` error message with no way of knowing what its trying to connect to!

The following logs show what `apt`, `apt-get`, `dpkg` or whatever is doing on that step:

.. bash:

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
