---
name: Git Workflow
description: Execute git workflow operations including branch creation, commits, and pull requests
capabilities:
  - create-branch
  - commit
  - create-pull-request
---

# Git Workflow Skill

## Overview

This skill provides capabilities for executing git workflow operations that comply with organisational standards. It covers the complete development lifecycle from branch creation through pull request submission.

## Capabilities

| Capability | Action | Description |
| ---------- | ------ | ----------- |
| Create Branch | `actions/create-branch.md` | Create a standards-compliant branch linked to an issue |
| Commit | `actions/commit.md` | Create conventional commits with AI attribution |
| Create Pull Request | `actions/create-pull-request.md` | Generate a standards-compliant PR linked to an issue |

## Standards

This skill bundles the following standards in `standards/`:

| Standard | File | Description |
| -------- | ---- | ----------- |
| Core | `core.md` | Invariant workflow rules: branch-issue linking, conventional commits, PR-issue linking |
| Checklist | `checklist.md` | Validation checklist for all workflow operations |
| GitHub Provider | `github-provider.md` | GitHub CLI commands for issues and PRs |
| Signing Setup | `signing-setup.md` | SSH commit signing configuration guide |

## External Standards

This skill references customizable policy standards from `standards/git-workflow/`. These can be modified by organisations to match their specific requirements:

| Standard | File | Description |
| -------- | ---- | ----------- |
| Branch | `branch.md` | Branch naming patterns, allowed types, validation regex |
| Commit | `commit.md` | Commit types, scopes, AI trailer configuration |
| Commit Template | `commit.template.md` | Commit message templates |
| Pull Request | `pull-request.md` | PR title format, description structure, review requirements |
| Pull Request Template | `pull-request.template.md` | PR description template |

## Usage

1. Load this skill manifest
2. Identify the required capability (create-branch, commit, or create-pull-request)
3. Load the bundled standards from `standards/`
4. Load the customizable policy standards from `standards/git-workflow/`
5. Execute the action following `actions/<capability>.md`
