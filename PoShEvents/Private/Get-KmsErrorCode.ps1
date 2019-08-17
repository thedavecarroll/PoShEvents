function Get-KmsErrorCode {
    param([string]$ErrorCode)
    switch ($ErrorCode) {
        { $_ -eq '0x0' -or $_ -eq '0x00000000' } { $null }
        '0xC004F035' { 'The Software Licensing Service reported that the computer could not be activated with a Volume license product key. Volume-licensed systems require upgrading from a qualifying operating system. Please contact your system administrator or use a different type of key.' }
        '0xC004F038' { 'The Software Licensing Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator.' }
        '0xC004F039' { 'The Software Licensing Service reported that the product could not be activated. The Key Management Service (KMS) is not enabled.' }
        '0x4004F040' { 'The Software Licensing Service reported that the product was activated but the owner should verify the Product Use Rights.' }
        '0x4004F041' { 'SL_I_VL_OOB_NO_BINDING_SERVER_REGISTRATION' }
        { $_ -eq '0x4004F042' -or $_ -eq '0xC004F042' } { 'The Software Licensing Service determined that the specified Key Management Service (KMS) cannot be used' }
        '0x4004F056' { 'The Software Licensing Service reported that the product could not be activated using the Key Management Service (KMS).' }
        '0xC004F015' { 'The Software Licensing Service reported that the license is not installed.' }
        '0xC004F041' { 'The Software Licensing Service determined that the Key Management Service (KMS) is not activated. KMS needs to be activated. Please contact system administrator.' }
        '0xC0020017' { 'The RPC Service is unavailable.' }
        default { $ErrorCode }
    }
}