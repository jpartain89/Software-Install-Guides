=============================
Saving your Git Repo Password
=============================

When pushing over HTTPS, modern Git hosting services usually require a :abbr:`personal access token (PAT)` rather than your account password. If you are doing frequent pushes on a trusted machine, you can cache credentials with a helper.

Of course, depending on the system you are using, depends on how long that info is cached:

- If you're on a linux machine, there is a specific time you can program in for caching
- If you're on macOS, it caches that info up to your Keychain, therefore its accessible so long as you're logged into the machines account its saved to

These caching programs have the moniker ``credential helpers``.

.. note::

  For GitHub specifically, password auth over HTTPS was removed. Use SSH keys, GitHub CLI auth, or a :abbr:`personal access token (PAT)`.

GitHub CLI option:

.. code-block:: bash

  gh auth login

---
OR
---

You can use the ssh version of the URL instead!:

.. code-block:: bash

  git clone git@github.com:username/your-repo
  git clone git@gitlab.com:username/your-repo

And that will utilize the SSH keys you have setup with those respective services, which you do have setup, right??? (You give them the public key, and then you can use your private key for authentication.)

--------------------
macOS and 1Password
--------------------

`1Password`_ now has ssh key management built into their desktop program! You can either import your existing keys or create brand new ones from within 1Password's interface. And it even has the capability of inserting your public keys into websites - Like Github and Gitlab - when necessary.

-----------
macOS Keys
-----------

In your macOS's terminal, to see if ``osxkeychain helper`` is already installed:

.. code-block:: bash

  git credential-osxkeychain

  usage: git credential-osxkeychain <get|store|erase>

If its not downloaded, it'll prompt you to retrieve the Xcode Command Line Tools that you have to have to do much of anything terminal-wise on macOS. That output will tell you what to do in that event.

Next, you have to tell ``git``, through config files, to utilize the credential helper.

.. code-block:: bash

  git config --global credential.helper osxkeychain

Now, the next time you try to do anything requiring HTTPS credentials, it'll prompt you for a PAT/token and then save it in your keychain.

.. _1Password: https://www.1password.dev/ssh/manage-keys

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Updated HTTPS authentication guidance to modern token/PAT expectations.
  - Added a GitHub-specific note about removed password authentication.
  - Added ``gh auth login`` as a modern alternative workflow.
  - Changed the display of the acronym ``PAT`` to use the :abbr: directive for consistency and clarity per rST formatting.

Reason for Change
  Align Git authentication guidance with current hosted Git security requirements.
  Align the documentation with the use of the :abbr: directive for ``PAT`` throughout the text for consistency and clarity in rST formatting.

Compatibility Notes
  Applies to current GitHub/GitLab HTTPS auth models and macOS keychain credential helper behavior.

Tested On
  Documentation review only (commands not executed in this repo).
