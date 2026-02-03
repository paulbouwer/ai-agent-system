# Pull Request Standard

## Standards for Pull Request Structure and Content

This document defines the rules and standards for creating pull requests, including structure conventions, content requirements, and linking policies.

## PR Title Format

Pull request titles must follow the conventional commit format:

```text
{type}({scope}): {description}
```

### Title Rules

| Element | Requirement |
| ------- | ----------- |
| Type | Must match branch type: `feat`, `fix`, `core`, `docs`, `refactor`, `test` |
| Scope | Optional, matches affected area |
| Description | Brief summary, imperative mood |

### Examples

```text
feat(auth): add JWT token validation
fix(parser): handle null input gracefully
docs(api): update endpoint documentation
core(ci): add automated testing pipeline
```

## PR Description Structure

### Required Sections

| Section | Purpose | Required |
| ------- | ------- | -------- |
| Description | Brief overview of changes | ✅ Yes |
| Related Issues | Link to work items | ✅ Yes |
| Changes | Detailed list of modifications | ✅ Yes |
| Additional Context | Extra information | ❌ Optional |
| Coding Agents Used | AI contribution tracking | ⚠️ If applicable |

### What/Why Pattern

Each change should explain:

- ***What***: Brief description of what was changed
- ***Why***: Reason for the change

```text
**✨ feat(auth): Add login validation**
*What*: Added input validation for login credentials
*Why*: Prevent injection attacks and improve error messages
📁 Files: `src/auth.ts` (`validateCredentials`, `sanitizeInput`)
```

## Issue Linking

### Automatic Linking

Extract issue ID from branch name:

```text
feat/123-add-widget  →  Issue #123
fix/PROJ-456-fix-bug →  Issue PROJ-456
```

### Closing Keywords

Use these keywords to automatically close issues on merge:

- `Fixes #123`
- `Closes #456`
- `Resolves #789`

## AI Agent Usage Tracking

### When to Include

Include the "Coding Agents Used" section when:

1. Git commits contain agent/model trailers
2. Total PR description ≤ 4000 characters

### When to Comment Instead

Post as PR comment when:

1. Including the section would exceed 4000 characters
2. Detailed breakdown is needed

### Usage Table Format

```markdown
| Agent | Model | Commits |
| ----- | ----- | ------- |
| github-copilot | gpt-4o | 5 |
| cursor | claude-opus-4-5 | 3 |
```

## Character Limits

| Element | Limit | Enforcement |
| ------- | ----- | ----------- |
| Title | 72 characters | Recommended |
| Description | 4000 characters | Required (provider limit) |

## Pre-PR Validation

### Required Policies

Before PR creation, validate:

| Policy | Requirement | Blocks PR |
| ------ | ----------- | --------- |
| Branch Pushed | Upstream tracking configured | ✅ Yes |
| Commits Exist | Changes between source and target | ✅ Yes |

## Review Requirements

### Reviewer Assignment

| PR Type | Minimum Reviewers | Auto-Assign |
| ------- | ----------------- | ----------- |
| Feature | 1 | ✅ Recommended |
| Fix | 1 | ✅ Recommended |
| Docs | 1 | ❌ Optional |
| Core/Infra | 2 | ✅ Required |

### Review Focus Areas

Reviewers should check:

- [ ] Code quality and standards compliance
- [ ] Test coverage
- [ ] Documentation updates
- [ ] Security considerations
- [ ] Performance implications

## Best Practices

### DO

- Use the PR template consistently
- Link to related issues and documentation
- Provide clear context for reviewers
- Include screenshots for UI changes
- Update documentation with code changes

### DON'T

- Create PRs without issue linkage
- Exceed 4000 character description limit
- Submit PRs with failing checks
- Merge without required approvals
- Use vague titles like "Updates" or "Fix bugs"

## References

- [PR Template](./pull-request.template.md)
- [Commit Standard](./commit.md)
- [Branch Standard](./branch.md)
