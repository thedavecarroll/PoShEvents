function ConvertFrom-EventLogRecord {
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [System.Diagnostics.Eventing.Reader.EventLogRecord[]]
        $Events,
        [ValidateSet(
            'PrintDocument','SystemRestartEvent','LogonFailureEvent',
            'OSVersionFromEvent','RemoteLogonEvent','ServiceEvent',
            'GPOProcessingEvent','AccountManagementEvent','KMSClientEvent',
            'KMSHostEvent','KMSHostLicenseCheckEvent')]
        [AllowNull()]
        [string]$EventRecordType,
        [object[]]$GroupPolicy
    )

    begin {
        function ConvertFrom-UserSID {
            param([string]$UserSID)
            try {
                $SecurityIdentifier = New-Object System.Security.Principal.SecurityIdentifier($UserSID)
                $SecurityIdentifier.Translate([System.Security.Principal.NTAccount]).Value
            }
            catch {
                $null
            }
        }

        function Get-LogonMethod {
            param($LogonMethod)
            switch ($LogonMethod) {
                2 { 'Interactive (local system)' }
                3 { 'Network' }
                4 { 'Batch' }
                5 { 'Service' }
                7 { 'Unlock' }
                8 { 'ClearText' }
                9 { 'NewCredentials' }
                10 { 'RemoteInteractive (Remote Desktop)' }
                11 { 'CachedInteractive' }
                default { 'Undetermined logon method' }
            }
        }

        function Get-LogonFailureReason {
            param($EventRecord)
            $Reason = $null
            switch ($EventRecord.FailureReason) {
                "%%2305" { $Reason = 'The specified user account has expired.' }
                "%%2309" { $Reason = "The specified account's password has expired." }
                "%%2310" { $Reason = 'Account currently disabled.' }
                "%%2311" { $Reason = 'Account logon time restriction violation.' }
                "%%2312" { $Reason = 'User not allowed to logon at this computer.' }
                "%%2313" { $Reason = 'Unknown user name or bad password.' }
                "%%2304" { $Reason = 'An Error occurred during Logon.' }
            }
            if ($Reason -eq $null) {
                if ($EventRecord.Id -eq 4625) {
                    switch ($EventRecord.Status) {
                        "0xC0000234" { $Reason = "Account locked out" }
                        "0xC0000193" { $Reason = "Account expired" }
                        "0xC0000133" { $Reason = "Clocks out of sync" }
                        "0xC0000224" { $Reason = "Password change required" }
                        "0xc000015b" { $Reason = "User does not have logon right" }
                        "0xc000006d" { $Reason = "Logon failure" }
                        "0xc000006e" { $Reason = "Account restriction" }
                        "0xc00002ee" { $Reason = "An error occurred during logon" }
                        "0xC0000071" { $Reason = "Password expired" }
                        "0xC0000072" { $Reason = "Account disabled" }
                        "0xC0000413" { $Reason = "Authentication firewall prohibits logon" }
                        default { $Reason = $Event.Status }
                    }
                    if ($EventRecord.Status -ne $EventRecord.SubStatus) {
                        switch ($EventRecord.SubStatus) {
                            "0xC0000234" { $Reason += " : Account locked out" }
                            "0xC0000193" { $Reason += " : Account expired" }
                            "0xC0000133" { $Reason += " : Clocks out of sync" }
                            "0xC0000224" { $Reason += " : Password change required" }
                            "0xc000015b" { $Reason += " : User does not have logon right" }
                            "0xc000006d" { $Reason += " : Logon failure" }
                            "0xc000006e" { $Reason += " : Account restriction" }
                            "0xc00002ee" { $Reason += " : An error occurred during logon" }
                            "0xC0000071" { $Reason += " : Password expired" }
                            "0xC0000072" { $Reason += " : Account disabled" }
                            "0xc000006a" { $Reason += " : Incorrect password" }
                            "0xc0000064" { $Reason += " : Account does not exist" }
                            "0xC0000413" { $Reason += " : Authentication firewall prohibits logon" }
                            default { $Reason += " : " + $EventRecord.SubStatus }
                        }
                    }
                } elseif ($EventRecord.Id -eq 4771)  {
                    switch ($EventRecord.Status) {
                        "0x1" { $Reason = "Client's entry in database has expired" }
                        "0x2" { $Reason = "Server's entry in database has expired" }
                        "0x3" { $Reason = "Requested protocol version # not supported" }
                        "0x4" { $Reason = "Client's key encrypted in old master key" }
                        "0x5" { $Reason = "Server's key encrypted in old master key" }
                        "0x6" { $Reason = "Client not found in Kerberos database" }	#Bad user name, or new computer/user account has not replicated to DC yet
                        "0x7" { $Reason = "Server not found in Kerberos database" } #	 New computer account has not replicated yet or computer is pre-w2k
                        "0x8" { $Reason = "Multiple principal entries in database" }
                        "0x9" { $Reason = "The client or server has a null key" } # administrator should reset the password on the account
                        "0xA" { $Reason = "Ticket not eligible for postdating" }
                        "0xB" { $Reason = "Requested start time is later than end time" }
                        "0xC" { $Reason = "KDC policy rejects request" } #	Workstation restriction
                        "0xD" { $Reason = "KDC cannot accommodate requested option" }
                        "0xE" { $Reason = "KDC has no support for encryption type" }
                        "0xF" { $Reason = "KDC has no support for checksum type" }
                        "0x10" { $Reason = "KDC has no support for padata type" }
                        "0x11" { $Reason = "KDC has no support for transited type" }
                        "0x12" { $Reason = "Clients credentials have been revoked" } # Account disabled, expired, locked out, logon hours.
                        "0x13" { $Reason = "Credentials for server have been revoked" }
                        "0x14" { $Reason = "TGT has been revoked" }
                        "0x15" { $Reason = "Client not yet valid - try again later" }
                        "0x16" { $Reason = "Server not yet valid - try again later" }
                        "0x17" { $Reason = "Password has expired" } # The user’s password has expired.
                        "0x18" { $Reason = "Pre-authentication information was invalid" } # Usually means bad password
                        "0x19" { $Reason = "Additional pre-authentication required*" }
                        "0x1F" { $Reason = "Integrity check on decrypted field failed" }
                        "0x20" { $Reason = "Ticket expired" } #Frequently logged by computer accounts
                        "0x21" { $Reason = "Ticket not yet valid" }
                        "0x21" { $Reason = "Ticket not yet valid" }
                        "0x22" { $Reason = "Request is a replay" }
                        "0x23" { $Reason = "The ticket isn't for us" }
                        "0x24" { $Reason = "Ticket and authenticator don't match" }
                        "0x25" { $Reason = "Clock skew too great" } #	Workstation’s clock too far out of sync with the DC’s
                        "0x26" { $Reason = "Incorrect net address" } # IP address change?
                        "0x27" { $Reason = "Protocol version mismatch" }
                        "0x28" { $Reason = "Invalid msg type" }
                        "0x29" { $Reason = "Message stream modified" }
                        "0x2A" { $Reason = "Message out of order" }
                        "0x2C" { $Reason = "Specified version of key is not available" }
                        "0x2D" { $Reason = "Service key not available" }
                        "0x2E" { $Reason = "Mutual authentication failed" } #	 may be a memory allocation failure
                        "0x2F" { $Reason = "Incorrect message direction" }
                        "0x30" { $Reason = "Alternative authentication method required*" }
                        "0x31" { $Reason = "Incorrect sequence number in message" }
                        "0x32" { $Reason = "Inappropriate type of checksum in message" }
                        "0x3C" { $Reason = "Generic error (description in e-text)" }
                        "0x3D" { $Reason = "Field is too long for this implementation" }
                        default { $Reason = $EventRecord.Status }
                    }
                }
                $Reason
            }
        }

        function Get-GPEventType($EventId) {
            switch ($EventId) {
                {$_ -ge 4000 -and $_ -le 4007} { 'GP Start' }
                {$_ -ge 4016 -and $_ -le 4299} { 'Component Start' }
                {$_ -ge 5000 -and $_ -le 5299} { 'Component Success' }
                {$_ -ge 5300 -and $_ -le 5999} { 'Informative' }
                {$_ -ge 6000 -and $_ -le 6007} { 'GP Warning '}
                {$_ -ge 6017 -and $_ -le 6299} { 'Component Warning' }
                {$_ -ge 6300 -and $_ -le 6999} { 'Informative Warning' }
                {$_ -ge 7000 -and $_ -le 7007} { 'GP Error' }
                {$_ -ge 7017 -and $_ -le 7299} { 'Component Error' }
                {$_ -ge 7300 -and $_ -le 7999} { 'Informative Start' }
                {$_ -ge 8000 -and $_ -le 8007} { 'GP Success' }
                default { 'Unknown' }
            }
        }

        $TextInfo = (Get-Culture).TextInfo
        $EventCount = 0
    }

    process {

        foreach ($EventLogRecord in $Events) {
            $EventCount++
            Write-Progress -Id 1 -Activity "Formatting events..." -Status $EventLogRecord.MachineName -CurrentOperation "Processing record $EventCount"

            $EventRecordXml = [xml]$EventLogRecord.ToXml()

            $EventData = $EventRecordXml.Event.EventData
            $UserData = $EventRecordXml.Event.UserData

            $Event = [PSCustomObject]@{
                ComputerName = $EventLogRecord.MachineName
                TimeCreated  = $EventLogRecord.TimeCreated
                Id           = $EventLogRecord.Id
                Level        = $EventLogRecord.LevelDisplayName
                ActivityId   = $EventLogRecord.ActivityId
                RecordId     = $EventLogRecord.RecordId
                LogName      = $EventLogRecord.LogName
                ProviderName = $EventLogRecord.ProviderName
                UserId       = $EventLogRecord.UserId
                UserName     = ConvertFrom-UserSID -UserSID $EventLogRecord.UserId
                Message      = $EventLogRecord.Message
            }

            $BaseParams = @{
                InputObject = $Event
                MemberType = 'NoteProperty'
            }

            if ($EventData) {
                if ($EventData.Data.Count) {
                    For ($i=0; $i -lt $EventData.Data.Count; $i++) {
                        if ($EventData.Data[$i].name) {
                            if ($EventData.Data[$i].'#text' -eq "-") {
                                $Value = $null
                            } else {
                                $Value = $EventData.Data[$i].'#text'
                            }
                            Add-Member @BaseParams -Name $EventData.Data[$i].name -Value $Value
                        }
                    }
                } else {
                    if ($EventData.Data.Name) {
                        Add-Member @BaseParams -Name $EventData.Data.Name -Value $EventData.Data.'#text'
                    }
                }

            } else {
                $EventData = $null
            }
            Add-Member @BaseParams -Name EventData -Value $EventData

            if ($UserData) {
                if ($UserData.Data.Count) {
                    For ($i=0; $i -lt $UserData.Data.Count; $i++) {
                        if ($UserData.Data[$i].name) {
                            if ($UserData.Data[$i].'#text' -eq "-") {
                                $Value = $null
                            } else {
                                $Value = $UserData.Data[$i].'#text'
                            }
                            Add-Member @BaseParams -Name $UserData.Data[$i].name -Value $Value
                        }
                    }
                } else {
                    if ($UserData.Data.Name) {
                        Add-Member @BaseParams -Name $UserData.Data.Name -Value $UserData.Data.'#text'
                    }
                }
            } else {
                $UserData = $null
            }
            Add-Member @BaseParams -Name UserData -Value $UserData

            switch ($EventRecordType) {
                'PrintDocument' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.PrintDocument'
                    Add-Member @BaseParams -Name PrintJobId -Value $UserData.DocumentPrinted.Param1
                    Add-Member @BaseParams -Name DocumentName -Value $UserData.DocumentPrinted.Param2
                    Add-Member @BaseParams -Name ClientMachineName -Value $UserData.DocumentPrinted.Param4
                    Add-Member @BaseParams -Name PrinterName -Value $UserData.DocumentPrinted.Param5
                    Add-Member @BaseParams -Name PrinterPort -Value $UserData.DocumentPrinted.Param6
                    Add-Member @BaseParams -Name DocumentSizeBytes -Value $UserData.DocumentPrinted.Param7
                    Add-Member @BaseParams -Name DocumentPageCount -Value $UserData.DocumentPrinted.Param8
                }
                'SystemRestartEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.SystemRestartEvent'
                    $Reason = $Details = $Comment = $null
                    switch ($Event.id) {
                        6005 { $Status = "Startup" }
                        6006 { $Status = "Shutdown" }
                        6008 { $Status = "Unexpected Shutdown" }
                        6009 { $Status = "System Info" }
                        1074 {
                            $Reason = $Event.param3
                            $Status = $TextInfo.ToTitleCase($Event.param5)
                            $Comment = $Event.param6
                            if ($Event.param1 -match "CcmExec") {
                                $Details = "Configuration Manager"
                            } elseif ($Event.param1 -match "msiexe") {
                                $Details = "Windows Installer"
                            } elseif ($Event.param1 -match "vmtoolsd") {
                                $Details = "VMTools"
                            } elseif ($Event.param1 -match "RuntimeBroker") {
                                $Details = "RuntimeBroker"
                            } elseif ($Event.param1 -match "FveNotify") {
                                $Details = "BitLocker"
                            } elseif ($Event.param1) {
                                $Details = $Event.param1.Split(" ")[0].Split("\")[-1]
                            }
                        }
                    }
                    Add-Member @BaseParams -Name Status -Value $Status
                    Add-Member @BaseParams -Name Reason -Value $Reason
                    Add-Member @BaseParams -Name Details -Value $Details
                    Add-Member @BaseParams -Name Comment -Value $Comment
                }
                'LogonFailureEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.LogonFailureEvent'
                    Add-Member @BaseParams -Name LogonMethod -Value (Get-LogonMethod -LogonMethod $Event.LogonType)
                    Add-Member @BaseParams -Name Reason -Value (Get-LogonFailureReason -EventRecord $Event)
                }
                'OSVersionFromEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.OSVersionFromEvent'
                    [Version]$Version = $EventData.Data[0] + $EventData.Data[1]
                    Add-Member @BaseParams -Name OperatingSystemVersion -Value $Version.ToString()
                }
                'RemoteLogonEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.RemoteLogonEvent'
                    Add-Member @BaseParams -Name LogonMethod -Value (Get-LogonMethod -LogonMethod $Event.LogonType)
                    Add-Member @BaseParams -Name Reason -Value (Get-LogonFailureReason -EventRecord $Event)
                    switch ($Event.Id) {
                        4624 { $EventType  = "Logon" }
                        4634 { $EventType  = "Logoff" }
                        4778 { $EventType  = "Session Reconnect" }
                        4779 { $EventType  = "Session Disconnect" }
                        4625 { $EventType  = "Logon Failure" }
                        default { $EventType = $null }
                    }
                    Add-Member @BaseParams -Name EventType -Value $EventType
                }
                'ServiceEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.ServiceEvent'

                    #https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc756379(v%3dws.10)
                    if ($Event.Id -in @(7009,7011,7016,7021,7030,7035,7036,7037,7040)) {
                        $EventType = "ServiceOperations"
                    } elseif ($Event.Id -in @(7000,7001,7002,7003,7017,7019,7020,7022,7038,7039,7041)) {
                        $EventType = "ServiceStart"
                    } elseif ($Event.Id -in @(7023,7024,7031,7032,7034,7042,7043)) {
                        $EventType = "ServiceStop"
                    } elseif ($Event.Id -in @(7005,7006,7007,7008,7010,7012,7015,7018,7025,7026,7027,7028,7033)) {
                        $EventType = "ServiceControlManagerOperations"
                    } elseif ($Event.Id -eq 7045 ) {
                        $EventType = "ServiceInstall"
                    }
                    Add-Member @BaseParams -Name EventType -Value $EventType

                    if ($Event.param1) {
                        Add-Member @BaseParams -Name ServiceName -Value $Event.param1.trim()
                    }
                    Add-Member @BaseParams -Name ServiceMessage -Value $Event.Message

                    switch ($Event.Id) {
                        7009 {
                            Add-Member @BaseParams -Name ServiceName -Value $Event.param2.trim() -Force
                        }
                        7045 {
                            $ServiceMessage = $Event.Message.Split("`n")[0].Trim()
                            Add-Member @BaseParams -Name ServiceMessage -Value $ServiceMessage -Force
                        }
                    }
                }
                'GPOProcessingEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.GPOProcessingEvent'

                    if ($Event.Message -like "*\Policies\*") {
                        $GPguid= $Event.Message.Split("{")[1].Split("}")[0]
                        if ($GroupPolicy) {
                            $GPName = $GroupPolicy | Where-Object { $_.Id -eq $GPguid} | Select-Object -ExpandProperty DisplayName
                        } else {
                            $GPName = $GPguid
                        }
                    } else {
                        $GPName = $null
                    }
                    Add-Member @BaseParams -Name GroupPolicy -Value $GPName

                    if ($Event.ErrorCode -ne 0) {
                        $Status = ([System.ComponentModel.Win32Exception] [int]$Event.ErrorCode).Message
                    } else {
                        $Status = $null
                    }
                    Add-Member @BaseParams -Name Status -Value $Status

                    $EventMessageFirstLine = $Event.Message.Split("`n")
                    if ($EventMessageFirstLine[0].Trim() -match '.+?details:$' ) {
                        $Details = $Event.Message -Split ("`n",2)
                        $DetailLines = $Details[1].Split("`n")
                        $Action = [PsCustomObject]::new()
                        foreach ($Line in $DetailLines) {
                            Add-Member -InputObject $Action -MemberType NoteProperty -Name $Line.Split(':')[0].Trim().Replace(' ','') -Value $Line.Split(':')[1].Trim()
                        }
                    } elseif ($EventMessageFirstLine[0].Trim() -match '.+?:$' ) {
                        $Action = $EventMessageFirstLine[0].Replace(':','').Trim()
                    } else {
                        $Action = $EventMessageFirstLine[0].Trim()
                    }
                    Add-Member @BaseParams -Name Action -Value $Action

                    Add-Member @BaseParams -Name EventType -Value (Get-GPEventType $Event.Id)

                    $GPOApplied = $GPOList = $null
                    switch ($Event.Id) {
                        5312 {
                            $GPOApplied = $true
                            $GPOList = $Event.DescriptionString.trim()
                        }
                        5313 {
                            $GPOApplied = $false
                            $GPOList = $Event.DescriptionString.trim()
                        }
                    }
                    Add-Member @BaseParams -Name GPOApplied -Value $GPOApplied
                    Add-Member @BaseParams -Name GPOList -Value $GPOList
                }
                'KMSClientEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.KMSClientEvent'

                    $KMSHost = $KMSHostPort = $ClientMachineID = $ClientTimestamp = $null
                    $CurrentActivationState = $LicenseStateExpirationMin = $LicenseStateExpiration = $null
                    $ProductSkuId = $ProductSkuName = $MinActivateCount = $KmsErrorCode = $KmsErrorMessage = $null
                    $CurrentActivationCount = $NextActivationAttempt = $null
                    $ActivationStatus = $ADActivationObjectName = $ADActivationObject = $null

                    $KmsEventData = ($EventData.Data).Split(',')
                    switch ($Event.Id) {
                        12288 {
                            $KMSHost = $KmsEventData[2].Trim().Split(':')[0]
                            $KMSHostPort = $KmsEventData[2].Trim().Split(':')[1]
                            $ClientMachineID = $KmsEventData[3].Trim()
                            $ClientTimestamp = (Get-Date $KmsEventData[4].Trim())
                            $CurrentActivationState = (Get-KmsLicenseState -LicenseState $KmsEventData[6].Trim())
                            $LicenseStateExpirationMin = $KmsEventData[7].Trim()
                            $LicenseStateExpiration = (Get-Date $KmsEventData[4].Trim()).AddMinutes($KmsEventData[7].Trim())
                            $ProductSkuId = $KmsEventData[8].Trim()
                            $ProductSkuName = (Get-KmsProductSku -ProductSku $KmsEventData[8].Trim())
                            $MinActivateCount = $KmsEventData[9].Trim()
                            $KmsErrorCode = $KmsEventData[0].Trim()
                            $KmsErrorMessage = (Get-KmsErrorCode -ErrorCode $KmsEventData[0].Trim())
                        }
                        12289 {
                            if ($KmsEventData[2] -eq 1) {
                                $ActivationStatus = 'Successful'
                            } else {
                                $ActivationStatus = 'Failure'
                            }
                            $ClientTimestamp = (Get-Date $KmsEventData[7].Trim())
                            $CurrentActivationCount = $KmsEventData[4].Trim()
                            $NextActivationAttempt = (Get-Date $KmsEventData[7].Trim()).AddMinutes($KmsEventData[6].Trim())
                            $KmsErrorCode = $KmsEventData[0].Trim()
                            $KmsErrorMessage = (Get-KmsErrorCode -ErrorCode $KmsEventData[0].Trim())
                        }
                        12308 {
                            $ProductSkuId = $EventData.Data[0]
                            $ProductSkuName = (Get-KmsProductSku -ProductSku $EventData.Data[0])
                            $ActivationStatus = 'Active Directory Activation has succeeded.'
                            $ADActivationObjectName = $EventData.Data[1]
                            $ADActivationObject = $EventData.Data[2]
                        }
                    }

                    Add-Member @BaseParams -Name KMSHost -Value $KMSHost
                    Add-Member @BaseParams -Name KMSHostPort -Value $KMSHostPort
                    Add-Member @BaseParams -Name ClientMachineID -Value $ClientMachineID
                    Add-Member @BaseParams -Name ClientTimestamp -Value $ClientTimestamp
                    Add-Member @BaseParams -Name CurrentActivationState -Value $CurrentActivationState
                    Add-Member @BaseParams -Name CurrentActivationCount -Value $CurrentActivationCount
                    Add-Member @BaseParams -Name LicenseStateExpirationMin -Value $LicenseStateExpirationMin
                    Add-Member @BaseParams -Name LicenseStateExpiration -Value $LicenseStateExpiration
                    Add-Member @BaseParams -Name NextActivationAttempt -Value $NextActivationAttempt
                    Add-Member @BaseParams -Name ActivationStatus -Value $ActivationStatus
                    Add-Member @BaseParams -Name ADActivationObjectName -Value $ADActivationObjectName
                    Add-Member @BaseParams -Name ADActivationObject -Value $ADActivationObject
                    Add-Member @BaseParams -Name ProductSkuId -Value $ProductSkuId
                    Add-Member @BaseParams -Name ProductSkuName -Value $ProductSkuName
                    Add-Member @BaseParams -Name MinActivateCount -Value $MinActivateCount
                    Add-Member @BaseParams -Name KmsErrorCode -Value $KmsErrorCode
                    Add-Member @BaseParams -Name KmsErrorMessage -Value $KmsErrorMessage
                }
                'KMSHostEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.KMSHostEvent'

                    if ($EventData.Data[6] -eq 0) {
                        $IsClientVM = $false
                    } else {
                        $IsClientVM = $true
                    }
                    Add-Member @BaseParams -Name MinActivateCount -Value $EventData.Data[2]
                    Add-Member @BaseParams -Name ClientFqdn -Value $EventData.Data[3]
                    Add-Member @BaseParams -Name ClientMachineID -Value $EventData.Data[4]
                    Add-Member @BaseParams -Name ClientTimestamp -Value (Get-Date $EventData.Data[5])
                    Add-Member @BaseParams -Name IsClientVM -Value $IsClientVM
                    Add-Member @BaseParams -Name LicenseState -Value (Get-KmsLicenseState -LicenseState $EventData.Data[7])
                    Add-Member @BaseParams -Name LicenseStateExpirationMin -Value $EventData.Data[8]
                    Add-Member @BaseParams -Name LicenseStateExpiration -Value (Get-Date $EventData.Data[5]).AddMinutes($EventData.Data[8])
                    Add-Member @BaseParams -Name ProductSkuId -Value $EventData.Data[9]
                    Add-Member @BaseParams -Name ProductSkuName -Value (Get-KmsProductSku -ProductSku $EventData.Data[9])
                    Add-Member @BaseParams -Name KmsErrorCode -Value $EventData.Data[1]
                    Add-Member @BaseParams -Name KmsErrorMessage -Value (Get-KmsErrorCode -ErrorCode $EventData.Data[1])
                }
                'KMSHostLicenseCheckEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.KMSHostLicenseCheckEvent'

                    $ActivationId = $EventData.Data[1].Split(':')[1].Split(',')[0].Trim()
                    Add-Member @BaseParams -Name ActivationId -Value $ActivationId
                    Add-Member @BaseParams -Name ApplicationName -Value (Get-KmsProductSku -ProductSku $ActivationId)
                    Add-Member @BaseParams -Name LicensingStatusMessage -Value $EventData.Data[1].Trim()
                }
                'AccountManagementEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.AccountManagementEvent'
                }
                default {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.Default'
                }
            }

            $Event
        }

    }

    end {

    }
}