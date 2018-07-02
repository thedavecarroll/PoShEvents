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