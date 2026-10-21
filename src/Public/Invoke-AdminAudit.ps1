function Invoke-AdminAudit {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$ComputerName = $env:COMPUTERNAME
    )

    $inventory = Get-ComputerInventory -ComputerName $ComputerName
    $stoppedServices = Get-ServicesHealth -Status 'Stopped'
    $recentErrors = Get-RecentWindowsEvents -LogName 'System' -MaxEvents 20 -Level 'Error'

    $serviceIssueCount = if ($stoppedServices) { @($stoppedServices).Count } else { 0 }
    $errorCount = if ($recentErrors) { @($recentErrors).Count } else { 0 }

    $status = if ($serviceIssueCount -gt 0 -or $errorCount -gt 0) {
        'Warning'
    }
    else {
        'Healthy'
    }

    $summary = Format-AdminSummary -ComputerName $ComputerName -ServiceIssueCount $serviceIssueCount -ErrorCount $errorCount

    return [pscustomobject]@{
        ComputerName = $ComputerName
        GeneratedAt = Get-Date
        HealthStatus = $status
        Inventory = $inventory
        StoppedServices = $stoppedServices
        RecentErrors = $recentErrors
        Summary = $summary
    }
}
