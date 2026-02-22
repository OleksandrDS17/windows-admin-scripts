param(
  [string[]]$LogName = @('System','Application'),
  [int]$KeepDays = 30,
  [string]$BackupDir = "$PSScriptRoot\backup"
)

New-Item -ItemType Directory -Force -Path $BackupDir | Out-Null
$cutoff = (Get-Date).AddDays(-$KeepDays)

foreach ($ln in $LogName) {
  $safe = $ln -replace '[^a-zA-Z0-9_-]','_'
  $bkp = Join-Path $BackupDir "$safe-before-clear-$((Get-Date).ToString('yyyyMMdd-HHmmss')).evtx"
  wevtutil epl $ln $bkp | Out-Null
  wevtutil cl $ln | Out-Null
  Write-Host "Backed up & cleared $ln -> $bkp (cutoff was $cutoff; log cleared fully)"
}
