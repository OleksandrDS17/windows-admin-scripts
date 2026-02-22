param(
  [Parameter(Mandatory)] [string]$Name,
  [int]$ResetSeconds = 86400,
  [int]$RestartDelayMs = 5000
)

# First/Second/Subsequent failure: restart
$actions = "restart/$RestartDelayMs/restart/$RestartDelayMs/restart/$RestartDelayMs"

sc.exe failure $Name reset= $ResetSeconds actions= $actions | Out-Null
sc.exe failureflag $Name 1 | Out-Null

[pscustomobject]@{
  Service       = $Name
  Recovery      = 'restart on failure'
  ResetSeconds  = $ResetSeconds
  RestartDelayMs= $RestartDelayMs
  Status        = 'OK'
}
