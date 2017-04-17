.. _initial-ip-addresses:

=================================
Initial Installation IP Addresses
=================================

FOREWARD
========

I decided to give this subject its own page, rather than being missable bits of info inside of the other how-to posts, because this is a decent subject that, while is easy to figure out, its also easy to just miss and not retain properly.

Meat of the Issue
=================

For all of these various apps that we use for our automation systems and what-not, they are almost always going to be managed through the web browser. Because of this, each app uses a port number, along with the machine's various IP addresses as the address to access the page.

Your unix machine has more than just one IP Address. There's the DHCP-assigned, local IPv4 address (192.168.1.xx or whatever), along with what are referenced as "local" IP addresses, which are ``127.0.0.1`` and ``localhost``.

You can use the "local" addresses to access these programs that we install, but you can only use those from that specific machine. As in the web browser that you're looking at has to be running on that machine locally.

Otherwise, you can use the machines network IP address, usually starting with ``192.168.`` or ``10.0.0``.

Finicky Applications
====================

Now, there are some apps that, upon initial installation and without editing the configuration file, will force you to access its web page from ONLY those "local" addresses, for "security" reasons. Which, if you don't know that that is the reason, can be REALLY annoying...

The usual way to change this is by editing the application's configuration file directly in the terminal and then restarting the app. And this is where you'll see people reference using ``0.0.0.0`` as the address. The reason for this is it tells that app to NOT "bind" to a specific IP number or network card. You CAN specify an IP address, but if that machines address changes and you don't change it in that app? Thats a rabbit hole of annoyance.
