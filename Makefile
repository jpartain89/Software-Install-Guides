# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = pipenv run sphinx-build
PAPER         =
BUILDDIR      = _build
TMPDIR        = _tmp
RTD_OS        ?= ubuntu-26.04

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .

.PHONY: all
all: install clean linkcheck dummy html

clean:
	rm -rf $(BUILDDIR)/*

linkcheck:
	mkdir -p $(TMPDIR)/linkcheck
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(TMPDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(TMPDIR)/linkcheck/output.txt."
dummy:
	$(SPHINXBUILD) -b dummy $(ALLSPHINXOPTS) $(TMPDIR)/dummy
	@echo
	@echo "Build finished. Dummy builder generates no files."

html:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	#$(RSYNC) $(BUILDDIR)/html /var/www/html/docs
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

.PHONY: help
help:
	@echo "Please use \`make <target>\` where <target> is one of"
	@echo "  build         Runs clean, linkcheck, dummy and builds the documentation"
	@echo "  install       to install needed-python stuff"
	@echo "  clean         Removes any old files, previously built - if present"
	@echo "  local-tests   Removes any old docs and runs local tests "
	@echo "  linkcheck     to check all external links for integrity"
	@echo "  dummy         to check syntax errors of document sources"
	@echo "  html          to make standalone HTML files"
	@echo "  dirhtml       to make HTML files named index.html in directories"
	@echo "  text          to make text files"
	@echo "  update        updates Python (via pyenv), pipenv lock/deps, and .readthedocs.yaml"

.PHONY: build
build: clean linkcheck dummy html

.PHONY: local-tests
local-tests: clean linkcheck dummy

.PHONY: html

.PHONY: dirhtml
dirhtml:
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml."

.PHONY: text
text:
	$(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(TMPDIR)/text
	@echo
	@echo "Build finished. The text files are in $(TMPDIR)/text."

.PHONY: linkcheck

.PHONY: clean

.PHONY: dummy

.PHONY: update
update:
	@set -e; \
	if ! command -v pyenv >/dev/null 2>&1; then \
		echo "Error: pyenv is required for 'make update'."; \
		exit 1; \
	fi; \
	if ! command -v pipenv >/dev/null 2>&1; then \
		echo "Error: pipenv is required for 'make update'."; \
		exit 1; \
	fi; \
	PYTHON_FULL_VERSION="$$(pyenv install --list | sed 's/^[[:space:]]*//' | grep -E '^3\.[0-9]+\.[0-9]+$$' | tail -1)"; \
	if [ -z "$$PYTHON_FULL_VERSION" ]; then \
		echo "Error: unable to detect latest stable CPython from pyenv."; \
		exit 1; \
	fi; \
	PYTHON_RTD_VERSION="$$(printf '%s' "$$PYTHON_FULL_VERSION" | awk -F. '{print $$1 "." $$2}')"; \
	case "$$PYTHON_RTD_VERSION" in \
		3.8|3.9|3.10|3.11|3.12|3.13|3.14) ;; \
		*) \
			echo "Error: Read the Docs does not support Python selector '$$PYTHON_RTD_VERSION'."; \
			echo "Set an explicit supported version and rerun make update."; \
			exit 1; \
		;; \
	esac; \
	echo "Using CPython $$PYTHON_FULL_VERSION (Read the Docs selector: $$PYTHON_RTD_VERSION)."; \
	mkdir -p "$(TMPDIR)"; \
	PYENV_TMPDIR="$$PWD/$(TMPDIR)"; \
	TMPDIR="$$PYENV_TMPDIR" pyenv install -s "$$PYTHON_FULL_VERSION"; \
	PYENV_PYTHON="$$(pyenv root)/versions/$$PYTHON_FULL_VERSION/bin/python"; \
	if [ ! -x "$$PYENV_PYTHON" ]; then \
		echo "Error: Python executable not found at $$PYENV_PYTHON."; \
		exit 1; \
	fi; \
	awk -v v="$$PYTHON_FULL_VERSION" '\
		/^python_version[[:space:]]*=/ {print "python_version = \"" v "\""; next} \
		/^python_full_version[[:space:]]*=/ {print "python_full_version = \"" v "\""; next} \
		{print} \
	' Pipfile > Pipfile.tmp && mv Pipfile.tmp Pipfile; \
	pipenv --python "$$PYENV_PYTHON" install --dev; \
	pipenv --python "$$PYENV_PYTHON" update; \
	printf '%s\n' \
		'# .readthedocs.yaml' \
		'# Read the Docs configuration file' \
		'# See https://docs.readthedocs.io/en/stable/config-file/v2.html for details' \
		'' \
		'version: 2' \
		'' \
		'# Set the version of Python and other tools you might need' \
		'build:' \
		"  os: $(RTD_OS)" \
		'  tools:' \
		"    python: \"$$PYTHON_RTD_VERSION\"" \
		'  jobs:' \
		'    install:' \
		'      - pip install pipenv' \
		'      - pipenv sync --dev --system' \
		'    build:' \
		'      html:' \
		'        - sphinx-build -b html . $$READTHEDOCS_OUTPUT/html' \
		'' \
		'# Build documentation in the docs/ directory with Sphinx' \
		'sphinx:' \
		'  configuration: ./conf.py' \
		'  fail_on_warning: true' > .readthedocs.yaml; \
	echo "Updated Pipfile/Pipfile.lock/.readthedocs.yaml";

install:
	/bin/bash scripts/install.sh
	@echo
	@echo "Installation Finished."
