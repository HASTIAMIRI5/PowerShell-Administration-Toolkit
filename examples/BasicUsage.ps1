# Basic usage examples

Import-Module (Join-Path $PSScriptRoot '..\PowerShellAdministrationToolkit.psd1') -Force

# Inventory snapshot
$inventory = Get-ComputerInventory
$inventory | Format-List *

# Host reachability
Test-NetworkPath -ComputerNames 'localhost', '8.8.8.8'

# Event log review
Get-RecentWindowsEvents -LogName 'System' -MaxEvents 10 -Level 'Error'

# Service health
Get-ServicesHealth -Status 'Stopped'

# Full administrative audit
Invoke-AdminAudit | Format-List *
