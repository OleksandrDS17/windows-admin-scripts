param([int]$DaysBack=30)
$since = (Get-Date).AddDays(-$DaysBack)

Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=$since} |
  Where-Object { $_.Id -in 41,1001 } |
  Select-Object TimeCreated, Id, ProviderName, Message |
  Sort-Object TimeCreated -Descending
