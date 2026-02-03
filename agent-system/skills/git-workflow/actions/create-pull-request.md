# Create Pull Request

## Purpose

Create a standards-compliant pull request with issue linking and AI contribution tracking.

---

## Flow

### Step 1: Load Standards

Load from this skill's `standards/`:

- `core.md` — Invariant workflow rules
- `checklist.md` — Validation criteria
- `github-provider.md` — PR creation commands

Load from `standards/git-workflow/`:

- `pull-request.md` — PR format policy
- `pull-request.template.md` — PR description template

**Success Criteria:**

- [ ] All standards loaded

---

### Step 2: Pre-PR Validation

Validate foundational requirements before proceeding.

#### Validation 1: Branch Pushed

```bash
git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null
```

- **If no upstream:** Block PR creation
- Display: "❌ Current branch has not been pushed. Run `git push -u origin <branch>` first."

#### Validation 2: Commits Exist

```bash
git log {target}..{current} --oneline
```

- **If no commits:** Block PR creation
- Display: "❌ No commits found between {target} and {current}. Nothing to merge."

**Success Criteria:**

- [ ] Branch has upstream tracking
- [ ] Commits exist between source and target

---

### Step 3: Determine Context

#### Current Branch

```bash
git branch --show-current
```

#### Target Branch

```bash
git remote show origin | grep 'HEAD branch' | sed 's/.*: //'
```

Default: `main`

#### Extract Issue ID

Parse issue ID from branch name:

```text
feat/123-add-widget  →  Issue #123
fix/456-fix-bug      →  Issue #456
```

#### Get Issue Context

```bash
gh issue view {issue-id} --json title,body
```

Use issue title and description to inform PR content.

#### Get Commits

```bash
git log {target}..{current} --oneline
```

**Success Criteria:**

- [ ] Current branch identified
- [ ] Target branch determined
- [ ] Issue ID extracted
- [ ] Issue context retrieved
- [ ] Commits listed

---

### Step 4: Extract AI Usage from Commits

Scan commits for AI attribution trailers:

```bash
git log {target}..{current} --format="%B" | grep -E "^(agent|model):"
```

**Aggregate usage:**

| Agent | Model | Commits |
| ----- | ----- | ------- |
| github-copilot | gpt-5-2 | 3 |
| claude-code | claude-sonnet-4-5 | 2 |

**Success Criteria:**

- [ ] AI trailers extracted from commits
- [ ] Usage aggregated by agent/model

---

### Step 5: Generate PR Content

#### Title

Format: `{type}({scope}): {description}`

- Derive type from branch prefix
- Derive scope and description from branch name or issue title

#### Description

Use template from `standards/git-workflow/pull-request.template.md`:

1. **📝 Description** — Overview from issue context
2. **🔗 Related Issues** — `Fixes #{issue-id}`
3. **🚀 Changes** — What/Why for each change (from commits)
4. **🙏 Additional Context** — Extra information
5. **🤖 Coding Agents Used** — AI usage table (if applicable)

**Character Limit:** Total description ≤ 4000 characters

**Success Criteria:**

- [ ] Title follows conventional format
- [ ] Description uses template
- [ ] Issue linked with closing keyword
- [ ] AI usage included (if applicable)
- [ ] Description ≤ 4000 characters

---

### Step 6: User Confirmation 🛑

**MANDATORY: Explicit user approval required.**

Display PR Preview:

```text
═══════════════════════════════════════════════════════════
📋 PULL REQUEST PREVIEW
═══════════════════════════════════════════════════════════
Title: {pr_title}
Source: {current_branch}
Target: {target_branch}

{full description}
═══════════════════════════════════════════════════════════

Ready to create this PR? (yes/no/edit)
```

| Response | Action |
| -------- | ------ |
| yes/y | Proceed to Step 7 |
| no/n | Display "PR creation cancelled", stop |
| edit | Allow modifications, re-display preview |

**🛑 STOP**: Wait for explicit user approval.

**Success Criteria:**

- [ ] Preview displayed
- [ ] User explicitly approved

---

### Step 7: Create Pull Request

Create PR using GitHub CLI:

```bash
gh pr create \
  --title "{pr_title}" \
  --body "{pr_description}" \
  --base {target_branch}
```

**Optional flags:**

- `--reviewer user1,user2` — Request reviewers
- `--assignee user` — Assign PR
- `--draft` — Create as draft

**Success Criteria:**

- [ ] PR created successfully

---

### Step 8: Display Success

```text
✓ Pull Request created successfully!
  URL: {pr_url}
  PR #: {pr_number}
  Source: {current_branch}
  Target: {target_branch}
  Issue: #{issue-id} (will close on merge)
```

**Optional:** Comment on issue with PR link:

```bash
gh issue comment {issue-id} --body "PR created: {pr_url}"
```

**Success Criteria:**

- [ ] PR URL displayed
- [ ] Success message shown

---

## Error Handling

| Error | Recovery |
| ----- | -------- |
| Branch not pushed | Display error, instruct to push first |
| No commits to merge | Display error, nothing to create |
| Issue not found | Proceed without issue context, warn user |
| PR already exists | Display existing PR URL |
| Description exceeds limit | Trim content, move AI usage to comment |
| PR creation failed | Display error, check permissions |
| gh CLI not authenticated | Run `gh auth login` |
