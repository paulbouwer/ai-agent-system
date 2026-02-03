# Learnings

Patterns, insights, and decisions discovered during agent system development.

---

## Architecture Patterns

### Skill-Based Organisation

**Learning:** Domain-specific capabilities belong in self-contained skills, not scattered across commands/flows/standards folders.

**Pattern:** Each skill bundles its own actions, standards, and templates in a single folder structure:

```bash
skills/<domain>/
├── SKILL.md          # Manifest
├── actions/          # Executable workflows
└── standards/        # Domain-specific rules
```

**Source:** Decision Records migration (2026-01)

---

### Standards Bundling

**Learning:** Standards that serve only one skill should be bundled with that skill, not in shared standards.

**Pattern:** Only truly cross-cutting standards (e.g., language standards used by multiple skills) belong in `standards/`. Domain-specific standards live in `skills/<domain>/standards/`.

**Rationale:** This keeps skills self-contained and reduces coupling. When a skill is loaded, all its dependencies are in one place.

**Source:** Decision Records migration (2026-01)

---

### Subagent + Skill Separation

**Learning:** Subagents should be thin routing layers that reference skills, not contain domain logic themselves.

**Pattern:**

- Subagent (`agents/*.md`) defines: name, description, tools, response format, and skill reference
- Skill (`skills/*/SKILL.md`) defines: capabilities, actions, standards

**Source:** DevContainer Expert pattern (observed 2026-01)

---

## Planning Patterns

### Clarifying Questions Before Planning

**Learning:** Asking targeted clarifying questions before planning reduces rework and surfaces implicit assumptions.

**Pattern:** Identify decision points and present options with recommendations:

- Naming conventions (singular vs plural, casing)
- Scope boundaries (what's in, what's out)
- Migration strategy (move, copy, delete, deprecate)
- Cleanup approach (immediate vs deferred)

**Source:** Decision Records planning session (2026-01)

---

## Documentation Patterns

### Backlog Format

**Learning:** Markdown tables are restrictive for capturing ideas; sections with prose scale better.

**Pattern:** Use `project/future-enhancement-ideas.md` with domain sections. Each item has a unique identifier using the section prefix + incrementing 3-digit number (e.g., `DR001` for Decision Records, `GN001` for General).

Item format:

- `### {ID}: {Title}` — Unique identifier and descriptive title
- **Idea** — What the enhancement would do
- **Context** — Why it came up
- **Potential Approach** — How it might be implemented
- **Priority** — Low / Medium / High
- **Added** — Date added (YYYY-MM-DD)

**Source:** Decision Records planning session (2026-01)

---

## Git Workflow Migration Patterns

### Hybrid Standards Layering

**Learning:** Skills can separate invariant process rules from customizable organisational policies using a hybrid standards approach.

**Pattern:** Two-layer standards structure:

- **Skill-bundled** (`skills/<domain>/standards/`) — Invariant rules defining the *process* (e.g., "commits MUST use conventional commits format")
- **External/customizable** (`standards/<domain>/`) — Organisation-specific *policies* (e.g., allowed commit types, branch prefixes, templates)

Actions explicitly load both:

```markdown
Load from this skill's `standards/`:
- core.md — Invariant workflow rules

Load from `standards/git-workflow/`:
- commit.md — Commit format policy
```

**Rationale:** Organisations get sensible defaults with the ability to customise policies without modifying the core skill. The skill defines *how* things work; the organisation defines *what* specific values to use.

**Source:** Git Workflow migration (2026-02)

---

### Platform Provider Bundling (Temporary)

**Learning:** When a skill needs external integrations, bundle a single-provider implementation initially with clear extraction path documented.

**Pattern:** Create a provider file (e.g., `github-provider.md`) within the skill that:

- Documents all platform-specific commands
- Notes it's temporary and will be extracted
- Defines the implicit interface for future abstraction

**Rationale:** Delivers working functionality now while acknowledging technical debt. The provider file serves as a specification for the eventual abstraction.

**Source:** Git Workflow migration (2026-02)

---

### Flow-to-Action Conversion

**Learning:** Existing flows with detailed step-by-step instructions convert well to action format with minimal restructuring.

**Pattern:** When converting flows to actions:

- Keep numbered steps with success criteria checkboxes
- Add 🛑 markers for user interaction points
- Add "Load Standards" step at the beginning
- Reference standards by relative path from skill
- Keep error handling tables at the end

**Source:** Git Workflow migration (2026-02)

---

### Learnings as Institutional Memory

**Learning:** Capturing patterns and anti-patterns during work creates reusable knowledge for future planning.

**Pattern:** Maintain `project/learnings.md` with categorised insights:

- Architecture Patterns
- Planning Patterns
- Documentation Patterns
- Anti-Patterns (when discovered)

**Source:** Decision Records planning session (2026-01)
