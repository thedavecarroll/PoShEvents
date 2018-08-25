# PoShEvents

[![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PoShEvents.svg?style=for-the-badge)](https://www.powershellgallery.com/packages/PoShEvents/)

The functions contained in this module will assist in harvesting data from event logs for various events.

## Installing the Module

```powershell
Install-Module -Name PoShEvents
```

## Group Policy Processing Events

If you need to determine if a particular policy has applied to a user or computer, you can use the `Get-GPOProcessingEvent` function.

```powershell
Get-GPOProcessingEvent -MaxEvents 10 | Out-GridView
```

This command will show the last 10 group policy processing events on the local system in gridview. You can then sort or enter additional criteria in the gridview.

## Logon Failure Events

Logon failure events, those events with Ids of 4625 and 4771, can be found using the `Get-LogonFailureEvent` function.

## Document Printing

The `Get-PrintDocumentEvent` function will show you all of the successful print jobs that the system has processed.

```powershell
C:\PowerShell\Get-PrintDocumentEvent -ComputerName printsvc -MaxEvents 1 -Oldest

ComputerName      : PRINTSVR
TimeCreated       : 10/5/2017 8:12:05 AM
PrintJobId        : 234
DocumentName      : Print Document
UserName          : <user name>
ClientMachineName : <system name>
PrinterName       : <generic printer name>
PrinterPort       : IP_<printer IP>
DocumentSizeBytes : 1557928
DocumentPageCount : 2
```

## Remote Desktop Connection Activity

Use `Get-RemoteLogonEvent` to show all remote desktop connections.
[This function needs to be refactored to use Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational. Also, auditing would need to be enabled for this function to useful.]

## Service Events

The `Get-ServiceEvent` function will query the specified system for all service control manager events for service operations, stop, and start events. You can then filter on a particular service name or service displayname.

```powershell
PS C:\PowerShell\Temp> (Get-ServiceEvent).Where({$_.ServiceDisplayName -match "print"}) | Select-Object -Property TimeCreated,EventType,ServiceName,ServiceDisplayName,Message

TimeCreated        : 9/12/2017 9:41:27 PM
EventType          : ServiceOperations
ServiceName        :
ServiceDisplayName : Printer Extensions and Notifications
Message            : The Printer Extensions and Notifications service is marked as an interactive service.  However,
                     the system is configured to not allow interactive services.  This service may not function
                     properly.

TimeCreated        : 10/3/2017 10:42:18 PM
EventType          : ServiceOperations
ServiceName        : Spooler
ServiceDisplayName : Print Spooler
Message            : The start type of the Print Spooler service was changed from auto start to demand start.

TimeCreated        : 10/3/2017 10:42:20 PM
EventType          : ServiceOperations
ServiceName        : Spooler
ServiceDisplayName : Print Spooler
Message            : The start type of the Print Spooler service was changed from demand start to auto start.
```

## System Restarts

You can quickly find out when a system was restarted and what process or user initiated the restart using the `Get-SystemRestartEvent` function.

```powershell
Get-SystemRestartEvent -ComputerName DC1 -MaxEvents 10
```