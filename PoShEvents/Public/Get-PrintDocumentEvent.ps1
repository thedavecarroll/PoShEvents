function Get-PrintDocumentEvent {
    [CmdLetBinding(DefaultParameterSetName='TimeSpan')]
    param(
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('IPAddress','__Server','CN')]
        [string]$ComputerName='localhost',
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [Parameter(ParameterSetName='TimeRange')]
        [datetime]$StartTime,
        [Parameter(ParameterSetName='TimeRange')]
        [datetime]$EndTime,
        [Parameter(ParameterSetName='TimeSpan')]
        [timespan]$Since,
        [int64]$MaxEvents,
        [switch]$Oldest,
        [switch]$Raw,
        [string]$UserName,
        [string]$ClientMachineName,
        [string]$PrinterName,
        [string]$PrinterPort,
        [string]$DocumentName,
        [int]$PagesPrinted
    )

    begin {

        $Hashtable = @{
            UserData = @{
                DocumentPrinted = @{}
            }
        }
        if ($DocumentName) {
            $Hashtable['UserData']['DocumentPrinted'].Add('Param2',$DocumentName)
        }
        if ($UserName) {
            $Hashtable['UserData']['DocumentPrinted'].Add('Param3',$UserName)
        }
        if ($ClientMachineName) {
            $Hashtable['UserData']['DocumentPrinted'].Add('Param4',$ClientMachineName)
        }
        if ($PrinterName) {
            $Hashtable['UserData']['DocumentPrinted'].Add('Param5',$PrinterName)
        }
        if ($PrinterPort) {
            $Hashtable['UserData']['DocumentPrinted'].Add('Param6',$PrinterPort)
        }
        if ($PagesPrinted) {
            $Hashtable['UserData']['DocumentPrinted'].Add('Param8',$PagesPrinted -as [string])
        }

        $FilterXmlParam = @{
            LogName = 'Microsoft-Windows-PrintService/Operational'
            EventId = 307
        }

        if ($Hashtable.Values.Values.Count -gt 0) {
            $FilterXmlParam.Add('EventDataFilter',(New-EventDataFilter -Hashtable $Hashtable))
        }

        if ($PSCmdlet.ParameterSetName -eq 'TimeSpan') {
            if ($Since) {
                $FilterXmlParam.Add('Since',$Since)
            }
        } else {
            if ($StartTime) {
                $FilterXmlParam.Add('StartTime',$StartTime)
            }
            if ($EndTime) {
                $FilterXmlParam.Add('EndTime',$EndTime)
            }
        }

        $FilterXml = New-EventFilterXml @FilterXmlParam

        '{0}{1}' -f [System.Environment]::NewLine,$FilterXml | Write-Verbose

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
    }

    process {
        if ($Raw) {
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat
        } else {
            Get-MyEvent -ComputerName $ComputerName -FilterXml $FilterXml @ParameterSplat | ConvertFrom-EventLogRecord -EventRecordType 'PrintDocument'
        }
    }

    end {

    }
}