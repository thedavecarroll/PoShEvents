function Import-KmsProductSku {
    [CmdLetBinding()]
    param()
    # see https://github.com/asaboss/py-kms-server/ for updates
    # check https://github.com/CNMan/balala/blob/master/pkconfig.csv for more updates

    $KmsProductSkuPath = Join-Path -Path $PSScriptRoot -ChildPath 'KmsProductSku.csv'
    Import-Csv -Path $KmsProductSkuPath
}