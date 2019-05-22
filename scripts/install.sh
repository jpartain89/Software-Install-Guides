#!/bin/bash -e

# Installation file for Software-Install-Guides
## Not installing the DOCS, but the `Sphinx-Docs` parts that you need
## to build the docs.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$(uname)" == "Linux" ]]; then
    . /etc/*release
    PIPBIN="$(command -v pip3)"
else
    if [[ ! -z "$(command -v pip3)" ]]; then
        PIPBIN="$(command -v pip3)"
    fi
fi

sudo -H "${PIPBIN}" install --upgrade -r "${DIR}/requirements.txt"
