# PoShEvents TODO

My general TODO list for this module.

## Features

* Add new function to provide useable FilterXML for basic Get-WinEvent.
* Add completed function for Get-AccountManagementEvent.
* Add new function to get the statistics of an event log or provider.
* Add -AsJob to Get-MyEvent private function in hopes of speeding up results for large number of systems. An alternative would be to create a workflow to get the events.
* When needed, switch to filter XML for parameter filtering.
* Test signing.

## Bugs

* Help me find typos or bugs.

## Maybe Things that Need to be Done

* Get-RemoteLogonEvent - refactor to use Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational
