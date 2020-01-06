[CmdLetBinding()]
param()

#region info
<#
The following members are exported via the module's data file (.psd1)
    Functions
    TypeData
    FormatData
#>
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments','')]
[object[]]$KmsProductSku = $null

enum LogLevelName { LogAlways; Critical; Error; Warning; Informational; Verbose; Issues }
#endregion info

#region discover module name
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments','')]
$ScriptPath = Split-Path $MyInvocation.MyCommand.Path
$ModuleName = $ExecutionContext.SessionState.Module
Write-Verbose -Message "Loading module $ModuleName"
#endregion discover module name

#region dot source public and private function definition files, export publich functions
try {
    foreach ($Scope in 'Public','Private') {
        Get-ChildItem -Path (Join-Path -Path $PSScriptRoot -ChildPath $Scope) -Filter *.ps1 | ForEach-Object {
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
#endregion dot source public and private function definition files, export publich functions