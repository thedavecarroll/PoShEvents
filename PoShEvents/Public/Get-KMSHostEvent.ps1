function Get-KMSHostEvent {
    [CmdletBinding()]    
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('IPAddress','__Server','CN')]      
        [string]$ComputerName='localhost',
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
            LogName = "Key Management Service"
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

        # verify that KMS service is running on computer
        try {
            $Service = Get-Service -ComputerName $ComputerName -Name sppsvc -ErrorAction Stop
        }
        catch {
            Write-Warning -Message 'The KMS service (sppsvc) is not installed or the system could not be reached.'
            break
        }

        if ($Service.Status -ne 'Running') {
            Write-Warning -Message 'The KMS service (sppsvc) is not currently running.'
        }
        
        $Events = Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat

        $EventCount = 0
        foreach ($Event in $Events) {
            if ($EventCount -gt 0) {
                Write-Progress -Id 1 -Activity "Formatting events..." -PercentComplete (($EventCount / $Events.count) * 100)
            }
            $EventCount++

            $EventLogRecord = ConvertFrom-EventLogRecord -EventLogRecord $Event

            [PsCustomObject]@{
                ComputerName                = $EventLogRecord.ComputerName
                TimeCreated                 = $EventLogRecord.TimeCreated
                Id                          = $EventLogRecord.Id
                Level                       = $EventLogRecord.Level
                MinActivateCount            = $EventLogRecord.MinActivateCount
                ClientFqdn                  = $EventLogRecord.ClientFqdn
                ClientMachineID             = $EventLogRecord.ClientMachineID
                ClientTimestamp             = $EventLogRecord.ClientTimestamp
                IsClientVM                  = $EventLogRecord.IsClientVM
                LicenseState                = $EventLogRecord.LicenseState
                LicenseStateExpiration      = $EventLogRecord.LicenseStateExpiration
                LicenseStateExpirationMin   = $EventLogRecord.LicenseStateExpirationMin    
                ProductSkuId                = $EventLogRecord.ProductSkuId
                ProductSkuName              = $EventLogRecord.ProductSkuName
                KmsErrorCode                = $EventLogRecord.KmsErrorCode
                KmsErrorMessage             = $EventLogRecord.KmsErrorMessage
            }
        }
    }

    end {

    }
}