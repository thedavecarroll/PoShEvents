Properties {
    $ProjectRoot = $env:BHProjectPath
    if(-not $ProjectRoot) {
        $ProjectRoot = $PSScriptRoot
    }

    $Timestamp = Get-date -UFormat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $TestResultsName = 'TestResults_PS{0}_{1}.xml' -f $PSVersion,$TimeStamp

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $Line = [Environment]::NewLine + ('-' * 70)

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $ModulePath = $env:BHModulePath
    $BuildOutput = Join-Path -Path $env:BHBuildOutput -ChildPath $env:BHProjectName

    $Manifest = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $psd1 = $env:BHPSModuleManifest

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $VersionFolder = Join-Path -Path $BuildOutput -ChildPath $Manifest.ModuleVersion

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $TestsPath = Join-Path -Path $ProjectRoot -ChildPath 'Tests'

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $PrivateFunctionsPath = Join-Path -Path $ModulePath -ChildPath 'Private'

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $PublicFunctionsPath = Join-Path -Path $ModulePath -ChildPath 'Public'

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $ClassPath = Join-Path -Path $ModulePath -ChildPath 'Classes'

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $TypeData = Join-Path -Path $ModulePath -ChildPath 'Classes'

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $ExternalHelpPath = Join-Path -Path $ModulePath -ChildPath 'en-US'

    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $DotNetFramework = 'netstandard2.0'
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
    $Release = 'Release'
}

Task Default -Depends Test

Task Init -Description 'Initialize build environment' {
    "STATUS: Testing with PowerShell $PSVersion"
    ''
    "Build System Details:"
    Get-Item ENV:BH*
    ''
    "Version Folder:".PadRight(20) + $VersionFolder
    ''
    "Loading modules:"
    'Pester', 'platyPS', 'PSScriptAnalyzer' | Foreach-Object {
        "    $_"
        if (-not (Get-Module -Name $_ -ListAvailable -Verbose:$false -ErrorAction SilentlyContinue)) {
            Install-Module -Name $_ -Repository PSGallery -Scope CurrentUser -AllowClobber -Confirm:$false -ErrorAction Stop
        }
        Import-Module -Name $_ -Verbose:$false -Force -ErrorAction Stop
    }
    $Line
}

Task Clean -Depends Init -Description 'Cleans module output directory' {
    Remove-Module -Name $env:BHProjectName -Force -ErrorAction SilentlyContinue

    if (Test-Path -Path $BuildOutput) {
        Get-ChildItem -Path $BuildOutput -Recurse | Remove-Item -Force -Recurse
    } else {
        $null = New-Item -Path $BuildOutput -ItemType Directory
    }

    "    Cleaned previous output directory [$BuildOutput]"
    $Line
}

Task Compile -Depends Clean -Description 'Compiles module from source' {

    # create module output directory
    $null = New-Item -Path $VersionFolder -ItemType Directory

    # append items to psm1
    Write-Verbose -Message 'Creating psm1...'
    $psm1 = Copy-Item -Path (Join-Path -Path $ModulePath -ChildPath "$env:BHProjectName.psm1") -Destination (Join-Path -Path $VersionFolder -ChildPath "$($ENV:BHProjectName).psm1") -PassThru

    # append psm1
    '#region classes' | Add-Content -Path $psm1 -Encoding UTF8
    Write-Verbose -Message "Appending folder $_ to psm1..."
    Get-ChildItem -Path (Join-Path -Path $ModulePath -ChildPath 'Classes') -Recurse -File |
        Get-Content -Raw | Add-Content -Path $psm1 -Encoding UTF8
    '#endregion classes' | Add-Content -Path $psm1 -Encoding UTF8

    # copy LICENSE, README.md, and CHANGELOG.md file


    # copy private and public functions to build output version folder
    'Private','Public','TypeData' | ForEach-Object {
        Write-Verbose -Message "Copying folder $_ to BuildOutput..."
        $BuildFolderPath = Join-Path -Path $VersionFolder -ChildPath $_
        $FolderPath = Join-Path -Path $ModulePath -ChildPath $_
        $HasFiles = Get-ChildItem -Path $FolderPath -File
        if ($HasFiles) {
            $null = New-Item -Path $BuildFolderPath -ItemType Directory
            $HasFiles | ForEach-Object { Copy-Item -Path $_.FullName -Destination $BuildFolderPath }
        }
    }

    # copy psd1 to build version output folder
    Copy-Item -Path $psd1 -Destination $VersionFolder
    $BuildManifest = Get-ChildItem -Path $VersionFolder -Include *.psd1 -Recurse | Select-Object -First 1 -ExpandProperty FullName

    # copy external help to build version output folder
    if (Test-Path -Path $ExternalHelpPath) {
        $BuildExternalHelpPath = Join-Path -Path $VersionFolder -ChildPath 'en-US'
        $HasExternalHelp = Get-ChildItem -Path $ExternalHelpPath -File
        if ($HasExternalHelp) {
            $null = New-Item -Path $BuildExternalHelpPath -ItemType Directory
            $HasExternalHelp | ForEach-Object { Copy-Item -Path $_.FullName -Destination $BuildExternalHelpPath }
        }
    }

    # copy updateable help to build version output folder
    $ModuleGuid = (Test-ModuleManifest -Path $psd1).GUID.ToString()
    $UpdatableHelpPath = Join-Path -Path $ModulePath -ChildPath ('{0}_{1}_HelpInfo.xml' -f $env:BHProjectName,$ModuleGuid)
    if (Test-Path -Path $UpdatableHelpPath) {
        Copy-Item -Path $UpdatableHelpPath -Destination $VersionFolder
    }

    $ModulePathSeparator = '{0}{1}' -f $ModulePath,[IO.Path]::DirectorySeparatorChar
    $Files = Get-ChildItem -Path $ModulePath -Recurse -Exclude '.gitignore','*.Class.ps1' -File
    $FileList = $Files.FullName | ForEach-Object { $_.Replace($ModulePathSeparator,'')}

    $FunctionsToExport =  (Get-ChildItem -Path (Join-Path -Path $ModulePath -ChildPath 'Public') -Recurse -File | ForEach-Object { $_.BaseName })

    $Formats = [IO.Path]::Combine($ModulePath,'TypeData',"$ModuleName.Format.ps1xml")
    if (Test-Path -Path $Formats) {
        $FormatsToProcess = $Formats.Replace($ModulePathSeparator,'')
    }

    $Types = [IO.Path]::Combine($ModulePath,'TypeData',"$ModuleName.Types.ps1xml")
    if (Test-Path -Path $Types) {
        $TypesToProcess = $Types.Replace($ModulePathSeparator,'')
    }

    $UpdateManifestParams = @{}
    if ($FileList)          { $UpdateManifestParams['FileList'] = $FileList }
    if ($FunctionsToExport) { $UpdateManifestParams['FunctionsToExport'] = $FunctionsToExport }
    if ($FormatsToProcess)  { $UpdateManifestParams['FormatsToProcess'] = $FormatsToProcess }
    if ($TypesToProcess)    { $UpdateManifestParams['TypesToProcess'] = $TypesToProcess }

    ''
    '    Adding the following to module manifest:'
    $UpdateManifestParams.Keys | ForEach-Object { "        $_"}
    Update-ModuleManifest -Path $BuildManifest @UpdateManifestParams

    ''
    "    Created compiled module at [$VersionFolder]"
    $Line
}

Task Test -Depends Init, Analyze, Pester -Description 'Run test suite'

Task Analyze -Description 'Run PSScriptAnalyzer' -Depends Compile {
    $Analysis = Invoke-ScriptAnalyzer -Path $VersionFolder -Verbose:$false
    $AnalyzeErrors = $Analysis | Where-Object {$_.Severity -eq 'Error'}
    $AnalyzeWarnings = $Analysis | Where-Object {$_.Severity -eq 'Warning'}

    '    PSScriptAnalyzer results:'
    ($Analysis | Group-Object -Property Severity,RuleName | Select-Object -Property Count,Name | Out-String).Trim().Split("`n") | Foreach-Object { (' ' * 8) + $_ }
    ''

    if (($AnalyzeErrors.Count -eq 0) -and ($AnalyzeWarnings.Count -eq 0)) {
        '    PSScriptAnalyzer passed without errors or warnings'
    }

    if (@($AnalyzeErrors).Count -gt 0) {
        Write-Error -Message 'One or more Script Analyzer errors were found. Build cannot continue!'
        $AnalyzeErrors | Format-Table
    }

    if (@($AnalyzeWarnings).Count -gt 0) {
        Write-Warning -Message 'One or more Script Analyzer warnings were found. These should be corrected.'
        $AnalyzeWarnings | Format-Table
    }
    $Line
}

Task Pester -Description 'Run Pester tests' -Depends Analyze {
    Push-Location
    Set-Location -Path $VersionFolder
    if(-not $ENV:BHProjectPath) {
        Set-BuildEnvironment -Path (Join-Path -Path $PSScriptRoot -ChildPath '..') -Passthru
    }

    $origModulePath = $env:PSModulePath
    if ( $env:PSModulePath.split($pathSeperator) -notcontains $BuildOutput ) {
        $env:PSModulePath = ($BuildOutput + $pathSeperator + $origModulePath)
    }

    Remove-Module $env:BHProjectName -ErrorAction SilentlyContinue -Verbose:$false
    Import-Module (Join-Path -Path $VersionFolder -ChildPath "${env:BHProjectName}.psd1") -Force -Verbose:$false
    $TestResultsXml = Join-Path -Path $BuildOutput -ChildPath $TestResultsName
    $TestResults = Invoke-Pester -Path $TestsPath -PassThru -OutputFile $TestResultsXml -OutputFormat NUnitXml -Show Describe,Context,Failed,Summary

    <#
    # Upload test artifacts to AppVeyor
    if ($env:APPVEYOR_JOB_ID) {
        $wc = New-Object 'System.Net.WebClient'
        $wc.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", $TestResultsXml)
    }
    #>

    if ($TestResults.FailedCount -gt 0) {
        $TestResults | Format-List
        Write-Error -Message 'One or more Pester tests failed. Build cannot continue!'
    }
    Pop-Location
    $env:PSModulePath = $origModulePath

    ''
    $Line
}


Task Build -Depends Compile, CreateMarkdownHelp, CreateExternalHelp {
    # External help
    $helpXml = New-ExternalHelp "$projectRoot\docs\reference\functions" -OutputPath (Join-Path -Path $VersionFolder -ChildPath 'en-US') -Force
    "    Module XML help created at [$helpXml]"
}
