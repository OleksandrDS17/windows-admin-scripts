<#
.SYNOPSIS
Checks the status of one or more Windows services.

.DESCRIPTION
Validates if specified services exist and are running.
Outputs structured results and optionally returns monitoring-style
exit codes:
- 0 = OK (all running)
- 1 = WARNING (one or more not running)
- 2 = CRITICAL (one or more not found)

.PARAMETER ServiceNames
List of service names to check (e.g. wuauserv, WinRM).

.PARAMETER AsJson
Outputs results as JSON.

.PARAMETER ExitCodes
Enables exit codes for monitoring systems (Task Scheduler, CI, etc.).

.EXAMPLE
.\check_services.ps1 -ServiceNames wuauserv,WinRM

.EXAMPLE
.\check_services.ps1 -ServiceNames wuauserv,WinRM -AsJson -ExitCodes
#>

param(
    [string[]]$ServiceNames = @("wuauserv","WinRM"),
    [switch]$AsJson,
    [switch]$ExitCodes
)

$results = foreach ($name in $ServiceNames) {
    $svc = Get-Service -Name $name -ErrorAction SilentlyContinue

    if (-not $svc) {
        [pscustomobject]@{
            Check   = "ServiceStatus"
            Name    = $name
            State   = $null
            Status  = "NOT_FOUND"
            Message = "Service does not exist"
        }
        continue
    }

    $status = if ($svc.Status -eq "Running") { "OK" } else { "WARNING" }

    [pscustomobject]@{
        Check   = "ServiceStatus"
        Name    = $svc.Name
        State   = $svc.Status.ToString()
        Status  = $status
        Message = if ($status -eq "OK") { "Service is running" } else { "Service is not running" }
    }
}

if ($AsJson) {
    $results | ConvertTo-Json -Depth 5
} else {
    $results
}

if ($ExitCodes) {
    if ($results.Status -contains "NOT_FOUND") { exit 2 }
    if ($results.Status -contains "WARNING")   { exit 1 }
    exit 0
}
