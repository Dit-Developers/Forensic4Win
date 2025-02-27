# Define the output report file
$ReportFile = "C:\Win_Forensic_Report_$(Get-Date -Format 'yyyyMMdd_HHmmss').html"

# Banner
$Banner = @"
    ______                           _      __ ___       ___     
   / ____/___  ________  ____  _____(_)____/ // / |     / (_)___ 
  / /_  / __ \/ ___/ _ \/ __ \/ ___/ / ___/ // /| | /| / / / __ \
 / __/ / /_/ / /  /  __/ / / (__  ) / /__/__  __/ |/ |/ / / / / /
/_/    \____/_/   \___/_/ /_/____/_/\___/  /_/  |__/|__/_/_/ /_/  

                                            https://msuport.vercel.app

"@
Write-Host $Banner



# Collect System Information
$SystemInfo = systeminfo | Out-String

# Collect Running Processes
$Processes = Get-Process | Select-Object ProcessName, Id, CPU, StartTime | ConvertTo-Html -Fragment | Out-String

# Collect Network Connections
$NetConnections = Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess | ConvertTo-Html -Fragment | Out-String

# Collect Installed Programs
$InstalledPrograms = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | 
                     Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | ConvertTo-Html -Fragment | Out-String

# Collect User Accounts
$UserAccounts = Get-WmiObject Win32_UserAccount | 
                Select-Object Name, FullName, Disabled | ConvertTo-Html -Fragment | Out-String

# Collect Security Logs (Last 50 entries)
$SecurityLogs = Get-WinEvent -LogName Security -MaxEvents 50 -ErrorAction SilentlyContinue | 
                Select-Object TimeCreated, Id, LevelDisplayName, Message | ConvertTo-Html -Fragment | Out-String

# Collect Running Services
$RunningServices = Get-Service | Where-Object { $_.StartType -eq 'Auto' } | 
                    Select-Object Name, DisplayName, Status | ConvertTo-Html -Fragment | Out-String

# Collect Startup Programs
$StartupPrograms = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" | ConvertTo-Html -Fragment | Out-String

# Collect USB Device History
$USBDevices = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\USBSTOR\*" -ErrorAction SilentlyContinue | 
              Select-Object FriendlyName, Manufacturer, ParentIdPrefix | ConvertTo-Html -Fragment | Out-String

# Detect Suspicious Network Traffic
$SuspiciousConnections = Get-NetTCPConnection | Where-Object { $_.State -eq "Established" -and $_.RemoteAddress -ne "127.0.0.1" } | 
                          Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess | ConvertTo-Html -Fragment | Out-String

# HTML Structure
$HtmlContent = @"
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='UTF-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Windows Forensic Report</title>
    <link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet'>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css' rel='stylesheet'>
</head>
<body class='container mt-4'>
    <h1 class='text-center'><i class='fas fa-shield-alt'></i> Windows Forensic Report</h1>
    <p class='text-center'><a href='https://msuport.vercel.app'><i class='fas fa-globe'></i> Developed by Muhammad Sudais Usmani </a></p>
    
    <ul class='nav nav-tabs' id='forensicTabs' role='tablist'>
        <li class='nav-item'><a class='nav-link active' data-bs-toggle='tab' href='#system'>System Info</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#processes'>Running Processes</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#network'>Network Connections</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#installed'>Installed Programs</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#users'>User Accounts</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#logs'>Security Logs</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#services'>Running Services</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#startup'>Startup Programs</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#usb'>USB Device History</a></li>
        <li class='nav-item'><a class='nav-link' data-bs-toggle='tab' href='#suspicious'>Suspicious Connections</a></li>
    </ul>

    <div class='tab-content mt-3'>
        <div class='tab-pane fade show active' id='system'><pre>$SystemInfo</pre></div>
        <div class='tab-pane fade' id='processes'>$Processes</div>
        <div class='tab-pane fade' id='network'>$NetConnections</div>
        <div class='tab-pane fade' id='installed'>$InstalledPrograms</div>
        <div class='tab-pane fade' id='users'>$UserAccounts</div>
        <div class='tab-pane fade' id='logs'>$SecurityLogs</div>
        <div class='tab-pane fade' id='services'>$RunningServices</div>
        <div class='tab-pane fade' id='startup'>$StartupPrograms</div>
        <div class='tab-pane fade' id='usb'>$USBDevices</div>
        <div class='tab-pane fade' id='suspicious'>$SuspiciousConnections</div>
    </div>

    <footer class='text-center mt-4 p-3 border-top'>
        <p>Developed by <strong>Muhammad Sudais Usmani</strong></p>
    </footer>

    <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js'></script>
</body>
</html>
"@

# Save the report
$HtmlContent | Out-File -Encoding utf8 -FilePath $ReportFile -Force

Write-Host "(Forensic4Win) Forensic report generated: $ReportFile"
