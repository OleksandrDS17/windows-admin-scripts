param([string]$OutDir="$PSScriptRoot\exports\windowsupdate")
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$out = Join-Path $OutDir "WindowsUpdate-$((Get-Date).ToString('yyyyMMdd-HHmmss')).log"
Get-WindowsUpdateLog -LogPath $out | Out-Null
Write-Host "Created: $out"
