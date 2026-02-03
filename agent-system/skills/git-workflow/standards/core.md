# Git Workflow Core Standards

Invariant rules for git-based development workflows. These rules define the process and cannot be overridden by organisational policy.

## Fundamental Principles

### 1. Issue-First Development

All work MUST be traceable to an issue in the tracking system.

| Artifact | Issue Requirement |
| -------- | ----------------- |
| Branch | MUST include issue ID in name |
| Commits | SHOULD reference issue context for grouping |
| Pull Request | MUST link to originating issue |

### 2. Conventional Commits

All commits MUST follow the [Conventional Commits](https://www.conventionalcommits.org/) specification.

```text
{type}[optional scope]: {description}

[optional body]

[optional footer(s)]
```

### 3. Atomic Changes

Each commit MUST represent a single logical change that can be independently understood and reverted.

## Branch Rules

### Branch-Issue Linking

Every branch MUST include the issue identifier:

```text
{type}/{issue-id}-{description}
```

**Rationale:** Enables automated traceability, simplifies PR creation, and ensures all work is tracked.

### Branch Lifecycle

```text
main ──▶ create branch ──▶ develop ──▶ push ──▶ PR ──▶ merge ──▶ delete branch
```

1. Branch from `main` (or designated base branch)
2. Develop with atomic commits
3. Push with upstream tracking
4. Create pull request
5. Merge after approval
6. Delete source branch

## Commit Rules

### Message Structure

| Element | Requirement |
| ------- | ----------- |
| Type | REQUIRED — must be valid type from policy |
| Scope | OPTIONAL — area affected |
| Description | REQUIRED — imperative mood, ≤50 characters |
| Body | OPTIONAL — explain what and why, ≤72 chars/line |
| Trailers | CONDITIONAL — required when AI contributes |

### AI Attribution

When AI coding agents contribute to a commit:

1. Include `Co-authored-by` trailer with agent identity
2. Include `agent` trailer with tool identifier
3. Include `model` trailer with model identifier

All trailers must be present together — partial sets are invalid.

### Commit Grouping

**Group together:**

- Related changes serving a single purpose
- Same feature, bug, or task
- Logically dependent changes (test + implementation)

**Separate:**

- Different features or bugs
- Unrelated documentation
- Independent refactoring

## Pull Request Rules

### PR-Issue Linking

Every pull request MUST be linked to an issue:

1. Extract issue ID from branch name
2. Include issue reference in PR description
3. Use closing keywords when appropriate (`Fixes #123`, `Closes #456`)

### PR Content Requirements

| Section | Requirement |
| ------- | ----------- |
| Title | MUST follow conventional commit format |
| Description | MUST include overview of changes |
| Related Issues | MUST link to originating issue |
| Changes | MUST list modifications with what/why |
| AI Usage | MUST include if commits have AI trailers |

### Character Limits

| Element | Limit | Enforcement |
| ------- | ----- | ----------- |
| Title | 72 characters | Recommended |
| Description | 4000 characters | Required (provider limit) |

## Protected Branches

| Branch | Direct Commits | PR Required |
| ------ | -------------- | ----------- |
| `main` | ❌ Prohibited | ✅ Required |
| Feature branches | ✅ Allowed | N/A |

## Signing Requirements

Commit signing requirements vary by platform:

| Platform | Signing Required |
| -------- | ---------------- |
| GitHub | ✅ Required |
| Azure DevOps | ❌ Not supported |

See `signing-setup.md` for SSH signing configuration.

## Workflow Diagram

```text
┌─────────────────────────────────────────────────────────────────┐
│                        Git Workflow                             │
├─────────────────────────────────────────────────────────────────┤
│  1. Create Branch    →  Issue-linked, standards-aligned        │
│  2. Make Changes     →  Atomic commits, conventional format    │
│  3. Push Branch      →  Remote tracking, validation hooks      │
│  4. Create PR        →  Issue-linked, AI usage tracked         │
│  5. Review & Merge   →  Approval required, squash or merge     │
└─────────────────────────────────────────────────────────────────┘
```

## References

- [Conventional Commits Specification](https://www.conventionalcommits.org/)
- Policy standards in `standards/git-workflow/`
