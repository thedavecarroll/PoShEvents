function Get-MyEvent {
    [CmdLetBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('IPAddress','__Server','CN')]
        [string[]]$ComputerName='localhost',
        [Parameter(ParameterSetName='FilterHashTable')]
        [ValidateNotNull()]
        [hashtable]$FilterHashTable,
        [Parameter(ParameterSetName='FilterXml')]
        [ValidateNotNull()]
        [xml]$FilterXml,
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [int64]$MaxEvents,
        [switch]$Oldest
    )

    begin {

        $ParameterSplat = @{}
        if ($Credential) {
            $ParameterSplat['Credential'] = $Credential
        }
        if ($MaxEvents) {
            $ParameterSplat['MaxEvents'] = $MaxEvents
        }
        if ($Oldest) {
            $ParameterSplat['Oldest'] = $true
        }

        $ComputerCounter = 0

    }

    process {

        foreach ($Computer in $ComputerName) {
            $Computer = $Computer.ToUpper()
            if ($ComputerCounter -gt 0) {
                Write-Progress -Id 1 -Activity "Searching for events..." -CurrentOperation $Computer -PercentComplete (($ComputerCounter / $ComputerName.count) * 100)
            }
            $ComputerCounter++
            Write-Verbose "$Computer : Searching for events..."

            try {
                if ($Computer -isnot [ipaddress]) {
                    [void][System.Net.Dns]::GetHostByName($Computer)
                }
                switch ($PsCmdlet.ParameterSetName) {
                    'FilterHashTable' {
                        Get-WinEvent -ComputerName $Computer -FilterHashtable $FilterHashtable -ErrorAction Stop @ParameterSplat
                    }
                    'FilterXml' {
                        Get-WinEvent -ComputerName $Computer -FilterXml $FilterXml -ErrorAction Stop @ParameterSplat
                    }
                }
            }

            catch {
                if ($_.CategoryInfo.Category -eq 'ObjectNotFound') {
                    Write-Verbose -Message "$Computer : No events were found that match the specified selection criteria"
                } else {
                    $PSCmdlet.ThrowTerminatingError($PSItem)
                }
            }

        }
    }

    end {

    }
}