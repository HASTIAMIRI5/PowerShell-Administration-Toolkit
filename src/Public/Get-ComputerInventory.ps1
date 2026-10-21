function Get-ComputerInventory {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$ComputerName = $env:COMPUTERNAME
    )

    try {
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ComputerName -ErrorAction Stop
        $cs = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName -ErrorAction Stop
        $processor = Get-CimInstance -ClassName Win32_Processor -ComputerName $ComputerName -ErrorAction Stop | Select-Object -First 1
        $logicalDisks = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" -ComputerName $ComputerName -ErrorAction Stop

        $uptime = (Get-Date) - [datetime]$os.LastBootUpTime

        return [pscustomobject]@{
            ComputerName         = $cs.Name
            Domain               = $cs.Domain
            Manufacturer         = $cs.Manufacturer
            Model                = $cs.Model
            OS                   = $os.Caption
            Version              = $os.Version
            BuildNumber          = $os.BuildNumber
            InstallDate          = $os.InstallDate
            Uptime               = $uptime.ToString('d\.hh\:mm\:ss')
            TotalPhysicalMemoryGB = [math]::Round([decimal]$cs.TotalPhysicalMemory / 1GB, 2)
            Processor            = $processor.Name
            ProcessorCores       = $processor.NumberOfLogicalProcessors
            DiskSummary          = @(
                $logicalDisks | ForEach-Object {
                    [pscustomobject]@{
                        Drive             = $_.DeviceID
                        VolumeLabel      = $_.VolumeName
                        TotalGB          = [math]::Round([decimal]$_.Size / 1GB, 2)
                        FreeGB           = [math]::Round([decimal]$_.FreeSpace / 1GB, 2)
                        PercentFree      = if ([decimal]$_.Size -gt 0) { [math]::Round(([decimal]$_.FreeSpace / [decimal]$_.Size) * 100, 2) } else { 0 }
                    }
                }
            )
        }
    }
    catch {
        throw "Failed to collect inventory for '$ComputerName'. $($_.Exception.Message)"
    }
}
