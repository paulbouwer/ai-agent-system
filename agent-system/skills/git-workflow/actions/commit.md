# Commit

## Purpose

Create conventional commits with proper grouping and AI attribution tracking.

---

## Flow

### Step 1: Load Standards

Load from this skill's `standards/`:

- `core.md` — Invariant workflow rules
- `checklist.md` — Validation criteria
- `signing-setup.md` — SSH signing configuration (reference if needed)

Load from `standards/git-workflow/`:

- `commit.md` — Commit format policy, AI trailer configuration
- `commit.template.md` — Commit message templates

**Configuration:**

- `ENFORCE_GIT_SIGNING` — Set to `true` for GitHub, `false` for Azure DevOps

**Success Criteria:**

- [ ] All standards loaded

---

### Step 2: Check Git Status

Run `git status --porcelain` to identify all changes.

**Understanding the Output:**

```text
XY filename
│└─ Working tree status (unstaged)
└── Index status (staged)
```

| Code | Meaning |
| ---- | ------- |
| `M_` | Modified, staged only |
| `_M` | Modified, unstaged only |
| `MM` | Modified, both staged AND unstaged |
| `A_` | Added, staged |
| `??` | Untracked file |

_(Note: `_` represents a space character)_

**Key Rules:**

- Only commit files with staged changes (first character is not space or `?`)
- If files are pre-staged, commit only those files
- If no files are staged, analyze and group changes

**Success Criteria:**

- [ ] Git status output parsed correctly
- [ ] Staged vs unstaged changes identified

---

### Step 3: Determine Commit Strategy

**Decision Point:**

| Condition | Action |
| --------- | ------ |
| Files are pre-staged | Proceed to Step 6 (single commit flow) |
| No files are staged | Proceed to Step 4 (analyze and group) |

**Success Criteria:**

- [ ] Commit strategy determined

---

### Step 4: Analyze and Group Changes

If no files are pre-staged:

1. Run `git diff` to view all unstaged changes
2. Read issue context for grouping guidance:
   ```bash
   gh issue view {issue-id} --json title,body
   ```
3. Analyze changes and group into logical, atomic commits

**Grouping Criteria** (from `standards/core.md`):

| Group Together | Do NOT Group |
| -------------- | ------------ |
| Same feature/concern | Different features |
| Same change type | Docs with unrelated code |
| Logical dependencies | Config with unrelated features |
| Same scope/module | Refactoring with new features |

**Success Criteria:**

- [ ] All changes analyzed
- [ ] Logical commit groups identified

---

### Step 5: Present Commit Plan 🛑

Display proposed commits:

```text
Proposed commits:
1. feat(auth): add login validation - src/auth.ts, src/auth.test.ts
2. docs: update README - README.md
3. fix(api): handle null response - src/api/client.ts
```

**🛑 STOP**: Wait for user confirmation of commit plan.

**Success Criteria:**

- [ ] Commit plan presented to user
- [ ] User confirmed plan

---

### Step 6: Ask About Attribution 🛑

Ask user:

1. "Were these changes made with AI assistance? (yes/no)"
2. "Any co-authors to credit? Enter as 'Name <email>', or 'none'"

**For multi-commit flows**, specify per-commit:

- AI assistance: `1, 3` or `all` or `none`
- Co-authors: `1: Jane <email>` or `all: Jane <email>` or `none`

**🛑 STOP**: Wait for user response.

**Success Criteria:**

- [ ] AI assistance question answered
- [ ] Co-author question answered

---

### Step 7: Stage Changes

For each commit group:

```bash
git add <file1> <file2> ...
```

**Important:** Never use `git add .` for multi-commit workflows.

**Success Criteria:**

- [ ] Correct files staged for current commit

---

### Step 8: View Staged Changes

Run `git diff --cached` to verify staged changes.

**Success Criteria:**

- [ ] Staged changes verified
- [ ] Changes match intended commit

---

### Step 9: Generate Commit Message

Create message following `standards/git-workflow/commit.template.md`.

**Message Rules:**

- Subject ≤ 50 characters
- Body lines ≤ 72 characters
- Imperative mood
- Include AI trailers if AI-assisted

**Success Criteria:**

- [ ] Message follows conventional commit format

---

### Step 10: Confirm AI Agent Details 🛑

If commit marked as AI-assisted:

1. Display detected values: `"Detected: agent={agent}, model={model}"`
2. Ask: "Proceed with these values? (yes/no or provide corrections)"

**Agent Detection Methods** (in priority order):

1. **Environment variable**: Check for `AGENT_NAME`
2. **Known context signals**:
   - VS Code with Copilot → `github-copilot`
   - Claude Code CLI → `claude-code`
   - Cursor IDE → `cursor`
   - OpenCode → `opencode`
3. **Self-identification**: AI agent identifies the invoking tool

**Format**: Use kebab-case (e.g., `github-copilot`, `claude-code`)

**🛑 STOP**: Wait for user confirmation.

**Success Criteria:**

- [ ] Agent and model confirmed or corrected

---

### Step 11: Execute Commit

**Signing Check** (if `ENFORCE_GIT_SIGNING` is `true`):

```bash
git config --get user.signingkey
```

- **If empty:** STOP. Inform user signing is not configured. Reference `signing-setup.md`.
- **If configured:** Proceed with `-S` flag.

**Execute commit:**

| Scenario | Command |
| -------- | ------- |
| AI + Co-authors | `git commit -S -m "{message}" --trailer "Co-authored-by: Name <email>" --trailer "Co-authored-by: {Agent} <{model}@{agent}>" --trailer "agent: {agent}" --trailer "model: {model}"` |
| AI only | `git commit -S -m "{message}" --trailer "Co-authored-by: {Agent} <{model}@{agent}>" --trailer "agent: {agent}" --trailer "model: {model}"` |
| Co-authors only | `git commit -S -m "{message}" --trailer "Co-authored-by: Name <email>"` |
| No attribution | `git commit -S -m "{message}"` |

**Note:** Omit `-S` flag if `ENFORCE_GIT_SIGNING` is `false`.

**Success Criteria:**

- [ ] Commit created successfully
- [ ] Commit is signed (if required)
- [ ] All trailers present as expected

---

### Step 12: Repeat for Remaining Groups

If multiple commit groups exist, return to Step 7 for the next group.

**Success Criteria:**

- [ ] All commit groups processed

---

### Step 13: Verify Commits

Run `git log --oneline -n {count}` to confirm all commits.

**Success Criteria:**

- [ ] All commits verified in log
- [ ] Commit messages follow standards

---

## Error Handling

| Error | Recovery |
| ----- | -------- |
| No changes detected | Inform user, exit workflow |
| Signing not configured | Reference signing-setup.md, block commit |
| Signing failed | Inform user, suggest troubleshooting |
| Commit hook rejected | Display validation error, allow correction |
| Staging failed | Check file paths, permissions |
