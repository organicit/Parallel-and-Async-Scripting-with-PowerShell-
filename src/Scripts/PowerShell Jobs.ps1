Get-Process -Name powershell
$PSJob = Start-Job -Name PSJob -ScriptBlock { $appdomain = [System.AppDomain]::CurrentDomain.GetType() ; $appdomain.GetType() ; write-output $appdomain }
$PSJob | Format-List
$PSJob | Receive-Job
Get-Process -Name powershell
$PSJob | Stop-Job
Get-Job
$PSJob | Remove-Job
Get-Job
