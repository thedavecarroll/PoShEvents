function Get-OSVersionFromEvent {
    [CmdLetBinding()]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('IPAddress','__Server','CN')]
        [string[]]$ComputerName='localhost',
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty
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

        Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashtable | ConvertFrom-EventLogRecord -EventRecordType 'OSVersionFromEvent'

    }

    end {

    }
}
