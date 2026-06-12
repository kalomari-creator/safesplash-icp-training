# Riverdale To Ridge Hill Reference Workflow

This is a reusable workflow reference derived from prior Riverdale to Ridge Hill work. It is not permission to run a live transfer by itself.

## Use Case

Riverdale clients may need records, enrollments, makeup tokens, or credits moved to Ridge Hill. This is high-risk live account work.

## Required Authorization

Before any mutation, confirm:

- Source location: Riverdale
- Target location: Ridge Hill
- Exact scope: one client, one class, all active clients, tokens only, credits only, enrollments, or another defined scope
- Notification policy
- Drop policy
- Token cap, if any
- Balance/credit handling rule
- Whether missing target families/students can be created
- Whether notes should be added and exact note wording if required

Default safety:

- No customer email unless explicitly authorized.
- No source-class drop unless explicitly authorized.
- No silent family/student creation unless explicitly authorized.
- No credit movement if the ledger payload or sign convention is unclear.

## Location Keys

- `yonkersriverdaleny`: SafeSplash Yonkers (Riverdale), NY
- `yonkersridgehillny`: SafeSplash Yonkers (Ridge Hill), NY

## Enrollment Transfer Pattern

1. Read source Riverdale enrollment, class, student, family, billing schedule, and notification/drop state.
2. Confirm target Ridge Hill class.
3. Search Ridge Hill for existing family/student first.
4. Create missing target records only if authorized.
5. Enroll target student with confirmed start date and billing schedule.
6. Verify target enrollment.
7. Verify source stayed active/open if no drop was authorized.
8. Confirm notifications were not sent if no notification was authorized.
9. Add notes.

Known issue:

```text
loginId_0: ["Invalid login Id"]
```

This can happen when copied guardian/contact data includes login/session-only fields from the source account. Strip login/session-only fields before retrying family creation.

## Active Client Token Audit Pattern

1. Pull live active/future Riverdale enrollment list.
2. Confirm pagination is working. In one workflow, `enrollments/filtered` ignored top-level `page`; pagination had to be inside `filters.page` and `filters.pageSize`.
3. For each active/future student, read available makeup tokens.
4. Match each Riverdale student/family to Ridge Hill.
5. Split results:
   - clear match
   - no Ridge match
   - duplicate/ambiguous match
   - already at cap
   - manual review
6. Mutate only clear approved matches.

## Token Transfer Pattern

1. Read source Riverdale available tokens.
2. Read target Ridge Hill available tokens.
3. Enforce cap exactly, such as max 5 available tokens.
4. Create only the number of target tokens allowed under the cap.
5. Verify target token creation.
6. Delete/clear source token only after target creation verifies.
7. Re-read source and target token counts.
8. Add notes on both Riverdale and Ridge Hill accounts.

Stop if token creation fails, target goes over cap, source deletion fails, or the client cannot be matched.

## Credit / Balance Pattern

Credits are higher risk than tokens.

1. Read Riverdale ledger/balance.
2. Read Ridge Hill ledger/balance.
3. Verify sign convention in the live account.
4. Inspect the real iClassPro payment/charge/credit workflow before any mutation.
5. Do not guess payloads.
6. Do not move credits for unmatched families.
7. Add notes on both accounts after any authorized balance action.

In one workflow, ledger info was found through a path shaped like:

```text
/api/v1/ledger/{familyId}/info
```

This is a note for discovery, not permission to mutate.

## Final Report

Report:

- Total active/future Riverdale students checked
- Total with source tokens
- Total matched to Ridge Hill
- Total transferred
- Total skipped due to cap
- Total unmatched
- Total ambiguous
- Credit/balance findings
- Notes added
- Audit file paths
- Final verification result

