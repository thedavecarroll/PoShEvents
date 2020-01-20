function Get-GPOProcessingEvent {
    [CmdLetBinding(DefaultParameterSetName='TimeSpan')]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
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
        [switch]$Raw,
        [object[]]$GroupPolicy
    )

    begin {

        $FilterXmlParam = @{
            LogName = 'Microsoft-Windows-GroupPolicy/Operational'
            Verbose = $false
        }
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

    process {
        if ($Raw) {
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat
        } else {
            if ($GroupPolicy) {
                Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'GPOProcessingEvent' -GroupPolicy $GroupPolicy
            } else {
                Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'GPOProcessingEvent'
            }
        }
    }

    end {

    }
}