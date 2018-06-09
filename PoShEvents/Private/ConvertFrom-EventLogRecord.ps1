function ConvertFrom-EventLogRecord {
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [System.Diagnostics.Eventing.Reader.EventLogRecord[]]
        $Events,
        #[Parameter(Mandatory=$true)]
        #[ValidateSet()]
        [string]$EventRecordType
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

        $TextInfo = (Get-Culture).TextInfo

    }

    process {

        foreach ($EventLogRecord in $Events) {
            Write-Progress -Id 1 -Activity "Formatting events..." -Status $EventLogRecord.MachineName

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
            }

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
            }

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
                }
                'ServiceEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.ServiceEvent'
                }
                'GPOProcessingEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.GPOProcessingEvent'
                }
                'KMSClientEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.KMSClientEvent'
                }
                'KMSHostEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.KMSHostEvent'
                }
                'KMSHostLicenseCheckEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.KMSHostLicenseCheckEvent'
                }
                'AccountManagementEvent' {
                    Add-Member -InputObject $Event -TypeName 'MyEvent.EventRecordType.AccountManagementEvent'
                }
            }

            $Event
        }

    }

    end {

    }
}