param(
    [string]$ComputerName = "8.8.8.8",
    [int]$Count = 4
)

$pings = Test-Connection -ComputerName $ComputerName -Count $Count -ErrorAction SilentlyContinue
$received = ($pings | Measure-Object).Count
$lossPct = [math]::Round((($Count - $received) / $Count) * 100,2)

[pscustomobject]@{
    Check        = "Ping"
    Target       = $ComputerName
    Sent         = $Count
    Received     = $received
    LossPct      = $lossPct
    Status       = if ($lossPct -gt 0) { "WARNING" } else { "OK" }
}
