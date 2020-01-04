function Get-KmsProductSku {
    [CmdLetBinding()]
    param([string]$ProductSku)
    # see https://github.com/asaboss/py-kms-server/ for updates
    # check https://github.com/CNMan/balala/blob/master/pkconfig.csv for more updates

    $KmsProductSkuPath = Join-Path -Path $PSScriptRoot -ChildPath 'KmsProductSku.csv'
    $KmsProductSku = Import-Csv -Path $KmsProductSkuPath
    if ($KmsProductSku.Where({$_.ActConfigID -match $ProductSku})) {
        $KmsProductSku.Where({$_.ActConfigID -match $ProductSku}).ProductDescription
    } else {
        $ProductSku
    }
}