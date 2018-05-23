function Get-PrintDocumentEvent {
    [CmdLetBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('IPAddress','__Server','CN')]      
        [string]$ComputerName='localhost',
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [datetime]$StartTime,
        [datetime]$EndTime,
        [int64]$MaxEvents,
        [switch]$Oldest    
    )

    begin {

        $FilterHashTable = @{
            LogName = "Microsoft-Windows-PrintService/Operational"
            Id = 307
        }
        if ($StartTime) { $FilterHashTable.Add("StartTime",$StartTime) }
        if ($EndTime) { $FilterHashTable.Add("EndTime",$EndTime) }

        $ParameterSplat = @{}
        if ($Credential) {
            $ParameterSplat['Credential'] = $Credential
        }
        if ($MaxEvents) {
            $ParameterSplat['MaxEvents'] = $MaxEvents
        }
        if ($Oldest) {
            $ParameterSplat['Oldest'] = $true
        }
    }

    process {

        $Events = Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat
        
        $EventCount = 0
        foreach ($Event in $Events) {
            if ($EventCount -gt 0) {
                Write-Progress -Id 1 -Activity "Formatting events..." -PercentComplete (($EventCount / $Events.count) * 100)
            }
            $EventCount++
            $EventLogRecord = ConvertFrom-EventLogRecord -EventLogRecord $Event

            [PsCustomObject]@{
                ComputerName = $EventLogRecord.ComputerName
                TimeCreated = $EventLogRecord.TimeCreated
                PrintJobId = $EventLogRecord.PrintJobId
                DocumentName = $EventLogRecord.DocumentName
                UserName = $EventLogRecord.UserName
                ClientMachineName = $EventLogRecord.ClientMachineName
                PrinterName = $EventLogRecord.PrinterName
                PrinterPort = $EventLogRecord.PrinterPort
                DocumentSizeBytes = $EventLogRecord.DocumentSizeBytes
                DocumentPageCount = $EventLogRecord.DocumentPageCount
            }

        }

    }

    end {

    }
}