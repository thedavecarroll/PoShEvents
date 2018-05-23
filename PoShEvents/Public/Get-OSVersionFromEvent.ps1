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

        $Event = Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashtable -MaxEvents 1                
        ConvertFrom-EventLogRecord -EventLogRecord $Event | Select-Object -Property ComputerName,OperatingSystemVersion

    }

    end {
        
    }
}
