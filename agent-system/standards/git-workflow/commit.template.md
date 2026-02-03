# Git Commit Template

Template for commit messages following the Conventional Commits specification.

## Basic Template

```text
{type}({scope}): {description}

{body}

{trailers}
```

## Template With AI Contribution

Use this format when AI coding agents contributed to the changes:

```text
{type}({scope}): {description}

- {change-summary-1}
- {change-summary-2}

Co-authored-by: {Name} <{email}>
Co-authored-by: {Agent Name} <{model-name}@{agent-name}>
agent: {agent-name}
model: {model-name}
```

**Note:** Human co-authors are optional. Include them when others contributed to the changes.

## Template Without AI Contribution

Use this format for human-only changes:

```text
{type}({scope}): {description}

- {change-summary-1}
- {change-summary-2}
```

## Field Definitions

| Field | Description | Example |
| ----- | ----------- | ------- |
| `{type}` | Change category | `feat`, `fix`, `docs` |
| `{scope}` | Affected area (optional) | `auth`, `api`, `parser` |
| `{description}` | Brief summary (≤50 chars) | `add user authentication` |
| `{body}` | Detailed explanation (optional) | Bullet points of changes |
| `{Name}` | Co-author name | `Jane Doe` |
| `{email}` | Co-author email | `jane.doe@example.com` |
| `{Agent Name}` | Human-readable agent name | `Github Copilot`, `Cursor` |
| `{agent-name}` | AI tool/interface (kebab-case) | `github-copilot`, `claude-code`, `cursor`, `opencode` |
| `{model-name}` | AI model identifier | `claude-sonnet-4-5`, `gpt-5-2`, `gemini-3-pro` |

## Examples

### Simple Feature (No AI)

```text
feat(auth): add JWT token validation
```

### Simple Fix (With AI)

```text
fix(parser): handle null input gracefully

Co-authored-by: Github Copilot <gpt-4o@github-copilot>
agent: github-copilot
model: gpt-4o
```

### Complex Feature (No AI)

```text
feat(integration): add HL7 message validation

- Implement schema-based validation for ORU messages
- Add custom error handling for malformed segments
- Support both v2.3 and v2.5 HL7 versions
```

### Complex Documentation (With AI)

```text
docs(prompts): streamline PR instructions

- Simplified workflow from 221 to 43 lines
- Added structured metadata headers
- Enhanced readability and reduced cognitive overhead

Co-authored-by: Github Copilot <claude-opus-4-5@github-copilot>
agent: github-copilot
model: claude-opus-4-5
```

### Multi-Scope Refactoring (With AI and Co-author)

```text
core(azure,messaging): update service bus configuration

- Migrate from legacy connection string format
- Add retry policies with exponential backoff
- Update environment-specific property files

Co-authored-by: Bob Smith <bob.smith@example.com>
Co-authored-by: Cursor <claude-sonnet-4@cursor>
agent: cursor
model: claude-sonnet-4
```

## Git Command Examples

### With Trailers (AI-Assisted, Signed)

```bash
git commit -S -m "feat(api): add user authentication endpoint

- Implement JWT token validation
- Add role-based access control" \
  --trailer "Co-authored-by: Github Copilot <gpt-4o@github-copilot>" \
  --trailer "agent: github-copilot" \
  --trailer "model: gpt-4o"
```

### Without Trailers (Human-Only, Signed)

```bash
git commit -S -m "fix(parser): correct message segment parsing"
```

### Unsigned Fallback

```bash
git commit -m "docs(readme): update installation instructions"
```
