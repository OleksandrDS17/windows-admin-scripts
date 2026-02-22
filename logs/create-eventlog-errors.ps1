param(
  [string]$Source = "AdminScripts",
  [string]$LogName = "Application",
  [int]$Count = 5
)

if (-not [System.Diagnostics.EventLog]::SourceExists($Source)) {
  New-EventLog -LogName $LogName -Source $Source
}

1..$Count | ForEach-Object {
  Write-EventLog -LogName $LogName -Source $Source -EntryType Error -EventId 9001 -Message "Synthetic error #$_ for monitoring tests."
}
Write-Host "Wrote $Count errors to $LogName with source $Source"
