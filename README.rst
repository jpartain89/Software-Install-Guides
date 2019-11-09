=======================
Software Install Guides
=======================

===========  ==================
RTD Build     Travis-CI Build
===========  ==================
|rtd_image|  |travis-ci_image|
===========  ==================

My personal reStructuredText - ``rst`` - files for my `Software Installation Guides`_.

The majority of these guides are the ones that I find myself - time and time again - repeatedly having to revist in order to either; build, rebuild or re-aquaint myself with some point of knowledge.

I have these docs - both self-hosted and being hosted - on `ReadTheDocs.org`_ at `docs.jpcdi.com`_. The ReadTheDocs hosting part was a recent occurrence. Currently, my NGINX-based server is reverse-proxying out to ReadTheDocs.

To Install Sphinx Stuff
=======================

Its best to utilize `Homebrew <homebrew>`_ team's python and ``pip`` packages, making sure that its going to be python 3 that will be installed on your system. Python 2 is being phased out and Python 3 is just plain better.

Run ``./scripts/install.sh``. It utilizes ``pip3`` to install the required python programs.

If you want to just run the tests without the documents being built, run ``make local-tests``. Otherwise, you can run ``make build`` to clean out any old documentation, then it runs linkcheck, tests building and then actually builds the documentation.

.. _ReadTheDocs.org: http://readthedocs.org/
.. _Software Installation Guides: docs.jpcdi.com_
.. _docs.jpcdi.com: https://docs.jpcdi.com/
.. _homebrew: https://brew.sh
.. |rtd_image| image:: http://readthedocs.org/projects/software-install-guides/badge/?version=latest
    :target: http://software-install-guides.readthedocs.io/en/latest/?badge=latest
    :alt: Documentation Status
.. |travis-ci_image| image:: https://travis-ci.org/jpartain89/Software-Install-Guides.svg?branch=master
    :target: https://travis-ci.org/jpartain89/Software-Install-Guides
