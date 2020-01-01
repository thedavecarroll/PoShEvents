---
external help file: PoShEvents-help.xml
Module Name: PoShEvents
online version: https://poshevents.anovelidea.org/en/latest/Write-WinEvent/
schema: 2.0.0
---

# Write-WinEvent

## SYNOPSIS
Write an event to the given event log.

## SYNTAX

```
Write-WinEvent [[-LogName] <String>] [[-Provider] <String>] [[-EventId] <Int64>]
 [[-EventType] <EventLogEntryType>] [[-EventData] <OrderedDictionary>] [[-MessageFormat] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Write an event to the given event log.

## EXAMPLES

### Example 1
```powershell
PS C:\> $EventData = [ordered]@{Program = 'MyProgram';ThisEvent = 'This is an event I want to track'; SomethingElse = 'I like the C64'}
PS C:\> Write-WinEvent -LogName "Windows PowerShell" -Provider thedavecarroll -EventId 100 -EventType Information -EventData $EventData
```

Create a new informational event log entry in the "Windows PowerShell" event log with the provider of thedavecarroll.

## PARAMETERS

### -EventData
An ordered hashtable, also called dictionary.

```yaml
Type: OrderedDictionary
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventId
The Id for the event.

```yaml
Type: Int64
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventType
The display level for the event.

```yaml
Type: EventLogEntryType
Parameter Sets: (All)
Aliases:
Accepted values: Error, Warning, Information, SuccessAudit, FailureAudit

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName
The name of the event log.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MessageFormat
Specifies the format of the event Message property. The EventData will be converted to this format in its entirety.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: JSON, CSV, XML

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Provider
The provider, also called source, for the event.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Online Version](https://poshevents.anovelidea.org/en/latest/Write-WinEvent/)
