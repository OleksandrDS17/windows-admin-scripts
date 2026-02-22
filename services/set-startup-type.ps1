param(
  [Parameter(Mandatory)] [string]$Name,
  [ValidateSet('Automatic','Manual','Disabled')] [string]$StartupType
)

Set-Service -Name $Name -StartupType $StartupType -ErrorAction Stop
$svc = Get-CimInstance Win32_Service -Filter "Name='$Name'" | Select-Object Name, StartMode, State

[pscustomobject]@{
  Service    = $svc.Name
  StartMode  = $svc.StartMode
  State      = $svc.State
  Status     = 'OK'
}
