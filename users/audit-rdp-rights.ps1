$group = "Remote Desktop Users"

$members = Get-LocalGroupMember -Group $group -ErrorAction SilentlyContinue
if (-not $members) {
  [pscustomobject]@{ Check="RDPAccess"; Group=$group; Members=0; Status="OK"; Note="No members or group missing" }
  exit 0
}

[pscustomobject]@{
  Check   = "RDPAccess"
  Group   = $group
  Members = ($members | Measure-Object).Count
  Status  = "OK"
}

$members | Select-Object Name, ObjectClass, PrincipalSource
