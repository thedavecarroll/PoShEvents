function Get-AccountManagementEvent {
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

        [Parameter(ParameterSetName='AuditGroup')]
        [ValidateSet("UserAccount","SecurityEnabledGroup","DistributionGroup","ComputerAccount","ApplicationGroup","DSObject","AccountLockout")]
        [String]$Type,
        
        [Parameter(ParameterSetName='EventID')]
        [int[]]$EventID

    )

    Begin {

        $FilterHashTable = @{
            LogName= "Security"
        }
        if ($StartTime) { $FilterHashTable.Add("StartTime",$StartTime) }
        if ($EndTime) { $FilterHashTable.Add("EndTime",$EndTime) }

        switch ($PsCmdlet.ParameterSetName) { 
            'AuditGroup'  {
                [int[]]$UserAccount = 4720,4722,4723,4724,4725,4726,4738,4740,4765,4766,4767,4780,4781,4794,5376,5377
                [int[]]$SecurityEnabledGroup = 4727,4728,4729,4730,4731,4732,4733,4734,4735,4737,4754,4755,4756,4757,4758,4764
                [int[]]$DistributionGroup = 4744,4745,4746,4747,4748,4749,4750,4751,4752,4753,4759,4760,4761,4762
                [int[]]$ComputerAccount = 4741,4742,4743
                [int[]]$ApplicationGroup = 4783,4784,4785,4786,4787,4788,4789,4790
                [int[]]$DSObject = 5136,5137,5139,5141
                [int[]]$AccountLockout = 4740,4625

                $EventIDs = [PsCustomObject]@{
                    UserAccount = $UserAccount
                    SecurityEnabledGroup = $SecurityEnabledGroup
                    DistributionGroup = $DistributionGroup
                    ComputerAccount = $ComputerAccount
                    ApplicationGroup = $ApplicationGroup
                    DSObject = $DSObject
                    AccountLockout = $AccountLockout
                }

                $FilterHashTable.Add("Id",$EventIDs.$Type)
            } 
            "EventID"  {
                $FilterHashTable.Add("Id",$EventID)
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

    Process {
        
        $Events = Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat
        
        $EventCount = 0
        foreach ($Event in $Events) {
            if ($EventCount -gt 0) {
                Write-Progress -Id 1 -Activity "Formatting events..." -PercentComplete (($EventCount / $Events.count) * 100)
            }
            $EventCount++

            $EventLogRecord = ConvertFrom-EventLogRecord -EventLogRecord $Event
            Add-Member -InputObject $EventLogRecord -MemberType NoteProperty -Force `
                -Name EventType -Value ( $(if ($Type) { $Type } else { "EventID Lookup" }) )
            Add-Member -InputObject $EventLogRecord -MemberType NoteProperty -Force `
                -Name Action -Value  ($EventLogRecord.Message.Split("`n")[0].Trim() )

            $EventLogRecord | Select-Object * -ExcludeProperty Message,EventData,UserData
        }
    }

    End {

    }
}
