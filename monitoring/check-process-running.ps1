param(
    [Parameter(Mandatory)] [string]$ProcessName
)

$p = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue

[pscustomobject]@{
    Check       = "Process"
    ProcessName = $ProcessName
    Running     = [bool]$p
    Status      = if ($p) { "OK" } else { "WARNING" }
}
