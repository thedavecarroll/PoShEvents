# PoShEvents TODO

My general TODO list for this module.

## Features

* Add -AsJob to Get-MyEvent private function in hopes of speeding up results for large number of systems. An alternative would be to create a workflow to get the events.
* Create new object type in order to present data in custom views. **InProgress**
* Switch all remaining functions to use new pipeline method. **InProgress**
* When needed, switch to filter XML for parameter filtering.

## Bugs

* Help me find typos or bugs.
* All converted functions - Update help.

## Maybe Things that Need to be Done

* Get-RemoteLogonEvent - refactor to use Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational
