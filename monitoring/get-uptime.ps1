$os = Get-CimInstance Win32_OperatingSystem
$boot = $os.LastBootUpTime
$uptime = (Get-Date) - $boot

[pscustomobject]@{
    Check        = "Uptime"
    LastBoot     = $boot
    UptimeDays   = [math]::Round($uptime.TotalDays,2)
    Status       = "OK"
}
