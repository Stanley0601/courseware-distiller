param(
    [string]$SkillRoot,
    [Parameter(Mandatory = $true)]
    [string]$OutputZip
)

$ErrorActionPreference = 'Stop'
if ([string]::IsNullOrWhiteSpace($SkillRoot)) {
    $SkillRoot = Split-Path -Parent $PSScriptRoot
}
& (Join-Path $PSScriptRoot 'validate_skill.ps1') -SkillRoot $SkillRoot

$resolvedRoot = (Resolve-Path -LiteralPath $SkillRoot).Path
$resolvedOutputParent = (Resolve-Path -LiteralPath (Split-Path -Parent $OutputZip)).Path
$outputFull = Join-Path $resolvedOutputParent (Split-Path -Leaf $OutputZip)
$staging = Join-Path ([System.IO.Path]::GetTempPath()) ("courseware-distiller-package-" + [guid]::NewGuid().ToString('N'))
$stagedSkill = Join-Path $staging 'courseware-distiller'

try {
    New-Item -ItemType Directory -Path $staging | Out-Null
    Copy-Item -LiteralPath $resolvedRoot -Destination $stagedSkill -Recurse
    if (Test-Path -LiteralPath $outputFull) { Remove-Item -LiteralPath $outputFull }
    Compress-Archive -LiteralPath $stagedSkill -DestinationPath $outputFull -CompressionLevel Optimal

    $extract = Join-Path $staging 'verify'
    Expand-Archive -LiteralPath $outputFull -DestinationPath $extract
    $extractedRoot = Join-Path $extract 'courseware-distiller'
    & (Join-Path $PSScriptRoot 'validate_skill.ps1') -SkillRoot $extractedRoot

    $sourceFiles = Get-ChildItem -LiteralPath $resolvedRoot -File -Recurse | ForEach-Object {
        [pscustomobject]@{ Relative = $_.FullName.Substring($resolvedRoot.Length + 1); Hash = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash }
    }
    $zipFiles = Get-ChildItem -LiteralPath $extractedRoot -File -Recurse | ForEach-Object {
        [pscustomobject]@{ Relative = $_.FullName.Substring($extractedRoot.Length + 1); Hash = (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash }
    }
    $difference = Compare-Object $sourceFiles $zipFiles -Property Relative, Hash
    if ($difference) { throw 'Packaged files differ from source.' }
    Write-Output "PASS: package created and verified: $outputFull"
    Get-FileHash -LiteralPath $outputFull -Algorithm SHA256
}
finally {
    if (Test-Path -LiteralPath $staging) { Remove-Item -LiteralPath $staging -Recurse -Force }
}
