param(
  [Parameter(Mandatory)] [string]$Username,
  [switch]$WhatIf
)

$profile = Get-CimInstance Win32_UserProfile |
  Where-Object { $_.LocalPath -like "C:\Users\$Username" }

if (-not $profile) { throw "Profile not found for: $Username" }

if ($WhatIf) {
  $profile | Select-Object LocalPath, SID
  exit 0
}

$profile | Remove-CimInstance
[pscustomobject]@{ Action="RemoveProfile"; User=$Username; Status="OK" }
