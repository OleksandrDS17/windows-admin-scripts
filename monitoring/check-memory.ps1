param(
    [int]$MinFreeGB = 2
)

$os = Get-CimInstance Win32_OperatingSystem
$freeGB = [math]::Round($os.FreePhysicalMemory / 1MB,2)

$status = if ($freeGB -lt $MinFreeGB) { "WARNING" } else { "OK" }

[pscustomobject]@{
    Check      = "Memory"
    FreeGB     = $freeGB
    MinFreeGB  = $MinFreeGB
    Status     = $status
}
