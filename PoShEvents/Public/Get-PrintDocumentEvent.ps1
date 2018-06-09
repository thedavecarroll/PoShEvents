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
        [switch]$Oldest,
        [switch]$Raw,
        [string]$UserName,
        [string]$ClientMachineName,
        [string]$PrinterName,
        [string]$PrinterPort
    )

    begin {

        if ($StartTime -and $EndTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&gt;='$($StartTime.ToUniversalTime().ToString("s"))' and @SystemTime&lt;='$($EndTime.ToUniversalTime().ToString("s"))'])"
        } elseif ($StartTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&gt;='$($StartTime.ToUniversalTime().ToString("s"))'])"
        } elseif ($EndTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&lt;='$($EndTime.ToUniversalTime().ToString("s"))'])"
        } else {
            $TimeCreatedFilter = $null
        }

        $DocumentPrintedFilterCount = 0
        if ($UserName) { $DocumentPrintedFilterCount++ }
        if ($ClientMachineName) { $DocumentPrintedFilterCount++ }
        if ($PrinterName) { $DocumentPrintedFilterCount++ }
        if ($PrinterPort) { $DocumentPrintedFilterCount++ }

        if ($DocumentPrintedFilterCount -gt 0) {
            $DocumentPrintedFilter = " and *[UserData[DocumentPrinted["

            if ($UserName) {
                $DocumentPrintedFilter += " (Param3='" + $UserName + "') "
            }
            if ($ClientMachineName) {
                if ($DocumentPrintedFilterCount -eq 1) {
                    $DocumentPrintedFilter += " (Param4='" + $ClientMachineName + "') "
                } else {
                    $DocumentPrintedFilter += " and (Param4='" + $ClientMachineName + "') "
                }
            }
            if ($PrinterName) {
                if ($DocumentPrintedFilterCount -eq 1) {
                    $DocumentPrintedFilter += " (Param5='" + $PrinterName + "') "
                } else {
                    $DocumentPrintedFilter += " and (Param5='" + $PrinterName + "') "
                }
            }
            if ($PrinterPort) {
                if ($DocumentPrintedFilterCount -eq 1) {
                    $DocumentPrintedFilter += " (Param6='" + $PrinterPort + "') "
                } else {
                    $DocumentPrintedFilter += " and (Param6='" + $PrinterPort + "') "
                }
            }

            $DocumentPrintedFilter += "]]] "

        } else {
            $DocumentPrintedFilter = $null
        }

        $FilterXmlText = '<QueryList>'
        $FilterXmlText += '<Query Id="0" Path="Microsoft-Windows-PrintService/Operational">'
        $FilterXmlText += '<Select Path="Microsoft-Windows-PrintService/Operational">'
        $FilterXmlText += '*[System[(EventID=307)]]'
        $FilterXmlText += $TimeCreatedFilter
        $FilterXmlText += $DocumentPrintedFilter
        $FilterXmlText += '</Select>'
        $FilterXmlText += '</Query>'
        $FilterXmlText += '</QueryList>'

        [xml]$FilterXml = $FilterXmlText

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
        if ($Raw) {
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat
        } else {
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'PrintDocument'
        }
    }

    end {

    }
}