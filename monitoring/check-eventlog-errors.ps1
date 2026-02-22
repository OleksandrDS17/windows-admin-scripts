param(
    [int]$MinutesBack = 60,
    [int]$MaxErrors = 10,
    [string[]]$LogName = @("System","Application")
)

$since = (Get-Date).AddMinutes(-$MinutesBack)

$count = Get-WinEvent -FilterHashtable @{
    LogName   = $LogName
    StartTime = $since
} | Where-Object {$_.LevelDisplayName -eq "Error"} | Measure-Object | Select-Object -ExpandProperty Count

[pscustomobject]@{
    Check      = "EventLogErrors"
    Errors     = $count
    Threshold  = $MaxErrors
    Status     = if ($count -gt $MaxErrors) { "WARNING" } else { "OK" }
}
