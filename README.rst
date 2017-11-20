=======================
Software Install Guides
=======================

===========  ==================
RTD Build     Travis-CI Build
===========  ==================
|rtd_image|  |travis-ci_image|
===========  ==================

My personal reStructuredText - ``rst`` - files for my Software Installation Guides.

The majority of these guides are the ones that I find myself - time and time again - repeatedly having to revist in order to either; build, rebuild or re-aquaint myself with some point of knowledge.

I have these docs - both self-hosted and being hosted - on `ReadTheDocs.org`_ at `docs.jpcdi.com`_. The ReadTheDocs hosting part was a recent occurrence. Currently, my NGINX-based server is reverse-proxying out to ReadTheDocs.

To Install Sphinx Stuff
=======================

You have to have python and ``pip`` already installed on your system. The main reason for this is that the `Homebrew <homebrew>`_  team recently made some changes to how pip is installed on our macOS systems. (Its installed under ``pip2``, ``pip2.7``, etc.)

Run ``./scripts/install.sh``

This will subsequently install the required python programs to let you build and view the docs.

Then, run ``make local-tests``. This will run link tests on all of the URL's, along with testing for any other errors or issues, and then will build the docs into HTML files that are viewable from your browser.

.. _ReadTheDocs.org: http://readthedocs.org/
.. _docs.jpcdi.com: https://docs.jpcdi.com/
.. _homebrew: https://brew.sh
.. |rtd_image| image:: http://readthedocs.org/projects/software-install-guides/badge/?version=latest
    :target: http://software-install-guides.readthedocs.io/en/latest/?badge=latest
    :alt: Documentation Status
.. |travis-ci_image| image:: https://travis-ci.org/jpartain89/Software-Install-Guides.svg?branch=master
    :target: https://travis-ci.org/jpartain89/Software-Install-Guides
