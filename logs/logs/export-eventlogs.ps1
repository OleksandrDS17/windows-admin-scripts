<#
.SYNOPSIS
Export Windows Event Logs to EVTX and optional CSV.
#>
param(
  [string[]]$LogName = @('System','Application','Security'),
  [string]$OutDir = "$PSScriptRoot\exports",
  [int]$DaysBack = 7,
  [switch]$AlsoCsv
)

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$since = (Get-Date).AddDays(-$DaysBack)

foreach ($ln in $LogName) {
  $safe = $ln -replace '[^a-zA-Z0-9_-]','_'
  $evtx = Join-Path $OutDir "$safe-$((Get-Date).ToString('yyyyMMdd-HHmmss')).evtx"
  wevtutil epl $ln $evtx "/q:*[System[TimeCreated[@SystemTime>='$($since.ToUniversalTime().ToString("o"))']]]" 2>$null

  if ($AlsoCsv) {
    $csv = $evtx -replace '\.evtx$','.csv'
    Get-WinEvent -FilterHashtable @{LogName=$ln; StartTime=$since} |
      Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message |
      Export-Csv -NoTypeInformation -Encoding UTF8 -Path $csv
  }
  Write-Host "Exported $ln -> $evtx"
}
