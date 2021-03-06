function New-EventFilterXml {
    [CmdLetBinding(DefaultParameterSetName='TimeSpan')]
    param(
        [Parameter(Mandatory)]
        [string]$LogName,

        [string]$Provider,

        [Alias('Id')]
        [string[]]$EventId,

        [Parameter(ParameterSetName='TimeRange')]
        [datetime]$StartTime,

        [Parameter(ParameterSetName='TimeRange')]
        [datetime]$EndTime,

        [Parameter(ParameterSetName='TimeSpan')]
        [Alias('TimeSpan')]
        [timespan]$Since,

        [string]$EventDataFilter,

        [Alias('Level')]
        [LogLevelName[]]$LevelDisplayName,

        [ValidateSet('Success','Failure')]
        [string[]]$Audit,

        [switch]$XPath
    )

    #region validate logname when using parameterset Security
    if ($PSBoundParameters.Keys -contains 'Audit' -and $LogName -ne 'Security')  {

        try {
            Write-Error -Message 'Audit filtering must specify Security as LogName' -Category InvalidArgument -ErrorAction Stop
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }
    #endregion validate logname when using parameterset Security

    $EventFilterList = [System.Collections.Generic.List[object]]::new()

    #region set event log level filter
    $LogLevel = [System.Collections.Generic.List[object]]::new()
    foreach ($Level in $LevelDisplayName) {
        if ($Level -eq 'Issues') {
            $LogLevel.Add('Level=1 or Level=2 or Level=3')
        } else {
            $LogLevel.Add('Level={0}' -f [LogLevelname]::$Level.Value__)
        }
    }
    if ($LogLevel.Count -gt 0) {
        $LogLevelFilter = '({0})' -f ($LogLevel -join ' or ')
        $EventFilterList.Add($LogLevelFilter)
    }
    #endregion set event log level filter

    #region set event id filter
    $EventIdList = [System.Collections.Generic.List[object]]::new()
    $EventIdRangeList = [System.Collections.Generic.List[object]]::new()
    foreach ($Id in $EventId) {
        if ($Id -as [int]) {
            $EventIdList.Add("EventID=$Id")
        } elseif ($Id -match '^\d+-\d+$') {
            $EventIdRange = $Id.Split('-')
            if ($EventIdRange.Count -eq 2) {
                if ($EventIdRange[0] -lt $EventIdRange[1] ) {
                    $EventIdRangeFilter = '(EventID >= {0} and EventID <= {1})' -f $EventIdRange[0],$EventIdRange[1]
                    $EventIdRangeList.Add($EventIdRangeFilter)
                } else {
                    'Invalid event Id range: {0} is larger than {1}' -f $EventIdRange[0],$EventIdRange[1] | Write-Warning
                    return
                }
            } else {
            'Invalid event Id range: {0}' -f $Id | Write-Warning
            return
            }
        } else {
            'Invalid event Id: {0}' -f $Id | Write-Warning
            return
        }
    }
    if ($EventIdRangeList.Count -gt 0) {
        foreach ($EventIdRangeFilter in $EventIdRangeList) {
            $EventIdList.Add($EventIdRangeFilter)
        }
    }
    if ($EventIdList.Count -gt 0) {
        $EventIdFilter = '({0})' -f ($EventIdList -join ' or ')
        $EventFilterList.Add($EventIdFilter)
    }
    #endregion set event id filter

    #region set event time filter
    if ($PSBoundParameters.Keys -contains 'Since') {
        $SinceTime = 'TimeCreated[timediff(@SystemTime) <= {0}]' -f $Since.TotalMilliseconds.ToString()
        $EventFilterList.Add($SinceTime)
    } else {
        $StartFilter = $EndFilter = $null
        if ($StartTime) {
            $StartFilter = "@SystemTime>='{0}Z'" -f $StartTime.ToUniversalTime().ToString('s')
        }
        if ($EndTime) {
            $EndFilter = "@SystemTime<='{0}Z'" -f $EndTime.ToUniversalTime().ToString('s')
        }
        if ($StartFilter -and $EndFilter) {
            $StartEndTime = 'TimeCreated[{0} and {1}]' -f $StartFilter,$EndFilter
            $EventFilterList.Add($StartEndTime)
        } elseif ($StartFilter -and $null -eq $EndFilter) {
            $StartTime = 'TimeCreated[{0}]' -f $StartFilter
            $EventFilterList.Add($StartTime)
        } elseif ($null -eq $StartFilter -and $EndFilter) {
            $EndTime = 'TimeCreated[{0}]' -f $EndFilter
            $EventFilterList.Add($EndTime)
        }
    }
    #endregion set event time filter

    #region add provider and build filter
    if ($EventFilterList.Count -gt 1) {
        $FilterListText = $EventFilterList -join ' and '
    } elseif ($EventFilterList.Count -eq 1) {
        $FilterListText = $EventFilterList[0]
    } else {
        $FilterListText = $null
    }
    if ($FilterListText) {
        if ($Provider) {
            $XPathFilter = '*[System[Provider[@Name="{0}"] and {1}]]' -f $Provider,$FilterListText
        } else {
            $XPathFilter = '*[System[{0}]]' -f $FilterListText
        }
    } else {
        $XPathFilter = '*'
    }
    #endregion add provider

    #region combine data filter
    if ($EventDataFilter) {
        $CombinedFilter = $XPathFilter,$EventDataFilter -join ' and '
    } else {
        $CombinedFilter = $XPathFilter
    }
    #endregion

    #region output XPath filter only
    if ($XPath) {
        '{0}{1}' -f [System.Environment]::NewLine,$CombinedFilter | Write-Verbose
        $CombinedFilter
        return
    }
    #endregion

    #region create xml
    $xmlWriterSettings = [System.Xml.XmlWriterSettings]::new()
    $xmlWriterSettings.OmitXmlDeclaration = $true
    $xmlWriterSettings.Indent = $true
    $xmlWriterSettings.IndentChars = '    '
    $xmlWriterSettings.NewLineChars = [System.Environment]::NewLine
    $xmlWriterSettings.NewLineHandling = [System.Xml.NewLineHandling]::Replace

    $stringBuilder = [System.Text.StringBuilder]::new()
    $xmlWriter = [System.Xml.XmlWriter]::Create($StringBuilder,$xmlWriterSettings)

    $xmlWriter.WriteStartDocument()
    $xmlWriter.WriteStartElement('QueryList')
    $xmlWriter.WriteStartElement('Query')
    $xmlWriter.WriteAttributeString('Id',0)
    $xmlWriter.WriteAttributeString('Path',$LogName)
    $xmlWriter.WriteStartElement('Select')
    $xmlWriter.WriteAttributeString('Path',$LogName)

    $xmlWriter.WriteString($CombinedFilter)

    $xmlWriter.WriteEndElement() # end Select
    $xmlWriter.WriteEndElement() # end Query
    $xmlWriter.WriteEndElement() # end QueryList
    $xmlWriter.WriteEndDocument() # end document
    $xmlWriter.Flush()
    $xmlWriter.Close()
    #endregion create xml

    '{0}{1}' -f [System.Environment]::NewLine,$stringBuilder.ToString() | Write-Verbose
    $stringBuilder.ToString()

}