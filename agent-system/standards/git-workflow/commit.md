# Git Commit Standard

## Conventional Commits & AI Contribution Tracking

This document defines commit message formatting standards and AI contribution tracking requirements. All commits must follow the Conventional Commits specification with structured trailers for AI coding agent usage.

## Conventional Commits Format

All commits must follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification:

### Basic Structure

```text
{type}[optional scope]: {description}

[optional body]

[optional footer(s)]
```

### Required Components

#### Commit Types

Six standard types are accepted:

| Type | Purpose | Example Use Case |
| ---- | ------- | ---------------- |
| `feat` | New feature or capability | Adding new API endpoint, implementing new workflow |
| `fix` | Bug fix or defect resolution | Fixing null pointer exception, correcting validation logic |
| `core` | Infrastructure or tooling changes | DevContainer setup, CI/CD pipeline updates |
| `docs` | Documentation updates | README changes, API documentation, code comments |
| `refactor` | Code restructuring without behavior change | Extracting methods, reorganizing modules |
| `test` | Test additions or modifications | Adding unit tests, updating test fixtures |

#### Scope (Optional)

Scope provides additional context about the area affected:

```text
feat(auth): add token validation middleware
fix(parser): handle null pointer in message parser
core(azure): update service bus configuration
docs(api): document REST endpoint parameters
```

**Scope Guidelines:**

- Use lowercase, alphanumeric characters with dashes/underscores/dots
- Keep concise and meaningful
- Common scopes: `auth`, `api`, `azure`, `database`, `config`, `ui`

#### Description

The description summarizes the change:

- **Maximum 50 characters** (subject line limit)
- Use imperative mood ("add" not "added" or "adds")
- No period at the end
- Start with lowercase after the colon

### Message Body (Optional)

For complex changes, add a body after a blank line:

- **Maximum 72 characters per line**
- Explain the **what** and **why**, not the how
- Use bullet points for multiple changes
- Separate from subject with a blank line

**Example:**

```text
feat(integration): add HL7 message validation

- Implement schema-based validation for ORU messages
- Add custom error handling for malformed segments
- Support both v2.3 and v2.5 HL7 versions
```

## AI Contribution Tracking

### Required Trailers

When AI coding agents contribute to a commit, capture this information using git trailers. Both trailers (`agent` and `model`) must be present together—if you include one, you must include both.

### Trailer Format

```text
Co-authored-by: {Name} <{email}>
Co-authored-by: {Agent Name} <{model}@{agent}>
agent: {agent-name}
model: {model-name}
```

**Note:** The first `Co-authored-by` (for human contributors) is optional. The agent `Co-authored-by` is required when AI contributes.

### Agent Co-author

When AI assists with a commit, include the agent as a co-author using the standard `Co-authored-by` trailer format:

- **Name**: Human-readable agent name (e.g., `Github Copilot`, `Claude Code`, `Cursor`)
- **Email**: `{model}@{agent}` format (e.g., `claude-opus-4-5@github-copilot`)

This ensures AI contributions appear in GitHub/GitLab contributor graphs and commit attribution.

### Trailer Values

#### Agent

The coding tool/interface you're running in. Use kebab-case.

**Acceptable Values:**

| Value | Description |
| ----- | ----------- |
| `github-copilot` | GitHub Copilot in VS Code, JetBrains, or CLI |
| `claude-code` | Claude Code CLI or desktop application |
| `cursor` | Cursor IDE |
| `opencode` | OpenCode CLI tool |

For unlisted agents, use kebab-case naming (e.g., `my-custom-agent`).

#### Model

Your model identifier in kebab-case. Agents self-identify their model—no hardcoded list required.

**Common Values:**

| Value | Provider |
| ----- | -------- |
| `claude-sonnet-4-5` | Anthropic |
| `claude-opus-4-5` | Anthropic |
| `claude-haiku-4-5` | Anthropic |
| `gpt-5-2` | OpenAI |
| `gpt-5-2-codex` | OpenAI |
| `gpt-5-mini` | OpenAI |
| `gemini-3-pro` | Google |
| `gemini-3-flash` | Google |
| `gemini-2-5-pro` | Google |
| `gemini-2-5-flash` | Google |

For unlisted models, use kebab-case naming matching the provider's identifier.

### Trailer Consistency Rule

**Both trailers are required together—if either trailer is present, both must be included.**

✅ **Valid:**

```text
fix(auth): handle null token gracefully

Co-authored-by: Github Copilot <gpt-4o@github-copilot>
agent: github-copilot
model: gpt-4o
```

❌ **Invalid (incomplete trailers):**

```text
fix(auth): handle null token gracefully

agent: github-copilot
```

## Signed Commits

**All commits must be signed for GitHub repositories.**

> **Note:** Commit signing is required for GitHub repositories only. Azure DevOps does not support signature verification, making signing unnecessary on that platform.

See [Signing Setup](../../skills/git-workflow/standards/signing-setup.md) for SSH signing configuration instructions.

## Validation Patterns

### Commit Subject Pattern

```regex
^(feat|fix|core|docs|refactor|test)(\([a-z0-9._-]+\))?: .{1,72}$
```

### Local Git Hooks

Client-side git hooks provide immediate feedback before code reaches pull requests.

**Hooks Provided:**

- `commit-msg`: Validates Conventional Commit format and trailer consistency

> **Note:** The `pre-push` hook for branch naming validation is documented in the [Branch Standard](./branch.md#git-hooks).

## Best Practices

### DO

- Keep subject lines under 50 characters
- Use imperative mood in descriptions
- Include both trailers when AI contributes
- Add body for non-trivial changes
- Run git hooks installation script after cloning

### DON'T

- Exceed 72 characters per body line
- Use past tense in commit messages
- Include partial trailer sets
- Bypass hooks without good reason
- Commit directly to `main` branch
- Use vague descriptions like "fix bug" or "update code"

## Quick Reference Card

| Element | Format | Max Length | Required |
| ------- | ------ | ---------- | -------- |
| Type | `feat\|fix\|core\|docs\|refactor\|test` | N/A | ✅ Yes |
| Scope | `(scope-name)` | ~20 chars | ❌ Optional |
| Description | Imperative, lowercase start | 50 chars | ✅ Yes |
| Body line | Bullet or paragraph | 72 chars | ❌ Optional |
| Trailer: Co-authored-by | `Co-authored-by: {Name} <{model}@{agent}>` | N/A | ⚠️ If AI-assisted |
| Trailer: agent | `agent: {name}` | N/A | ⚠️ If AI-assisted |
| Trailer: model | `model: {name}` | N/A | ⚠️ If AI-assisted |

## References

- [Conventional Commits Specification](https://www.conventionalcommits.org/en/v1.0.0/)
- [Branch Standard](./branch.md)
- [Pull Request Standard](./pull-request.md)
