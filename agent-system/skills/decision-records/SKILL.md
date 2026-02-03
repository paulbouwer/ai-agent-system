---
name: Decision Records
description: Create and review architectural decision records
capabilities:
  - create
  - review
---

# Decision Records Skill

## Overview

This skill provides capabilities for creating and reviewing architectural decision records (ADRs) through guided discovery and standards compliance.

## Capabilities

| Capability | Action | Description |
| ---------- | ------ | ----------- |
| Create | `actions/create.md` | Guide the creation of a decision record through Socratic discovery |
| Review | `actions/review.md` | Analyse an existing decision record for completeness and quality |

## Standards

This skill bundles the following standards in `standards/`:

| Standard | File | Description |
| -------- | ---- | ----------- |
| Core | `core.md` | When to create, naming conventions, required sections, status lifecycle |
| Checklist | `checklist.md` | Validation checklist for decision record completeness |
| Template | `template.md` | Decision record markdown template |

## Index Maintenance

Both capabilities are responsible for maintaining the decision records index at `project/decision-records/decision-records.index.md`:

| Action | Index Update |
| ------ | ------------ |
| Create | Add new entry to Active Records table |
| Review (status change) | Update status in Active Records table |
| Review (deprecation) | Move entry from Active Records to Deprecated Records table |

## Usage

1. Load this skill manifest
2. Identify the required capability (create or review)
3. Load the bundled standards from `standards/`
4. Execute the action following `actions/<capability>.md`
5. Ensure index is updated per Index Maintenance rules

