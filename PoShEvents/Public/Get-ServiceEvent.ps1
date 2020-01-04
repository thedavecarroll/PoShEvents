function Get-ServiceEvent {
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
        [ValidateSet('ServiceOperations','ServiceStart','ServiceStop','ServiceControlManagerOperations','ServiceInstall')]
        [string]$EventType,
        [switch]$Raw
    )

    begin {

        $FilterHashTable = @{
            ProviderName = "Service Control Manager"
        }
        if ($StartTime) { $FilterHashTable.Add("StartTime",$StartTime) }
        if ($EndTime) { $FilterHashTable.Add("EndTime",$EndTime) }

        switch ($EventType) {
            'ServiceOperations' {
                $EventID = @(7009,7011,7016,7021,7030,7035,7036,7037,7040)
                $FilterHashTable.Add('Id',$EventID)
            }
            'ServiceStart' {
                $EventID = @(7000,7001,7002,7003,7017,7019,7020,7022,7038,7039,7041)
                $FilterHashTable.Add('Id',$EventID)
            }
            'ServiceStop' {
                $EventID = @(7023,7024,7031,7032,7034,7042,7043)
                $FilterHashTable.Add('Id',$EventID)
            }
            'ServiceControlManagerOperations' {
                $EventID = @(7005,7006,7007,7008,7010,7012,7015,7018,7025,7026,7027,7028,7033)
                $FilterHashTable.Add('Id',$EventID)
            }
            'ServiceInstall' {
                $FilterHashTable.Add('Id',7045)
            }
        }

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
            Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat
        } else {
            Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'ServiceEvent'
        }
    }

    end {

    }

}