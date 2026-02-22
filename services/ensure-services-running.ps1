param(
  [Parameter(Mandatory)] [string[]]$ServiceNames
)

$results = foreach ($name in $ServiceNames) {
  $svc = Get-Service -Name $name -ErrorAction SilentlyContinue
  if (-not $svc) {
    [pscustomobject]@{ Service=$name; Action='none'; Status='NOT_FOUND' }
    continue
  }

  if ($svc.Status -ne 'Running') {
    try {
      Start-Service -Name $name -ErrorAction Stop
      Start-Sleep -Seconds 2
      $new = (Get-Service -Name $name).Status
      [pscustomobject]@{ Service=$name; Action='start'; Status= if($new -eq 'Running'){'OK'} else {'WARNING'} }
    } catch {
      [pscustomobject]@{ Service=$name; Action='start'; Status='FAILED'; Error=$_.Exception.Message }
    }
  } else {
    [pscustomobject]@{ Service=$name; Action='none'; Status='OK' }
  }
}

$results
