Get-Process -Name powershell
$PSJob = Start-Job -Name PSJob -ScriptBlock { $appdomain = [System.AppDomain]::CurrentDomain ; write-output $appdomain ; while($true){Start-Sleep -Seconds 2}}
$PSJob | Format-List
$PSJob | Receive-Job
Get-Process -Name powershell
$PSJob | Stop-Job
Get-Job
$PSJob | Remove-Job
Get-Job
