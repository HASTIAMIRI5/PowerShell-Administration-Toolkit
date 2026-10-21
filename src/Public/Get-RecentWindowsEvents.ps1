function Get-RecentWindowsEvents {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$LogName = 'System',

        [Parameter()]
        [int]$MaxEvents = 10,

        [Parameter()]
        [ValidateSet('Critical', 'Error', 'Warning', 'Information', 'Verbose')]
        [string]$Level = 'Error',

        [Parameter()]
        [string]$ComputerName = '.'
    )

    try {
        $events = Get-WinEvent -LogName $LogName -MaxEvents $MaxEvents -ComputerName $ComputerName -ErrorAction Stop |
            Where-Object { $_.LevelDisplayName -eq $Level }

        return $events | Select-Object TimeCreated, LevelDisplayName, Id, ProviderName, Message
    }
    catch {
        throw "Unable to read the '$LogName' log on '$ComputerName'. $($_.Exception.Message)"
    }
}
