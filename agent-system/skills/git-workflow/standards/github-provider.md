# GitHub Provider

GitHub CLI commands for issue and pull request operations. This provider will be extracted to a separate issue/platform skill in the future.

## Prerequisites

- GitHub CLI (`gh`) installed and authenticated
- Repository has GitHub remote configured

```bash
# Verify authentication
gh auth status

# Verify repository
gh repo view
```

---

## Issue Operations

### Read Issue

Retrieve issue details for context (branch naming, commit grouping, PR description).

```bash
# Get issue title and body
gh issue view {issue-id}

# Get issue in JSON format for parsing
gh issue view {issue-id} --json title,body,labels,state

# Get just the title
gh issue view {issue-id} --json title --jq '.title'

# Get just the body
gh issue view {issue-id} --json body --jq '.body'
```

**Use Cases:**

- Extract context for branch description
- Understand scope for commit grouping
- Generate PR description content

### Update Issue Description

Modify issue body to add implementation notes or status updates.

```bash
# Update issue body
gh issue edit {issue-id} --body "Updated description"

# Update issue body from file
gh issue edit {issue-id} --body-file description.md

# Add to existing body (requires reading first)
CURRENT_BODY=$(gh issue view {issue-id} --json body --jq '.body')
gh issue edit {issue-id} --body "$CURRENT_BODY

## Additional Notes
New content here"
```

### Add Issue Comment

Add comments to track progress or provide updates.

```bash
# Add a comment
gh issue comment {issue-id} --body "Comment text"

# Add comment from file
gh issue comment {issue-id} --body-file comment.md
```

**Use Cases:**

- Document PR creation
- Track implementation progress
- Note blockers or decisions

---

## Pull Request Operations

### Create Pull Request

Create a new pull request with title and description.

```bash
# Interactive PR creation
gh pr create

# PR with title and body
gh pr create --title "feat(scope): description" --body "PR description"

# PR with body from file
gh pr create --title "feat(scope): description" --body-file pr-description.md

# PR targeting specific base branch
gh pr create --base main --title "feat(scope): description" --body "Description"

# PR with reviewers
gh pr create --title "feat(scope): description" --body "Description" --reviewer user1,user2

# PR linking to issue (auto-close on merge)
gh pr create --title "feat(scope): description" --body "Fixes #123"
```

### PR Creation Options

| Option | Description |
| ------ | ----------- |
| `--title` | PR title (conventional commit format) |
| `--body` | PR description text |
| `--body-file` | Read description from file |
| `--base` | Target branch (default: default branch) |
| `--head` | Source branch (default: current branch) |
| `--reviewer` | Request reviewers (comma-separated) |
| `--assignee` | Assign users (comma-separated) |
| `--label` | Add labels (comma-separated) |
| `--draft` | Create as draft PR |

### View Pull Request

```bash
# View current branch's PR
gh pr view

# View specific PR
gh pr view {pr-number}

# View PR in browser
gh pr view --web
```

---

## Workflow Integration

### Branch Creation Flow

```bash
# 1. Get issue context
ISSUE_TITLE=$(gh issue view {issue-id} --json title --jq '.title')

# 2. Create and push branch
git checkout -b feat/{issue-id}-{description}
git push -u origin feat/{issue-id}-{description}

# 3. Comment on issue (optional)
gh issue comment {issue-id} --body "Branch created: feat/{issue-id}-{description}"
```

### PR Creation Flow

```bash
# 1. Get issue context
ISSUE_TITLE=$(gh issue view {issue-id} --json title --jq '.title')
ISSUE_BODY=$(gh issue view {issue-id} --json body --jq '.body')

# 2. Create PR with issue link
gh pr create \
  --title "feat(scope): description" \
  --body "## Description
Summary of changes

## Related Issues
Fixes #{issue-id}

## Changes
- Change 1
- Change 2"

# 3. Comment on issue with PR link
PR_URL=$(gh pr view --json url --jq '.url')
gh issue comment {issue-id} --body "PR created: $PR_URL"
```

---

## Error Handling

| Error | Cause | Resolution |
| ----- | ----- | ---------- |
| `gh: command not found` | CLI not installed | Install GitHub CLI |
| `not logged in` | Not authenticated | Run `gh auth login` |
| `Could not resolve` | Not in git repo | Navigate to repository |
| `issue not found` | Invalid issue ID | Verify issue exists |
| `pull request already exists` | PR exists for branch | View existing PR |

---

## Future Extraction

This provider is bundled with the git-workflow skill temporarily. Future work will:

1. Extract to separate `issue` skill with provider abstraction
2. Support multiple providers (GitHub, GitLab, Azure DevOps, Jira)
3. Define common interface for issue operations
