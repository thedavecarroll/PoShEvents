function New-EventDataFilter {
    [CmdLetBinding()]
    param(
        [hashtable]$Hashtable
    )

    $EventDataFilter = [System.Text.StringBuilder]::new()
    foreach ($DataType in $Hashtable.Keys) {
        [void]$EventDataFilter.Append('*[{0}' -f $DataType)
        foreach ($FilterType in $Hashtable[$DataType].Keys) {
            [void]$EventDataFilter.Append('[{0}[' -f $FilterType)

            $FilterList = [System.Collections.Generic.List[System.String]]::new()
            if ($Hashtable[$DataType][$FilterType].Keys -contains 'Name') {
                $FilterList.Add('@Name="{0}"]' -f $Hashtable[$DataType][$FilterType]['Name'] )
                $Hashtable[$DataType][$FilterType].Remove('Name')
            }

            foreach ($Filter in $Hashtable[$DataType][$FilterType].Keys) {
                $ArrayList = [System.Collections.Generic.List[System.String]]::new()
                if ($Hashtable[$DataType][$FilterType][$Filter] -is [array]) {
                    foreach ($ItemFromArray in $Hashtable[$DataType][$FilterType][$Filter] ) {
                        if ($ItemFromArray -is [int]) {
                            $ArrayList.Add(('({0}={1})' -f $Filter,$ItemFromArray))
                        } else {
                            $ArrayList.Add(('({0}="{1}")' -f $Filter,$ItemFromArray))
                        }
                    }
                    $FilterList.Add('({0})' -f ($ArrayList -join ' and '))
                } else {
                    if ($Hashtable[$DataType][$FilterType][$Filter] -is [int]) {
                        $ArrayList.Add(('({0}={1})' -f $Filter,$Hashtable[$DataType][$FilterType][$Filter]))
                    } else {
                        $ArrayList.Add(('({0}="{1}")' -f $Filter,$Hashtable[$DataType][$FilterType][$Filter]))
                    }
                    $FilterList.Add('{0}' -f ($ArrayList -join ' and '))
                }
            }
            [void]$EventDataFilter.Append($FilterList -join ' and ')
        }
        $BeginBrace = $EventDataFilter.ToString().Split('[').Count -1
        $EndBrace = $EventDataFilter.ToString().Split(']').Count -1
        $AppendBrace = ']' * ($BeginBrace - $EndBrace)
        [void]$EventDataFilter.Append($AppendBrace)
    }

    $EventDataFilter.ToString()
}
