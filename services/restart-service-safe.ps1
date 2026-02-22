param(
  [Parameter(Mandatory)] [string]$Name,
  [int]$Retries = 3,
  [int]$WaitSeconds = 10
)

for ($i=1; $i -le $Retries; $i++) {
  try {
    Restart-Service -Name $Name -Force -ErrorAction Stop
    Start-Sleep -Seconds $WaitSeconds
    $svc = Get-Service -Name $Name -ErrorAction Stop
    if ($svc.Status -eq 'Running') {
      [pscustomobject]@{ Service=$Name; Status='OK'; Attempt=$i; Message='Service restarted successfully' }
      exit 0
    }
    throw "Service status is $($svc.Status)"
  } catch {
    if ($i -eq $Retries) {
      [pscustomobject]@{ Service=$Name; Status='FAILED'; Attempt=$i; Message=$_.Exception.Message }
      exit 1
    }
    Start-Sleep -Seconds $WaitSeconds
  }
}
