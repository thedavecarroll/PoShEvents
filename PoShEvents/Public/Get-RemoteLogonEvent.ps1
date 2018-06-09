function Get-RemoteLogonEvent {
    [CmdLetBinding()]
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

    Begin {


        if ($StartTime -and $EndTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&gt;='$($StartTime.ToUniversalTime().ToString("s"))' and @SystemTime&lt;='$($EndTime.ToUniversalTime().ToString("s"))'])"
        } elseif ($StartTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&gt;='$($StartTime.ToUniversalTime().ToString("s"))'])"
        } elseif ($EndTime) {
            $TimeCreatedFilter = "and (System/TimeCreated[@SystemTime&lt;='$($EndTime.ToUniversalTime().ToString("s"))'])"
        } else {
            $TimeCreatedFilter = $null
        }

        $FilterXmlText = '<QueryList>'
        $FilterXmlText += '<Query Id="0" Path="Security">'
        $FilterXmlText += '<Select Path="Security">'
        $FilterXmlText += '*[System[Provider[@Name=''Microsoft-Windows-Security-Auditing''] and '
        $FilterXmlText += '(EventID=4624 or EventID=4625 or EventID=4634 or EventID=4778 or EventID=4779)]]'
        $FilterXmlText += ' and *[EventData[Data[@Name=''LogonType''] and (Data=''3'' or Data=''8'' or Data=''10'')]]'
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

    Process {
        if ($Raw) {
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat
        } else {
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'RemoteLogonEvent'
        }
    }

    End {

    }
}