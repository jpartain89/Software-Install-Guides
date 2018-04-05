# -*- coding: utf-8 -*-
#
# Software Install Guides documentation build configuration file, created by
# sphinx-quickstart on Tue Aug  9 21:08:14 2016.
#
# This file is execfile()d with the current directory set to its
# containing dir.

import os
import sys

from datetime import date

sys.path.insert(0, os.path.abspath('.'))

# --------- This section is for ReadTheDocs ------------------------------
# You have to use this type of coding if building locally with RTD theme, then
# pushing the build out to RTD website for hosting. As RTD will fail because
# they auto-add in the RTD theme building.
# Copied from http://bit.ly/2bsA5zu

# on_rtd is whether we are on readthedocs.org, this line of code grabbed from
# docs.readthedocs.org

on_rtd = os.environ.get('READTHEDOCS') == 'True'

if on_rtd:
    html_theme = 'default'
else:
    import sphinx_rtd_theme
    html_theme = 'sphinx_rtd_theme'
    html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]

# --------- END RTD SECTION ----------------------------------------------

# -- General configuration ------------------------------------------------

extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.intersphinx',
    'sphinx.ext.extlinks'
    ]
templates_path = ['_templates']
source_suffix = ['.rst']
master_doc = 'index'
project = u'Software Install Guides'
copyright = u'2016-' + str(date.today().year) + \
    u', Justin Partain, JPartain89, JPCDI'
author = u'Justin Partain'
version = u'2.7.0'
release = u'2.7.0'
today_fmt = '%B %d, %Y'
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store', '_drafts', 'README.rst']
pygments_style = 'sphinx'
html_theme_options = {'analytics_id': 'UA-75489042-1'}
html_logo = 'JPLogo-Header.png'
html_favicon = 'favicon.ico'
html_static_path = ['_static']
html_last_updated_fmt = '%B %d, %Y'
html_use_smartypants = True
html_domain_indices = True
html_use_index = True
html_show_sourcelink = True
html_show_sphinx = True
html_show_copyright = True
man_pages = [
    (master_doc, 'softwareinstallguides', u'Software Install Guides Documentation',
     [author], 1)
]
man_show_urls = True
texinfo_documents = [
    (master_doc, 'SoftwareInstallGuides', u'Software Install Guides Documentation',
     author, 'SoftwareInstallGuides', 'One line description of project.',
     'Miscellaneous'),
]
linkcheck_ignore = [
    r'http://localhost:\d+/',
    r'http://localhost',
    r'http://127.0.0.1'
]
