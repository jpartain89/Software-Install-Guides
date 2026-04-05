# Copilot Instructions for Software-Install-Guides

## Repository Overview

This repository is a **Sphinx-based documentation site** containing software installation and configuration guides authored by Justin Partain (JPartain89). All content is written in **reStructuredText (RST)** format. The site is hosted on [ReadTheDocs](https://docs.jpcdi.com) and mirrored to GitHub Pages.

There is **no application source code** — every contribution is documentation.

---

## Repository Structure

```
/
├── conf.py                  # Sphinx configuration (root level)
├── index.rst                # Site entry point / top-level TOC
├── Makefile                 # Build targets (html, linkcheck, dummy, clean, install)
├── Pipfile / Pipfile.lock   # Python dependency management (pipenv)
├── .readthedocs.yaml        # ReadTheDocs build configuration
├── scripts/install.sh       # Bootstrap script; installs pipenv + project deps
├── _static/                 # Static assets (CSS, images)
├── _extra_html/             # Extra HTML files copied into the build
├── docs/
│   ├── debian-ubuntu/       # Debian/Ubuntu guides (apt, dpkg, docker, etc.)
│   ├── extras/              # Ansible and miscellaneous extras
│   ├── general-bash/        # Bash scripting guides
│   ├── git/                 # Git usage guides
│   ├── homelabChangelog/    # Personal homelab change log
│   ├── macOS/               # macOS-specific guides
│   ├── virtualbox/          # VirtualBox guides
│   ├── website-testing/     # Web/security testing guides
│   └── archive/             # Older, no-longer-updated guides
└── .github/
    ├── dependabot.yml       # Dependabot: weekly pip + GitHub Actions updates
    └── workflows/
        └── documentation.yml  # CI: build on PRs; deploy to GitHub Pages on merge
```

Each `docs/<topic>/` subdirectory contains:
- An `index.rst` that acts as the chapter entry point with a `toctree` listing sub-pages.
- One `.rst` file per topic/guide.

---

## Content Conventions (RST)

- **File extension:** always `.rst` (configured in `conf.py`: `source_suffix = ['.rst']`).
- **Encoding:** UTF-8.
- **Section underline style** (follow existing files):
  - `=` double overline+underline for the page title.
  - `-` underline for top-level headings.
  - `~` underline for sub-headings.
  - `^` for deeper levels if needed.
- **Code blocks:** use `.. code-block:: bash` (or appropriate language). Indent content 2 spaces.
- **Notes/warnings:** use `.. note::` and `.. warning::` directives.
- **Internal references:** use `:ref:` labels defined with `.. _label-name:`.
- **External links:** use named hyperlinks at the bottom of the file  
  (e.g., `.. _Link Text: https://example.com`).
- **`toctree` directive:** every `index.rst` must have a `.. toctree::` listing child pages without the `.rst` extension.
- **Avoid tabs** — use spaces throughout RST files.

---

## Build System

### Install dependencies (first-time setup)

```bash
bash scripts/install.sh
# or manually:
pip install pipenv
pipenv install
```

### Common Make targets

| Target | Command | Description |
|---|---|---|
| Build HTML | `make html` | Builds the full HTML site into `_build/` |
| Link check | `make linkcheck` | Checks all external hyperlinks |
| Syntax check | `make dummy` | Validates RST syntax without producing output |
| Local tests | `make local-tests` | Runs `clean` + `linkcheck` + `dummy` |
| Full build | `make all` | `install` + `clean` + `linkcheck` + `dummy` + `html` |
| Clean | `make clean` | Removes `_build/` |

All Sphinx commands run inside the pipenv virtualenv via `pipenv run sphinx-build`.

### Build output

- HTML output: `_build/` (git-ignored).
- Temporary files: `_tmp/` (git-ignored).

---

## CI / CD (GitHub Actions)

**Workflow file:** `.github/workflows/documentation.yml`

- **Trigger:** `pull_request` — runs the `doc_test` job (builds HTML) on every PR.
- **Merge trigger:** `pull_request_target` with `types: [closed]` — if the PR is merged into `primary`, the `final_doc_creation` job deploys `_build/` to the `gh-pages` branch via `peaceiris/actions-gh-pages`.
- **Default branch:** `primary` (not `main`).
- **Python version:** 3.13.9 (pinned in `Pipfile` and the workflow).

A PR **must pass the `doc_test` job** (successful `make html`) before merging.

**ReadTheDocs** also auto-builds on push using `.readthedocs.yaml` with `fail_on_warning: true` — treat Sphinx warnings as errors.

---

## Dependabot

Configured in `.github/dependabot.yml`:
- **pip** (Pipfile at root): weekly, Mondays 09:00 ET, minor/patch updates grouped.
- **github-actions**: weekly, Mondays 09:00 ET, all updates grouped.
- Security updates are NOT grouped (appear as individual PRs).

---

## Adding or Editing Guides

1. **Add a new guide** in the relevant `docs/<topic>/` directory as a `.rst` file.
2. **Register it** by adding the filename (without `.rst`) to the `.. toctree::` in that topic's `index.rst`.
3. **Run `make local-tests`** to check syntax and links.
4. **Run `make html`** to verify the full build succeeds.
5. Submit a PR targeting the `primary` branch.

**Moving a guide to archive:** add the page under `docs/archive/index.rst`'s toctree and remove it from its current toctree entry. The archive section is excluded from `linkcheck` (see `linkcheck_exclude_documents` in `conf.py`).

---

## Known Ignored Links

The following URL patterns are configured to be ignored during link checks (`conf.py: linkcheck_ignore`). These include regex patterns copied from the Sphinx configuration:

- `http://localhost:\\d+/`
- `http://localhost`
- `http://127.0.0.1`
- `https://atom.io`
- `http://askubuntu.com`
- `https://theunarchiver.com/`
- `https://securityheaders.com`
- `https://www.linode.com`

Do **not** remove these without verifying the links are reachable.

---

## Errors & Workarounds

| Issue | Workaround |
|---|---|
| `make html` fails with "WARNING treated as error" | Fix the RST warning (undefined reference, missing image, etc.) before pushing — ReadTheDocs sets `fail_on_warning: true`. |
| `pipenv` not on `PATH` after `pip install --user pipenv` | Run `export PATH="$(python3 -m site --user-base)/bin:$PATH"` then retry. |
| `sphinx_rtd_theme` import error during local build | Ensure `pipenv install` completed successfully; the theme must be in the virtualenv. |
| `actions/checkout@v6` / `actions/setup-python@v6` not found | These are pinned in the workflow; if they fail, check the actions marketplace for the latest stable version. |
| ReadTheDocs build uses Python 3.12 (`.readthedocs.yaml`) while local Pipfile requires 3.13.9 | This is intentional — ReadTheDocs constrains available Python versions. Do not change the `.readthedocs.yaml` Python version unless ReadTheDocs adds support for 3.13. |
