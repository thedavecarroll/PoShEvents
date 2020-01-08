#
# Module manifest for module 'PoShEvents'
#
# Generated by: Dave Carroll
#
# Generated on: 1/7/2020
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'PoShEvents.psm1'

# Version number of this module.
ModuleVersion = '0.4.0'

# Supported PSEditions
CompatiblePSEditions = 'Desktop'

# ID used to uniquely identify this module
GUID = 'c9c97755-98f3-4fcc-84e6-43075cc31abb'

# Author of this module
Author = 'Dave Carroll'

# Company or vendor of this module
CompanyName = 'Unknown'

# Copyright statement for this module
Copyright = '(c) 2018-2019 Dave Carroll. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell module to query Windows Event Logs and write events with structured EventData or UserData'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
TypesToProcess = 'TypeData\PoShEvents.Types.ps1xml'

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = 'TypeData\PoShEvents.Format.ps1xml'

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'ConvertFrom-EventLogRecord', 'Get-GPOProcessingEvent', 
               'Get-KMSClientEvent', 'Get-KMSHostEvent', 
               'Get-KMSHostLicenseCheckEvent', 'Get-LogonFailureEvent', 
               'Get-OSVersionFromEvent', 'Get-PrintDocumentEvent', 
               'Get-RemoteLogonEvent', 'Get-ServiceEvent', 'Get-SystemRestartEvent', 
               'New-EventDataFilter', 'New-EventFilterXml', 'New-EventSource', 
               'Write-WinEvent'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
# VariablesToExport = @()

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
FileList = 'en-US\about_PoShEvents.help.txt', 'en-US\PoShEvents-help.xml', 
               'Private\ConvertFrom-UserSID.ps1', 'Private\Get-GPEventType.ps1', 
               'Private\Get-KmsErrorCode.ps1', 'Private\Get-KmsLicenseState.ps1', 
               'Private\Get-KmsProductSku.ps1', 
               'Private\Get-LogonFailureReason.ps1', 'Private\Get-LogonMethod.ps1', 
               'Private\Get-MyEvent.ps1', 'Private\Import-KmsProductSku.ps1', 
               'Private\KmsProductSku.csv', 
               'Public\ConvertFrom-EventLogRecord.ps1', 
               'Public\Get-GPOProcessingEvent.ps1', 
               'Public\Get-KMSClientEvent.ps1', 'Public\Get-KMSHostEvent.ps1', 
               'Public\Get-KMSHostLicenseCheckEvent.ps1', 
               'Public\Get-LogonFailureEvent.ps1', 
               'Public\Get-OSVersionFromEvent.ps1', 
               'Public\Get-PrintDocumentEvent.ps1', 
               'Public\Get-RemoteLogonEvent.ps1', 'Public\Get-ServiceEvent.ps1', 
               'Public\Get-SystemRestartEvent.ps1', 
               'Public\New-EventDataFilter.ps1', 'Public\New-EventFilterXml.ps1', 
               'Public\New-EventSource.ps1', 'Public\Write-WinEvent.ps1', 
               'TypeData\PoShEvents.Format.ps1xml', 
               'TypeData\PoShEvents.Types.ps1xml', 'PoShEvents.psd1', 
               'PoShEvents.psm1'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    #IsPrerelease of this module
    IsPrerelease = 'True'

    #Category of this module
    Category = 'Event Logs'

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'PoShEvents','Events','EventLogs','PowerShell','AzureAutomationNotSupported'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/thedavecarroll/PoShEvents/blob/master/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/thedavecarroll/PoShEvents'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = '## [0.4.0] - 2020-01-07, Bugfix and Feature Release, Update Strongly Recommended

### Added

* [Issue 23](https://github.com/thedavecarroll/PoShEvents/issues/23) - `Get-ServiceEvent` - add switch for EventType
* [Issue 33](https://github.com/thedavecarroll/PoShEvents/issues/33) - `Import-KmsProductSku` - new private function

### Fixed

* [Issue 25](https://github.com/thedavecarroll/PoShEvents/issues/25) - `New-EventFilterXml` does not produce a valid xml filter under certain circumstances
* [Issue 26](https://github.com/thedavecarroll/PoShEvents/issues/26) - `Get-KmsProductSku` - Import-Csv : Could not find file ''C:\KmsProductSku.csv''
* [Issue 27](https://github.com/thedavecarroll/PoShEvents/issues/27) - `Get-RemoteLogonEvent` - Error ''ParameterSetName'' is a ReadOnly property
* [Issue 34](https://github.com/thedavecarroll/PoShEvents/issues/34) - `New-EventDataFilter` - data of array uses "and" instead of "or"

### Changed

* [Issue 24](https://github.com/thedavecarroll/PoShEvents/issues/24) - Updatable Help - Convert Module HelpInfoUri to Bit.ly Link
* [Issue 28](https://github.com/thedavecarroll/PoShEvents/issues/28) - `Get-OSVersionFromEvent` - Should only return the latest event
* [Issue 29](https://github.com/thedavecarroll/PoShEvents/issues/29) - `Get-OSVersionFromEvent` - add All switch to return all events
* [Issue 31](https://github.com/thedavecarroll/PoShEvents/issues/31) - `ConvertFrom-EventLogRecord` - for KMS events, import CSV in begin{} block
* [Issue 32](https://github.com/thedavecarroll/PoShEvents/issues/32) - `Get-KmsProductSku` - remove import CSV code
* [Issue 35](https://github.com/thedavecarroll/PoShEvents/issues/35) - `New-EventFilterXml` - replace LogLevelName with enum

For full CHANGELOG, see https://github.com/thedavecarroll/PoShEvents/blob/master/CHANGELOG.md'

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        RequireLicenseAcceptance = $true

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
HelpInfoURI = 'http://bit.ly/PoShEventsHelp'

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

