#!/bin/bash -e

# Installation file for Software-Install-Guides
## Not installing the DOCS, but the `Sphinx-Docs` parts that you need
## to build the docs.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[[ "$(uname)" == "Linux" ]] && . /etc/*release

[ -e "$(command -v pip)" ] || {
  if [[ "$(uname)" == "Darwin" ]]; then
    if [[ ! -e "$(command -v brew)" ]]; then
      /usr/bin/ruby -e "$(curl -fsSL  https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew install python
    else
      brew install python
    fi
  elif [[ "$ID_LIKE" == "debian" ]]; then
    sudo apt-get install python-pip -y
  fi
}

sudo -H pip install --upgrade -r "${DIR}/requirements.txt"
