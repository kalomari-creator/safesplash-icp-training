# SafeSplash/SwimLabs ICP Training

Shared Codex training materials for SafeSplash/SwimLabs call center and ICP operations.

This repository is team training material. It is not a Khaled personal bot and it is not tied to any single PC or teammate.

## What This Contains

- `AGENTS.md`: primary Codex operating rules.
- `CALL_CENTER_PLAYBOOK.md`: shared call center and system workflow rules.
- `PROJECT_KNOWLEDGE_REFERENCE.md`: starter notes file for local learning.
- `workflows/`: detailed iClassPro/front-end API and transfer workflow references.
- `templates/`: checkpoint templates for live operations.
- `examples/`: starter prompts for new Codex threads.
- `scripts/update_icp_training.ps1`: Windows update script for each team PC.

## Team PC Setup

Team PCs should treat this repository as pull-only. They should clone, pull, and run the update script, but they should not commit, push, or store local customer data in this repo.

On each Windows PC, open Codex in the existing `ICP Training` project and ask it:

```text
Clone or pull the SafeSplash/SwimLabs ICP Training GitHub repo into Downloads, then run scripts/update_icp_training.ps1 to update this PC's Desktop ICP Training project. Treat the repo as pull-only on this PC. Use the logged-in Windows user's Desktop path, not a hardcoded Call Center user path. Read AGENTS.md first. Do not perform live customer/system actions.
```

If running manually in PowerShell:

```powershell
cd $env:USERPROFILE\Downloads
git clone https://github.com/kalomari-creator/safesplash-icp-training.git icp-training-team
cd icp-training-team
powershell -ExecutionPolicy Bypass -File .\scripts\update_icp_training.ps1
```

## Maintainer Setup

Khaled's Mac at `/Users/khaledalomari/Documents/Agents/icp-training-team` is the maintainer copy. It is configured to pull and push through:

```text
https://github.com/kalomari-creator/safesplash-icp-training.git
```

Use this copy to update the shared files over time, then commit and push to `main`. Team PCs should pull those changes.

## Folder Rule

The target project folder on each PC should be found this way:

1. Look for `ICP Training` on the current user's Desktop.
2. Prefer `%USERPROFILE%\Desktop\Project\ICP Training` if present.
3. If not present, search the Desktop for a folder named `ICP Training`.
4. If still not found, stop and ask where the project folder is.

Do not assume every PC uses `C:\Users\Call Center 2\...`.

## Safety

Do not commit or upload:

- Passwords
- Cookies
- Tokens
- Customer exports
- Private customer records
- Live browser state
- Screenshots with customer data

Live iClassPro, Enterprise, Podium, AquaSuite, Outlook, Connecteam, and SwimLabs Announcer actions require explicit authorization and verification before and after any mutation.
