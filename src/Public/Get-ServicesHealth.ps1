function Get-ServicesHealth {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string[]]$ServiceName = '*',

        [Parameter()]
        [ValidateSet('Running', 'Stopped', 'Paused')]
        [string]$Status = 'Stopped'
    )

    try {
        $services = Get-Service -Name $ServiceName -ErrorAction Stop |
            Where-Object { $_.Status.ToString() -eq $Status }

        return $services | Select-Object Name, DisplayName, Status, StartType
    }
    catch {
        throw "Failed to enumerate service health. $($_.Exception.Message)"
    }
}
