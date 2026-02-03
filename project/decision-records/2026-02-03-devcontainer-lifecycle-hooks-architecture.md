# Decision Record: Modular DevContainer Lifecycle Hooks Architecture

- **Status:** Accepted
- **Deciders:** Paul Bouwer
- **Date:** 03 February 2026
- **Related Docs:** [DevContainer Core Standard](../../agent-system/skills/devcontainer/standards/core.md), [Issue #1](https://github.com/paulbouwer/ai-agent-system/issues/1)

## Summary (Y-Statement)

_**In the context of**_ managing devcontainer lifecycle setup tasks across projects,
_**facing**_ the need for composable, reusable hooks and user-specific customisations,
_**we decided**_ to implement a modular `.d` directory pattern with orchestrator scripts and mounted user extensions,
_**to achieve**_ componentised lifecycle management that supports both shared repository hooks and personal user hooks,
_**accepting**_ that users must configure their own extensions folder on the host machine.

## Context

DevContainer lifecycle hooks (`postCreateCommand`, `postStartCommand`) provide extension points for setup tasks when containers are created or started. Projects typically need multiple setup tasks:

- Git safe directory configuration
- Tool installation
- Environment setup
- User-specific customisations (prompts, personal tools, credentials)

**Constraints:**

1. Setup tasks should be composable — add/remove without editing monolithic scripts
2. Repository hooks should be version-controlled and shared with the team
3. Users may have personal setup preferences not appropriate for the shared repository
4. Execution order must be predictable and controllable

**Inspiration:** Linux `rc.d` runlevel system, which uses numbered scripts in directories for ordered, modular service management.

## Decision

Implement a modular lifecycle hooks architecture with three layers:

### 1. Orchestrator Scripts

Top-level scripts invoked by `devcontainer.json`:

```text
.devcontainer/
├── post-create.sh      # Orchestrates post-create hooks
├── post-start.sh       # Orchestrates post-start hooks
└── run-scripts.sh      # Shared runner library
```

The orchestrators source `run-scripts.sh` and execute all scripts in the corresponding `.d` directory.

### 2. Repository Hooks (`.d` directories)

Modular scripts organised by lifecycle phase:

```text
.devcontainer/
├── post-create.d/
│   ├── 00-git-safe-directory.sh
│   └── 10-install-tools.sh
└── post-start.d/
    └── 10-start-services.sh
```

**Execution rules:**

- Scripts execute in sorted order (numerical prefix controls sequence)
- Naming convention: `NN-descriptive-name.sh` (two-digit prefix)
- Scripts with `.skip.sh` suffix are ignored (disable without deleting)
- Fail-fast: first failure stops subsequent scripts

### 3. User Extensions (mounted)

Personal hooks mounted from the user's host machine:

```jsonc
// devcontainer.json
"mounts": [
  "source=${localEnv:HOME}${localEnv:USERPROFILE}/.devcontainer-extensions,target=${containerWorkspaceFolder}/.devcontainer-extensions,type=bind,consistency=cached"
]
```

User extension scripts are invoked via `90-run-extensions-scripts.sh` in each `.d` directory:

```text
~/.devcontainer-extensions/     # On host machine
├── post-create.d/
│   └── 10-configure-prompt.sh  # User's oh-my-posh setup
└── post-start.d/
    └── 10-personal-env.sh
```

The `90-` prefix ensures user scripts run after all repository-level hooks.

## Consequences

### Benefits

- **Composability** — Add/remove hooks without editing shared scripts
- **Clear ordering** — Numeric prefixes provide predictable execution sequence
- **User autonomy** — Personal customisations stay outside the repository
- **Team flexibility** — Shared hooks are version-controlled; personal hooks are not
- **Easy debugging** — Disable scripts with `.skip.sh` suffix without deletion
- **Familiar pattern** — Linux administrators recognise the `rc.d` convention

### Risks & Trade-offs

- **Host setup required** — Users must create `~/.devcontainer-extensions/` structure on their machine
- **Not version-controlled** — User extension scripts live outside the repository
- **Discovery** — New team members may not know about user extensions capability
- **Platform paths** — Mount source uses `${localEnv:HOME}${localEnv:USERPROFILE}` for cross-platform support

## Alternatives Considered

### Option 1: Single Monolithic Script

- **Pros:** Simple, all logic in one place, no directory scanning
- **Cons:** No composability, difficult to enable/disable individual tasks, merge conflicts when multiple contributors edit
- **Why not chosen:** Does not support the componentised, catalog-based approach needed for reusable hooks

## Follow-up Actions

| Action | Owner | Due Date |
| ------ | ----- | -------- |
| Document user extensions setup in a docs folder | TBD | TBD |

## Notes

- The `.devcontainer-extensions` folder is gitignored to prevent accidental commits of user-specific scripts
- Example use case: A user configures their oh-my-posh prompt theme via a personal `post-create.d` script, applied to all their devcontainer projects without modifying any repository

