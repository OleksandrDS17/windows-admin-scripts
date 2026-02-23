param([int]$DaysInactive = 90)

$cutoff = (Get-Date).AddDays(-$DaysInactive)

Get-LocalUser |
  Where-Object { $_.LastLogon -and $_.LastLogon -lt $cutoff } |
  Select-Object Name, Enabled, LastLogon, Description |
  Sort-Object LastLogon
