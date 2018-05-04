function ConvertFrom-EventLogRecord {
    param (
        [System.Diagnostics.Eventing.Reader.EventLogRecord]
        $EventLogRecord
    )

    begin {
        function ConvertFrom-UserSID {
            param([string]$UserSID)
        
            try {
                $SecurityIdentifier = New-Object System.Security.Principal.SecurityIdentifier($UserSID)
                $SecurityIdentifier.Translate([System.Security.Principal.NTAccount]).Value
            }
            catch {
        
            }
        }

    }

    process {
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

        if ($EventData) {
            if ($EventData.Data.Count) {
                For ($i=0; $i -lt $EventData.Data.Count; $i++) {                            
                    if ($EventData.Data[$i].name) {
                        if ($EventData.Data[$i].'#text' -eq "-") {
                            $Value = $null
                        } else {
                            $Value = $EventData.Data[$i].'#text'
                        }
                        Add-Member -InputObject $Event -MemberType NoteProperty `
                            -Name $EventData.Data[$i].name -Value $Value
                    }
                }
            } else {
                if ($EventData.Data.Name) {            
                    Add-Member -InputObject $Event -MemberType NoteProperty `
                        -Name $EventData.Data.Name -Value $EventData.Data.'#text'
                }
            }
        }

        if ($Event.IpAddress) {
            Add-Member -InputObject $Event -MemberType NoteProperty -Force `
                -Name IpAddress -Value $Event.IpAddress.Replace("::ffff:","")
        }

        if ($Event.Id -eq 6009) {
            Add-Member -InputObject $Event -MemberType NoteProperty -Force `
                -Name OperatingSystemVersion -Value $([string]$EventData.Data[0] + [string]$EventData.Data[1])
        }
        
        if ($UserData.DocumentPrinted) {
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name PrintJobId -Value $UserData.DocumentPrinted.Param1
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name DocumentName -Value $UserData.DocumentPrinted.Param2
            Add-Member -InputObject $Event -MemberType NoteProperty -Force `
                -Name UserName -Value $UserData.DocumentPrinted.Param3
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name ClientMachineName -Value $UserData.DocumentPrinted.Param4
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name PrinterName -Value $UserData.DocumentPrinted.Param5
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name PrinterPort -Value $UserData.DocumentPrinted.Param6
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name DocumentSizeBytes -Value $UserData.DocumentPrinted.Param7
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name DocumentPageCount -Value $UserData.DocumentPrinted.Param8
        }        

        if ($Event.Id -in 5031,5150,5151,5152,5153,5154,5155,5156,5157,5158,5159) {
            switch ($Event.Protocol) {
                1   { $ProtocolDisplayName = "Internet Control Message Protocol (ICMP)"}
                3   { $ProtocolDisplayName = "Gateway-Gateway Protocol (GGP)"}
                6   { $ProtocolDisplayName = "Transmission Control Protocol (TCP)"}
                8   { $ProtocolDisplayName = "Exterior Gateway Protocol (EGP)"}
                12  { $ProtocolDisplayName = "PARC Universal Packet Protocol (PUP)"}
                17  { $ProtocolDisplayName = "User Datagram Protocol (UDP)"}
                20  { $ProtocolDisplayName = "Host Monitoring Protocol (HMP)"}
                27  { $ProtocolDisplayName = "Reliable Datagram Protocol (RDP)"}
                46  { $ProtocolDisplayName = "Reservation Protocol (RSVP) QoS"}
                47  { $ProtocolDisplayName = "General Routing Encapsulation (PPTP data over GRE)"}
                50  { $ProtocolDisplayName = "Encapsulation Security Payload (ESP) IPSec"}
                51  { $ProtocolDisplayName = "Authentication Header (AH) IPSec"}
                66  { $ProtocolDisplayName = "MIT Remote Virtual Disk (RVD)"}
                88  { $ProtocolDisplayName = "Internet Group Management Protocol (IGMP)"}
                89  { $ProtocolDisplayName = "Open Shortest Path First (OSPF)"}
                default { $ProtocolDisplayName = "Unknown"}
            }

            if ($Event.Direction -eq "%%14592") {
                $DirectionDisplayName -eq "Inbound"
            } else {
                $DirectionDisplayName -eq "Outbound"
            }
            
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name ProtocolDisplayName -Value $ProtocolDisplayName
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name DirectionDisplayName -Value $DirectionDisplayName

        }
        
        if ($Event.ProviderName -eq 'Microsoft-Windows-Security-SPP') {
            if ($Event.Id -eq 12290) {
                if ($EventData.Data[6] -eq 0) {
                    $IsClientVM = $false
                } else {
                    $IsClientVM = $true
                }
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name MinActivateCount -Value $EventData.Data[2]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ClientFqdn -Value $EventData.Data[3]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ClientMachineID -Value $EventData.Data[4]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ClientTimestamp -Value (Get-Date $EventData.Data[5])
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name IsClientVM -Value $IsClientVM
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name LicenseState -Value (Get-KmsLicenseState -LicenseState $EventData.Data[7])
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name LicenseStateExpirationMin -Value $EventData.Data[8]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name LicenseStateExpiration -Value (Get-Date $EventData.Data[5]).AddMinutes($EventData.Data[8])
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ProductSkuId -Value $EventData.Data[9]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ProductSkuName -Value (Get-KmsProductSku -ProductSku $EventData.Data[9])
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name KmsErrorCode -Value $EventData.Data[1]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name KmsErrorMessage -Value (Get-KmsErrorCode -ErrorCode $EventData.Data[1])

            } elseif ($Event.Id -eq 12288) {
                $KmsEventData = ($EventData.Data).Split(",")
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name KMSHost -Value $KmsEventData[2].Trim().Split(':')[0]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name KMSHostPort -Value $KmsEventData[2].Trim().Split(':')[1]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ClientMachineID -Value $KmsEventData[3].Trim()
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ClientTimestamp -Value (Get-Date $KmsEventData[4].Trim())
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name CurrentActivationState -Value (Get-KmsLicenseState -LicenseState $KmsEventData[6].Trim()) 
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name LicenseStateExpirationMin -Value $KmsEventData[7].Trim()
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name LicenseStateExpiration -Value (Get-Date $KmsEventData[4].Trim()).AddMinutes($KmsEventData[7].Trim())
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ProductSkuId -Value $KmsEventData[8].Trim()
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ProductSkuName -Value (Get-KmsProductSku -ProductSku $KmsEventData[8].Trim())                
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name MinActivateCount -Value $KmsEventData[9].Trim()
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name KmsErrorCode -Value $KmsEventData[0].Trim()
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name KmsErrorMessage -Value (Get-KmsErrorCode -ErrorCode $KmsEventData[0].Trim())                

            } elseif ($Event.Id -eq 12289) {
                $KmsEventData = ($EventData.Data).Split(",")
                if ($KmsEventData[2] -eq 1) {
                    $Activation = 'Successful'
                } else {
                    $Activation = 'Failure'
                }
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ActivationStatus -Value $Activation
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ClientTimestamp -Value (Get-Date $KmsEventData[7].Trim())
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name CurrentActivationCount -Value $KmsEventData[4].Trim()
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name NextActivationAttempt -Value (Get-Date $KmsEventData[7].Trim()).AddMinutes($KmsEventData[6].Trim())
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name KmsErrorCode -Value $KmsEventData[0].Trim()
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name KmsErrorMessage -Value (Get-KmsErrorCode -ErrorCode $KmsEventData[0].Trim())                

            } elseif ($Event.Id -eq 12308) {
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ProductSkuId -Value $EventData.Data[0]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ProductSkuName -Value (Get-KmsProductSku -ProductSku $EventData.Data[0])  
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ActivationStatus -Value 'Active Directory Activation has succeeded.'
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ADActivationObjectName -Value $EventData.Data[1]
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ADActivationObject -Value $EventData.Data[2]

            } elseif ($Event.Id -eq 1003) {
                $ActivationId = $EventData.Data[1].Split(':')[1].Split(',')[0].Trim()
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ActivationId -Value $ActivationId
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name ApplicationName -Value (Get-KmsProductSku -ProductSku $ActivationId)  
                Add-Member -InputObject $Event -MemberType NoteProperty `
                    -Name LicensingStatusMessage -Value $EventData.Data[1].Trim()
            }
        }

        $Reason = $LogonMethod = $null        
        switch ($Event.FailureReason) {
            "%%2305" { $Reason = 'The specified user account has expired.' }
            "%%2309" { $Reason = "The specified account's password has expired." }
            "%%2310" { $Reason = 'Account currently disabled.' }
            "%%2311" { $Reason = 'Account logon time restriction violation.' }
            "%%2312" { $Reason = 'User not allowed to logon at this computer.' }
            "%%2313" { $Reason = 'Unknown user name or bad password.' }
            "%%2304" { $Reason = 'An Error occurred during Logon.' }
        }

        switch ($Event.LogonType) {
            2 {$LogonMethod = "Interactive (local system)" } 
            3 {$LogonMethod = "Network" } 
            4 {$LogonMethod = "Batch" } 
            5 {$LogonMethod = "Service" } 
            7 {$LogonMethod = "Unlock" } 
            8 {$LogonMethod = "ClearText" } 
            9 {$LogonMethod = "NewCredentials" } 
            10 {$LogonMethod = "RemoteInteractive (Remote Desktop)" } 
            11 {$LogonMethod = "CachedInteractive" } 
            default {$LogonMethod = "Undetermined logon method" } 
        }    

        if ($Reason -eq $null) {
            if ($Event.Id -eq 4625) {

                switch ($Event.Status) {
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
                
                if ($Event.Status -ne $Event.SubStatus) {
                    switch ($Event.SubStatus) {
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
                        default { $Reason += " : " + $Event.SubStatus }
                    }            
                }        
                        
            } elseif ($Event.Id -eq 4771)  {

                switch ($EventLogRecord.Status) {
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
                    default { $Reason = $Event.Status }
                }

            }
        }

        if ($Reason) {
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name Reason -Value $Reason
            
            Add-Member -InputObject $Event -MemberType NoteProperty `
                -Name LogonMethod -Value $LogonMethod
        }
    }

    end {
        return $Event
    }
}