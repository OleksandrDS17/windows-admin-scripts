param(
  [Parameter(Mandatory)] [string]$Name,
  [switch]$StopFirst
)

$svc = Get-Service -Name $Name -ErrorAction SilentlyContinue
if (-not $svc) { throw "Service not found: $Name" }

if ($StopFirst -and $svc.Status -ne 'Stopped') {
  Stop-Service -Name $Name -Force
  Start-Sleep -Seconds 2
}

sc.exe delete $Name | Out-Null

[pscustomobject]@{
  Service = $Name
  Status  = 'OK'
  Message = 'Service deleted'
}
