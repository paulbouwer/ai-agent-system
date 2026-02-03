# Git Workflow Checklist

Consolidated validation checklist for all git workflow operations.

---

## Branch Creation

### Pre-Creation

- [ ] Issue exists in tracking system
- [ ] Issue ID identified
- [ ] Branch type determined (`feat`, `fix`, `docs`, `core`, `refactor`, `test`)
- [ ] Branch description prepared (lowercase, hyphens)

### Validation

- [ ] Branch name matches pattern: `{type}/{issue-id}-{description}`
- [ ] Branch name passes regex: `^(feat|fix|core|docs|refactor|test)/[0-9]+-[a-z0-9][a-z0-9-]*$`
- [ ] Branch created from correct base (`main` or designated branch)
- [ ] Upstream tracking configured

### Post-Creation

- [ ] Branch pushed to remote
- [ ] Issue linked to branch (if provider supports)

---

## Commits

### Pre-Commit

- [ ] Changes are atomic (single logical change)
- [ ] Changes are related (same feature/bug/task)
- [ ] Commit type identified
- [ ] Commit scope identified (if applicable)

### Message Validation

- [ ] Type is valid (`feat`, `fix`, `docs`, `core`, `refactor`, `test`)
- [ ] Subject line ≤50 characters
- [ ] Subject uses imperative mood
- [ ] Subject starts lowercase after colon
- [ ] No period at end of subject
- [ ] Body lines ≤72 characters (if body present)

### AI Attribution

- [ ] If AI contributed: `Co-authored-by` trailer present
- [ ] If AI contributed: `agent` trailer present
- [ ] If AI contributed: `model` trailer present
- [ ] No partial trailer sets (all or none)

### Signing (GitHub only)

- [ ] Commit signing configured
- [ ] Commit is signed (`git log --show-signature -1`)

---

## Pull Request Creation

### Pre-PR Validation

- [ ] All commits follow conventional format
- [ ] Branch pushed with upstream tracking
- [ ] Issue ID extracted from branch name
- [ ] Issue context retrieved (title, description)

### PR Content

- [ ] Title follows conventional commit format
- [ ] Title ≤72 characters
- [ ] Description includes overview
- [ ] Related issue linked with closing keyword
- [ ] Changes section lists modifications
- [ ] AI usage section included (if commits have AI trailers)
- [ ] Total description ≤4000 characters

### Post-Creation

- [ ] PR created in provider
- [ ] Issue updated with PR link (if applicable)
- [ ] Reviewers assigned (if required)

---

## Quick Reference

| Operation | Key Validation |
| --------- | -------------- |
| Branch | `{type}/{issue-id}-{description}` format |
| Commit | Conventional format, AI trailers complete |
| PR | Issue linked, ≤4000 chars, AI usage tracked |
