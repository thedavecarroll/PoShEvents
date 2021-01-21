function Get-LogonFailureReason {
    param($EventRecord)

    $LogonFailureReason = [System.Text.StringBuilder]::new()

    switch ($EventRecord.FailureReason) {
        '%%2305' { [void]$LogonFailureReason.Append('The specified user account has expired.') }
        '%%2309' { [void]$LogonFailureReason.Append('The specified account''s password has expired.') }
        '%%2310' { [void]$LogonFailureReason.Append('Account currently disabled.') }
        '%%2311' { [void]$LogonFailureReason.Append('Account logon time restriction violation.') }
        '%%2312' { [void]$LogonFailureReason.Append('User not allowed to logon at this computer.') }
        '%%2313' { [void]$LogonFailureReason.Append('Unknown user name or bad password.') }
        '%%2304' { [void]$LogonFailureReason.Append('An Error occurred during Logon.') }
    }
    if ($null -eq $Reason) {
        if ($EventRecord.Id -eq 4625) {
            switch ($EventRecord.Status) {
                '0xC0000234' { [void]$LogonFailureReason.Append('Account locked out')}
                '0xC0000193' { [void]$LogonFailureReason.Append('Account expired')}
                '0xC0000133' { [void]$LogonFailureReason.Append('Clocks out of sync')}
                '0xC0000224' { [void]$LogonFailureReason.Append('Password change required')}
                '0xc000015b' { [void]$LogonFailureReason.Append('User does not have logon right')}
                '0xc000006d' { [void]$LogonFailureReason.Append('Logon failure')}
                '0xc000006e' { [void]$LogonFailureReason.Append('Account restriction')}
                '0xc00002ee' { [void]$LogonFailureReason.Append('An error occurred during logon')}
                '0xC0000071' { [void]$LogonFailureReason.Append('Password expired')}
                '0xC0000072' { [void]$LogonFailureReason.Append('Account disabled')}
                '0xC0000413' { [void]$LogonFailureReason.Append('Authentication firewall prohibits logon')}
                default { [void]$LogonFailureReason.Append($Event.Status) }
            }
            if ($EventRecord.Status -ne $EventRecord.SubStatus) {
                switch ($EventRecord.SubStatus) {
                    '0xC0000234' { [void]$LogonFailureReason.Append(' : Account locked out')}
                    '0xC0000193' { [void]$LogonFailureReason.Append(' : Account expired')}
                    '0xC0000133' { [void]$LogonFailureReason.Append(' : Clocks out of sync')}
                    '0xC0000224' { [void]$LogonFailureReason.Append(' : Password change required')}
                    '0xc000015b' { [void]$LogonFailureReason.Append(' : User does not have logon right')}
                    '0xc000006d' { [void]$LogonFailureReason.Append(' : Logon failure')}
                    '0xc000006e' { [void]$LogonFailureReason.Append(' : Account restriction')}
                    '0xc00002ee' { [void]$LogonFailureReason.Append(' : An error occurred during logon')}
                    '0xC0000071' { [void]$LogonFailureReason.Append(' : Password expired')}
                    '0xC0000072' { [void]$LogonFailureReason.Append(' : Account disabled')}
                    '0xc000006a' { [void]$LogonFailureReason.Append(' : Incorrect password')}
                    '0xc0000064' { [void]$LogonFailureReason.Append(' : Account does not exist')}
                    '0xC0000413' { [void]$LogonFailureReason.Append(' : Authentication firewall prohibits logon')}
                    default { [void]$LogonFailureReason.Append(' : ' + $EventRecord.SubStatus ) }
                }
            }
        } elseif ($EventRecord.Id -eq 4771)  {
            switch ($EventRecord.Status) {
                '0x1' { [void]$LogonFailureReason.Append('Clients entry in database has expired')}
                '0x2' { [void]$LogonFailureReason.Append('Server''s entry in database has expired')}
                '0x3' { [void]$LogonFailureReason.Append('Requested protocol version # not supported')}
                '0x4' { [void]$LogonFailureReason.Append('Client''s key encrypted in old master key')}
                '0x5' { [void]$LogonFailureReason.Append('Server''s key encrypted in old master key')}
                '0x6' { [void]$LogonFailureReason.Append('Client not found in Kerberos database')} # Bad user name, or new computer/user account has not replicated to DC yet
                '0x7' { [void]$LogonFailureReason.Append('Server not found in Kerberos database')} # New computer account has not replicated yet or computer is pre-w2k
                '0x8' { [void]$LogonFailureReason.Append('Multiple principal entries in database')}
                '0x9' { [void]$LogonFailureReason.Append('The client or server has a null key')} # administrator should reset the password on the account
                '0xA' { [void]$LogonFailureReason.Append('Ticket not eligible for postdating')}
                '0xB' { [void]$LogonFailureReason.Append('Requested start time is later than end time')}
                '0xC' { [void]$LogonFailureReason.Append('KDC policy rejects request')} # Workstation restriction
                '0xD' { [void]$LogonFailureReason.Append('KDC cannot accommodate requested option')}
                '0xE' { [void]$LogonFailureReason.Append('KDC has no support for encryption type')}
                '0xF' { [void]$LogonFailureReason.Append('KDC has no support for checksum type')}
                '0x10' { [void]$LogonFailureReason.Append('KDC has no support for padata type')}
                '0x11' { [void]$LogonFailureReason.Append('KDC has no support for transited type')}
                '0x12' { [void]$LogonFailureReason.Append('Clients credentials have been revoked')} # Account disabled, expired, locked out, logon hours.
                '0x13' { [void]$LogonFailureReason.Append('Credentials for server have been revoked')}
                '0x14' { [void]$LogonFailureReason.Append('TGT has been revoked')}
                '0x15' { [void]$LogonFailureReason.Append('Client not yet valid - try again later')}
                '0x16' { [void]$LogonFailureReason.Append('Server not yet valid - try again later')}
                '0x17' { [void]$LogonFailureReason.Append('Password has expired')} # The user's password has expired.
                '0x18' { [void]$LogonFailureReason.Append('Pre-authentication information was invalid')} # Usually means bad password
                '0x19' { [void]$LogonFailureReason.Append('Additional pre-authentication required*')}
                '0x1F' { [void]$LogonFailureReason.Append('Integrity check on decrypted field failed')}
                '0x20' { [void]$LogonFailureReason.Append('Ticket expired')} # Frequently logged by computer accounts
                '0x21' { [void]$LogonFailureReason.Append('Ticket not yet valid')}
                '0x21' { [void]$LogonFailureReason.Append('Ticket not yet valid')}
                '0x22' { [void]$LogonFailureReason.Append('Request is a replay')}
                '0x23' { [void]$LogonFailureReason.Append('The ticket isn''t for us')}
                '0x24' { [void]$LogonFailureReason.Append('Ticket and authenticator don''t match')}
                '0x25' { [void]$LogonFailureReason.Append('Clock skew too great')} # Workstation's clock too far out of sync with the DCâ€™s
                '0x26' { [void]$LogonFailureReason.Append('Incorrect net address')} # IP address change?
                '0x27' { [void]$LogonFailureReason.Append('Protocol version mismatch')}
                '0x28' { [void]$LogonFailureReason.Append('Invalid msg type')}
                '0x29' { [void]$LogonFailureReason.Append('Message stream modified')}
                '0x2A' { [void]$LogonFailureReason.Append('Message out of order')}
                '0x2C' { [void]$LogonFailureReason.Append('Specified version of key is not available')}
                '0x2D' { [void]$LogonFailureReason.Append('Service key not available')}
                '0x2E' { [void]$LogonFailureReason.Append('Mutual authentication failed')} #   may be a memory allocation failure
                '0x2F' { [void]$LogonFailureReason.Append('Incorrect message direction')}
                '0x30' { [void]$LogonFailureReason.Append('Alternative authentication method required*')}
                '0x31' { [void]$LogonFailureReason.Append('Incorrect sequence number in message')}
                '0x32' { [void]$LogonFailureReason.Append('Inappropriate type of checksum in message')}
                '0x3C' { [void]$LogonFailureReason.Append('Generic error (description in e-text)')}
                '0x3D' { [void]$LogonFailureReason.Append('Field is too long for this implementation')}
                default { [void]$LogonFailureReason.Append($Event.Status) }
            }
        }
    }
    $LogonFailureReason.ToString()
}
