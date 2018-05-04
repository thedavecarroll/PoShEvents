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

        try {
            $Event = Get-MyEvent -ComputerName $ComputerName -FilterHashtable $FilterHashtable -MaxEvents 1 -ErrorAction Continue
        }
        catch {
            Write-Error -Message "$Computer : $($_.CategoryInfo.Reason + " : " + $_.Exception.Message)"
        }
                  
        $EventLogRecord = ConvertFrom-EventLogRecord -EventLogRecord $Event | Select-Object -Property ComputerName,OperatingSystemVersion        

    }

    end {
        return $EventLogRecord
    }
}
