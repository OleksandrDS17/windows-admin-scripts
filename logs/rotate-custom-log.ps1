param(
  [Parameter(Mandatory)] [string]$Path,
  [int]$MaxSizeMB = 10,
  [int]$Keep = 5
)

if (!(Test-Path $Path)) { throw "File not found: $Path" }
$max = $MaxSizeMB * 1MB
$fi = Get-Item $Path

if ($fi.Length -lt $max) { Write-Host "OK: $Path size $($fi.Length)"; exit 0 }

for ($i=$Keep-1; $i -ge 1; $i--) {
  $old = "$Path.$i"
  $new = "$Path." + ($i+1)
  if (Test-Path $old) { Move-Item $old $new -Force }
}
Move-Item $Path "$Path.1" -Force
New-Item -ItemType File -Path $Path -Force | Out-Null
Write-Host "Rotated $Path (kept $Keep)."
