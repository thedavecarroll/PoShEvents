---
external help file: PoShEvents-help.xml
Module Name: PoShEvents
online version: https://powershell.anovelidea.org/
schema: 2.0.0
---

# Write-WinEvent

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

```
Write-WinEvent [[-LogName] <String>] [[-Provider] <String>] [[-EventId] <Int64>]
 [[-EventType] <EventLogEntryType>] [[-EventData] <OrderedDictionary>] [[-MessageFormat] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -EventData
{{ Fill EventData Description }}

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
{{ Fill EventId Description }}

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
{{ Fill EventType Description }}

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
{{ Fill LogName Description }}

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
{{ Fill MessageFormat Description }}

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
{{ Fill Provider Description }}

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
