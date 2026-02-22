param(
  [Parameter(Mandatory)] [string]$Name,
  [Parameter(Mandatory)] [string]$BinaryPath,
  [string]$DisplayName = $Name,
  [ValidateSet('auto','demand','disabled')] [string]$StartType = 'auto'
)

if (Get-Service -Name $Name -ErrorAction SilentlyContinue) {
  throw "Service already exists: $Name"
}

sc.exe create $Name binPath= "`"$BinaryPath`"" DisplayName= "`"$DisplayName`"" start= $StartType | Out-Null

[pscustomobject]@{
  Service     = $Name
  DisplayName = $DisplayName
  BinaryPath  = $BinaryPath
  StartType   = $StartType
  Status      = 'OK'
}
