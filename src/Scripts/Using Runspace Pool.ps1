$rsPool = New-RunspacePool -MaxSize 4
0..20 | Invoke-RunspaceAsync -ScriptBlock {
  param (
  [int]$SequenceNumber
  )
  Start-Sleep -Seconds 3
  Write-Output -InputObject "Runspace $SequenceNumber Finished"
} -RunspacePool $rsPool


$rsPool = New-RunspacePool -MaxSize 10
0..50 | Invoke-RunspaceAsync -ScriptBlock {
  param (
  [int]$SequenceNumber
  )
  Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 5)
  Write-Output -InputObject "Runspace $SequenceNumber Finished"
} -RunspacePool $rsPool


$rsPool = New-RunspacePool -MaxSize 2
'google.com', 'yahoo.com' | Invoke-RunspaceAsync -ScriptBlock {
  param (
  [string]$ComputerName
  )
  Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 2)
  Test-Connection -ComputerName $ComputerName
} -RunspacePool $rsPool


$rsPool = New-RunspacePool -MaxSize 4
0..10 | Invoke-RunspaceAsync -ScriptBlock {
  param (
  [int]$SequenceNumber
  )
  $spaceVariable++
  Write-Output -InputObject ( [PSCustomObject] @{ 
    SequenceNumber = $SequenceNumber
    SpaceVariable = $spaceVariable 
  })
} -RunspacePool $rsPool |
Format-Table -AutoSize