param(
  [Parameter(Mandatory)] [string]$CsvPath
)

if (!(Test-Path $CsvPath)) { throw "CSV not found: $CsvPath" }

$rows = Import-Csv $CsvPath
foreach ($r in $rows) {
  $u = $r.Username
  if (-not $u) { continue }

  if (Get-LocalUser -Name $u -ErrorAction SilentlyContinue) {
    Write-Host "Skip (exists): $u"
    continue
  }

  $pw = Read-Host "Enter password for $u" -AsSecureString
  New-LocalUser -Name $u -Password $pw -FullName $r.FullName -Description "Bulk created" | Out-Null

  $groups = @()
  foreach ($p in $r.PSObject.Properties.Name) {
    if ($p -like "Group*") {
      if ($r.$p) { $groups += $r.$p }
    }
  }

  foreach ($g in $groups) {
    Add-LocalGroupMember -Group $g -Member $u -ErrorAction SilentlyContinue
  }

  Write-Host "Created: $u (Groups: $($groups -join ', '))"
}
