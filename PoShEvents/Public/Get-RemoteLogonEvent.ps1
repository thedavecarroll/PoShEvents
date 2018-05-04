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
        [switch]$Oldest       
    )

    Begin {

        $FilterHashTable = @{
            LogName = "Security"
            Id = @(4624,4625,4634,4778,4779)
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
            if ( $EventLogRecord.LogonType -eq 10 -Or $EventLogRecord.Id -in @('4778','4779','4625') ) {
                switch ($EventLogRecord.Id ) {
                    4624 { $EventType = "Logon" }
                    4634 { $EventType = "Logoff" }
                    4778 { $EventType = "Session Reconnect" }
                    4779 { $EventType = "Session Disconnect" }
                    4625 { $EventType = "Logon Failure" }
                }
            }
            
            if ($EventLogRecord.TargetDomainName -ne $null -And $EventLogRecord.TargetUserName -ne $null) { 
                $UserName = $EventLogRecord.TargetDomainName + "\" + $EventLogRecord.TargetUserName.ToUpper() 
            }
            
            if ($EventLogRecord.IpAddress -eq "-" -Or $EventLogRecord.IpAddress -eq $null) { 
                $IpAddress = $null 
            } else { 
                $IPAddress = $EventLogRecord.IpAddress 
            }
        
            [PsCustomObject]@{
                ComputerName    = $EventLogRecord.ComputerName
                TimeCreated     = Get-Date (Get-Date $EventLogRecord.TimeCreated -Format G)
                Id              = $EventLogRecord.Id
                Level           = $EventLogRecord.Level               
                EventType       = $EventType
                UserName        = $UserName
                IpAddress       = $IPAddress
                LogonID         = $EventLogRecord.LogonID
                Reason          = $EventLogRecord.Reason
                LogonMethod     = $EventLogRecord.LogonMethod
            }

        }
    }

    End {

    }
}