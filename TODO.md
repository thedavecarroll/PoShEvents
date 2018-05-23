# PoShEvents TODO

My general TODO list for this module.

## Features

* Add -AsJob to Get-MyEvent private function in hopes of speeding up results for large number of systems. An alternative would be to create a workflow to get the events.
* Create new object type in order to present data in custom views.

## Bugs

* Help me find typos or bugs.
* Get-ServiceEvent - MaxEvents will return MaxEvents x 3, as there are three sets of event Ids.
* Get-GPOProcessingEvent - This has external module dependencies.

## Maybe Things that Need to be Done

* Get-RemoteLogonEvent - refactor to use Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational
