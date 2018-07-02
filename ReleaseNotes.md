# Release Notes

## 0.2.0

* Get-AccountManagementEvent - removed function in order to work on it in more detail
* ConvertFrom-EventLogRecord - switch to new pipeline execution method, switch to using hashtable before object build
* Add TypeData and FormatData for functions
* Add -Raw swich to present the raw event log records without converting them

  * Useful for some functions that use complex XML filters

* Updated help

## 0.1.2

* Added online help
* Corrected external help by adding online
* Get-MyEvent - switched to parameterset for filter and simplified error handling
* All public functions - removed try/catch for Get-MyEvent

## 0.1.1

* Added external help

## 0.1.0

* Initial release