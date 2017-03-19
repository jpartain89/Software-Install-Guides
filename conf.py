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

extensions = ['sphinx.ext.autodoc']
templates_path = ['_templates']
source_suffix = ['.rst']
master_doc = 'index'
project = u'Software Install Guides'
copyright = u'2016-' + str(date.today().year) + \
    u', Justin Partain, JPartain89, JPCDI'
author = u'Justin Partain'
version = u'2.1.0'
release = u'2.1.0'
today_fmt = '%B %d, %Y'
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store', '_drafts']
pygments_style = 'sphinx'

html_theme_options = {
    'analytics_id': 'UA-75489042-1',
}

html_title = u'Software Install Guides v1.7'

# A shorter title for the navigation bar.  Default is the same as html_title.
#
#html_short_title = u'Software Install Guides v1.7'

# The name of an image file (relative to this directory) to place at the top
# of the sidebar.
#
html_logo = 'JPLogo-Header.png'

# The name of an image file (relative to this directory) to use as a favicon of
# the docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
# pixels large.
#
html_favicon = 'favicon.ico'

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
html_static_path = ['_static']

# Add any extra paths that contain custom files (such as robots.txt or
# .htaccess) here, relative to this directory. These files are copied
# directly to the root of the documentation.
#
# html_extra_path = []

# If not None, a 'Last updated on:' timestamp is inserted at every page
# bottom, using the given strftime format.
# The empty string is equivalent to '%b %d, %Y'.
#
html_last_updated_fmt = '%B %d, %Y'

# If true, SmartyPants will be used to convert quotes and dashes to
# typographically correct entities.
#
html_use_smartypants = True

# Custom sidebar templates, maps document names to template names.
#
# html_sidebars = {}

# Additional templates that should be rendered to pages, maps page names to
# template names.
#
# html_additional_pages = {}

# If false, no module index is generated.
#
html_domain_indices = True

# If false, no index is generated.
#
html_use_index = True

# If true, the index is split into individual pages for each letter.
#
# html_split_index = False

# If true, links to the reST sources are added to the pages.
#
html_show_sourcelink = True

# If true, "Created using Sphinx" is shown in the HTML footer. Default is True.
#
html_show_sphinx = True

# If true, "(C) Copyright ..." is shown in the HTML footer. Default is True.
#
html_show_copyright = True

# If true, an OpenSearch description file will be output, and all pages will
# contain a <link> tag referring to it.  The value of this option must be the
# base URL from which the finished HTML is served.
#
# html_use_opensearch = ''

# This is the file name suffix for HTML files (e.g. ".xhtml").
# html_file_suffix = None

# Language to be used for generating the HTML full-text search index.
# Sphinx supports the following languages:
#   'da', 'de', 'en', 'es', 'fi', 'fr', 'hu', 'it', 'ja'
#   'nl', 'no', 'pt', 'ro', 'ru', 'sv', 'tr', 'zh'
#
#html_search_language = 'en'

# A dictionary with options for the search language support, empty by default.
# 'ja' uses this config value.
# 'zh' user can custom change `jieba` dictionary path.
#
# html_search_options = {'type': 'default'}

# The name of a javascript file (relative to the configuration directory) that
# implements a search results scorer. If empty, the default will be used.
#
# html_search_scorer = 'scorer.js'

# Output file base name for HTML help builder.
htmlhelp_basename = 'SoftwareInstallGuidesdoc'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {
    # The paper size ('letterpaper' or 'a4paper').
    #
    # 'papersize': 'letterpaper',

    # The font size ('10pt', '11pt' or '12pt').
    #
    # 'pointsize': '10pt',

    # Additional stuff for the LaTeX preamble.
    #
    # 'preamble': '',

    # Latex figure (float) alignment
    #
    # 'figure_align': 'htbp',
}

# Grouping the document tree into LaTeX files. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
    (master_doc, 'SoftwareInstallGuides.tex', u'Software Install Guides Documentation',
     u'Justin Partain', 'manual'),
]

# -- Options for manual page output ---------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, 'softwareinstallguides', u'Software Install Guides Documentation',
     [author], 1)
]

man_show_urls = True

# -- Options for Texinfo output -------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
    (master_doc, 'SoftwareInstallGuides', u'Software Install Guides Documentation',
     author, 'SoftwareInstallGuides', 'One line description of project.',
     'Miscellaneous'),
]
