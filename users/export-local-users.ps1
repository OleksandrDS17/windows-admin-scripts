param([string]$OutFile = "$PSScriptRoot\local-users.csv")

Get-LocalUser |
  Select-Object Name, Enabled, LastLogon, PasswordNeverExpires, Description |
  Export-Csv -NoTypeInformation -Encoding UTF8 -Path $OutFile

Write-Host "Exported -> $OutFile"
