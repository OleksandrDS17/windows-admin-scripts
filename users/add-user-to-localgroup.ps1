param(
  [Parameter(Mandatory)] [string]$Username,
  [Parameter(Mandatory)] [string]$Group
)

Get-LocalUser -Name $Username -ErrorAction Stop | Out-Null
Get-LocalGroup -Name $Group -ErrorAction Stop | Out-Null

Add-LocalGroupMember -Group $Group -Member $Username -ErrorAction Stop
[pscustomobject]@{ Action="AddGroupMember"; User=$Username; Group=$Group; Status="OK" }
