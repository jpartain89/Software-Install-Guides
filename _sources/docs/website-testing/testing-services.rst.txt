=====================================
Testing your Web Server Configuration
=====================================

This is a running list of websites that will, well, test your website for different reasons, mostly security.

------
List
------

#. `securityheaders.com <https://securityheaders.com>`_ an analyzer and rating system for your HTTP response headers, along with links to how to's to update your config. 
#. `Qualys SSL Labs <https://www.ssllabs.com/index.html>`_ This is the big behemoth of testing sites. They tend to be considered the defacto-standard for security testing.
#. `Mozilla HTTP Observatory <https://observatory.mozilla.org/>`_ broad web security checks (headers, TLS, and common hardening controls).
#. `OWASP ZAP <https://www.zaproxy.org/>`_ open-source active/passive web app security scanner for deeper testing.
#. `CFSSL <https://github.com/cloudflare/cfssl>`_ still useful as a PKI/TLS toolkit, but treat it as a tooling component rather than a primary web scanner.

.. rubric:: Update Changelog


Changed On
  2026-07-04

Summary of Updates
  - Expanded the testing list with modern maintained tools (Observatory and OWASP ZAP).
  - Repositioned CFSSL as PKI tooling rather than a primary hosted site scanner.

Reason for Change
  Keep website testing recommendations aligned with currently active security tooling.

Compatibility Notes
  Links and tools are current web security references as of this documentation update.

Tested On
  Documentation review only (commands not executed in this repo).
