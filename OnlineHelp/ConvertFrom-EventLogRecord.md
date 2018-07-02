---
external help file: PoShEvents-help.xml
Module Name: PoShEvents
online version: https://github.com/thedavecarroll/PoShEvents/blob/master/OnlineHelp/ConvertFrom-EventLogRecord.md
schema: 2.0.0
---

# ConvertFrom-EventLogRecord

## SYNOPSIS
This function converts EventLogRecords into human readable output.

## SYNTAX

```
ConvertFrom-EventLogRecord [-Events] <EventLogRecord[]> [[-EventRecordType] <String>]
 [[-GroupPolicy] <Object[]>] [<CommonParameters>]
```

## DESCRIPTION
This function converts EventLogRecords into human readable output.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-WinEvent -LogName System -MaxEvents 5 | ConvertFrom-EventLogRecord
```

### Example 2
```powershell
PS C:\> Get-WinEvent FilterHashTable = @{ProviderName = "Service Control Manager"} -MaxEvents 5 | ConvertFrom-EventLogRecord -EventRecordType ServiceEvent
```

## PARAMETERS

### -EventRecordType
Specifies the event record type which, in turn, determines the custom type and therefore the default properties of the output.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: PrintDocument, SystemRestartEvent, LogonFailureEvent, OSVersionFromEvent, RemoteLogonEvent, ServiceEvent, GPOProcessingEvent, KMSClientEvent, KMSHostEvent, KMSHostLicenseCheckEvent

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Events
One or more EventLogRecord objects.

```yaml
Type: EventLogRecord[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -GroupPolicy
Provide the function all group policy objects in order to have the friendly name presented in the event output. Usually, this can be set to 'Get-GPO -All'.

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Diagnostics.Eventing.Reader.EventLogRecord[]

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
