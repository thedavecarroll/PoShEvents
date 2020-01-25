function ConvertFrom-EventLogRecord {
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [System.Diagnostics.Eventing.Reader.EventLogRecord[]]
        $Events,
        [ValidateSet(
            'PrintDocument','SystemRestartEvent','LogonFailureEvent',
            'OSVersionFromEvent','RemoteLogonEvent','ServiceEvent',
            'GPOProcessingEvent','KMSClientEvent',
            'KMSHostEvent','KMSHostLicenseCheckEvent')]
        [AllowNull()]
        [string]$EventRecordType,
        [object[]]$GroupPolicy,
        [switch]$ShowProgress
    )

    begin {
        $EventCount = 0
        $Computers = [System.Collections.Generic.List[string]]::new()

        if ($EventRecordType -match 'KMS') {
            if ($null -eq $KmsProductSku) {
                $KmsProductSku = Import-KmsProductSku
            }
        }

        function ConvertDataNode {
            param($DataNode)
            if ($DataNode.Data.Count) {
                For ($i=0; $i -lt $DataNode.Data.Count; $i++) {
                    if ($DataNode.Data[$i].name) {
                        if ($DataNode.Data[$i].'#text' -eq "-") {
                            $Value = $null
                        } else {
                            $Value = $DataNode.Data[$i].'#text'
                        }
                        $Event.Add($DataNode.Data[$i].name,$value)
                    }
                }
            } else {
                if ($DataNode.Data.Name) {
                    $Event.Add($DataNode.Data.name,$DataNode.Data.'#text')
                }
            }
        }

    }
    process {
        foreach ($EventLogRecord in $Events) {
            $EventCount++
            $Computers.Add($EventLogRecord.MachineName)
            if ($ShowProgress) {
                Write-Progress -Id 1 -Activity "Formatting events..." -Status $EventLogRecord.MachineName -CurrentOperation "Processing record $EventCount"
            }

            $EventRecordXml = [xml]$EventLogRecord.ToXml()

            try {
                $UserName = ConvertFrom-UserSID -UserSID $EventLogRecord.UserId
            }
            catch {
                $UserName = $null
            }

            $Event = [ordered]@{
                ComputerName    = $EventLogRecord.MachineName
                TimeCreated     = $EventLogRecord.TimeCreated
                Id              = $EventLogRecord.Id
                Level           = $EventLogRecord.LevelDisplayName
                ActivityId      = $EventLogRecord.ActivityId
                RecordId        = $EventLogRecord.RecordId
                LogName         = $EventLogRecord.LogName
                ProviderName    = $EventLogRecord.ProviderName
                UserId          = $EventLogRecord.UserId
                UserName        = $UserName
                Message         = $EventLogRecord.Message
                EventData       = $EventRecordXml.Event.EventData
                UserData        = $EventRecordXml.Event.UserData
            }

            if ($Event.EventData) {
                ConvertDataNode -DataNode $Event.EventData
            }

            if ($Event.UserData) {
                ConvertDataNode -DataNode $Event.UserData
            }

            switch ($EventRecordType) {
                'PrintDocument' {
                    $Event.Add('PrintJobId',$Event.UserData.DocumentPrinted.Param1)
                    $Event.Add('DocumentName',$Event.UserData.DocumentPrinted.Param2)
                    $Event.Add('ClientMachineName',$Event.UserData.DocumentPrinted.Param4)
                    $Event.Add('PrinterName',$Event.UserData.DocumentPrinted.Param5)
                    $Event.Add('PrinterPort',$Event.UserData.DocumentPrinted.Param6)
                    $Event.Add('DocumentSizeBytes',$Event.UserData.DocumentPrinted.Param7)
                    $Event.Add('DocumentPageCount',$Event.UserData.DocumentPrinted.Param8)
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.PrintDocument' -PassThru
                }
                'SystemRestartEvent' {
                    $Reason = $Details = $Comment = $null
                    $TextInfo = (Get-Culture).TextInfo
                    switch ($Event.id) {
                        6005 { $Status = "Startup" }
                        6006 { $Status = "Shutdown" }
                        6008 { $Status = "Unexpected Shutdown" }
                        6009 { $Status = "System Info" }
                        1074 {
                            $Reason = $Event.param3
                            $Status = $TextInfo.ToTitleCase($Event.param5)
                            $Comment = $Event.param6
                            if ($Event.param1 -match "CcmExec") {
                                $Details = "Configuration Manager"
                            } elseif ($Event.param1 -match "msiexe") {
                                $Details = "Windows Installer"
                            } elseif ($Event.param1 -match "vmtoolsd") {
                                $Details = "VMTools"
                            } elseif ($Event.param1 -match "RuntimeBroker") {
                                $Details = "RuntimeBroker"
                            } elseif ($Event.param1 -match "FveNotify") {
                                $Details = "BitLocker"
                            } elseif ($Event.param1) {
                                $Details = $Event.param1.Split(" ")[0].Split("\")[-1]
                            }
                        }
                    }
                    $Event.Add('Status',$Status)
                    $Event.Add('Reason',$Reason)
                    $Event.Add('Details',$Details)
                    $Event.Add('Comment',$Comment)
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.SystemRestartEvent' -PassThru
                }
                'LogonFailureEvent' {
                    $Event.Add('LogonMethod',(Get-LogonMethod -LogonMethod $Event.LogonType))
                    $Event.Add('Reason',(Get-LogonFailureReason -EventRecord $Event))
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.LogonFailureEvent' -PassThru
                }
                'OSVersionFromEvent' {
                    [Version]$Version = $Event.EventData.Data[0] + $Event.EventData.Data[1]
                    $Event.Add('OperatingSystemVersion',$Version.ToString())
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.OSVersionFromEvent' -PassThru
                }
                'RemoteLogonEvent' {
                    $Event.Add('LogonMethod',(Get-LogonMethod -LogonMethod $Event.LogonType))
                    $Event.Add('Reason',(Get-LogonFailureReason -EventRecord $Event))
                    switch ($Event.Id) {
                        4624 { $EventType  = "Logon" }
                        4634 { $EventType  = "Logoff" }
                        4778 { $EventType  = "Session Reconnect" }
                        4779 { $EventType  = "Session Disconnect" }
                        4625 { $EventType  = "Logon Failure" }
                        default { $EventType = $null }
                    }
                    $Event.Add('EventType',$EventType)
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.RemoteLogonEvent' -PassThru
                }
                'ServiceEvent' {
                    #https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc756379(v%3dws.10)
                    if ($Event.Id -in @(7009,7011,7016,7021,7030,7035,7036,7037,7040)) {
                        $EventType = "ServiceOperations"
                    } elseif ($Event.Id -in @(7000,7001,7002,7003,7017,7019,7020,7022,7038,7039,7041)) {
                        $EventType = "ServiceStart"
                    } elseif ($Event.Id -in @(7023,7024,7031,7032,7034,7042,7043)) {
                        $EventType = "ServiceStop"
                    } elseif ($Event.Id -in @(7005,7006,7007,7008,7010,7012,7015,7018,7025,7026,7027,7028,7033)) {
                        $EventType = "ServiceControlManagerOperations"
                    } elseif ($Event.Id -eq 7045 ) {
                        $EventType = "ServiceInstall"
                    }
                    $Event.Add('EventType',$EventType)

                    if ($Event.Id -eq 7009) {
                        $Event.Add('ServiceName',$Event.param2.trim())
                    } elseif ($Event.param1) {
                        $Event.Add('ServiceName',$Event.param1.trim())
                    }
                    if ($Event.Id -eq 7045) {
                        $Event.Add('ServiceMessage',$Event.Message.Split("`n")[0].Trim())
                    } else {
                        $Event.Add('ServiceMessage',$Event.Message)
                    }
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.ServiceEvent' -PassThru
                }
                'GPOProcessingEvent' {
                    if ($Event.Message -like "*\Policies\*") {
                        $GPguid= $Event.Message.Split("{")[1].Split("}")[0]
                        if ($GroupPolicy) {
                            $GPName = $GroupPolicy | Where-Object { $_.Id -eq $GPguid} | Select-Object -ExpandProperty DisplayName
                        } else {
                            $GPName = $GPguid
                        }
                    } else {
                        $GPName = $null
                    }
                    $Event.Add('GroupPolicy',$GPName)

                    if ($Event.ErrorCode -ne 0) {
                        $Status = ([System.ComponentModel.Win32Exception] [int]$Event.ErrorCode).Message
                    } else {
                        $Status = $null
                    }
                    $Event.Add('Status',$Status)

                    $EventMessageLines = $Event.Message.Split("`n")
                    if ($EventMessageLines[0].Trim() -match '.+?details:$' ) {
                        $Details = $Event.Message -Split ("`n",2)
                        $DetailLines = $Details[1].Split("`n")
                        $Action = [PsCustomObject]::new()
                        foreach ($Line in $DetailLines) {
                            Add-Member -InputObject $Action -MemberType NoteProperty -Name $Line.Split(':')[0].Trim().Replace(' ','') -Value $Line.Split(':')[1].Trim()
                        }
                    } elseif ($EventMessageLines[0].Trim() -match '.+?:$' ) {
                        $Action = $EventMessageLines[0].Replace(':','').Trim()
                    } else {
                        $Action = $EventMessageLines[0].Trim()
                    }
                    $Event.Add('Action',$Action)
                    $Event.Add('EventType',(Get-GPEventType $Event.Id))

                    $GPOApplied = $GPOList = $null
                    switch ($Event.Id) {
                        5312 {
                            $GPOApplied = $true
                            $GPOList = $Event.DescriptionString.trim()
                        }
                        5313 {
                            $GPOApplied = $false
                            $GPOList = $Event.DescriptionString.trim()
                        }
                    }
                    $Event.Add('GPOApplied',$GPOApplied)
                    $Event.Add('GPOList',$GPOList)
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.GPOProcessingEvent' -PassThru
                }
                'KMSClientEvent' {
                    $KMSHost = $KMSHostPort = $ClientMachineID = $ClientTimestamp = $null
                    $CurrentActivationState = $LicenseStateExpirationMin = $LicenseStateExpiration = $null
                    $ProductSkuId = $ProductSkuName = $MinActivateCount = $KmsErrorCode = $KmsErrorMessage = $null
                    $CurrentActivationCount = $NextActivationAttempt = $null
                    $ActivationStatus = $ADActivationObjectName = $ADActivationObject = $null

                    $KmsEventData = ($Event.EventData.Data).Split(',')
                    switch ($Event.Id) {
                        12288 {
                            $KMSHost = $KmsEventData[2].Trim().Split(':')[0]
                            $KMSHostPort = $KmsEventData[2].Trim().Split(':')[1]
                            $ClientMachineID = $KmsEventData[3].Trim()
                            $ClientTimestamp = (Get-Date $KmsEventData[4].Trim())
                            $CurrentActivationState = (Get-KmsLicenseState -LicenseState $KmsEventData[6].Trim())
                            $LicenseStateExpirationMin = $KmsEventData[7].Trim()
                            $LicenseStateExpiration = (Get-Date $KmsEventData[4].Trim()).AddMinutes($KmsEventData[7].Trim())
                            $ProductSkuId = $KmsEventData[8].Trim()
                            $ProductSkuName = (Get-KmsProductSku -ProductSku $KmsEventData[8].Trim())
                            $MinActivateCount = $KmsEventData[9].Trim()
                            $KmsErrorCode = $KmsEventData[0].Trim()
                            $KmsErrorMessage = (Get-KmsErrorCode -ErrorCode $KmsEventData[0].Trim())
                        }
                        12289 {
                            if ($KmsEventData[2] -eq 1) {
                                $ActivationStatus = 'Successful'
                            } else {
                                $ActivationStatus = 'Failure'
                            }
                            $ClientTimestamp = (Get-Date $KmsEventData[7].Trim())
                            $CurrentActivationCount = $KmsEventData[4].Trim()
                            $NextActivationAttempt = (Get-Date $KmsEventData[7].Trim()).AddMinutes($KmsEventData[6].Trim())
                            $KmsErrorCode = $KmsEventData[0].Trim()
                            $KmsErrorMessage = (Get-KmsErrorCode -ErrorCode $KmsEventData[0].Trim())
                        }
                        12308 {
                            $ProductSkuId = $Event.EventData.Data[0]
                            $ProductSkuName = (Get-KmsProductSku -ProductSku $Event.EventData.Data[0])
                            $ActivationStatus = 'Active Directory Activation has succeeded.'
                            $ADActivationObjectName = $Event.EventData.Data[1]
                            $ADActivationObject = $Event.EventData.Data[2]
                        }
                    }

                    $Event.Add('KMSHost',$KMSHost)
                    $Event.Add('KMSHostPort',$KMSHostPort)
                    $Event.Add('ClientMachineID',$ClientMachineID)
                    $Event.Add('ClientTimestamp',$ClientTimestamp)
                    $Event.Add('CurrentActivationState',$CurrentActivationState)
                    $Event.Add('CurrentActivationCount',$CurrentActivationCount)
                    $Event.Add('LicenseStateExpirationMin',$LicenseStateExpirationMin)
                    $Event.Add('LicenseStateExpiration',$LicenseStateExpiration)
                    $Event.Add('NextActivationAttempt',$NextActivationAttempt)
                    $Event.Add('ActivationStatus',$ActivationStatus)
                    $Event.Add('ADActivationObjectName',$ADActivationObjectName)
                    $Event.Add('ADActivationObject',$ADActivationObject)
                    $Event.Add('ProductSkuId',$ProductSkuId)
                    $Event.Add('ProductSkuName',$ProductSkuName)
                    $Event.Add('MinActivateCount',$MinActivateCount)
                    $Event.Add('KmsErrorCode',$KmsErrorCode)
                    $Event.Add('KmsErrorMessage',$KmsErrorMessage)
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.KMSClientEvent' -PassThru
                }
                'KMSHostEvent' {
                    if ($Event.EventData.Data[6] -eq 0) { $IsClientVM = $false } else { $IsClientVM = $true }
                    $Event.Add('MinActivateCount',$Event.EventData.Data[2])
                    $Event.Add('ClientFqdn',$Event.EventData.Data[3])
                    $Event.Add('ClientMachineID',$Event.EventData.Data[4])
                    $Event.Add('ClientTimestamp',$Event.EventData.Data[5])
                    $Event.Add('IsClientVM',$IsClientVM)
                    $Event.Add('ProductSkuId', (Get-KmsLicenseState -LicenseState $Event.EventData.Data[7]))
                    $Event.Add('LicenseStateExpirationMin',$Event.EventData.Data[8])
                    $Event.Add('LicenseStateExpiration',(Get-Date $Event.EventData.Data[5]).AddMinutes($Event.EventData.Data[8]))
                    $Event.Add('ProductSkuId',$Event.EventData.Data[9])
                    $Event.Add('ProductSkuName',(Get-KmsProductSku -ProductSku $Event.EventData.Data[9]))
                    $Event.Add('KmsErrorCode',$Event.EventData.Data[1])
                    $Event.Add('KmsErrorMessage',(Get-KmsErrorCode -ErrorCode $Event.EventData.Data[1]))
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.KMSHostEvent' -PassThru
                }
                'KMSHostLicenseCheckEvent' {
                    $ActivationId = $Event.EventData.Data[1].Split(':')[1].Split(',')[0].Trim()
                    $Event.Add('ActivationId',$ActivationId)
                    $Event.Add('ApplicationName',(Get-KmsProductSku -ProductSku $ActivationId))
                    $Event.Add('LicensingStatusMessage',$Event.EventData.Data[1].Trim())
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.KMSHostLicenseCheckEvent' -PassThru
                }
                default {
                    New-Object -Property $Event -TypeName PSCustomObject | Add-Member -TypeName 'MyEvent.EventRecordType.Default' -PassThru
                }
            }
        }
    }

    end {
        $ComputerName = $Computers | Sort-Object -Unique
        if ($MachineNames.Count -gt 1) {
            $SystemCount = "$($ComputerName.Count) systems"
        } else {
            $SystemCount = "$($ComputerName.Count) system"
        }
        Write-Verbose -Message "Processed $EventCount EventLogRecords from $SystemCount"
        foreach ($System in $ComputerName) {
            Write-Verbose -Message $System
        }
    }
}