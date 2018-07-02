function ConvertFrom-UserSID {
    [CmdLetBinding()]
    param([string]$UserSID)
    try {
        $SecurityIdentifier = New-Object System.Security.Principal.SecurityIdentifier($UserSID)
        $SecurityIdentifier.Translate([System.Security.Principal.NTAccount]).Value
    }
    catch {
        $null
    }
}