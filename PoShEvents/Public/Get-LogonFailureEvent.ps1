function Get-LogonFailureEvent {
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
        [switch]$Oldest       
    )

    Begin {

        $FilterHashtable = @{
            LogName = "Security"
            Id = 4625,4771
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

    Process {

        try {
            $Events = Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashtable -ErrorAction Continue @ParameterSplat
        }
        catch {
            Write-Error -Message "$Computer : $($_.CategoryInfo.Reason + " : " + $_.Exception.Message)"
        }

        $EventCount = 0
        foreach ($Event in $Events) {
            if ($EventCount -gt 0) {
                Write-Progress -Id 1 -Activity "Formatting events..." -PercentComplete (($EventCount / $Events.count) * 100)
            }
            $EventCount++
                  
            $EventLogRecord = ConvertFrom-EventLogRecord -EventLogRecord $Event
            
            $EventLogRecord | Select-Object * -ExcludeProperty Message,EventData,UserData

        }

    }

    end {

    }
}
