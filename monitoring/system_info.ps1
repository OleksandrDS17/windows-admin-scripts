<#
.SYNOPSIS
Collects general system information for monitoring and diagnostics.

.DESCRIPTION
Gathers key Windows system metrics including:
- Computer name
- OS version
- CPU model
- Memory statistics
- Last boot time and uptime

Outputs structured object suitable for automation and reporting.
#>

$os  = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$cs  = Get-CimInstance Win32_ComputerSystem

$uptime = (Get-Date) - $os.LastBootUpTime
$totalRAMGB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 2)
$freeRAMGB  = [math]::Round($os.FreePhysicalMemory / 1MB, 2)

[pscustomobject]@{
    Check            = "SystemInfo"
    ComputerName     = $env:COMPUTERNAME
    OS               = $os.Caption
    OSVersion        = $os.Version
    CPU              = $cpu.Name
    TotalMemoryGB    = $totalRAMGB
    FreeMemoryGB     = $freeRAMGB
    LastBootTime     = $os.LastBootUpTime
    UptimeDays       = [math]::Round($uptime.TotalDays, 2)
    Status           = "OK"
}
