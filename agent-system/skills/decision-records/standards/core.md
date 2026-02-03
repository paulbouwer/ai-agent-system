# Decision Record Standards

Rules for documenting major project decisions.

## Quick Reference

| Item | Rule |
|------|------|
| **Location** | `project/decision-records/` at repository root |
| **Filename** | `YYYY-MM-DD-short-description.md` (lowercase, hyphens) |
| **Template** | `template.md` in this standards folder |
| **Initial Status** | `Proposed` |

## When to Create

**Create a Decision Record for:**
- Architecture changes (components, services, data flow)
- Technology adoption (frameworks, tools, platforms)
- Process changes (workflows, CI/CD, policies)
- Security decisions (auth, data protection)
- Integration patterns (APIs, messaging, external systems)
- Standards adoption (conventions, formats, strategies)
- Business/governance decisions (stakeholder engagement, approvals)

**Do NOT create for:**
- Routine bug fixes
- Minor refactoring
- Documentation updates
- Dependency version bumps (unless major version with breaking changes)

## Y-Statement Format

Every Decision Record MUST include a Y-Statement summary:

```
In the context of {situation/problem},
facing {specific concern or constraint},
we decided {what was chosen},
to achieve {desired outcome},
accepting {trade-off or downside}.
```

**Example:**
> In the context of needing consistent API authentication,
> facing multiple client types with different security requirements,
> we decided to implement OAuth 2.0 with JWT tokens,
> to achieve standardised, stateless authentication across all clients,
> accepting the additional complexity of token management and refresh flows.

## Required Sections

1. **Title** — Clear, descriptive name
2. **Metadata** — Status, deciders, date, related docs
3. **Summary (Y-Statement)** — Decision in structured format
4. **Context** — Background, constraints, stakeholder concerns
5. **Decision** — What was chosen and detailed rationale
6. **Consequences** — Benefits AND risks/trade-offs
7. **Alternatives Considered** — At least 1 option with pros/cons/rejection reason

## Optional Sections

- **Follow-up Actions** — Action items with owners and dates
- **Notes** — Additional references or discussion points

## Status Lifecycle

```
Proposed ──▶ Accepted ──▶ Deprecated
                │
                └──▶ Superseded
```

| Status | Description |
|--------|-------------|
| **Proposed** | Under discussion; not yet approved |
| **Accepted** | Approved and should be followed |
| **Deprecated** | No longer recommended; move to `project/decision-records/deprecated/` |
| **Superseded** | Replaced by newer Decision Record (link to it) |

## Naming Convention

**Format:** `YYYY-MM-DD-short-description.md`

**Rules:**
- ISO 8601 date format
- Lowercase with hyphens only
- 3-7 word description
- No spaces or underscores

**Examples:**
```
✓ 2025-12-03-adopt-oauth2-authentication.md
✓ 2025-11-15-use-postgresql-for-persistence.md
✗ adopt_oauth2_authentication.md          (missing date, underscores)
✗ 2025-12-03-Adopt-OAuth2.md              (uppercase)
```
