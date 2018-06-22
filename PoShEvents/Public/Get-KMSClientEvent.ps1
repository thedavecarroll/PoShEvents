function Get-KMSClientEvent {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('IPAddress','__Server','CN')]
        [string[]]$ComputerName='localhost',
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [datetime]$StartTime,
        [datetime]$EndTime,
        [int64]$MaxEvents,
        [switch]$Oldest,
        [switch]$Raw
    )

    begin {

        if ($StartTime -and $EndTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&gt;='$($StartTime.ToUniversalTime().ToString("s"))' and @SystemTime&lt;='$($EndTime.ToUniversalTime().ToString("s"))'])"
        } elseif ($StartTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&gt;='$($StartTime.ToUniversalTime().ToString("s"))'])"
        } elseif ($EndTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&lt;='$($EndTime.ToUniversalTime().ToString("s"))'])"
        } else {
            $TimeCreatedFilter = ']'
        }

        $FilterXmlText = '<QueryList>'
        $FilterXmlText += '<Query Id="0" Path="Application">'
        $FilterXmlText += '<Select Path="Application">'
        $FilterXmlText += '*[System[Provider[@Name=''Microsoft-Windows-Security-SPP''] and '
        $FilterXmlText += '(EventID=12288 or EventID=12289 or EventID=12308)]'
        $FilterXmlText += $TimeCreatedFilter
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
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'KMSClientEvent'
        }
    }

    end {

    }
}