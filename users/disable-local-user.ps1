param(
  [Parameter(Mandatory)] [string]$Username,
  [switch]$Enable
)

Get-LocalUser -Name $Username -ErrorAction Stop | Out-Null

if ($Enable) {
  Enable-LocalUser -Name $Username
  $state = "Enabled"
} else {
  Disable-LocalUser -Name $Username
  $state = "Disabled"
}

[pscustomobject]@{ Action="SetUserState"; User=$Username; State=$state; Status="OK" }
