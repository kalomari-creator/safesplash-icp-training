# Project Knowledge Reference

This is the local save file for evidence-based training notes.

Do not save:

- Passwords, cookies, tokens, session IDs, CSRF values, auth headers, PINs, or credentials.
- Full customer exports or unnecessary private customer data.
- Screenshots with sensitive information unless explicitly needed and authorized.

Safe to save:

- Workflow steps.
- Verified selectors or endpoint paths without secrets.
- High-level request/response shapes with fake or redacted values.
- Failure modes and safe fixes.
- Location keys.
- Stop rules.
- Notes about where each system keeps important information.

## Shared Starting Knowledge

### Project Folder Rule

On Windows, find `ICP Training` on the logged-in user's Desktop. Common path:

```text
%USERPROFILE%\Desktop\Project\ICP Training
```

Do not assume `C:\Users\Call Center 2\...`.

### Team Identity And Shared PCs

Managers: Khaled, Melanie, David, Michelle, Allison, Marissa, and Tawfiq.

Primary PC defaults:

- PC 1: Melanie
- PC 2: David
- PC 3: Tawfiq and Michelle
- PC 4: Marissa
- PC 5: Tawfiq

These are not hard assignments. Team members may share PCs and move around. Before live client work, ask who is currently using the PC and use that person's confirmed signature and approval preference.

### iClassPro Front-End API Safety

- Use the logged-in browser context only.
- Never expose cookies/tokens/passwords/session storage/local storage/auth headers.
- Verify before and after every mutation.
- Save read-only audit data before bulk work.
- Checkpoint small batches.
- Stop on ambiguity.

### Known iClassPro API Notes

- For class table scans, `table.iclass_list_table` has been useful. Real class rows may be followed by blank/detail rows, so parse only nonblank top-level class rows.
- In one Riverdale/Ridge Hill transfer workflow, enrollment pagination required pagination fields inside `filters`, such as `filters.page` and `filters.pageSize`, instead of top-level `page`.
- A family creation failure like `loginId_0: ["Invalid login Id"]` can mean source guardian payload included login/session-only fields that must be stripped before creating the target family.
- Ledger info was discovered through an endpoint shaped like `/api/v1/ledger/{familyId}/info`. Positive ledger balance/unapplied credit may indicate credit, but always verify the sign convention in the live account before any adjustment.
- Treat request dispatch as incomplete until the saved/exported artifact or final changed record is verified.

### Riverdale To Ridge Hill Workflow Lessons

- Start from live Riverdale state, not only a prior plan file.
- Find every currently active/future Riverdale client in scope before moving tokens or credits.
- Match to Ridge Hill carefully. If a client does not have a clear Ridge Hill family/student/enrollment match, do not create records silently.
- For makeup tokens, verify source and target counts before and after.
- If transferring tokens between locations, recreate authorized tokens at target first, verify creation, then delete/clear the matching source token.
- If a cap is provided, enforce it exactly. Example: max 5 available tokens at Ridge Hill.
- If token creation fails, do not delete the matching source token.
- Add notes on both source and target accounts for every account action.
- For credits, do not guess payment/charge payloads. Inspect the live app's ledger/payment/charge workflow and stop if the exact safe mutation is unclear.
- For balances, preserve the user's rule exactly and separate matched clients from manual-review exceptions.

### Podium Billing Outreach Defaults

- Run audit at 8:00 AM when configured as a daily workflow.
- Schedule qualified messages for 3:00 PM.
- Close conversations after scheduling only when authorized.
- Skip customers contacted or scheduled within the last 3 days.
- Use billing-team identity, not a personal name.
- Verify Enterprise/iClassPro account state before messaging.

## Notes To Add During Training

Use this format:

```md
### YYYY-MM-DD - System / Workflow

- What was checked:
- Source of truth:
- Exact safe path:
- What not to click without authorization:
- Verified endpoint/selectors, if any:
- Failure or blocker:
- Safe next step:
```
