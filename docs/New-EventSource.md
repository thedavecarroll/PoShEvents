---
external help file: PoShEvents-help.xml
Module Name: PoShEvents
online version: https://poshevents.anovelidea.org/en/latest/New-EventSource/
schema: 2.0.0
---

# New-EventSource

## SYNOPSIS
Create a new event source, also called event provider, for an event log.

## SYNTAX

```powershell
New-EventSource [[-EventLog] <String>] [[-Source] <String>] [<CommonParameters>]
```

## DESCRIPTION
Create a new event source, also called event provider, for an event log.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-EventSource -EventLog "Windows PowerShell" -Source thedavecarroll
```

Add a new source, thedavecarroll, to the Windows PowerShell event log.

## PARAMETERS

### -EventLog
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

### -Source
The name of the new source, or provider.

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

[Online Version](https://poshevents.anovelidea.org/en/latest/New-EventSource/)
