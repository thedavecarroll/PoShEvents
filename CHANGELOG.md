# PoShEvents

## Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## 0.3.0 - Unreleased

### Added

* [Issue #21](https://github.com/thedavecarroll/PoShEvents/issues/21) - Add `New-EventSource`
* [Issue #20](https://github.com/thedavecarroll/PoShEvents/issues/20) - Add `Write-WinEvent`
* [Issue #7](https://github.com/thedavecarroll/PoShEvents/issues/7) - Add `New-EventFilterXml` and `New-EventDataFilter`
* [Issue #3](https://github.com/thedavecarroll/PoShEvents/issues/3) - Add build script

### Fixed

* [Issue #17](https://github.com/thedavecarroll/PoShEvents/issues/17) - Use `StringBuilder` to concatenate text for `Get-RemoteLogonEvent`

### Changed

* [Issue #12](https://github.com/thedavecarroll/PoShEvents/issues/12) - Separate KMS private functions
* [Issue #13](https://github.com/thedavecarroll/PoShEvents/issues/13) - Refactor `Get-PrintDocumentEvent` to use new xml filter
* [Issue #16](https://github.com/thedavecarroll/PoShEvents/issues/16) - Refactor `Get-RemoteLogonEvent` to use new xml filter
* [Issue #22](https://github.com/thedavecarroll/PoShEvents/issues/22) - Move online help to [readthedocs](https://poshevents.anovelidea.org)
* Updated updatable help
* Changed `ReleaseNotes.md` to `CHANGELOG.md`

## [0.2.1] - 2018-08-27

### Changed

* [Issue #1](https://github.com/thedavecarroll/PoShEvents/issues/1) - Move online help to [blog](http://powershell.anovelidea.org/modulehelp/PoShEvents)
* [Issue #5](https://github.com/thedavecarroll/PoShEvents/issues/5) - Move updatable help to blog

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

## [0.1.1] - 2018-05-12

### Added

* Added external help

## [0.1.0] - 2018-05-04

* Initial release

[0.2.1]: https://github.com/thedavecarroll/PoShEvents/tree/b874e4cef884d732f4625383ff8cfd4fbf4704f7
[0.2.0]: https://github.com/thedavecarroll/PoShEvents/tree/6d0225ee13fba668014732f556e90956f3840c93
[0.1.2]: https://github.com/thedavecarroll/PoShEvents/tree/3b708cc40b498f2d54c30a7511c94baf6f3a5cdd
[0.1.1]: https://github.com/thedavecarroll/PoShEvents/tree/99ce4e7340d2311de175eed9a21460b729478f31
[0.1.0]: https://github.com/thedavecarroll/PoShEvents/tree/0867348cac84ee7bbdb3e9f41abf74133dc8a8cc
