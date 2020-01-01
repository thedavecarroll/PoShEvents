---
external help file: PoShEvents-help.xml
Module Name: PoShEvents
online version: https://poshevents.anovelidea.org/en/latest/New-EventDataFilter/
schema: 2.0.0
---

# New-EventDataFilter

## SYNOPSIS
Creates the text string that can be used with the `New-EventFilterXml` function to filter by named EventData data.

## SYNTAX

```powershell
New-EventDataFilter [[-Hashtable] <Hashtable>] [<CommonParameters>]
```

## DESCRIPTION
Creates the text string that can be used with the `New-EventFilterXml` function to filter by named EventData data.

## EXAMPLES

### Example 1
```powershell
PS C:\> $EventData = @{ UserData = @{ DocumentPrinted = @{Param2 = "MyDocumentName" }}}
PS C:\> New-EventDataFilter -Hashtable $EventData
*[UserData[DocumentPrinted[(Param2="MyDocumentName.docx")]]]
```

Create a EventData filter for the printed document named MyDocumentName.docx.

## PARAMETERS

### -Hashtable
The hashtable should contain UserData and/or EventData each with their own hashtable.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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

[Online Version](https://poshevents.anovelidea.org/en/latest/New-EventDataFilter/)
