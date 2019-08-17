function Get-KmsProductSku {
    param([string]$ProductSku)
    # see https://github.com/asaboss/py-kms-server/ for updates
    # check https://github.com/CNMan/balala/blob/master/pkconfig.csv for more updates

    $KmsProductSku = Import-Csv -Path .\KmsProductSku.csv
    if ($KmsProductSku.Where({$_.ActConfigID -match $ProductSku})) {
        $KmsProductSku.Where({$_.ActConfigID -match $ProductSku}).ProductDescription
    } else {
        $ProductSku
    }
}