# PoShEvents

## Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.4.1] - 2020-01-25

Feature, Bugfix, and Maintenance; Update Strongly Recommended

### Fixed

* [Issue #38](https://github.com/thedavecarroll/PoShEvents/issues/38) - New-EventFilterXml - Returns invalid query

### Changed

* [Issue #18](https://github.com/thedavecarroll/PoShEvents/issues/18) - Refactor Get-KMSClientEvent to use New-EventFilterXml
* [Issue #19](https://github.com/thedavecarroll/PoShEvents/issues/19) - Refactor Get-KMSHostLicenseCheckEvent to use New-EventFilterXml
* [Issue #39](https://github.com/thedavecarroll/PoShEvents/issues/39) - Refactor Get-KMSHostEvent to use New-EventFilterXml
* [Issue #40](https://github.com/thedavecarroll/PoShEvents/issues/40) - Refactor Get-ServiceEvent to use New-EventFilterXml
* [Issue #41](https://github.com/thedavecarroll/PoShEvents/issues/41) - Refactor Get-GPOProcessingEvent to use New-EventFilterXml

### Maintenance

* [Issue #36](https://github.com/thedavecarroll/PoShEvents/issues/36) - Update Module Copyright
* [Issue #42](https://github.com/thedavecarroll/PoShEvents/issues/42) - Update Help
* [Issue #43](https://github.com/thedavecarroll/PoShEvents/issues/43) - ConvertFrom-EventLogRecord - refactor to reduce code duplication

[0.4.1]: https://github.com/thedavecarroll/PoShEvents/tree/053f344329f424ff5a776b5f1dacb60bd9cf3d9d

## [0.4.0] - 2020-01-07

Bugfix and Feature Release, Update Strongly Recommended

### Added

* [Issue #23](https://github.com/thedavecarroll/PoShEvents/issues/23) - `Get-ServiceEvent` - add switch for EventType
* [Issue #33](https://github.com/thedavecarroll/PoShEvents/issues/33) - `Import-KmsProductSku` - new private function

### Fixed

* [Issue #25](https://github.com/thedavecarroll/PoShEvents/issues/25) - `New-EventFilterXml` does not produce a valid xml filter under certain circumstances
* [Issue #26](https://github.com/thedavecarroll/PoShEvents/issues/26) - `Get-KmsProductSku` - Import-Csv : Could not find file 'C:\KmsProductSku.csv'
* [Issue #27](https://github.com/thedavecarroll/PoShEvents/issues/27) - `Get-RemoteLogonEvent` - Error 'ParameterSetName' is a ReadOnly property
* [Issue #34](https://github.com/thedavecarroll/PoShEvents/issues/34) - `New-EventDataFilter` - data of array uses "and" instead of "or"

### Changed

* [Issue #24](https://github.com/thedavecarroll/PoShEvents/issues/24) - Updatable Help - Convert Module HelpInfoUri to Bit.ly Link
* [Issue #28](https://github.com/thedavecarroll/PoShEvents/issues/28) - `Get-OSVersionFromEvent` - Should only return the latest event
* [Issue #29](https://github.com/thedavecarroll/PoShEvents/issues/29) - `Get-OSVersionFromEvent` - add All switch to return all events
* [Issue #31](https://github.com/thedavecarroll/PoShEvents/issues/31) - `ConvertFrom-EventLogRecord` - for KMS events, import CSV in begin{} block
* [Issue #32](https://github.com/thedavecarroll/PoShEvents/issues/32) - `Get-KmsProductSku` - remove import CSV code
* [Issue #35](https://github.com/thedavecarroll/PoShEvents/issues/35) - `New-EventFilterXml` - replace LogLevelName with enum

[0.4.0]: https://github.com/thedavecarroll/PoShEvents/tree/a3b25c86aa968586ed8f6f5ed66aed1e27cf87e4

## [0.3.0] - 2020-01-01

### Added

* [Issue #21](https://github.com/thedavecarroll/PoShEvents/issues/21) - Add `New-EventSource`
* [Issue #20](https://github.com/thedavecarroll/PoShEvents/issues/20) - Add `Write-WinEvent`
* [Issue #7](https://github.com/thedavecarroll/PoShEvents/issues/7) - Add `New-EventFilterXml` and `New-EventDataFilter`
* [Issue #3](https://github.com/thedavecarroll/PoShEvents/issues/3) - Add build script

### Fixed

* [Issue #17](https://github.com/thedavecarroll/PoShEvents/issues/17) - Use `StringBuilder` to concatenate text for `Get-RemoteLogonEvent`
* [Issue #15](https://github.com/thedavecarroll/PoShEvents/issues/15) - Change `$Computers` array to use `[System.Collections.Generic.List]` in `ConvertFrom-EventLogRecord`

### Changed

* [Issue #12](https://github.com/thedavecarroll/PoShEvents/issues/12) - Separate KMS private functions
* [Issue #13](https://github.com/thedavecarroll/PoShEvents/issues/13) - Refactor `Get-PrintDocumentEvent` to use new xml filter
* [Issue #16](https://github.com/thedavecarroll/PoShEvents/issues/16) - Refactor `Get-RemoteLogonEvent` to use new xml filter
* [Issue #22](https://github.com/thedavecarroll/PoShEvents/issues/22) - Move online help to [readthedocs](https://poshevents.anovelidea.org)
* Moved updatable help to [https://powershell.anovelidea.org/modulehelp/](https://powershell.anovelidea.org/modulehelp/)
* Changed `ReleaseNotes.md` to `CHANGELOG.md`

[0.3.0]: https://github.com/thedavecarroll/PoShEvents/tree/e4f966f27b20a909379a0dc6516559371633bd18

## [0.2.1] - 2018-08-27

### Changed

* [Issue #1](https://github.com/thedavecarroll/PoShEvents/issues/1) - Move online help to [blog](http://powershell.anovelidea.org/modulehelp/PoShEvents)
* [Issue #5](https://github.com/thedavecarroll/PoShEvents/issues/5) - Move updatable help to blog

[0.2.1]: https://github.com/thedavecarroll/PoShEvents/tree/b874e4cef884d732f4625383ff8cfd4fbf4704f7

## [0.2.0] - 2018-07-03

### Removed

* Get-AccountManagementEvent
  * Removed function in order to work on it in more detail

### Changed

* ConvertFrom-EventLogRecord
  * Switched to new pipeline execution method and switched to using hashtable before object build
* Updated help

### Added

* Add TypeData and FormatData for functions
* Add -Raw switch to present the raw event log records without converting them
  * Useful for some functions that use complex XML filters

[0.2.0]: https://github.com/thedavecarroll/PoShEvents/tree/6d0225ee13fba668014732f556e90956f3840c93

## [0.1.2] - 2018-05-23

### Added

* Added online help

### Fixed

* Corrected external help by adding online
* All public functions
  * Removed try/catch for Get-MyEvent

### Changed

* Get-MyEvent
  * Switched to parameter set for filter and simplified error handling

[0.1.2]: https://github.com/thedavecarroll/PoShEvents/tree/3b708cc40b498f2d54c30a7511c94baf6f3a5cdd

## [0.1.1] - 2018-05-12

### Added

* Added external help

[0.1.1]: https://github.com/thedavecarroll/PoShEvents/tree/99ce4e7340d2311de175eed9a21460b729478f31

## [0.1.0] - 2018-05-04

* Initial release

[0.1.0]: https://github.com/thedavecarroll/PoShEvents/tree/0867348cac84ee7bbdb3e9f41abf74133dc8a8cc
