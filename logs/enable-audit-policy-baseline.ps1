# Requires admin
$audit = @(
  'Account Logon\Credential Validation',
  'Account Management\User Account Management',
  'Logon/Logoff\Logon',
  'Policy Change\Audit Policy Change'
)

foreach ($cat in $audit) {
  auditpol /set /subcategory:"$cat" /success:enable /failure:enable | Out-Null
  Write-Host "Enabled: $cat"
}
