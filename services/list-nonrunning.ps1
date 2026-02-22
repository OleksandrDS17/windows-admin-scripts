param(
  [switch]$OnlyAutomatic
)

$services = Get-Service
if ($OnlyAutomatic) {
  $autoNames = Get-CimInstance Win32_Service | Where-Object { $_.StartMode -eq 'Auto' } | Select-Object -ExpandProperty Name
  $services = $services | Where-Object { $_.Name -in $autoNames }
}

$services | Where-Object { $_.Status -ne 'Running' } |
  Select-Object Name, DisplayName, Status |
  Sort-Object Name
