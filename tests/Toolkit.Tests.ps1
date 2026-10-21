$modulePath = Join-Path $PSScriptRoot '..\PowerShellAdministrationToolkit.psd1'
Import-Module $modulePath -Force

Describe 'PowerShellAdministrationToolkit' {
    It 'loads the module and exposes the expected public functions' {
        $commands = Get-Command -Module PowerShellAdministrationToolkit
        $commands.Name | Should -Contain 'Get-ComputerInventory'
        $commands.Name | Should -Contain 'Test-NetworkPath'
        $commands.Name | Should -Contain 'Get-RecentWindowsEvents'
        $commands.Name | Should -Contain 'Get-ServicesHealth'
        $commands.Name | Should -Contain 'Invoke-AdminAudit'
    }

    It 'returns a valid computer inventory object' {
        $inventory = Get-ComputerInventory
        $inventory.ComputerName | Should -Not -BeNullOrEmpty
        $inventory.OS | Should -Not -BeNullOrEmpty
        $inventory.TotalPhysicalMemoryGB | Should -BeGreaterThan 0
    }

    It 'returns reachability information for a host' {
        $results = Test-NetworkPath -ComputerNames 'localhost'
        $results | Should -HaveCount 1
        $results[0].Reachable | Should -BeOfType [bool]
    }
}
