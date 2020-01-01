function Get-LogonFailureReason {
    param($EventRecord)

    $LogonFailureReason = [System.Text.StringBuilder]::new()

    switch ($EventRecord.FailureReason) {
        '%%2305' { $LogonFailureReason.Append('The specified user account has expired.') }
        '%%2309' { $LogonFailureReason.Append('The specified account''s password has expired.') }
        '%%2310' { $LogonFailureReason.Append('Account currently disabled.') }
        '%%2311' { $LogonFailureReason.Append('Account logon time restriction violation.') }
        '%%2312' { $LogonFailureReason.Append('User not allowed to logon at this computer.') }
        '%%2313' { $LogonFailureReason.Append('Unknown user name or bad password.') }
        '%%2304' { $LogonFailureReason.Append('An Error occurred during Logon.') }
    }
    if ($null -eq $Reason) {
        if ($EventRecord.Id -eq 4625) {
            switch ($EventRecord.Status) {
                '0xC0000234' { $LogonFailureReason.Append('Account locked out')}
                '0xC0000193' { $LogonFailureReason.Append('Account expired')}
                '0xC0000133' { $LogonFailureReason.Append('Clocks out of sync')}
                '0xC0000224' { $LogonFailureReason.Append('Password change required')}
                '0xc000015b' { $LogonFailureReason.Append('User does not have logon right')}
                '0xc000006d' { $LogonFailureReason.Append('Logon failure')}
                '0xc000006e' { $LogonFailureReason.Append('Account restriction')}
                '0xc00002ee' { $LogonFailureReason.Append('An error occurred during logon')}
                '0xC0000071' { $LogonFailureReason.Append('Password expired')}
                '0xC0000072' { $LogonFailureReason.Append('Account disabled')}
                '0xC0000413' { $LogonFailureReason.Append('Authentication firewall prohibits logon')}
                default { $LogonFailureReason.Append($Event.Status) }
            }
            if ($EventRecord.Status -ne $EventRecord.SubStatus) {
                switch ($EventRecord.SubStatus) {
                    '0xC0000234' { $LogonFailureReason.Append(' : Account locked out')}
                    '0xC0000193' { $LogonFailureReason.Append(' : Account expired')}
                    '0xC0000133' { $LogonFailureReason.Append(' : Clocks out of sync')}
                    '0xC0000224' { $LogonFailureReason.Append(' : Password change required')}
                    '0xc000015b' { $LogonFailureReason.Append(' : User does not have logon right')}
                    '0xc000006d' { $LogonFailureReason.Append(' : Logon failure')}
                    '0xc000006e' { $LogonFailureReason.Append(' : Account restriction')}
                    '0xc00002ee' { $LogonFailureReason.Append(' : An error occurred during logon')}
                    '0xC0000071' { $LogonFailureReason.Append(' : Password expired')}
                    '0xC0000072' { $LogonFailureReason.Append(' : Account disabled')}
                    '0xc000006a' { $LogonFailureReason.Append(' : Incorrect password')}
                    '0xc0000064' { $LogonFailureReason.Append(' : Account does not exist')}
                    '0xC0000413' { $LogonFailureReason.Append(' : Authentication firewall prohibits logon')}
                    default { $LogonFailureReason.Append(' : ' + $EventRecord.SubStatus ) }
                }
            }
        } elseif ($EventRecord.Id -eq 4771)  {
            switch ($EventRecord.Status) {
                '0x1' { $LogonFailureReason.Append('Clients entry in database has expired')}
                '0x2' { $LogonFailureReason.Append('Server''s entry in database has expired')}
                '0x3' { $LogonFailureReason.Append('Requested protocol version # not supported')}
                '0x4' { $LogonFailureReason.Append('Client''s key encrypted in old master key')}
                '0x5' { $LogonFailureReason.Append('Server''s key encrypted in old master key')}
                '0x6' { $LogonFailureReason.Append('Client not found in Kerberos database')}	#Bad user name, or new computer/user account has not replicated to DC yet
                '0x7' { $LogonFailureReason.Append('Server not found in Kerberos database')} #	 New computer account has not replicated yet or computer is pre-w2k
                '0x8' { $LogonFailureReason.Append('Multiple principal entries in database')}
                '0x9' { $LogonFailureReason.Append('The client or server has a null key')} # administrator should reset the password on the account
                '0xA' { $LogonFailureReason.Append('Ticket not eligible for postdating')}
                '0xB' { $LogonFailureReason.Append('Requested start time is later than end time')}
                '0xC' { $LogonFailureReason.Append('KDC policy rejects request')} #	Workstation restriction
                '0xD' { $LogonFailureReason.Append('KDC cannot accommodate requested option')}
                '0xE' { $LogonFailureReason.Append('KDC has no support for encryption type')}
                '0xF' { $LogonFailureReason.Append('KDC has no support for checksum type')}
                '0x10' { $LogonFailureReason.Append('KDC has no support for padata type')}
                '0x11' { $LogonFailureReason.Append('KDC has no support for transited type')}
                '0x12' { $LogonFailureReason.Append('Clients credentials have been revoked')} # Account disabled, expired, locked out, logon hours.
                '0x13' { $LogonFailureReason.Append('Credentials for server have been revoked')}
                '0x14' { $LogonFailureReason.Append('TGT has been revoked')}
                '0x15' { $LogonFailureReason.Append('Client not yet valid - try again later')}
                '0x16' { $LogonFailureReason.Append('Server not yet valid - try again later')}
                '0x17' { $LogonFailureReason.Append('Password has expired')} # The user’s password has expired.
                '0x18' { $LogonFailureReason.Append('Pre-authentication information was invalid')} # Usually means bad password
                '0x19' { $LogonFailureReason.Append('Additional pre-authentication required*')}
                '0x1F' { $LogonFailureReason.Append('Integrity check on decrypted field failed')}
                '0x20' { $LogonFailureReason.Append('Ticket expired')} #Frequently logged by computer accounts
                '0x21' { $LogonFailureReason.Append('Ticket not yet valid')}
                '0x21' { $LogonFailureReason.Append('Ticket not yet valid')}
                '0x22' { $LogonFailureReason.Append('Request is a replay')}
                '0x23' { $LogonFailureReason.Append('The ticket isn''t for us')}
                '0x24' { $LogonFailureReason.Append('Ticket and authenticator don''t match')}
                '0x25' { $LogonFailureReason.Append('Clock skew too great')} #	Workstation’s clock too far out of sync with the DC’s
                '0x26' { $LogonFailureReason.Append('Incorrect net address')} # IP address change?
                '0x27' { $LogonFailureReason.Append('Protocol version mismatch')}
                '0x28' { $LogonFailureReason.Append('Invalid msg type')}
                '0x29' { $LogonFailureReason.Append('Message stream modified')}
                '0x2A' { $LogonFailureReason.Append('Message out of order')}
                '0x2C' { $LogonFailureReason.Append('Specified version of key is not available')}
                '0x2D' { $LogonFailureReason.Append('Service key not available')}
                '0x2E' { $LogonFailureReason.Append('Mutual authentication failed')} #	 may be a memory allocation failure
                '0x2F' { $LogonFailureReason.Append('Incorrect message direction')}
                '0x30' { $LogonFailureReason.Append('Alternative authentication method required*')}
                '0x31' { $LogonFailureReason.Append('Incorrect sequence number in message')}
                '0x32' { $LogonFailureReason.Append('Inappropriate type of checksum in message')}
                '0x3C' { $LogonFailureReason.Append('Generic error (description in e-text)')}
                '0x3D' { $LogonFailureReason.Append('Field is too long for this implementation')}
                default { $LogonFailureReason.Append($Event.Status) }
            }
        }
        $LogonFailureReason.ToString()
    }
}