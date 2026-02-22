param(
  [string]$IisLogRoot = "$env:SystemDrive\inetpub\logs\LogFiles",
  [string]$OutDir = "$PSScriptRoot\exports\iis",
  [int]$DaysBack = 7,
  [switch]$Zip
)

if (!(Test-Path $IisLogRoot)) { throw "IIS log root not found: $IisLogRoot" }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$since = (Get-Date).AddDays(-$DaysBack)
$files = Get-ChildItem $IisLogRoot -Recurse -File | Where-Object { $_.LastWriteTime -ge $since }
foreach ($f in $files) {
  $dest = Join-Path $OutDir ($f.FullName.Substring($IisLogRoot.Length).TrimStart('\'))
  New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null
  Copy-Item $f.FullName $dest -Force
}
if ($Zip) {
  $zipPath = "$OutDir-$((Get-Date).ToString('yyyyMMdd-HHmmss')).zip"
  Compress-Archive -Path $OutDir\* -DestinationPath $zipPath -Force
  Write-Host "Created zip: $zipPath"
}
Write-Host "Exported $($files.Count) IIS log files."
