param([string]$SkillRoot)

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($SkillRoot)) {
    $SkillRoot = Split-Path -Parent $PSScriptRoot
}
$required = @(
    'SKILL.md',
    'references/source_processing.md',
    'references/evidence_schema.md',
    'references/methodology.md',
    'references/teaching_workflow.md',
    'references/teacher_persona.md',
    'references/incremental_update.md',
    'assets/templates/course_manifest_template.md',
    'assets/templates/source_map_template.md',
    'assets/templates/teacher_profile_template.md',
    'assets/templates/evidence_template.md',
    'assets/templates/method_template.md',
    'assets/templates/example_template.md',
    'assets/templates/knowledge_index_template.md',
    'assets/templates/teacher_explanation_template.md'
)

$errors = [System.Collections.Generic.List[string]]::new()
foreach ($relative in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $SkillRoot $relative) -PathType Leaf)) {
        $errors.Add("Missing required file: $relative")
    }
}

$skillPath = Join-Path $SkillRoot 'SKILL.md'
if (Test-Path -LiteralPath $skillPath) {
    $skill = Get-Content -LiteralPath $skillPath -Raw
    if ($skill -notmatch '(?s)^---\s*\r?\n.*?name:\s*courseware-distiller\s*\r?\n.*?description:.*?\r?\n.*?---') {
        $errors.Add('SKILL.md frontmatter is missing required name/description fields.')
    }
    $frontmatterMatch = [regex]::Match($skill, '(?s)^---\s*\r?\n(.*?)\r?\n---')
    if ($frontmatterMatch.Success) {
        $topLevelKeys = [regex]::Matches($frontmatterMatch.Groups[1].Value, '(?m)^([A-Za-z][A-Za-z0-9_-]*):') | ForEach-Object { $_.Groups[1].Value }
        $unexpected = @($topLevelKeys | Where-Object { $_ -notin @('name', 'description', 'license', 'allowed-tools', 'metadata') })
        if ($unexpected.Count -gt 0) { $errors.Add("Unexpected frontmatter keys: $($unexpected -join ', ')") }
    }
    if ($skill -match '(?m)^\s*\[TODO:[^\]]*\]\s*$') {
        $errors.Add('SKILL.md contains an unfinished TODO placeholder.')
    }
    $links = [regex]::Matches($skill, '\[[^\]]+\]\(([^)]+)\)')
    foreach ($link in $links) {
        $target = $link.Groups[1].Value
        if ($target -notmatch '^[a-z]+://' -and -not (Test-Path -LiteralPath (Join-Path $SkillRoot $target))) {
            $errors.Add("Broken SKILL.md link: $target")
        }
    }
}

$templateChecks = @{
    'assets/templates/evidence_template.md' = @('evidence_id:', 'source_id:', 'locator:', 'speaker:', 'status:')
    'assets/templates/method_template.md' = @('Recognition signals:', 'Required conditions:', 'Exclusion conditions:', 'Selection rationale:', 'Explicit unknowns:')
    'assets/templates/example_template.md' = @("Teacher's worked sequence", 'Wrong attempts and corrections', 'Verification:')
}
foreach ($entry in $templateChecks.GetEnumerator()) {
    $content = Get-Content -LiteralPath (Join-Path $SkillRoot $entry.Key) -Raw
    foreach ($needle in $entry.Value) {
        if (-not $content.Contains($needle)) { $errors.Add("$($entry.Key) lacks: $needle") }
    }
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output "PASS: structural validation completed for $SkillRoot"
