#!/usr/bin/env bash
set -euo pipefail

# Installation file for Software-Install-Guides
# Ensures pipenv is available and installs/updates the project's dependencies

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Checking for python"
if ! type -P python3 >/dev/null 2>&1; then
	echo "Python 3 not found. Trying to install..."
	if type -P apt-get >/dev/null 2>&1; then
		sudo apt-get update
		sudo apt-get install -y python3 python3-pip
	elif type -P brew >/dev/null 2>&1; then
		brew install python
	else
		echo "No supported package manager found. Please install Python 3 and re-run this script."
		exit 1
	fi
fi

echo "Checking for pipenv..."
if ! type -P pipenv >/dev/null 2>&1; then
	echo "pipenv not found. Attempting to install pipenv using pip."
	pip3 install --user pipenv
	if command -v pip3 >/dev/null 2>&1; then
		PIP_CMD=pip3
	elif command -v pip >/dev/null 2>&1; then
		PIP_CMD=pip
	else
		echo "No pip or pip3 found. Please install Python pip and re-run this script."
		exit 1
	fi

	if ! type -P pipenv >/dev/null 2>&1; then
		# Try to add user base bin to PATH for this script execution
		USER_BASE=$(${PIP_CMD} --version >/dev/null 2>&1 || true)
		echo "Warning: pipenv still not found after install. You may need to add the user's local bin to PATH."
		echo "Typically: export PATH=\"\$(python3 -m site --user-base)/bin:\$PATH\""
		exit 1
	fi
fi

echo "Installing project dependencies with pipenv..."
pipenv --python /opt/homebrew/bin/python3.13 install --dev

echo "Updating project dependencies with pipenv..."
pipenv --python /opt/homebrew/bin/python3.13  update || true

echo
echo "Pipenv environment ready. To build the docs run:" \
		 "pipenv run sphinx-build -b html . _build/" \
		 "or use 'make html' which calls pipenv run sphinx-build."
