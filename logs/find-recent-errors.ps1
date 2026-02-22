param([int]$HoursBack=24,[string[]]$LogName=@('System','Application'))
$since = (Get-Date).AddHours(-$HoursBack)

Get-WinEvent -FilterHashtable @{LogName=$LogName; StartTime=$since} |
  Where-Object { $_.LevelDisplayName -in 'Error','Critical' } |
  Select-Object TimeCreated, LogName, Id, LevelDisplayName, ProviderName, Message |
  Sort-Object TimeCreated -Descending
