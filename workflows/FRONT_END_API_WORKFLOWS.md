# Front-End API Workflows

Use these patterns for efficient read-only audits and carefully authorized bulk work.

## General API Pattern

1. Confirm the user is logged in through the browser.
2. Use the live page context so requests inherit the browser session.
3. Inspect the app's own Network calls or already verified notes.
4. Run read-only requests first.
5. Build a local audit file before mutation.
6. Ask for explicit authorization if the next step changes customer/account data.
7. Mutate only records in the approved plan.
8. Verify after each record or small batch.
9. Save final report.

Never print, save, or inspect cookies, tokens, passwords, auth headers, local storage, or session storage.

## Availability And Class Checks

Read-only unless the user authorizes booking/class edits.

1. Confirm location, program, level, day/time, age, start date, and max future booking window.
2. Use iClassPro Classes filters.
3. For each candidate, check occupancy, active/open/future counts, instructor, zone, schedule, and capacity.
4. Open class edit/pencil view and check Bill Dates before offering the class.
5. Do not save when only checking.
6. Do not overbook.

Output:

- Class name/ID
- Day/time
- Level
- Openings
- Bill Dates status
- Confidence and caveats

## Booking / Enrollment

Authorized mutation only.

1. Verify family and student.
2. Verify exact class, day, time, level, instructor, Bill Dates, capacity, future start date, and billing setup.
3. Confirm payment handling and notification policy.
4. Enroll only after explicit authorization.
5. Verify final enrollment exists.
6. Add iClassPro and Podium notes.

Stop if the match is ambiguous or a notification may be sent unexpectedly.

## Drops

Authorized mutation only.

1. Verify exact student, enrollment, class, location, day/time, and requested drop date.
2. Confirm whether this is a real drop or a demo/test/no-drop workflow.
3. Confirm notification policy.
4. Save only after explicit authorization.
5. Verify the drop date/status after saving.
6. Add notes.

Do not drop when the user said demo, test, proof of concept, no-drop, or read-only.

## Makeup Token Transfer With Cap

Authorized mutation only.

1. Build a read-only plan listing source location, target location, family, student, source token IDs, target student ID, and current target token count.
2. Confirm cap. Example: max 5 available target tokens.
3. For each matched swimmer:
   - Read source available tokens.
   - Read target available tokens.
   - Create/recreate only the allowed number at target.
   - Verify target creation.
   - Delete/clear source token only after target creation verifies.
   - Re-read source and target counts.
4. Add notes on both accounts.
5. Stop on unmatched family/student, creation failure, delete failure, or over-cap result.

Do not silently create missing target families/students unless the user authorized that scope.

## Credits / Ledger Transfer

Authorized mutation only and higher risk.

1. Read source ledger/balance and target ledger/balance.
2. Verify sign convention in the live account. Do not assume positive/negative meaning without confirmation.
3. Find the app's real payment/charge/credit workflow and exact payload.
4. Create a dry-run plan with amounts and reason.
5. Ask for explicit authorization for the exact amount and families.
6. Apply target credit/payment first only if that is the approved workflow.
7. Offset/remove source credit only after target state verifies.
8. Verify final source and target balances.
9. Add notes on both accounts.

Stop if the payload is unclear, the sign convention is unclear, there are pre-existing balances, or the user's balance rule has exceptions.

## Reports And Exports

Read-only unless upload/import/submission is authorized.

1. Confirm report, filters, dates, location, and output folder.
2. Set filters exactly.
3. Trigger export only if read-only export is authorized.
4. Verify the file exists and is readable.
5. Treat request dispatch as incomplete until the saved artifact is confirmed.

