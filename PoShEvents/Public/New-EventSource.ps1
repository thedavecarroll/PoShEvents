function New-EventSource {
    [CmdLetBinding()]
    param(
        [string]$EventLog,
        [string]$Source
    )

    if ([System.Diagnostics.EventLog]::SourceExists($Source) -eq $false) {
        try {
            [System.Diagnostics.EventLog]::CreateEventSource($Source, $EventLog)
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }  else {
        'Source {0} for event log {1} already exists' -f $Source,$EventLog | Write-Warning
    }
}