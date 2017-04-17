======================
NZBGet [NZBGet-HTPC]_
======================

NZBGet is a downloading program specifically for downloading from [Usenet-Servers]_. They are inherintely more secure and are, in general, much quicker to download than torrents.

UnRar
=====

First, install `UnRAR <unrar-link>`_. This is specifically for handingling what are called ``.rar`` files. Those mysterious crazy files that you randomly come across on the internets.

Rar files are usually large files, taken apart into seperate items, along with a couple extra, documentation files for how they should be pieced back together again. ``unrar`` handles these guys along with NZBGet.

.. code-block:: bash

  sudo apt-get install unrar

NZBGet Installation
====================

NZBGet Is installed... a bit different than other, apt-based applications.

[NZBGet-GitHub]_ is nice enough to provide us shell scripts that take care of a lot of installation steps. Though, if you're like me, you might, at LEAST, want to look over what this script does first.

But, if you want the installation command, thats:

.. code-block:: bash

  wget -O - http://nzbget.net/info/nzbget-version-linux.json | \
  sed -n "s/^.*stable-download.*: \"\(.*\)\".*/\1/p" | \
  wget --no-check-certificate -i - -O nzbget-latest-bin-linux.run

.. note::

  Check out :ref:`using-forwardslash` for some breakdown as above.

Sadly, a lot of times this command doesn't always work out, and its almost never a "one-size-fits-all" scenario on why. The best first step is to look at [NZBGet-GitHub]_ to see what they say, and if anyone else has had the same issues.

.. [NZBGet-HTPC] Copied from `HTPCGuides on NZBGet <htpcguides-nzbget>`_
.. [NZBGet-GitHub] `NZBGet GitHub Page <nzbget-github-page>`_
.. [Usenet-Servers] Usenet Servers are the old-school Internet, more-or-less, before there was a real "internet." `Usenet Wikipedia <usenet-wikipedia>`_

.. _unrar-link: http://rarlab.com/
.. _htpcguides-nzbget: http://www.htpcguides.com/install-latest-nzbget-on-ubuntu-15-x-with-easy-updates/
.. _nzbget-github-page: https://github.com/nzbget/nzbget/
.. _usenet-wikipedia: https://en.wikipedia.org/wiki/Usenet/
