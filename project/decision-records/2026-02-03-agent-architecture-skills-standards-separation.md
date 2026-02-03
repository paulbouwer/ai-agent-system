# Decision Record: Agent Architecture with Skills and Standards Separation

- **Status:** Accepted
- **Deciders:** Paul Bouwer
- **Date:** 03 February 2026
- **Related Docs:** [Agent System AGENTS.md](../../agent-system/AGENTS.md), [Standards Index](../../agent-system/standards/standards.index.md), [Issue #1](https://github.com/paulbouwer/ai-agent-system/issues/1)

## Summary (Y-Statement)

_**In the context of**_ enabling AI-assisted engineering across multiple repositories and AI coding agents,
_**facing**_ the need for isolated context management, portability, and organisational customisation,
_**we decided**_ to implement a three-layer architecture separating agents, skills, and standards with invariant and customisable components,
_**to achieve**_ a portable, agent-agnostic system that provides focused expertise while allowing project-specific policy customisation,
_**accepting**_ that users must understand the layering to effectively navigate and extend the system.

## Context

AI coding agents (GitHub Copilot, Claude, etc.) work best with focused, relevant context. Loading too much information into a single conversation degrades performance and wastes tokens. Additionally:

- Different AI agents have historically required separate configuration folders (`.github/`, `.claude/`)
- Organisations need to customise policies (commit types, branch naming) without forking core workflows
- Skills and workflows should be reusable across repositories without modification
- The system should be portable — copy one folder to enable AI-assisted development

**Previous approach:** Agents, commands, and referenced workflows with standards scattered across agent-specific folders. This created duplication and tight coupling to specific AI tools.

**Inspiration:** The separation of concerns principle — keep what changes frequently separate from what remains stable.

## Decision

Implement a three-layer architecture with clear separation between routing, capabilities, and policies:

### Architecture Overview

```text
agent-system/
├── AGENTS.md                 # Entry point and routing table
├── agents/                   # Layer 1: Thin routers (subagents)
│   └── <agent>.expert.md
├── skills/                   # Layer 2: Self-contained capabilities
│   └── <skill>/
│       ├── SKILL.md          # Manifest
│       ├── actions/          # Executable workflows
│       └── standards/        # Invariant rules (bundled)
└── standards/                # Layer 3: Customisable policies
    └── <domain>/             # Project/org-specific values
```

### Layer 1: Agents (Subagents)

Agents are thin routers that orchestrate skills based on task requirements:

- **Location:** `agents/*.md`
- **Purpose:** Route queries to appropriate skills, spawn with isolated context
- **Design:** Lightweight definitions that reference skills, not duplicate logic

```markdown
# DevContainer Expert Agent

## Skill
Load the DevContainer skill from `skills/devcontainer/SKILL.md`...
```

**Rationale:** Isolating work in subagents prevents context pollution in the main conversation and enables focused expertise per domain.

### Layer 2: Skills

Skills are self-contained capability packages:

- **Location:** `skills/<domain>/`
- **Structure:**
  - `SKILL.md` — Manifest defining capabilities and standards references
  - `actions/` — Step-by-step workflows for each capability
  - `standards/` — Invariant rules bundled with the skill

**Example:** Git Workflow skill bundles the *process* (branch-issue linking is mandatory) while referencing external *policies* (which commit types are allowed).

### Layer 3: Standards (Customisable Policies)

Shared standards that can be modified per project or organisation:

- **Location:** `standards/<domain>/`
- **Purpose:** Define values that vary between projects (commit types, branch patterns, language tooling)
- **Relationship:** Skills reference these for policy values

### Invariant vs Customisable Standards

| Type | Location | Purpose | Example |
| ---- | -------- | ------- | ------- |
| **Invariant** | `skills/<skill>/standards/` | Process rules that cannot be overridden | "All commits MUST follow Conventional Commits" |
| **Customisable** | `standards/<domain>/` | Organisation-specific policy values | "Allowed commit types: feat, fix, core, docs, refactor, test" |

This separation enables organisations to adopt the system and customise policies without modifying skill internals.

### Portability Model

```text
Repository A                    Repository B
├── agent-system/    ◄────────► ├── agent-system/     (copied, unchanged)
│   ├── agents/                 │   ├── agents/
│   ├── skills/                 │   ├── skills/
│   └── standards/   ◄── customised ── standards/     (modified per org)
├── project/         (repo-specific)  ├── project/    (repo-specific)
└── AGENTS.md        (entry point)    └── AGENTS.md   (entry point)
```

- **Agents and skills:** Unchanged across repositories (like a library)
- **Standards:** Customised per project/organisation
- **Project folder:** Repo-specific (learnings, decision records) — does not travel

## Consequences

### Benefits

- **Agent-agnostic** — Single `AGENTS.md` entry point works for any AI coding agent (Copilot, Claude, etc.)
- **Isolated context** — Subagents operate with focused context, improving accuracy and reducing token usage
- **Portability** — Copy `agent-system/` folder to enable AI-assisted development in any repository
- **Customisation without forking** — Modify `standards/` without touching skills or agents
- **Self-contained skills** — Each skill bundles its workflows and invariant rules together
- **Clear boundaries** — Obvious where to look for processes (skills) vs policies (standards)

### Risks & Trade-offs

- **Learning curve** — Users must understand the three-layer architecture to navigate effectively
- **More files** — Distributed structure means more files/folders than a monolithic approach
- **Indirection** — Following the path from agent → skill → standards requires understanding the relationships

## Alternatives Considered

### Option 1: Agent-Specific Configuration Folders

- **Pros:** Each AI tool has its own familiar structure (`.github/`, `.claude/`)
- **Cons:** Duplication across tools, tight coupling to specific agents, not portable
- **Why not chosen:** Violates agent-agnostic goal; requires maintaining multiple configurations

### Option 2: Monolithic Agent with Embedded Skills

- **Pros:** Everything in one place, no navigation required
- **Cons:** Context overload, no isolation, difficult to customise, not portable
- **Why not chosen:** Defeats the purpose of isolated context and organisational customisation

### Option 3: Flat Standards Structure

- **Pros:** All standards in one location, simpler navigation
- **Cons:** No distinction between invariant process and customisable policy, harder to protect core workflows
- **Why not chosen:** Organisations might accidentally modify invariant rules when customising

## Notes

- The root `AGENTS.md` file serves as the universal entry point for all AI coding agents
- Skills define *how* to do something; standards define *what values* to use
- This architecture emerged from practical experience with context management in AI conversations
- The system is self-improving — this repository uses its own agent-system to build and improve itself

