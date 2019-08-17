function Get-KmsLicenseState {
    param([string]$LicenseState)
    switch ($LicenseState) {
        0 { 'Unlicensed' }
        1 { 'Activated' }
        2 { 'Grace Period' }
        3 { 'Out-of-Tolerance Grace Period' }
        4 { 'Non-Genuine Grace Period' }
        5 { 'Notifications Mode' }
        6 { 'Extended Grace Period' }
    }
}