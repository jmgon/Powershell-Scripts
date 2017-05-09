function Get-OSInfo {
[cmdletbinding()]
    param (
        [string]$computername 
    )
    Get-WmiObject -Class Win32_OperatingSystem -ComputerName Client |
    Select-Object Version,ServicePackMajorVersion,BuildNumber,OSArchitecture
}
