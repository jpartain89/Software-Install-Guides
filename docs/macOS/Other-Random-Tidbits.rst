====================
Other Random Tidbits
====================

This page will be for those little nuggets of info that I have to have documented or else when I forget again, I'll remember having known how to fix it before, but no clue on what to do or where to go. The worst feeling in the world!

This is to stop that.

Local WebPage Wont Load Anywhere!!!
===================================

A locally-hosted site refused to load in any web browser on the same computer, but it would load in my iPhone...

Essentially the DNS cache was poisoned and needed to be flushed. The only command that worked was:

.. code-block:: bash

  dscacheutil -flushcache && sudo killall -HUP mDNSResponder

which I have saved as an alias.
