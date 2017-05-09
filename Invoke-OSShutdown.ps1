function Invoke-OSShutdown {
[cmdletbinding()]
param (
    [string]$computername, 
    [int]$state = 4
)


Get-WMIObject -Class Win32_OperatingSystem -ComputerName $computername |
    Invoke-WmiMethod -Name Win32Shutdown -Arg $state | 
    Out-Null

}