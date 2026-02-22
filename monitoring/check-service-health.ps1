param(
    [string[]]$ServiceNames = @("wuauserv","WinRM")
)

foreach ($svc in $ServiceNames) {
    $s = Get-Service -Name $svc -ErrorAction SilentlyContinue

    if (-not $s) {
        $status = "NOT_FOUND"
    } elseif ($s.Status -ne "Running") {
        $status = "WARNING"
    } else {
        $status = "OK"
    }

    [pscustomobject]@{
        Check   = "Service"
        Name    = $svc
        State   = $s.Status
        Status  = $status
    }
}
