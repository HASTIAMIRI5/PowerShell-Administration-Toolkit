function Test-NetworkPath {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string[]]$ComputerNames = @('localhost')
    )

    $results = foreach ($target in $ComputerNames) {
        try {
            $ping = Test-Connection -ComputerName $target -Count 1 -ErrorAction Stop
            [pscustomobject]@{
                ComputerName = $target
                Reachable = $true
                ResponseTimeMs = $ping.ResponseTime
            }
        }
        catch {
            [pscustomobject]@{
                ComputerName = $target
                Reachable = $false
                ResponseTimeMs = $null
            }
        }
    }

    return $results
}
