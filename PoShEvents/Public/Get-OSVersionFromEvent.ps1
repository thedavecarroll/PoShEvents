function Get-OSVersionFromEvent {
    [CmdLetBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('IPAddress','__Server','CN')]
        [string[]]$ComputerName='localhost',
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [switch]$Raw
    )

    Begin {

        $FilterHashtable = @{
            LogName     = 'System'
            Id          = 6009
        }

        $ParameterSplat = @{}
        if ($Credential) {
            $ParameterSplat['Credential'] = $Credential
        }

    }

    Process {
        if ($Raw) {
            Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat
        } else {
            Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashTable @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'OSVersionFromEvent'
        }
    }

    end {

    }
}
