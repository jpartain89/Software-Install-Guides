==============
Securing NGINX
==============

This is a high level, very basic, more of a "config-only" document. There will be other docs that better explain the items listed here.

One big, generalized note to keep in mind is each line ends with ``;``

These following steps are almost singularly taken from `Bjornjohansen`_  website. His `NGINX Configuration`_ how-to's were the singular guides I used for securing my setup. I cannot recommend his website more!

Basic HTTPS Setup
=================
Obtaining the Certificate
-------------------------

First off, in order to actually have a secure connection to a website, that website has to have a trusted certificate. Its fine and dandy for you to be your own Certificate Authority, or CA, if only you or people who will trust your certs will access your site. If you want anyone else ever to access your site, services or apps, you need to use an already-trusted CA. Of which, you no longer have to pay for this, if you so choose.

Enter `CertBot`_. They are a means of having a free, short term certificate that is SO SO SO much easier to install than almost any other CA I've ever found. Though, the main downside being that its only valid for 3 months (other CA's offer for much much longer), but it being BOTH free and easy is world-shattering in how long it took for this to occur.

The system works, at least in the way I use it, by creating a temporary webserver itself, then trying to access said webserver through the address you've requested a cert for. As in, your web address has to be pointing to the machine running the certbot server at that time.

Then, once it validates that info, it creates the cert, registers it with the Acme CA (their CA repo that they use/created) and instantly, your website's secure certs are trusted by browsers everywhere, due to the Acme CA being a registered and trusted CA.

The options are wide and varied, but the way I use it is:

.. code-block:: bash

  cd ~/
  wget https://dl.eff.org/certbot-auto
  chmod a+x certbot-auto
  sudo nginx -s stop
  ./certbot-auto certonly

Then follow the prompts. Make sure nothing is hogging the ports ``80`` or ``443``, as thats what certbot's server uses to authorize you.

You'll also see letsencrypt floating around, that was the original name, and is the parent projects name.

Take note of the location of the saved certs.

Server Redirect
---------------

To default-direct all requests to the secured, 443 items, you can use the following in your ``80`` server section.

.. code-block:: bash

  server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name jpcdi.com www.jpcdi.com;
    return 301 https://$server_name$request_uri;
    }

The ``return 301 https://$server_name$request_uri;`` tells the requesting browser or program to use ``https``, which then routes to the next server block, which is ``https``

adding ``http2``
-----------------

The ``http2`` is the new standard for the ``http`` protocol. This is the first update to the protocol in over 15 years, and adds important updates.

From their `FAQs`_:

  **What are the key differences to HTTP/1.x?**
    At a high level, HTTP/2:

    * is binary, instead of textual
    * is fully multiplexed, instead of ordered and blocking
    * can therefore use one connection for parallelism
    * uses header compression to reduce overhead
    * allows servers to “push” responses proactively into client caches

It is, in my opinion, a very important and necessary addition to your NGINX configuration.

On your 443 ``listen`` directives, add ``http2;``, as in:

.. code-block:: bash

  listen 443 default_server ssl http2;
  listen [::]: 443 default_server ssl http2;

The second line being the ipv6 version of the listen directive

Certificate Locations in NGINX
------------------------------

There are 2 specific items you need to start.

  ``ssl_certificate`` and ``ssl_certificate_key``

The ``ssl_certificate`` is specifically the ``fullchain.pem`` file that is in  the ``/etc/letsencrypt/live`` directory.
The ``ssl_certificate_key`` is the ``privkey.pem`` file in the same location as above.

Normally, with almost ANY other CA, there are a million and one steps between start and finish. Between creating accounts, paying them, downloading maybe one file and then sussing out the certificate chains, and all sorts of other things.

Foward Secrecy
--------------

Luckily, and most likely the ONLY, NGINX has Forward Secrecy (FS) enabled by default on its connections. So, awesome on less manual steps.

Optimizing NGINX's Secure Connection
====================================
Connection Credentials Caching
------------------------------

Almost all of the overhead with SSL/TLS is during the initial connection. So, we setup caching parameters.

.. code-block:: bash

  ssl_session_cache shared:SSL:20m;
  ssl_session_timeout 180m;

From Bjornjohansen's `Optimizing NGINX`_ website:
  This will create a cache shared between all worker processes. The cache size is specified in bytes (in this example: 20 MB). According to the Nginx documentation, 1MB can store about 4,000 sessions, so for this example, we can store about 80,000 sessions, and we will store them for 180 minutes. If you expect more traffic, increase the cache size accordingly.

I personally use ``ssl_session_cache shared:SSL:20m builtin:1000;``. You'll notice the added ``builtin`` option, defined below, pulled from nginx's website.

builtin
  a cache built in OpenSSL; used by one worker process only. The cache size is specified in sessions. If size is not given, it is equal to 20480 sessions. Use of the built-in cache can cause memory fragmentation.

SSL Protocols
-------------

So, here is where we disable SSL. (?)

The reason for this:
  SSL is old news, with TLS being what has replaced SSL. But, SSL is still a bit in the common vernacular to this day. SSL also has been broken through several weaknesses and is easily bypassed through protocol downgrade attacks.

The only browser left to not support TLS is IE6. Which, I personally believe if someone is still using that browser, they don't really need my site anyways.

We add:::

  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

to cite the specific secure protocols we use on our site.

Optimizing the Cipher Suites
----------------------------

The cipher suites are how the data is encrypted. We list which suites we will use with the browsers.

I personally use:::

  ssl_prefer_server_ciphers on;
  ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5

The ``ssl_prefer_server_ciphers on;`` is to tell the client we have a preferred order of cipher suites. Then, the list of the suites. Take a look at SSL Labs `Deployment Best Practices`_ for detailed info on the suites.

For the long list they present, you can make a seperate file, save it inside your ``/etc/nginx`` directory, and reference it in your nginx configuration ``include cipher_suites``, and it will use the contents of that file.

Generate DH Parameters
----------------------

Please check `Mozillas Wiki`_ for the explainer on this one, as its nice and complicated.

Create the DH Parameters file with 2048 bit long safe prime:

.. code-block:: bash

  sudo mkdir /etc/nginx/cert
  sudo openssl dhparam 2048 -out /etc/nginx/cert/dhparam.pem

And add it to your config with

.. code-block:: bash

  ssl_dhparam /etc/nginx/cert/dhparam.pem;

Enable OCSP Stapling
--------------------

Online Certificate Status Protocol (OCSP) is a protocol for checking the revocation status of the presented certificate. When a proper browser is presented a certificate, it will contact the issuer of that certificate to check that it hasn’t been revoked. This, of course, adds overhead to the connection initialization and also presents a privacy issue involving a 3rd party. Thus, the reason for OCSP Stapling:

The web server can, at regular intervals, contact the certificate authority’s OCSP server to get a signed response and staple it on to the handshake when the connection is set up. This provides for a much more efficient connection initialization and keeps the 3rd party out of the way.

To make sure the response from the CA is not tampered with, we also set up Nginx to verify the response using the trusted certificate provided by CertBot, which is the ``chain.pem`` file provided.

So, for the NGINX configuration:

.. code-block:: bash

  ssl_stapling on;
  ssl_stapling_verify on;
  ssl_trusted_certificate /etc/letsencrypt/live/jpcdi.com/chain.pem;
  resolver 8.8.8.8 8.8.4.4;

The resolver uses whatever DNS server you specify, so NGINX can find the resolver through the internet.If you want to use another public DNS, use them.

Strict Transport Security
-------------------------

This setting tells your browser, after its attempted an unsecure connection once, will default to the secure connections only within the cached timeframe you have listed.

.. code-block:: bash

  add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload';

The preload is if you want to add your server to the Google Maintained list of sites that are for sure secure.

The includeSubDomains, obviously is to include all subdomains. And I have this in my ``http`` block, above the ``server`` block.

Configuration Example
=====================

Here is the tl;dr configuration, with the above in one place, plus more lines from my personal config file:

.. code-block:: bash

  http {

    # beginning of your config file

    add_header Strict-Transport-Security 'max-age=31536000; includeSubDomains; preload';
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Robots-Tag none;
    add_header X-Download-Options noopen;
    add_header X-Permitted-Cross-Domain-Policies none;

    # Giant sea of SSL stuff...
    ssl_session_cache shared:SSL:20m builtin:1000;
    ssl_session_timeout 180m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

    # Using list of ciphers from https://bjornjohansen.no/optimizing-https-nginx
    ssl_prefer_server_ciphers on;
    ssl_ciphers ECDH+AESGCM:ECDH+AES256:ECDH+AES128:DH+3DES:!ADH:!AECDH:!MD5;

    # rest of http block
  }
  server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name jpcdi.com www.jpcdi.com;
    return 301 https://$server_name$request_uri;
  }
  server {
    listen 443 default_server ssl http2;
    listen [::]:443 default_server ssl http2;

    # Letsencrypt ssl_certs and one dhparam.pem
    ssl_certificate /etc/letsencrypt/live/jpcdi.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/jpcdi.com/privkey.pem;
    ssl_dhparam /etc/nginx/cert/jpcdi_dhparam.pem;

    # HSTS/SSL Stapling stuff...
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8 8.8.4.4 valid=86400;
    ssl_trusted_certificate /etc/letsencrypt/live/jpcdi.com/chain.pem;
  }

.. _Bjornjohansen: https://www.bjornjohansen.no/
.. _NGINX Configuration: https://www.bjornjohansen.no/tag/nginx
.. _Optimizing NGINX: https://www.bjornjohansen.no/optimizing-https-nginx

.. _CertBot: https://certbot.eff.org/

.. _FAQs: https://http2.github.io/faq/#what-are-the-key-differences-to-http1x
.. _Deployment Best Practices: https://github.com/ssllabs/research/wiki/SSL-and-TLS-Deployment-Best-Practices

.. _Mozillas Wiki: https://wiki.mozilla.org/Security/Server_Side_TLS#DHE_handshake_and_dhparam
