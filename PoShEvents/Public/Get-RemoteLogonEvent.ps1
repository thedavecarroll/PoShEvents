function Get-RemoteLogonEvent {
    [CmdLetBinding(DefaultParameterSetName='TimeSpan')]
    param(
        [Parameter(ParameterSetName='Default',ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [Alias('IPAddress','__Server','CN')]
        [string[]]$ComputerName='localhost',
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [Parameter(ParameterSetName='TimeRange')]
        [datetime]$StartTime,
        [Parameter(ParameterSetName='TimeRange')]
        [datetime]$EndTime,
        [Parameter(ParameterSetName='TimeSpan')]
        [timespan]$Since,
        [int64]$MaxEvents,
        [switch]$Oldest,
        [switch]$Raw
    )

    Begin {

        $Hashtable = @{
            EventData = @{
                Data = @{
                    Name = 'LogonType'
                    Data = 3,8,10
                }
            }
        }

        $FilterXmlParam = @{
            LogName = 'Security'
            Provider = 'Microsoft-Windows-Security-Auditing'
            EventId = 4624,4625,4634,4778,4779
        }
        $FilterXmlParam.Add('EventDataFilter',(New-EventDataFilter -Hashtable $Hashtable))

        if ($PSCmdlet.ParameterSetName -eq 'TimeSpan') {
            if ($Since) {
                $FilterXmlParam.Add('Since',$Since)
            }
        } else {
            if ($StartTime) {
                $FilterXmlParam.Add('StartTime',$StartTime)
            }
            if ($EndTime) {
                $FilterXmlParam.Add('EndTime',$EndTime)
            }
        }

        $FilterXml = New-EventFilterXml @FilterXmlParam

        '{0}{1}' -f [System.Environment]::NewLine,$FilterXml | Write-Verbose

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