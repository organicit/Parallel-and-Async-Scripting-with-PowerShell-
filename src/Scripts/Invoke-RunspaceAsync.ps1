
function Invoke-RunspaceAsync {
  [CmdletBinding()]
  param (
  [Parameter(ValueFromPipeline)]
  $InputObject,
  [Parameter(Mandatory)]
  [scriptblock]
  $ScriptBlock,
  [AllowNull()]
  [System.Management.Automation.Runspaces.RunspacePool]
  $RunspacePool
  )

  BEGIN {
    $rspaces = @()
  }

  PROCESS {
    $space = [PowerShell]::Create().AddScript($ScriptBlock).AddArgument($InputObject)
    if($RunspacePool) {
          $space.RunspacePool = $RunspacePool
    }

    $rspaces += @{
      Instance = $space
      Handle = $space.BeginInvoke()
    }
  }

  END {
    $stillProcessing = $true
    while($stillProcessing) {
      $stillProcessing = $false
      for($i=0; $i -lt $rspaces.Count; $i++) {
        $rspace = $rspaces[$i]
        if($rspace) {
          if($rspace.Handle.IsCompleted) {
            $rspace.Instance.EndInvoke($rspace.Handle)
            $rspace.Instance.Dispose()
            $rspaces[$i] = $null
          }
          else {
            $stillProcessing = $true
          }
        }
      }
    }
  }
}