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
        [switch]$Oldest
    )

    begin {

        [int[]]$ServiceOperations = 7009,7011,7016,7021,7030,7035,7036,7037,7040
        [int[]]$ServiceStart = 7000,7001,7002,7003,7017,7019,7020,7022,7038,7039,7041
        [int[]]$ServiceStop = 7023,7024,7031,7032,7034,7042,7043
        
        $FilterHashTable = @{
            ProviderName = "Service Control Manager"
        }
        if ($StartTime) { $FilterHashTable.Add("StartTime",$StartTime) }
        if ($EndTime) { $FilterHashTable.Add("EndTime",$EndTime) }

        $FilterSet =  @(
            ($FilterHashTable + @{ Id = $ServiceOperations }),
            ($FilterHashTable + @{ Id = $ServiceStart }),
            ($FilterHashTable + @{ Id = $ServiceStop  })
        )

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

        $Events = foreach ($FilterHashtable in $FilterSet) {            
            Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashtable @ParameterSplat
        }

        $EventCount = 0
        foreach ($Event in $Events) {
            if ($EventCount -gt 0) {
                Write-Progress -Id 1 -Activity "Formatting events..." -PercentComplete (($EventCount / $Events.count) * 100)
            }
            $EventCount++

            $ServiceName = $ServiceDisplayName = $ImagePath =  $ServiceType = $StartType = $AccountName = $null
            
            $EventLogRecord = ConvertFrom-EventLogRecord -EventLogRecord $Event

            if ($EventLogRecord.Id -in $ServiceOperations) {
                $EventType = "ServiceOperations"
            } elseif ($EventLogRecord.Id -in $ServiceStart) {
                $EventType = "ServiceStart"
            } elseif ($EventLogRecord.Id -in $ServiceStop) {
                $EventType = "ServiceStop"
            }

            $ServiceDisplayName = $EventLogRecord.param1
            $ServiceName = $EventLogRecord.param4

            switch ($EventLogRecord.Id) { 
                7031 {
                    $ServiceDisplayName = $EventLogRecord.param1
                    $ServiceName = $null
                }
                7045 { 
                    $ServiceName = $EventLogRecord.ServiceName
                    $ImagePath = $EventLogRecord.ImagePath 
                    $ServiceType = $EventLogRecord.ServiceType 
                    $StartType = $EventLogRecord.StartType
                    $AccountName = $EventLogRecord.AccountName
                }
                default {
                    #$ServiceName = $EventLogRecord.param4
                }
    
            }

            [PsCustomObject]@{
                ComputerName = $EventLogRecord.ComputerName
                TimeCreated = $EventLogRecord.TimeCreated
                Id = $EventLogRecord.Id
                EventType = $EventType
                Level = $EventLogRecord.Level
                ServiceName = $ServiceName
                ServiceDisplayName = $ServiceDisplayName
                ImagePath = $ImagePath 
                ServiceType = $ServiceType 
                StartType = $StartType
                AccountName = $AccountName
                Message = $EventLogRecord.Message
            }

        }
    }

    end {

    }

}