# windows-admin-scripts

PowerShell automation for user management, service control, and administrative diagnostics on Windows systems.

---

## 📌 Overview

**windows-admin-scripts** is a practical collection of PowerShell scripts designed to support daily Windows administration tasks.
The repository focuses on automation, service monitoring, and structured system diagnostics.

All scripts are self-contained and can be executed independently.

---

## 🎯 Project Goals

* automate recurring administrative activities
* simplify system health checks
* provide structured output for further analysis
* improve reliability and speed of operational tasks
* support troubleshooting and maintenance preparation

---

## 🧩 Implemented Topics

* Local user and group management
* Windows service status verification
* System information collection
* Event Log filtering and analysis
* Basic health monitoring

---

## 🛠 Technologies & Tools

* PowerShell
* Get-Service
* Get-WinEvent
* CIM/WMI cmdlets
* Standard Windows administration utilities

---

## 📂 Repository Structure

```
windows-admin-scripts/
│
├── logs/
│   └── Event log analysis and export scripts
│
├── monitoring/
│   └── System health and availability checks
│
├── services/
│   └── Windows service management tools
│
├── users/
│   └── Local user and group administration
│
└── README.md
```

---

## 🚀 Example Use Cases

* quick verification whether important Windows services are running
* extracting relevant system data for troubleshooting
* administrative preparation before maintenance
* repetitive daily system checks
* Event Viewer error inspection
* basic server health monitoring

---

## ▶️ Example Execution

```powershell
.\script.ps1
```

Some scripts require elevated privileges (Run as Administrator).

---

## 🔐 Requirements

* Windows 10 / Windows Server
* PowerShell 5.1 or newer
* Administrator rights for certain operations

---

## ⚠️ Notes

* Test scripts in a non-production environment first.
* Review scripts before running in sensitive environments.
* Some service and user operations require administrative privileges.

---

# 🇩🇪 Windows Administration & PowerShell Automatisierung

## 📌 Überblick

**windows-admin-scripts** ist eine Sammlung praktischer PowerShell-Skripte zur Unterstützung täglicher Windows-Administrationsaufgaben.

Der Fokus liegt auf:

* Automatisierung
* Service-Monitoring
* strukturierter Systemdiagnose

Alle Skripte sind eigenständig ausführbar.

---

## 🎯 Projektziele

* wiederkehrende Administrationsaufgaben automatisieren
* Systemprüfungen vereinfachen
* strukturierte Ausgaben für Analysen bereitstellen
* Zuverlässigkeit und Geschwindigkeit erhöhen
* Troubleshooting unterstützen

---

## 🧩 Abgedeckte Themen

* Lokale Benutzer- und Gruppenverwaltung
* Überprüfung von Windows-Diensten
* Sammlung von Systeminformationen
* Event-Log-Analyse
* Basis-Monitoring

---

## ⚙️ Voraussetzungen

* Windows 10 / Windows Server
* PowerShell 5.1 oder neuer
* Für einige Skripte: Administratorrechte

---

## 📎 Ausführung

```powershell
.\script.ps1
```

---

## 📜 License

See [LICENSE](LICENSE) for details.

---

**Author:** OleksandrDS17
**Purpose:** Practical Windows administration automation

