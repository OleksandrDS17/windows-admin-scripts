
# windows-admin-scripts
PowerShell automation for user management, service control and administrative diagnostics on Windows systems

# Windows Administration & PowerShell Automatisierung

A collection of practical PowerShell scripts created to support daily Windows administration tasks.  
The focus of this repository is automation, service monitoring and extraction of system information.

## Goals of the project
- automate recurring administrative activities  
- simplify system checks  
- provide structured output for further analysis  
- improve reliability and speed of operational tasks  

## Implemented topics
- local user and group management  
- Windows service status verification  
- system information collection  
- Event Log filtering and analysis  

## Technologies & Tools
- PowerShell  
- Get-Service  
- Get-WinEvent  
- CIM/WMI cmdlets  
- standard Windows administration utilities  

## Example use cases
- quick verification whether important Windows services are running  
- extracting relevant system data for troubleshooting  
- administrative preparation before maintenance  
- repetitive daily checks  
- Event Viewer error inspection  

## Structure
Each script is self-contained and can be executed independently.  
Most scripts require standard user permissions, some may need elevated rights.

## Example execution
```powershell
.\script.ps1
