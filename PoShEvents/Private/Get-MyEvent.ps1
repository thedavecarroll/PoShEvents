function Get-MyEvent {
    [CmdLetBinding()]
    param(  
        [Parameter(ValueFromPipelineByPropertyName=$true,ValueFromPipeline=$true)]
        [Alias('IPAddress','__Server','CN')]    
        [string[]]$ComputerName='localhost',
        [ValidateNotNull()]
        [hashtable]$FilterHashTable,
        [ValidateNotNull()]
        [xml]$FilterXml,
        [ValidateNotNull()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
        [int64]$MaxEvents,
        [switch]$Oldest
    )

    begin {

        if (-Not $FilterHashTable -and -Not $FilterXml) {
            Write-Error -Message "You must supply a FilterHashTable or a FilterXml"
            break
        } elseif ($FilterHashTable -and $FilterXml) {
            Write-Error -Message "You must supply either a FilterHashTable or a FilterXml, but not both"
            break
        }

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

                try {        
                    if ($FilterHashTable) {
                        Get-WinEvent -ComputerName $Computer -FilterHashtable $FilterHashtable -ErrorAction Stop  @ParameterSplat
                    } else {
                        Get-WinEvent -ComputerName $Computer -FilterXml $FilterXml -ErrorAction Stop  @ParameterSplat
                    }                        
                }
                catch {
                    Write-Verbose -Message "$Computer : $($_.CategoryInfo.Reason + " : " + $_.Exception.Message)"
                }
                
            }
            catch [System.Net.Sockets.SocketException] {
                Write-Warning -Message "$Computer : Name resolution failed"
            }
            catch [System.UnauthorizedAccessException] {
                Write-Warning -Message "$Computer : Attempted to perform an unauthorized operation"
            }
            catch {
                Write-Warning -Message "$Computer : $($_.CategoryInfo.Reason + " : " + $_.Exception.Message)"
            }
        }
    }

    end { 

    }
}