# Future Enhancement Ideas

Future enhancement ideas for the agent system.

---

## Decision Records

### DR001: Scan for Undocumented Decisions

**Idea:** Add a capability to scan a codebase and identify architectural decisions that should have decision records but don't.

**Context:** During a planning session (2026-01), this was identified as a valuable companion to the existing create/review capabilities. Many projects have implicit decisions embedded in code, configuration, or commit history that would benefit from formal documentation.

**Potential Approach:**

- Analyse commit messages for decision-related keywords (e.g., "decided", "chose", "switched to", "migrated")
- Scan configuration files for significant technology choices
- Look for TODO/FIXME comments that reference decisions
- Compare detected technologies against existing decision records

**Priority:** Medium

**Added:** 2026-01-29

---

## Git Workflow

### GW001: Issue Provider Abstraction

**Idea:** Extract the GitHub provider from git-workflow skill into a separate issue skill with provider abstraction supporting multiple platforms.

**Context:** During git-workflow skill migration (2026-02), we bundled GitHub CLI commands directly in `skills/git-workflow/standards/github-provider.md` as a temporary solution. This works for GitHub-only projects but doesn't support GitLab, Azure DevOps, Jira, or other issue tracking systems.

**Potential Approach:**

- Create `skills/issue/` with provider abstraction
- Define common interface: read issue, update issue, add comment
- Implement providers: `github-provider.md`, `gitlab-provider.md`, `azure-devops-provider.md`
- Git-workflow skill references issue skill instead of bundling provider

**Priority:** Medium

**Added:** 2026-02-01

---

### GW002: Review Capability

**Idea:** Add a review capability to the git-workflow skill for analysing existing branches, commits, and PRs against standards.

**Context:** During git-workflow skill planning (2026-02), review was identified as a valuable capability (matching decision-records and devcontainer patterns) but deferred to focus on core create operations first.

**Potential Approach:**

- Add `actions/review.md` to git-workflow skill
- Review branch naming compliance
- Review commit message format and grouping
- Review PR description completeness and issue linking
- Generate compliance report with recommendations

**Priority:** Low

**Added:** 2026-02-01

---

### GW003: Additional Issue Providers

**Idea:** Implement issue providers for GitLab, Azure DevOps, and Jira.

**Context:** Current implementation only supports GitHub via `gh` CLI. Enterprise environments often use different platforms.

**Potential Approach:**

- GitLab: Use `glab` CLI or GitLab API
- Azure DevOps: Use `az devops` CLI
- Jira: Use Jira REST API or `jira-cli`
- Each provider implements the same interface from GW001

**Priority:** Low

**Added:** 2026-02-01

---

## General

{Future general agent system enhancements will be captured here}
