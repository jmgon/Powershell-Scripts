function Get-DiskInfo {
    [cmdletbinding()]
param (
    [int]$drivetype,
    [String]$computername,
    [int]$PercentFree = 10
)

Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=$drivetype" -Computer $computername | 
    Where-Object { $_.FreeSpace / $_.Size * 100 -lt $PercentFree }

}