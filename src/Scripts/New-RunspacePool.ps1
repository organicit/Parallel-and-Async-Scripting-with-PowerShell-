function New-RunspacePool {
  [CmdletBinding()]
  param (
  [Parameter(
    Mandatory,
    HelpMessage='Maximum number of runspaces that can be allocated to this pool'
  )]
  [ValidateRange(1, 40)]
  [int]
  $MaxSize,
  [System.Management.Automation.Runspaces.InitialSessionState]
  $InitialSessionState
  )

  END {
    if($InitialSessionState -eq $null) {
      $InitialSessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
    }
    $pool = [Runspacefactory]::CreateRunspacePool(1, $MaxSize, $InitialSessionState, $Host)
    $pool.open()
    Write-Output $pool
  }
}