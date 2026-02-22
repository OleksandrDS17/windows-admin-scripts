param(
  [string]$OutFile = "$PSScriptRoot\service-config.csv"
)

$items = Get-CimInstance Win32_Service | Select-Object `
  Name, DisplayName, StartMode, State, PathName, StartName

$items | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $OutFile
Write-Host "Exported -> $OutFile"
