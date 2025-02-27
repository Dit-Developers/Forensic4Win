# Forensic4Win
```bash
    ______                           _      __ ___       ___
   / ____/___  ________  ____  _____(_)____/ // / |     / (_)___
  / /_  / __ \/ ___/ _ \/ __ \/ ___/ / ___/ // /| | /| / / / __ \
 / __/ / /_/ / /  /  __/ / / (__  ) / /__/__  __/ |/ |/ / / / / /
/_/    \____/_/   \___/_/ /_/____/_/\___/  /_/  |__/|__/_/_/ /_/

                                            https://msuport.vercel.app
```

## Overview
Forensic4Win is a Windows forensic tool that gathers system information, running processes, network connections, installed programs, user accounts, security logs, running services, startup programs, USB device history, and suspicious network connections. It generates an HTML report with a structured and easy-to-navigate interface.

## Features
- **System Information**: Collects detailed system specifications.
- **Running Processes**: Lists active processes with their details.
- **Network Connections**: Captures active TCP connections and their status.
- **Installed Programs**: Extracts a list of installed applications.
- **User Accounts**: Displays user account information.
- **Security Logs**: Retrieves the latest 50 security log events.
- **Running Services**: Lists auto-start services and their statuses.
- **Startup Programs**: Identifies programs set to launch at startup.
- **USB Device History**: Fetches details of previously connected USB storage devices.
- **Suspicious Network Connections**: Detects established connections to remote hosts.

## Usage
1. **Run PowerShell as Administrator**: 
   - Open PowerShell with administrative privileges.
2. **Execute the Script**:
   - Run the the script as `Forensic4Win.ps1` and run it using:
     ```powershell
     powershell -ExecutionPolicy Bypass -File Forensic4Win.ps1
     ```
3. **View the Report**:
   - The script generates an HTML report saved in `C:\Win_Forensic_Report_YYYYMMDD_HHMMSS.html`.
   - Open the report in a web browser to view forensic details.

## Dependencies
- **PowerShell** (Pre-installed on Windows)
- **Administrator Privileges** (Required for gathering certain data)
- **Internet Access** (Optional, for Bootstrap and FontAwesome styling)

## License
Forensic4Win is released under the MIT License.

## Author
Developed by **Muhammad Sudais Usmani**

For more details, visit: [msuport.vercel.app](https://msuport.vercel.app)
