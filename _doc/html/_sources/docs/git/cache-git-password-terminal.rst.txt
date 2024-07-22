=============================
Saving your Git Repo Password
=============================

When pushing back up to your own git repo - and you are using HTTPS for the address - it should ask for your password. And, if you have your username in the repo address, it'll bypass asking you for that info. But, you are able to cache your password; if you have fairly frequent pushes, and/or trust the system you're using.

Of course, depending on the system you are using, depends on how long that info is cached:

- If you're on a linux machine, there is a specific time you can program in for caching
- If you're on macOS, it caches that info up to your Keychain, therefore its accessible so long as you're logged into the machines account its saved to

These caching programs have the moniker ``credential helpers``

---
OR
---

You can use the ssh version of the URL instead!:

.. code-block:: bash

  git clone git@github.com:username/your-repo
  git clone git@gitlab.com:username/your-repo

And that will utilize the SSH keys you have setup with those respective services, which you do have setup, right??? (You give them the public key, and then you can use your private key for authentication.)

------
macOS
------

In your macOS's terminal, to see if ``osxkeychain helper`` is already installed:

.. code-block:: bash

  git credential-osxkeychain

  usage: git credential-osxkeychain <get|store|erase>

If its not downloaded, it'll prompt you to retrieve the Xcode Command Line Tools that you have to have to do much of anything terminal-wise on macOS. That output will tell you what to do in that event.

Next, you have to tell ``git``, through config files, to utilize the credential helper.

.. code-block:: bash

  git config --global credential.helper osxkeychain

Now, the next time you try to do anything requiring that git password, it'll prompt you for the info, and then automatically save it in your keychain.
