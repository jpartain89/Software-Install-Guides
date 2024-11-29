=======================
Software Install Guides
=======================

My personal reStructuredText - ``rst`` - files for my `Software Installation Guides`_.

The majority of these guides are the ones that I find myself - time and time again - repeatedly having to revist in order to either; build, rebuild or re-aquaint myself with some point of knowledge.

I have these docs - both self-hosted and being hosted - on the project's `Github Pages`_ at `docs.jpcdi.com`_. I recently changed over from `ReadTheDocs`_ to `Github Pages`_.

To Install Sphinx Stuff
=======================

Its best to utilize `Homebrew <homebrew>`_ team's python and ``pip`` packages, making sure that its going to be python 3 that will be installed on your system.

Run ``./scripts/install.sh``. It utilizes ``pipenv`` to install the required python programs.

If you want to just run the tests without the documents being built, run ``make local-tests``. Otherwise, you can run ``make build`` to clean out any old documentation, then it runs linkcheck, tests building and then actually builds the documentation.

Version 8.0.0
=============

Version 7 to version 8 is a gargantuan jump of a ton of pushes that do not follow any set of proper update/upgrade processes or industry-accepted CI/CD rules in anyway, shape, or form...

.. _Software Installation Guides: https://docs.jpcdi.com
.. _docs.jpcdi.com: https://docs.jpcdi.com/
.. _homebrew: https://brew.sh
.. _Github Pages: https://github.com/jpartain89/Software-Install-Guides.git
