function Invoke-OSShutdown {

param (
    [string[]]$computername, 
    [int]$args= 4,
    [switch]$logerrors,
    [string]$errorlog = 'c:\errors.txt'
)
foreach ($computer in $computername) {
    Try {

    Get-WMIObject -EA Stop -Class Win32_OperatingSystem -ComputerName $computer |
        Invoke-WmiMethod -Name Win32Shutdown -Arg $args | 
        Out-Null

    }
    catch {
        if ($logerrors){
            $computer | Out-file $errorlog -Append
        }
        Write-Warning "Error with $computer"
    }
}
}

function Get-OSInfo {

    param (
        [string[]]$computername,
        [switch]$logerrors,
        [string]$errorlog = 'c:\errors.txt'
    )

    Foreach ($computer in $computername){
        Try{
            Get-WmiObject -EA Stop -Class Win32_OperatingSystem -ComputerName $computer |
                    Select-Object Version,ServicePackMajorVersion,BuildNumber,OSArchitecture
        }
        Catch {
            if ($logerrors) {
                $computer | Out-File $errorlog -Append 
            }    
            Write-Warning "Error with $computer"
        }
    }   
}


function Get-DiskInfo {
    
param (
    [int]$drivetype,
    [String[]]$computername,
    [int]$PercentFree = 10,
    [string]$errorlog = 'C:\errors.txt',
    [switch]$logerrors
)

foreach ($computer in $computername){
    Try {
        Get-WmiObject -EA Stop -Class Win32_LogicalDisk -Filter "DriveType=$drivetype" -Computer $computer | 
            Where-Object { $_.FreeSpace / $_.Size * 100 -lt $PercentFree }

        }
    Catch {
        if ($logerrors){
            $computer | Out-file $errorlog -Append

        }
        Write-warning "Error with $computer"
    }
}
}