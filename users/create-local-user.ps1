param(
  [Parameter(Mandatory)] [string]$Username,
  [string]$FullName = "",
  [string]$Description = "Created by windows-admin-scripts",
  [switch]$PasswordNeverExpires,
  [string[]]$AddToGroups = @()
)

if (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue) {
  throw "User already exists: $Username"
}

$pw = Read-Host "Enter password for $Username" -AsSecureString
New-LocalUser -Name $Username -Password $pw -FullName $FullName -Description $Description | Out-Null

if ($PasswordNeverExpires) {
  Set-LocalUser -Name $Username -PasswordNeverExpires $true
}

foreach ($g in $AddToGroups) {
  Add-LocalGroupMember -Group $g -Member $Username -ErrorAction Stop
}

[pscustomobject]@{ Action="CreateUser"; User=$Username; Status="OK"; Groups=($AddToGroups -join ",") }
