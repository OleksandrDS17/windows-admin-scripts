param(
  [Parameter(Mandatory)] [string]$Query
)

Get-Service | Where-Object {
  $_.Name -like "*$Query*" -or $_.DisplayName -like "*$Query*"
} | Select-Object Name, DisplayName, Status | Sort-Object Name
