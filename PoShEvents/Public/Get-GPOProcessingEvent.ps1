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
        [switch]$Oldest
    )

    begin {
                
        $FilterHashTable = @{
            LogName = "Microsoft-Windows-GroupPolicy/Operational"
        }
        if ($StartTime) { $FilterHashTable.Add("StartTime",$StartTime) }
        if ($EndTime) { $FilterHashTable.Add("EndTime",$EndTime) }

        try {
            $GPOs = Get-GPO -All
        }
        catch {
            $GPOS = $false
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

        function GetEventType($EventId) {
            switch ($EventId) {
                {$_ -ge 4000 -and $_ -le 4007} { $EventType = "GP Start"}
                {$_ -ge 4016 -and $_ -le 4299} { $EventType = "Component Start"}
                {$_ -ge 5000 -and $_ -le 5299} { $EventType = "Component Success"}
                {$_ -ge 5300 -and $_ -le 5999} { $EventType = "Informative"}
                {$_ -ge 6000 -and $_ -le 6007} { $EventType = "GP Warning"}
                {$_ -ge 6017 -and $_ -le 6299} { $EventType = "Component Warning"}                
                {$_ -ge 6300 -and $_ -le 6999} { $EventType = "Informative Warning"}
                {$_ -ge 7000 -and $_ -le 7007} { $EventType = "GP Error"}
                {$_ -ge 7017 -and $_ -le 7299} { $EventType = "Component Error"}
                {$_ -ge 7300 -and $_ -le 7999} { $EventType = "Informative Start"}
                {$_ -ge 8000 -and $_ -le 8007} { $EventType = "GP Success"}           
                default { $EventType = "Unknown"}
            }
            return $EventType
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
            
            $GPName = $null

            $EventLogRecord = ConvertFrom-EventLogRecord -EventLogRecord $Event

            if ($EventLogRecord.Message -like "*\Policies\*") {                
                $GPguid= $EventLogRecord.Message.Split("{")[1].Split("}")[0]
                if ($GPOS) {
                    $GPName = $GPOs | Where-Object { $_.Id -eq $GPguid} | Select-Object -ExpandProperty DisplayName 
                } else {
                    $GPName = $GPguid
                }
            } 
            
            [PsCustomObject]@{
                ComputerName = $EventLogRecord.ComputerName
                TimeCreated = $EventLogRecord.TimeCreated
                Id = $EventLogRecord.Id
                UserId = $EventLogRecord.UserId
                UserName = $EventLogRecord.UserName
                PrincipalSamName = $EventLogRecord.PrincipalSamName
                Level = $EventLogRecord.Level
                Action = $EventLogRecord.Message.Split("`n")[0].Trim()
                EventType = GetEventType $EventLogRecord.Id
                GPO = $GPName
                ErrorCode = $EventLogRecord.ErrorCode
                PolicyElaspedTimeInSeconds = $EventLogRecord.PolicyElaspedTimeInSeconds
                IsMachine = $EventLogRecord.IsMachine
                IsConnectivityFailure = $EventLogRecord.IsConnectivityFailure
                Message = $EventLogRecord.Message
            }
        }
    }

    end {

    }
}