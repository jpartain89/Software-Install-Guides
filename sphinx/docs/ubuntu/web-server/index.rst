================
Web Server Stuff
================

Here, I will mostly be concentrating on the NGINX web server, as that is what I personally use for m y own setup. Plus, when I began looking around for which server systems to use, NGINX kept standing out more and more, simply for the number of people online writing how-to's for it.

I use NGINX mostly as a reverse proxy server to my downloading programs. This way, rather than having every port for every app forwarded through my router, leaving more and more security holes open to be exploited, but it just makes it easier to remember program names over port numbers when trying to access those sites.

Now, I'm also not going to pretend that I am some kind of expert with NGINX. Moreover, most would probably consider me a half-step above newbie, as I do lack a more fundamental unerstanding of the different options inside an NGINX configuration.

.. toctree::

  nginx-from-ubuntu-ppa
  nginx-from-source
  nginx-basic-auth
  ddclient
