param(
    [int]$MinFreePct = 15
)

Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" | ForEach-Object {
    $freePct = [math]::Round(($_.FreeSpace / $_.Size) * 100,2)
    $status = if ($freePct -lt $MinFreePct) { "WARNING" } else { "OK" }

    [pscustomobject]@{
        Check     = "Disk"
        Drive     = $_.DeviceID
        FreePct   = $freePct
        Threshold = $MinFreePct
        Status    = $status
    }
}
