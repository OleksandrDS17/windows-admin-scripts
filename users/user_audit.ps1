<#
.SYNOPSIS
Comprehensive local user audit.

.DESCRIPTION
Collects and reports:

- All local users
- Disabled accounts
- Inactive accounts (LastLogon)
- Local Administrators members
- Remote Desktop Users members

Designed for security auditing and operational visibility.

.PARAMETER InactiveDays
Threshold for inactive users.

.PARAMETER AsJson
Output results as JSON.
#>

param(
    [int]$InactiveDays = 90,
    [switch]$AsJson
)

$cutoff = (Get-Date).AddDays(-$InactiveDays)

# --- Local Users ---
$users = Get-LocalUser | Select-Object `
    Name,
    Enabled,
    LastLogon,
    PasswordNeverExpires,
    Description

# --- Disabled Users ---
$disabled = $users | Where-Object { -not $_.Enabled }

# --- Inactive Users ---
$inactive = $users | Where-Object {
    $_.LastLogon -and $_.LastLogon -lt $cutoff
}

# --- Local Admins ---
$admins = Get-LocalGroupMember -Group "Administrators" -ErrorAction SilentlyContinue |
    Select-Object Name, ObjectClass, PrincipalSource

# --- RDP Users ---
$rdp = Get-LocalGroupMember -Group "Remote Desktop Users" -ErrorAction SilentlyContinue |
    Select-Object Name, ObjectClass, PrincipalSource

# --- Summary Object ---
$result = [pscustomobject]@{
    Check            = "UserAudit"
    ComputerName     = $env:COMPUTERNAME
    TotalUsers       = ($users | Measure-Object).Count
    DisabledUsers    = ($disabled | Measure-Object).Count
    InactiveUsers    = ($inactive | Measure-Object).Count
    LocalAdmins      = ($admins | Measure-Object).Count
    RdpUsers         = ($rdp | Measure-Object).Count
    InactiveDays     = $InactiveDays
    Status           = "OK"
    Timestamp        = (Get-Date)
}

# --- Output ---
$output = [pscustomobject]@{
    Summary        = $result
    Users          = $users
    DisabledUsers  = $disabled
    InactiveUsers  = $inactive
    Administrators = $admins
    RdpUsers       = $rdp
}

if ($AsJson) {
    $output | ConvertTo-Json -Depth 5
} else {
    $output
}
