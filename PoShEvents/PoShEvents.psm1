[CmdLetBinding()]
param()

# dot source public and private function definition files, export public functions
try {
    foreach ($Scope in 'Public','Private') {
        Get-ChildItem "$PSScriptRoot\$Scope" -Filter *.ps1 | ForEach-Object {
            . $_.FullName
            if ($Scope -eq 'Public') {
                Export-ModuleMember -Function $_.BaseName -ErrorAction Stop
            }
        }
    }
}
catch {
    Write-Error ("{0}: {1}" -f $_.BaseName,$_.Exception.Message)
    exit 1
}

# import format and type data
Try {
    Update-FormatData "$PSScriptRoot\TypeData\PoShEvents.Format.ps1xml" -ErrorAction Stop
}
catch {
    Write-Error ("{0}: {1}" -f 'Update-FormatData',$_.Exception.Message)
    exit 1
}
try {
    Update-TypeData "$PSScriptRoot\TypeData\PoShEvents.Types.ps1xml" -ErrorAction Stop
}
catch {
    Write-Error ("{0}: {1}" -f 'Update-TypeData',$_.Exception.Message)
    exit 1
}