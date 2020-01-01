function Write-WinEvent {
    [CmdLetBinding()]
    param(
        [string]$LogName,
        [string]$Provider,
        [int64]$EventId,
        [System.Diagnostics.EventLogEntryType]$EventType,
        [System.Collections.Specialized.OrderedDictionary]$EventData,
        [ValidateSet('JSON','CSV','XML')]
        [string]$MessageFormat='JSON'
    )

    $EventMessage = [System.Collections.Generic.List[string]]::new()

    switch ($MessageFormat) {
        'JSON' {
            $Json = $EventData | ConvertTo-Json
            $EventMessage.Add($Json)
        }
        'CSV'  {
            $Csv = ($EventData.GetEnumerator() | Select-Object -Property Key,Value | ConvertTo-Csv -NoTypeInformation) -join "`n"
            $EventMessage.Add($Csv)
        }
        'XML'  {
            $Xml = ($EventData | ConvertTo-Xml).OuterXml
            $EventMessage.Add($Xml)
        }
    }

    foreach ($Key in $EventData.Keys) {
        $EventMessage.Add(('{0}:{1}' -f $Key,$EventData.$Key))
    }

    try {
        $Event = [System.Diagnostics.EventInstance]::New($EventId,$null,$EventType)
        $EventLog = [System.Diagnostics.EventLog]::New()
        $EventLog.Log = $LogName
        $EventLog.Source = $Provider
        $EventLog.WriteEvent($Event,$EventMessage)
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}
