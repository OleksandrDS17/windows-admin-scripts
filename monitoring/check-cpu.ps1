param(
    [int]$Threshold = 80
)

$cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
$cpu = [math]::Round($cpu,2)

$status = if ($cpu -ge $Threshold) { "WARNING" } else { "OK" }

[pscustomobject]@{
    Check      = "CPU"
    UsagePct   = $cpu
    Threshold  = $Threshold
    Status     = $status
}
