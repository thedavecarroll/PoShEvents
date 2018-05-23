function Get-SystemRestartEvent {
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

        $FilterHashTable = @{
            LogName = "System"
            Id = 6005,6006,6008,6009,1074
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

            if ($EventLogRecord.Id -eq 1074) {
                $UserName = $EventLogRecord.param7
                $Reason = $EventLogRecord.param3
                if ($EventLogRecord.param1 -match "CcmExec") {
                    $Details = "Configuration Manager"
                } elseif ($EventLogRecord.param1 -match "msiexe") {
                    $Details = "Windows Installer"
                } elseif ($EventLogRecord.param1 -match "vmtoolsd") {
                    $Details = "VMTools"
                } elseif ($EventLogRecord.param1 -match "FveNotify") {
                    $Details = "BitLocker"
                } else {
                    $Details = $EventLogRecord.param1.Split(" ")[0].Split("\")[-1]
                }

            } else {
                $UserName = $null
                $Reason = $null
                $Details = $null
            }

            switch ($EventLogRecord.id) {
                6005 { $Status = "Startup" }
                6006 { $Status = "Shutdown" }
                6008 { $Status = "Unexpected Shutdown" }
                6009 { $Status = "System Info" }
                1074 { $Status = "Shutdown Initiated" }
            }

            [PSCustomObject]@{
                ComputerName = $EventLogRecord.ComputerName
                TimeCreated = $EventLogRecord.TimeCreated
                Id = $EventLogRecord.Id
                ProviderName = $EventLogRecord.ProviderName
                Level = $EventLogRecord.Level
                Status = $Status 
                UserName = $UserName
                Reason = $Reason
                Details = $Details
            } 
        }
    }

    end {

    }
}