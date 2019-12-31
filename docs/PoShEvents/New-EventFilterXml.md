---
external help file: PoShEvents-help.xml
Module Name: PoShEvents
online version: https://powershell.anovelidea.org/
schema: 2.0.0
---

# New-EventFilterXml

## SYNOPSIS
{{ Fill in the Synopsis }}

## SYNTAX

### Default (Default)
```
New-EventFilterXml -LogName <String> [-Provider <String>] [-EventId <String[]>] [-StartTime <DateTime>]
 [-EndTime <DateTime>] [-Since <TimeSpan>] [-EventDataFilter <String>] [-LevelDisplayName <String[]>]
 [-Suppress] [<CommonParameters>]
```

### Security
```
New-EventFilterXml -LogName <String> [-Provider <String>] [-EventId <String[]>] [-StartTime <DateTime>]
 [-EndTime <DateTime>] [-Since <TimeSpan>] [-EventDataFilter <String>] [-Suppress] [-Audit <String[]>]
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

### -Audit
{{ Fill Audit Description }}

```yaml
Type: String[]
Parameter Sets: Security
Aliases:
Accepted values: Success, Failure

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EndTime
{{ Fill EndTime Description }}

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventDataFilter
{{ Fill EventDataFilter Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventId
{{ Fill EventId Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LevelDisplayName
{{ Fill LevelDisplayName Description }}

```yaml
Type: String[]
Parameter Sets: Default
Aliases: Level
Accepted values: LogAlways, Critical, Error, Warning, Informational, Verbose, Issues

Required: False
Position: Named
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

Required: True
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Since
{{ Fill Since Description }}

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases: TimeSpan

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTime
{{ Fill StartTime Description }}

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Suppress
{{ Fill Suppress Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
