function Get-GPEventType($EventId) {
    switch ($EventId) {
        {$_ -ge 4000 -and $_ -le 4007} { 'GP Start' }
        {$_ -ge 4016 -and $_ -le 4299} { 'Component Start' }
        {$_ -ge 5000 -and $_ -le 5299} { 'Component Success' }
        {$_ -ge 5300 -and $_ -le 5999} { 'Informative' }
        {$_ -ge 6000 -and $_ -le 6007} { 'GP Warning '}
        {$_ -ge 6017 -and $_ -le 6299} { 'Component Warning' }
        {$_ -ge 6300 -and $_ -le 6999} { 'Informative Warning' }
        {$_ -ge 7000 -and $_ -le 7007} { 'GP Error' }
        {$_ -ge 7017 -and $_ -le 7299} { 'Component Error' }
        {$_ -ge 7300 -and $_ -le 7999} { 'Informative Start' }
        {$_ -ge 8000 -and $_ -le 8007} { 'GP Success' }
        default { 'Unknown' }
    }
}