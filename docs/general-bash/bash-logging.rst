============
Bash Logging
============

tl;dr::

  exec 1> >(logger -s -t "$(basename "$0")") 2>&1

Been looking for a way to pipe your entire bash script into a `log file`, `syslog`, `journald`, or whatever? The above line does it super simply!!

This was a line I had found a few years back, started learning ansible, and lost this nugget of knowledge, and recenlty found it once again (but lost the website I found it from... Sorry!)

-----------------
What does it do?
-----------------

- ``exec``: this line tells bash "you are to run everything"
- ``1> >(`` this sets up piping ``1`` (``stdout``) through to whats inside the parenthesis
- ``logger -s -t "$(basename "$0")")`` the ``logger`` program is a means of piping output into your systems ``syslog`` or ``rsyslog`` or what have you. ``basename`` adds the file/scripts name onto the syslog entry.
- ``2>&1`` is for piping ``2`` or ``stderr`` into the ``exec`` command

This information was wonderfully pulled from `UrbanAutomation <https://urbanautomaton.com/blog/2014/09/09/redirecting-bash-script-output-to-syslog/>`_'s website.
