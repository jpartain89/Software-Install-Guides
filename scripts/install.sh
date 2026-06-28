#!/usr/bin/env bash
set -euo pipefail

# Installation file for Software-Install-Guides
# Ensures pipenv is available and installs/updates the project's dependencies

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PIPFILE_PATH="${DIR}/../Pipfile"

get_required_python_version() {
	awk -F'"' '
		/^python_full_version[[:space:]]*=/ { print $2; exit }
		/^python_version[[:space:]]*=/ { print $2; exit }
	' "${PIPFILE_PATH}"
}

python_version_matches_requirement() {
	local required_version="$1"
	local installed_version="$2"

	if [[ "${required_version}" == *.*.* ]]; then
		[[ "${installed_version}" == "${required_version}" ]]
	else
		[[ "${installed_version}" == "${required_version}".* ]]
	fi
}

REQUIRED_PYTHON_VERSION="$(get_required_python_version)"

if [[ -z "${REQUIRED_PYTHON_VERSION}" ]]; then
	echo "Unable to determine the required Python version from ${PIPFILE_PATH}."
	exit 1
fi

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

PYTHON_PATH="$(type -P python3)"
INSTALLED_PYTHON_VERSION="$("${PYTHON_PATH}" -c 'import sys; print(".".join(str(part) for part in sys.version_info[:3]))')"

if ! python_version_matches_requirement "${REQUIRED_PYTHON_VERSION}" "${INSTALLED_PYTHON_VERSION}"; then
	echo "Installed Python version ${INSTALLED_PYTHON_VERSION} does not match the required version ${REQUIRED_PYTHON_VERSION} from ${PIPFILE_PATH}."
	echo "Update ${PIPFILE_PATH} if the project is moving to a newer Python release, or install the required Python version and re-run this script."
	exit 1
fi

export PATH="$("${PYTHON_PATH}" -m site --user-base)/bin:${PATH}"

echo "Checking for pip..."
if "${PYTHON_PATH}" -m pip --version >/dev/null 2>&1; then
		PIP_CMD=("${PYTHON_PATH}" -m pip)
	elif command -v pip3 >/dev/null 2>&1; then
		PIP_CMD=(pip3)
	elif command -v pip >/dev/null 2>&1; then
		PIP_CMD=(pip)
	else
		echo "No pip or pip3 found. Please install Python pip and re-run this script."
		exit 1
fi

if ! type -P pipenv >/dev/null 2>&1; then
	echo "pipenv not found. Attempting to install pipenv using pip."
	"${PIP_CMD[@]}" install --user pipenv

	if ! type -P pipenv >/dev/null 2>&1; then
		echo "Warning: pipenv still not found after install. You may need to add the user's local bin to PATH."
		echo "Typically: export PATH=\"\$(python3 -m site --user-base)/bin:\$PATH\""
		exit 1
	fi
fi

echo "Installing project dependencies with pipenv..."
pipenv --python "${PYTHON_PATH}" install --dev

echo "Updating project dependencies with pipenv..."
pipenv --python "${PYTHON_PATH}" update || true

echo
echo "Pipenv environment ready. To build the docs run:" \
		 "pipenv run sphinx-build -b html . _build/" \
		 "or use 'make html' which calls pipenv run sphinx-build."
