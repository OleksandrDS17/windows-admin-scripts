param(
  [Parameter(Mandatory)] [string]$Name,
  [Parameter(Mandatory)] [string]$Username,
  [string]$Password = ""
)

# For LocalSystem use: Username = "LocalSystem" and empty Password
sc.exe config $Name obj= $Username password= $Password | Out-Null

$svc = Get-CimInstance Win32_Service -Filter "Name='$Name'" | Select-Object Name, StartName
[pscustomobject]@{
  Service   = $svc.Name
  StartName = $svc.StartName
  Status    = 'OK'
}
