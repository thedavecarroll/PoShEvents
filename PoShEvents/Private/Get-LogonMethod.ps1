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