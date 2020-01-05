function Get-KmsProductSku {
    [CmdLetBinding()]
    param([string]$ProductSku)

    if ($KmsProductSku.Where({$_.ActConfigID -match $ProductSku})) {
        $KmsProductSku.Where({$_.ActConfigID -match $ProductSku}).ProductDescription
    } else {
        $ProductSku
    }
}