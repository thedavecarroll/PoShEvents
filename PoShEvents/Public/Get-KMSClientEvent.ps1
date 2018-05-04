function Get-KMSClientEvent {
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
                
        if ($StartTime -and $EndTime) {
            $SystemTime = "and (System/TimeCreated[@SystemTime&gt;='$($StartTime.ToUniversalTime().ToString("s"))' and @SystemTime&lt;='$($EndTime.ToUniversalTime().ToString("s"))'])"
        } elseif ($StartTime) {
            $SystemTime = "and (System/TimeCreated[@SystemTime&gt;='$($StartTime.ToUniversalTime().ToString("s"))'])"
        } elseif ($EndTime) {
            $SystemTime = "and (System/TimeCreated[@SystemTime&lt;='$($EndTime.ToUniversalTime().ToString("s"))'])"
        } else {
            $SystemTime = $null
        }

        $FilterXml = @"
            <QueryList><Query Id="0" Path="Application">
            <Select Path="Application">*[System
                    [Provider[@Name='Microsoft-Windows-Security-SPP'] and 
                    (EventID=12288 or EventID=12289 or EventID=12308)] 
                    $SystemTime
            ]</Select>
            </Query></QueryList>
"@

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

        try {
            $Events = Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml -ErrorAction Continue @ParameterSplat
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

            [PsCustomObject]@{
                ComputerName                = $EventLogRecord.ComputerName
                TimeCreated                 = $EventLogRecord.TimeCreated
                Id                          = $EventLogRecord.Id
                Level                       = $EventLogRecord.Level
                KMSHost                     = $EventLogRecord.KMSHost
                KMSHostPort                 = $EventLogRecord.KMSHostPort
                ClientMachineID             = $EventLogRecord.ClientMachineID
                ClientTimestamp             = $EventLogRecord.ClientTimestamp
                ActivationStatus            = $EventLogRecord.ActivationStatus
                ADActivationObjectName      = $EventLogRecord.ADActivationObjectName
                ADActivationObject          = $EventLogRecord.ADActivationObject
                CurrentActivationCount      = $EventLogRecord.CurrentActivationCount
                NextActivationAttempt       = $EventLogRecord.NextActivationAttempt
                LicenseStateExpiration      = $EventLogRecord.LicenseStateExpiration
                LicenseStateExpirationMin   = $EventLogRecord.LicenseStateExpirationMin                    
                ProductSkuId                = $EventLogRecord.ProductSkuId
                ProductSkuName              = $EventLogRecord.ProductSkuName
                MinActivateCount            = $EventLogRecord.MinActivateCount
                KmsErrorCode                = $EventLogRecord.KmsErrorCode
                KmsErrorMessage             = $EventLogRecord.KmsErrorMessage
            }
        }
    }

    end {

    }
}