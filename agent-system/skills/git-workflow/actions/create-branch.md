# Create Branch

## Purpose

Create a standards-compliant git branch linked to an issue, ensuring traceability and consistent naming.

---

## Flow

### Step 1: Load Standards

Load from this skill's `standards/`:

- `core.md` — Invariant workflow rules
- `checklist.md` — Validation criteria
- `github-provider.md` — Issue provider commands

Load from `standards/git-workflow/`:

- `branch.md` — Branch naming policy

**Success Criteria:**

- [ ] All standards loaded

---

### Step 2: Gather Information 🛑

Collect required information from user:

| Input | Required | Description | Example |
| ----- | -------- | ----------- | ------- |
| Issue ID | ✅ | Work item identifier | `97`, `PROJ-123` |
| Branch Type | ✅ | Type of change | `feat`, `fix`, `docs` |
| Description | ✅ | Brief description | `add-authentication` |
| Source Branch | ❌ | Branch to create from | `main` (default) |

**Valid Branch Types** (from `standards/git-workflow/branch.md`):

| Type | Purpose |
| ---- | ------- |
| `feat` | New feature or capability |
| `fix` | Bug fix or defect resolution |
| `core` | Infrastructure or tooling changes |
| `docs` | Documentation updates |
| `refactor` | Code restructuring |
| `test` | Test additions or modifications |

**Issue Context:** If issue ID provided, read issue details for context:

```bash
gh issue view {issue-id} --json title,body
```

**🛑 STOP**: Wait for user to provide required information.

**Success Criteria:**

- [ ] Issue ID provided
- [ ] Branch type selected
- [ ] Description provided

---

### Step 3: Construct Branch Name

Format: `{type}/{issue-id}-{description}`

**Naming Rules:**

- Type: lowercase, one of accepted types
- Issue ID: numeric identifier
- Description: lowercase alphanumeric with hyphens

**Validation Pattern:**

```regex
^(feat|fix|core|docs|refactor|test)/[0-9]+-[a-z0-9][a-z0-9-]*$
```

**Examples:**

```text
feat/97-add-repo-assets
fix/123-null-pointer-validation
docs/456-update-api-docs
```

**Success Criteria:**

- [ ] Branch name follows naming convention
- [ ] Branch name passes validation pattern

---

### Step 4: Verify Source Branch

Ensure source branch exists and is up to date:

```bash
# Fetch latest from remote
git fetch origin

# Check if source branch exists
git rev-parse --verify origin/{source-branch}
```

**Default Source:** `main`

**Success Criteria:**

- [ ] Source branch exists
- [ ] Latest changes fetched

---

### Step 5: Check for Existing Branch

Verify branch doesn't already exist:

```bash
# Check local branches
git branch --list {branch-name}

# Check remote branches
git branch -r --list origin/{branch-name}
```

**If branch exists:**

- Inform user
- Ask whether to switch to existing branch or choose different name

**Success Criteria:**

- [ ] Branch name is unique (or user confirmed switch)

---

### Step 6: Create Branch

Create the new branch from source:

```bash
# Create and switch to new branch
git checkout -b {branch-name} origin/{source-branch}
```

**Success Criteria:**

- [ ] Branch created locally
- [ ] Switched to new branch

---

### Step 7: Push and Set Upstream

Push branch to remote with upstream tracking:

```bash
git push -u origin {branch-name}
```

**Success Criteria:**

- [ ] Branch pushed to origin
- [ ] Upstream tracking configured

---

### Step 8: Confirm Creation

Display confirmation:

```text
✓ Branch created successfully: {branch-name}
  Source: {source-branch}
  Tracking: origin/{branch-name}
  Issue: #{issue-id}
```

**Optional:** Link branch to issue (if provider supports):

```bash
gh issue comment {issue-id} --body "Branch created: \`{branch-name}\`"
```

**Success Criteria:**

- [ ] Confirmation displayed
- [ ] Branch ready for development

---

## Error Handling

| Error | Recovery |
| ----- | -------- |
| Invalid branch type | Show valid types, ask for correction |
| Source branch not found | List available branches, ask for selection |
| Branch already exists | Offer to switch or rename |
| Push failed | Check permissions, network connectivity |
| Invalid branch name | Show validation errors, ask for correction |
| Issue not found | Verify issue ID, check repository |
