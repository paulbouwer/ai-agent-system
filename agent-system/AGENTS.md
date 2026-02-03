# Agent System

## Overview

This agent system provides a structured approach to AI-assisted development through specialised agents, skills, and standards. The system emphasises isolated context for specific tasks, ensuring optimal token usage and focused expertise.

## Philosophy

- **Specialisation** — Each agent focuses on a specific domain, providing deep expertise
- **Isolation** — Subagents operate with isolated context, reducing noise and improving accuracy
- **Skills** — Self-contained capabilities that agents can invoke, bundling actions with relevant standards
- **Standards** — Codified best practices that ensure consistency across all work

## Structure

```bash
agent-system/
├── AGENTS.md                 # This file - system overview and routing
├── agents/                   # Agent definitions
├── skills/                   # Self-contained skill packages
│   └── <skill>/
│       ├── SKILL.md          # Skill manifest
│       ├── actions/          # Executable actions
│       └── standards/        # Skill-specific standards
└── standards/                # Project specific standards
    └── standards.index.md    # Standards registry
```

## Standards

Project specific standards are documented in `standards/standards.index.md`.

### Reading Standards

1. Start by reading `standards/standards.index.md` to identify relevant standards
2. The index lists each standards category with its path and structure
3. Navigate to the specified path and load the applicable files
4. For language standards, load only the category files relevant to your task (e.g., for DevContainer work, load `development-environment.md`)

### Skill-Bundled Standards

Skills will typically bundle their own generalised standards in `skills/<skill>/standards/`. Each skill will document how it manages precedence across the skill's generalised standards and the project specific standards.

## Routing

When a query matches a specific domain, delegate to the appropriate subagent for isolated, focused processing.

| Domain           | Keywords                                                          | Subagent                 | Skill                      |
|------------------|-------------------------------------------------------------------|--------------------------|----------------------------|
| DevContainer     | devcontainer, dev container, .devcontainer, development container | `DevContainer-Expert`    | `skills/devcontainer/`     |
| Decision Records | decision record, DR, architectural decision, ADR                  | `Decision-Record-Expert` | `skills/decision-records/` |
| Git Workflow     | git, branch, commit, pull request, PR, conventional commit        | `Git-Workflow-Expert`    | `skills/git-workflow/`     |

### How to Route

1. Identify the primary domain of the user's query
2. Match against the keywords in the routing table
3. Delegate to the specified subagent
4. The subagent will load its skill manifest (`SKILL.md`) and relevant standards

### When NOT to Route

- General questions that don't match a specific domain
- Questions spanning multiple domains (handle at orchestrator level)
- Simple queries that don't require specialist knowledge
