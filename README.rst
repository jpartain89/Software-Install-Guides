=======================
Software Install Guides
=======================

|rtd_image|

My personal reStructuredText - ``rst`` - files for my Software Installation Guides.

The majority of these guides are the ones that I find myself - time and time again - repeatedly having to revist in order to either; build, rebuild or re-aquaint myself with some point of knowledge.

I have these docs - both self-hosted and being hosted - on `ReadTheDocs.org`_ at `docs.jpcdi.com`_. The ReadTheDocs hosting part was a recent occurrence. Currently, my NGINX-based server is reverse-proxying out to ReadTheDocs.

To Install Sphinx Stuff
=======================

Run ``./scripts/install.sh``

This will install ``python-pip`` in Debian-based systems or ``python`` through `homebrew`_ on macOS.

.. _ReadTheDocs.org: http://readthedocs.org/
.. _docs.jpcdi.com: https://docs.jpcdi.com/
.. _homebrew: https://brew.sh
.. |rtd_image| image:: http://readthedocs.org/projects/software-install-guides/badge/?version=latest
  :target: http://software-install-guides.readthedocs.io/en/latest/?badge=latest
  :alt: Documentation Status
