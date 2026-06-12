$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$desktop = [Environment]::GetFolderPath('Desktop')
$preferred = Join-Path $desktop 'Project\ICP Training'

function Find-IcpTrainingFolder {
    if (Test-Path -LiteralPath $preferred) {
        return $preferred
    }

    $matches = Get-ChildItem -LiteralPath $desktop -Directory -Recurse -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -eq 'ICP Training' } |
        Select-Object -First 1

    if ($matches) {
        return $matches.FullName
    }

    New-Item -ItemType Directory -Force -Path $preferred | Out-Null
    return $preferred
}

$target = Find-IcpTrainingFolder

$items = @(
    'AGENTS.md',
    'CALL_CENTER_PLAYBOOK.md',
    'PROJECT_KNOWLEDGE_REFERENCE.md',
    'workflows',
    'templates',
    'examples'
)

foreach ($item in $items) {
    $sourcePath = Join-Path $repoRoot $item
    $targetPath = Join-Path $target $item

    if (Test-Path -LiteralPath $sourcePath -PathType Container) {
        New-Item -ItemType Directory -Force -Path $targetPath | Out-Null
        Copy-Item -LiteralPath (Join-Path $sourcePath '*') -Destination $targetPath -Recurse -Force
    } elseif (Test-Path -LiteralPath $sourcePath -PathType Leaf) {
        Copy-Item -LiteralPath $sourcePath -Destination $targetPath -Force
    } else {
        throw "Missing source item: $sourcePath"
    }
}

Write-Host "Updated ICP Training files at: $target"
Write-Host "Next: open Codex in the ICP Training project and read AGENTS.md."
