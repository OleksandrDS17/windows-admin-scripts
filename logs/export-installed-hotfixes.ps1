param([string]$OutFile="$PSScriptRoot\exports\hotfixes.csv")
New-Item -ItemType Directory -Force -Path (Split-Path $OutFile) | Out-Null
Get-HotFix | Sort-Object InstalledOn -Descending |
  Export-Csv -NoTypeInformation -Encoding UTF8 -Path $OutFile
Write-Host "Exported -> $OutFile"
