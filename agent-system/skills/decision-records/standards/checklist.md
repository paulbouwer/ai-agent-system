# Decision Record Compliance Checklist

## Overview

Consolidated checklist for validating decision records against all standards.

---

## Pre-Documentation (Before Writing)

- [ ] Core decision is clearly understood
- [ ] Stakeholders have been identified
- [ ] Success criteria are defined
- [ ] At least one alternative has been discussed
- [ ] Trade-offs are understood and accepted
- [ ] Y-Statement can be articulated

---

## Required Sections

- [ ] **Title** — Clear, descriptive name present
- [ ] **Metadata** complete:
  - [ ] Status (Proposed/Accepted/Deprecated/Superseded)
  - [ ] Deciders (names or roles)
  - [ ] Date (DD MMMM YYYY format)
  - [ ] Related docs (if applicable)
- [ ] **Summary (Y-Statement)** — All five clauses present:
  - [ ] "In the context of" — situation/problem
  - [ ] "facing" — specific concern or constraint
  - [ ] "we decided" — what was chosen
  - [ ] "to achieve" — desired outcome
  - [ ] "accepting" — trade-off or downside
- [ ] **Context** — Background, constraints, stakeholder concerns documented
- [ ] **Decision** — Choice stated with rationale
- [ ] **Consequences** section includes:
  - [ ] Benefits (at least one)
  - [ ] Risks/trade-offs (at least one)
- [ ] **Alternatives Considered** — At least one alternative with:
  - [ ] Pros
  - [ ] Cons
  - [ ] Why not chosen

---

## Naming & Location

- [ ] File located in `project/decision-records/` at repository root
- [ ] Filename format: `YYYY-MM-DD-short-description.md`
- [ ] Date is ISO 8601 format
- [ ] Description is lowercase with hyphens
- [ ] Description is 3-7 words
- [ ] No spaces or underscores in filename

---

## Quality Checks

- [ ] Y-Statement is specific, not vague
- [ ] Context explains WHY the decision was needed
- [ ] Alternatives are genuinely different options (not fabricated)
- [ ] Consequences are honest (risks acknowledged)
- [ ] Someone could implement based on this record

---

## Status Validity

- [ ] Status is one of: `Proposed`, `Accepted`, `Deprecated`, `Superseded`
- [ ] If `Superseded`, link to replacement record is provided
- [ ] If `Deprecated`, record has been moved to `project/decision-records/deprecated/`
