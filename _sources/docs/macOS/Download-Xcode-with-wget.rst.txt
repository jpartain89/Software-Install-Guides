=================================
Download Beta Xcode with ``wget``
=================================

For modern macOS systems, the supported and most reliable workflows are:

1. App Store for full Xcode.
2. ``xcode-select --install`` for Command Line Tools only.
3. Apple Developer downloads via browser when you specifically need a beta build.

The old cookie-export + ``wget`` flow can still work in some cases, but it is brittle against Apple auth/session changes.

Either way, I finally found a solution from a now-defunct website that worked wonderfully, and it was the tidbit at the bottom of their post that made the specific difference::

  for some reason cookies.txt only works if I only export cookies for the developer.apple.com website and doesnt work if I export all cookies from browser.

------
How To
------

1. Preferred: install/update Command Line Tools from terminal

.. code-block:: bash

  xcode-select --install

2. Preferred for full Xcode: use App Store updates.

3. If you need a specific beta build, sign in to `Beta Xcode Download`_ and download from the official portal.

4. Advanced fallback (not preferred): cookie-based ``wget`` download.

   #. start the download, then cancel it
   #. Then, go to your browser's "downloads" page, where you can copy the specific download URL

3. You'll need to download the cookies specifically for Apple's Developer Webpage, after you've logged in. I don't think Safari has an extension for downloading cookies, but I know Google Chrome has a few. I personally used Chromes Cookies.

As the site put it:

  I in no way endorse this product and many other solutions in different browsers should work just as well.

4. Once the extension is installed, go back to Apple's page and hit the extension's button. If, like me, the extension's little popup thing doesn't fully expand, these instructions will help:

   #. Once you hit it, and if the popup shrinks, you can just hit the ``Enter`` key
   #. That will download the website's cookies into a ``txt`` file for you automatically
   #. This information is in the extension's ``help`` page if you right click the extension and select ``Options``

5. Example ``wget`` command:

.. code-block:: bash

  wget --load-cookies=cookies.txt -c <apple-developer-xip-url>

.. note::

  Replace with the exact URL from your Apple Developer download session.

If this method fails, go back to App Store/official browser flow; it is more stable over time.

---------
Unzipping
---------

For the final step of unzipping/unpacking/un-whatever-its-technical-term-is-for-xip-files, if you have a 3rd party "unzipping" utility like I do (`The Unarchiver`_ is my personal favorite) you'll want to make sure that your system will NOT use it!

Due to the file being a "XIP Secure Archive", as it says in Finder.app, the other tools will fail or throw errors when trying to take care of this ``.xip`` file. So, use the system's ``Archive Utility.app`` to "inflate" the file.

IT WILL TAKE A BIT OF TIME... I assume due it being "Secure", its having to unencrypt whilst expanding. Plus its huge.

.. _The Unarchiver: https://theunarchiver.com/
.. _Beta Xcode Download: https://developer.apple.com/xcode/

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Reframed page to prioritize supported Xcode install/update paths.
  - Added modern ``xcode-select --install`` and App Store-first guidance.
  - Kept cookie-based ``wget`` as an advanced fallback only.

Reason for Change
  Reduce reliance on brittle login-cookie workflows and align with current Apple-supported install methods.

Compatibility Notes
  Primary guidance targets current macOS workflows; cookie-based wget behavior may vary by Apple auth/session changes.

Tested On
  Documentation review only (commands not executed in this repo).
