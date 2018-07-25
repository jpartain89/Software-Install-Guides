==========================
DPKG or APT General Errors
==========================

This is a general catch-all doc for any smaller errors you might come across involving the ``apt`` and ``dpkg`` installation systems.

.. _statoverride_fatal:

StatOverride File
=================

Sometimes, for a reason unknown to me, you'll get an error while installing, updating/upgrading - what have you - about the ``statoverride`` file having an unknown user:

.. code-block:: bash

  dpkg: unrecoverable fatal error, aborting:
  unknown user 'cockpit-ws' in statoverride file
  E: Sub-process /usr/bin/dpkg returned an error code (2)

For me, it usually happens after uninstalling a program - which makes sense, seeing as something extra has decided to hang around in our installation program files.

File Name
---------

The specific file that is giving us issues is :file:`/var/lib/dpkg/statoverride`.

How To Fix
-----------

There are 2 different ways I found to remove the extra bit of info from the offending file, of which, both require you to at least see the contents of the file:

.. code-block:: bash

  cat /var/lib/dpkg/statoverride

-- or --

.. code-block:: bash

  sudo nano /var/lib/dpkg/statoverride

First Way
---------

The second option is the first way we can fix this issue, by removing the offending information, which in the above case - :ref:`statoverride_fatal` - the issue is about ``cockpit-ws``. Below is the output of the :file:`/var/lib/dpkg/statoverride` file.

.. code-block:: bash
  :emphasize-lines: 11

  root postdrop 2555 /usr/sbin/postqueue
  root sasl 660 /etc/sasldb2
  postfix postdrop 2710 /var/spool/postfix/public
  root root 4755 /usr/sbin/mount.davfs
  root crontab 2755 /usr/bin/crontab
  root sasl 710 /var/run/saslauthd
  root mlocate 2755 /usr/bin/mlocate
  root root 1733 /var/lib/php/sessions
  root ssl-cert 710 /etc/ssl/private
  root messagebus 4754 /usr/lib/dbus-1.0/dbus-daemon-launch-helper
  root cockpit-ws 4750 /usr/lib/cockpit/cockpit-session
  root postdrop 2555 /usr/sbin/postdrop

You can see the line that includes ``cockpit-ws`` above. If you have the above file open in your text editor, you can simply delete that line out, and rerun your prior apt command again.

Second Way
----------

The second way to fix it is a more official way, using one of :command:`dpkg`'s commands, :command:`dpkg-statoverride` - which makes even more sense....

.. code-block:: bash

  dpkg-statoverride --remove /usr/lib/cockpit/cockpit-session

For this one - and ironically, this is the ONE item that makes NO sense - you have to use the path that is listed in the file, rather than the specific "user" that :command:`&apt` errors out with... And thats why I'm using this option as my second fix, because its more or less an extra step after viewing or editing the :file:`statoverride` file above.
