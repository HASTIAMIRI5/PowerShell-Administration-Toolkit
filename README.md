# PowerShell Administration Toolkit

A polished, practical PowerShell module designed for system administrators who want a lightweight and professional toolkit for inventory, health checks, network validation, and event review.

## Features

- System inventory collection for local or remote computers
- Reachability checks for one or more hosts
- Event log review for warnings and errors
- Service health monitoring
- Administrative audit summary for quick troubleshooting
- Clean, reusable PowerShell module structure for extension

## Repository layout

```text
.
├── LICENSE
├── README.md
├── PowerShellAdministrationToolkit.psd1
├── src/
│   ├── PowerShellAdministrationToolkit.psm1
│   ├── Public/
│   │   ├── Get-ComputerInventory.ps1
│   │   ├── Get-RecentWindowsEvents.ps1
│   │   ├── Get-ServicesHealth.ps1
│   │   ├── Invoke-AdminAudit.ps1
│   │   └── Test-NetworkPath.ps1
│   └── Private/
│       └── Format-AdminSummary.ps1
├── tests/
│   └── Toolkit.Tests.ps1
├── examples/
│   └── BasicUsage.ps1
└── .gitignore
```

## Installation

From the repository root:

```powershell
Import-Module .\PowerShellAdministrationToolkit.psd1 -Force
```

## Quick start

```powershell
# Get a quick inventory snapshot
Get-ComputerInventory

# Check connectivity to a set of hosts
Test-NetworkPath -ComputerNames 'localhost', '8.8.8.8', 'google.com'

# Review recent errors in the Windows System log
Get-RecentWindowsEvents -LogName 'System' -MaxEvents 20 -Level 'Error'

# See stopped services
Get-ServicesHealth -Status 'Stopped'

# Run a full admin audit summary
Invoke-AdminAudit
```

## Example: export a full report

```powershell
$report = Invoke-AdminAudit
$report | Format-List *
```

## Requirements

- Windows PowerShell 5.1+ or PowerShell 7+
- Windows operating system for the event log and service-related functions

## Contributing

Contributions are welcome. Please keep functions focused, well-documented, and PowerShell-friendly.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
