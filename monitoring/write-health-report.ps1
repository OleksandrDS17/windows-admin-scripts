param(
    [string]$OutFile = "$PSScriptRoot\health-report.json"
)

$report = @()

$report += & "$PSScriptRoot\check-cpu.ps1"
$report += & "$PSScriptRoot\check-memory.ps1"
$report += & "$PSScriptRoot\get-uptime.ps1"

$report | ConvertTo-Json -Depth 5 | Set-Content $OutFile -Encoding UTF8

Write-Host "Health report written to $OutFile"
