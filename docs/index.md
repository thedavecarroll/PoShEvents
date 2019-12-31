# PoShEvents Module


## Description


PowerShell module to query Windows Event Logs


## PoShEvents CmdLets


### [ConvertFrom-EventLogRecord](ConvertFrom-EventLogRecord.html)


This function converts EventLogRecords into human readable output.
### [Get-GPOProcessingEvent](Get-GPOProcessingEvent.html)


Queries the specific computer or group of computers for group policy processing events.
### [Get-KMSClientEvent](Get-KMSClientEvent.html)


This function returns details from KMS client events.
### [Get-KMSHostEvent](Get-KMSHostEvent.html)


This function queries a KMS host server for registration events.
### [Get-KMSHostLicenseCheckEvent](Get-KMSHostLicenseCheckEvent.html)


This function will search the provider Microsoft-Windows-Security-SPP for KMS Host license checks with Microsoft.
### [Get-LogonFailureEvent](Get-LogonFailureEvent.html)


This function searchs for logon failure events, those events with Ids of 4625 and 4771.
### [Get-OSVersionFromEvent](Get-OSVersionFromEvent.html)


This function returns the OperatingSystem version.
### [Get-PrintDocumentEvent](Get-PrintDocumentEvent.html)


This function will show you details for the successful print jobs that the system has processed.
### [Get-RemoteLogonEvent](Get-RemoteLogonEvent.html)


This function queries the security log for EventIds 4624,4625,4634,4778,4779.
### [Get-ServiceEvent](Get-ServiceEvent.html)


This function will query the specified system for all service control manager events for service operations, stop, and start events. You can then filter on a particular service name or service displayname.
### [Get-SystemRestartEvent](Get-SystemRestartEvent.html)


This function returns the details for system startup and shutdown events.
### [New-EventDataFilter](New-EventDataFilter.html)



New-EventDataFilter [[-Hashtable] <hashtable>] [<CommonParameters>]

### [New-EventFilterXml](New-EventFilterXml.html)



New-EventFilterXml -LogName <string> [-Provider <string>] [-EventId <string[]>] [-StartTime <datetime>] [-EndTime <datetime>] [-Since <timespan>] [-EventDataFilter <string>] [-LevelDisplayName <string[]>] [-Suppress] [<CommonParameters>]

New-EventFilterXml -LogName <string> [-Provider <string>] [-EventId <string[]>] [-StartTime <datetime>] [-EndTime <datetime>] [-Since <timespan>] [-EventDataFilter <string>] [-Suppress] [-Audit <string[]>] [<CommonParameters>]

### [New-EventSource](New-EventSource.html)



New-EventSource [[-EventLog] <string>] [[-Source] <string>] [<CommonParameters>]

### [Write-WinEvent](Write-WinEvent.html)



Write-WinEvent [[-LogName] <string>] [[-Provider] <string>] [[-EventId] <long>] [[-EventType] <EventLogEntryType>] [[-EventData] <OrderedDictionary>] [[-MessageFormat] <string>] [<CommonParameters>]

