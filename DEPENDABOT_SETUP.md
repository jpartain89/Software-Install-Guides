# Dependabot Configuration Guide

## Overview

This repository now has a comprehensive Dependabot configuration that monitors dependencies for security vulnerabilities and version updates.

## Detected Package Ecosystems

The analysis of this repository detected the following package ecosystems:

### 1. **Pipenv (Python)**
- **Location:** `/Pipfile` (root directory)
- **Purpose:** Python dependency management for Sphinx documentation tools
- **Key Dependencies:** Sphinx, sphinx-rtd-theme, mkdocs, and related documentation tools
- **Configuration:** Weekly updates on Monday mornings with grouped minor/patch updates

### 2. **GitHub Actions**
- **Location:** `/.github/workflows/` directory
- **Purpose:** CI/CD workflow automation for documentation builds
- **Current Workflow:** `documentation.yml` - builds and deploys documentation to GitHub Pages
- **Configuration:** Weekly updates on Monday mornings with grouped action updates

## Dependabot Configuration Details

The `.github/dependabot.yml` file includes the following best practices:

### Security Features ✅
- **Automatic Security Updates:** Dependabot will automatically open PRs for security vulnerabilities
- **Separate Security PRs:** Security updates are NOT grouped, ensuring immediate visibility
- **Version Updates:** Weekly checks for new versions of dependencies

### Optimization Features ✅
- **Grouped Updates:** Minor and patch updates are grouped to reduce PR noise
- **Scheduled Updates:** All updates run on Monday mornings at 9 AM ET
- **PR Limits:** Limits on open PRs (10 for Python, 5 for GitHub Actions) to prevent overwhelming the repository
- **Smart Labels:** Automatically labels PRs with `dependencies` and ecosystem-specific tags
- **Conventional Commits:** Uses prefixes (`pip:`, `ci:`) for better commit message clarity

### Configuration Options Used

| Option | Value | Purpose |
|--------|-------|---------|
| `interval` | `weekly` | Checks for updates once per week |
| `day` | `monday` | Runs on Mondays to start the week |
| `time` | `09:00` | Runs at 9 AM for visibility during work hours |
| `timezone` | `America/New_York` | Eastern timezone for scheduling |
| `groups` | Enabled | Reduces PR noise by grouping similar updates |
| `open-pull-requests-limit` | 10/5 | Prevents too many open PRs |
| `labels` | Custom | Adds helpful labels for filtering |
| `commit-message.prefix` | `pip`, `ci` | Follows conventional commit standards |

## How to Commit dependabot.yml via GitHub Web Browser

Since the configuration file has been created in this pull request, here's how to finalize it:

### Option 1: Merge This Pull Request
1. Navigate to the pull request page for this branch
2. Review the changes to `.github/dependabot.yml`
3. Click the **"Merge pull request"** button
4. Confirm the merge
5. Dependabot will automatically activate once merged to the default branch

### Option 2: Manual Upload via GitHub Web UI (if starting fresh)
1. Go to your repository on GitHub: `https://github.com/jpartain89/Software-Install-Guides`
2. Click on the **`.github`** folder
3. If `.github` doesn't exist, click **"Add file" → "Create new file"**
4. Name the file: `.github/dependabot.yml`
5. Copy the entire contents from the dependabot.yml file in this repository
6. Scroll down to **"Commit changes"**
7. Add commit message: `Add Dependabot configuration for pip and GitHub Actions`
8. Select **"Commit directly to the main branch"** or **"Create a new branch"**
9. Click **"Commit changes"**

## How to Verify Dependabot is Enabled

After merging or committing the configuration file, verify Dependabot is working:

### Check Dependabot Version Updates
1. Navigate to your repository on GitHub
2. Click on **"Insights"** tab (top navigation)
3. Click on **"Dependency graph"** in the left sidebar
4. Click on **"Dependabot"** tab
5. You should see:
   - ✅ **Dependabot version updates:** Active
   - List of configured ecosystems (pip, github-actions)
   - Last checked timestamp
   - Any open pull requests

### Check Dependabot Security Updates
1. Navigate to **"Settings"** tab in your repository
2. Click on **"Code security and analysis"** in the left sidebar
3. Verify the following are enabled:
   - ✅ **Dependency graph:** Enabled (should be on by default)
   - ✅ **Dependabot alerts:** Enabled
   - ✅ **Dependabot security updates:** Enabled
   
4. If any are disabled, click **"Enable"** next to each option

### Alternative: Check via Security Tab
1. Click on the **"Security"** tab (top navigation)
2. Click on **"Dependabot alerts"** in the left sidebar
3. You'll see any existing vulnerabilities or a message saying "No Dependabot alerts"
4. Click on **"View Dependabot settings"** to verify configuration

## What to Expect After Enabling

### Immediate Actions
- Dependabot will scan your dependencies within a few minutes
- If vulnerabilities are found, you'll receive Dependabot alerts
- Security update PRs will be created automatically (if applicable)

### Weekly Updates (Every Monday at 9 AM ET)
- Dependabot will check for new versions of your dependencies
- Grouped PRs will be created for minor/patch updates
- Each PR will include:
  - Changelog information
  - Release notes
  - Compatibility score
  - Auto-generated commit message with conventional commit prefix

### Pull Request Management
- **Review PRs:** Check the Dependabot PRs in the "Pull requests" tab
- **Merge or Dismiss:** You can merge updates or dismiss them if not needed
- **Automatic Rebasing:** Dependabot will automatically rebase PRs if your base branch changes
- **Comment Commands:** You can comment on PRs with `@dependabot` commands to manage them

## Dependabot Commands (Comment on PRs)

You can interact with Dependabot by commenting on its PRs:

- `@dependabot rebase` - Rebase this PR
- `@dependabot recreate` - Recreate this PR
- `@dependabot merge` - Merge this PR after CI passes
- `@dependabot squash and merge` - Squash and merge this PR after CI passes
- `@dependabot cancel merge` - Cancel a previously requested merge
- `@dependabot reopen` - Reopen a closed PR
- `@dependabot close` - Close this PR
- `@dependabot ignore this [patch|minor|major] version` - Close this PR and ignore this version
- `@dependabot ignore this dependency` - Close this PR and ignore updates for this dependency
- `@dependabot use these labels` - Use the specified labels for future PRs
- `@dependabot use these reviewers` - Use the specified reviewers for future PRs
- `@dependabot use these assignees` - Use the specified assignees for future PRs

## Best Practices & Recommendations

### 1. ✅ **Enable Auto-Merge for Low-Risk Updates** (Optional)
For patch updates that pass tests, consider enabling auto-merge:
```yaml
# Add to each ecosystem in dependabot.yml
automerge:
  - match:
      dependency-type: "all"
      update-type: "semver:patch"
```

### 2. ✅ **Set Up Branch Protection Rules**
Ensure PRs require passing tests before merging:
1. Go to **Settings → Branches**
2. Add rule for your default branch
3. Enable **"Require status checks to pass before merging"**
4. Select required checks (e.g., documentation build)

### 3. ✅ **Review Security Updates Promptly**
- Security PRs are NOT grouped and appear separately
- Prioritize reviewing and merging security updates
- Check the severity rating in the PR description

### 4. ✅ **Monitor Dependabot Logs**
- Check the Dependabot tab regularly for errors
- Failed updates will show error messages
- Update configuration if issues persist

### 5. ✅ **Keep Configuration Updated**
- Review and adjust schedule based on your workflow
- Modify grouping strategy if receiving too many/few PRs
- Update PR limits if needed

### 6. ⚠️ **Current Limitations**
- Dependabot cannot update Python 3.13.9 pinned in Pipfile (major version)
- ReadTheDocs configuration (`.readthedocs.yaml`) is not monitored by Dependabot
- Makefile commands are not checked for updates

## Troubleshooting

### Dependabot Not Running
- Verify file is at `.github/dependabot.yml` (exact path)
- Check YAML syntax is valid (no tabs, correct indentation)
- Ensure you've pushed to the default branch (usually `main` or `master`)
- Wait a few minutes for GitHub to process the file

### No Pull Requests Created
- Check if dependencies are already up to date
- Verify `open-pull-requests-limit` isn't reached
- Check repository settings for Dependabot enablement
- Look for errors in Insights → Dependency graph → Dependabot

### Pull Requests Not Grouped
- Grouping only applies to minor/patch updates
- Security updates are intentionally separate
- Major version updates are separate by default
- Verify `groups` configuration is correct

## Additional Resources

- [Dependabot Documentation](https://docs.github.com/en/code-security/dependabot)
- [Configuration Options Reference](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file)
- [Dependabot Security Updates](https://docs.github.com/en/code-security/dependabot/dependabot-security-updates)
- [Managing Pull Requests](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/managing-pull-requests-for-dependency-updates)
- [Keeping Dependencies Secure](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-supply-chain-security)

## Summary

✅ **Configured Ecosystems:**
- Python (Pipenv) - Root directory
- GitHub Actions - Workflows directory

✅ **Features Enabled:**
- Weekly version update checks
- Automatic security vulnerability detection
- Grouped updates for reduced noise
- Conventional commit messages
- Custom labels for easy filtering

✅ **Next Steps:**
1. Merge this pull request or commit the dependabot.yml file
2. Verify Dependabot is enabled in repository settings
3. Monitor for the first Dependabot PRs (within 24 hours)
4. Review and merge dependency updates as they arrive

---

**Note:** This configuration follows GitHub's recommended best practices for Dependabot and is optimized for a documentation-focused repository with Python dependencies.
