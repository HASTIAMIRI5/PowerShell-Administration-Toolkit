function Format-AdminSummary {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$ComputerName,

        [Parameter()]
        [int]$ServiceIssueCount = 0,

        [Parameter()]
        [int]$ErrorCount = 0
    )

    $issues = @()

    if ($ServiceIssueCount -gt 0) {
        $issues += "Detected $ServiceIssueCount stopped or unhealthy services."
    }

    if ($ErrorCount -gt 0) {
        $issues += "Detected $ErrorCount recent Windows System log errors."
    }

    if (-not $issues) {
        return "Computer '$ComputerName' appears healthy. No immediate administrative issues were detected."
    }

    return "Computer '$ComputerName' generated the following issues: $($issues -join ' ')"
}
