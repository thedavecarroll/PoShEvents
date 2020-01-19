function Get-ServiceEvent {
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
        [ValidateSet('ServiceOperations','ServiceStart','ServiceStop','ServiceControlManagerOperations','ServiceInstall')]
        [string]$EventType,
        [switch]$Raw
    )

    begin {

        $FilterXmlParam = @{
            LogName = 'System'
            Provider = 'Service Control Manager'
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

        switch ($EventType) {
            'ServiceOperations' {
                $EventID = @(7009,7011,7016,7021,7030,7035,7036,7037,7040)
            }
            'ServiceStart' {
                $EventID = @(7000,7001,7002,7003,7017,7019,7020,7022,7038,7039,7041)
            }
            'ServiceStop' {
                $EventID = @(7023,7024,7031,7032,7034,7042,7043)
            }
            'ServiceControlManagerOperations' {
                $EventID = @(7005,7006,7007,7008,7010,7012,7015,7018,7025,7026,7027,7028,7033)
            }
            'ServiceInstall' {
                $EventID = 7045
            }
        }
        $FilterXmlParam.Add('EventId',$EventID)

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
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'ServiceEvent'
        }
    }

    end {

    }

}