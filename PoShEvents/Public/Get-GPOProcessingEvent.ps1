function Get-GPOProcessingEvent {
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
        [switch]$Raw,
        [object[]]$GroupPolicy
    )

    begin {

        $FilterHashTable = @{
            LogName = "Microsoft-Windows-GroupPolicy/Operational"
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
        if ($Raw) {
            Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat
        } else {
            if ($GroupPolicy) {
                Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'GPOProcessingEvent' -GroupPolicy $GroupPolicy
            } else {
                Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'GPOProcessingEvent'
            }
        }
    }

    end {

    }
}