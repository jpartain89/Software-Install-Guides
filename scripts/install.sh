#!/bin/bash -e

# Installation file for Software-Install-Guides
## Not installing the DOCS, but the `Sphinx-Docs` parts that you need
## to build the docs.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$(uname)" == "Linux" ]]; then
    . /etc/*release
    PIP_BIN="$(command -v pip2)"
else
    # This is to test for whether the macOS has a system-
    # installed pip, or a homebrew-installed pip2
    if [[ -z "$(command -v pip2)" ]]; then
        PIP_BIN="$(command -v pip2)"
    elif [[ -z "$(command -v pip3)" ]]; then
        echo "Sorry, right now Sphinx-Doc uses python 2.7. "
        echo "Please install python 2.7"
        exit 1
    fi
fi

sudo -H "$PIP_BIN" install --upgrade -r "${DIR}/requirements.txt"
