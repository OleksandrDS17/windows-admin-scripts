param([Parameter(Mandatory)] [string]$Username)

$user = Get-LocalUser -Name $Username -ErrorAction Stop
$pw = Read-Host "Enter new password for $Username" -AsSecureString
Set-LocalUser -Name $Username -Password $pw

[pscustomobject]@{ Action="ResetPassword"; User=$Username; Status="OK" }
