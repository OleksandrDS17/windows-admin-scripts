param(
    [Parameter(Mandatory)] [string]$ComputerName,
    [Parameter(Mandatory)] [int]$Port
)

$result = Test-NetConnection -ComputerName $ComputerName -Port $Port -WarningAction SilentlyContinue

[pscustomobject]@{
    Check        = "Port"
    ComputerName = $ComputerName
    Port         = $Port
    Reachable    = $result.TcpTestSucceeded
    Status       = if ($result.TcpTestSucceeded) { "OK" } else { "WARNING" }
}
