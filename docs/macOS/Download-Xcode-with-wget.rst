=================================
Download Beta Xcode with ``wget``
=================================

So, I was looking for a way to download the Beta version of Xcode over the terminal, using either ``wget`` or ``curl``, and almost every suggestion I found got it wrong somehow.... Some made it more complicated than it should be or was probably too old a suggestion for Apple's current login systems...

Either way, I finally found a solution from `Codesd`_'s website that worked wonderfully, and it was the tidbit at the bottom of their post that made the specific difference::

    for some reason cookies.txt only works if I only export cookies for the developer.apple.com website and doesnt work if I export all cookies from browser.

------
How To
------

1. First, you'll need to login to the developer portal at `Beta Xcode Download`_

2. You'll want to copy the download link for whichever Xcode version you are wanting/have access to.

   #. start the download, then cancel it
   #. Then, go to your browser's "downloads" page, where you can copy the specific download URL

3. You'll need to download the cookies specifically for Apple's Developer Webpage, after you've logged in. I don't think Safari has an extension for downloading cookies, but I know Google Chrome has a few. I personally used Chromes Cookies.

As `Codesds Blog Post`_  put it:

    I in no way endorse this product and many other solutions in different browsers should work just as well.

4. Once the extension is installed, go back to Apple's page and hit the extension's button. If, like me, the extension's little popup thing doesn't fully expand, these instructions will help:

   #. Once you hit it, and if the popup shrinks, you can just hit the ``Enter`` key
   #. That will download the website's cookies into a ``txt`` file for you automatically
   #. This information is in the extension's ``help`` page if you right click the extension and select ``Options``

5. And now the actual bash stuff:

.. code-block:: bash

    wget --load-cookies=cookies.txt -c https://download.developer.apple.com/Developer_Tools/Xcode_14.3_Release_Candidate_2/Xcode_14.3_Release_Candidate_2.xip

Replace the specific URL with the URL that you want/need to use, please.

And, you should find that the download this way is much much quicker than through the browser. Which is wonderful when the file is so gargantuan.

---------
Unzipping
---------

For the final step of unzipping/unpacking/un-whatever-its-technical-term-is-for-xip-files, if you have a 3rd party "unzipping" utility like I do (`The Unarchiver`_ is my personal favorite) you'll want to make sure that your system will NOT use it!

Due to the file being a "XIP Secure Archive", as it says in Finder.app, the other tools will fail or throw errors when trying to take care of this ``.xip`` file. So, use the system's ``Archive Utility.app`` to "inflate" the file.

IT WILL TAKE A BIT OF TIME... I assume due it being "Secure", its having to unencrypt whilst expanding. Plus its huge.

.. _Codesd: https://www.codesd.com/item/how-to-download-xcode-or-other-development-tools-in-a-resumable-way.html
.. _Codesds Blog Post: https://www.codesd.com/item/how-to-download-xcode-or-other-development-tools-in-a-resumable-way.html
.. _The Unarchiver: https://theunarchiver.com/
.. _Beta Xcode Download: https://developer.apple.com/xcode/
