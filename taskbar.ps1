# this module requires chocolatey-core.extension installed
# import-module $Env:ChocolateyInstall\extensions\chocolatey-core\Get-AppInstallLocation.ps1

function Write-TaskbarShortcuts {
  Begin{
    $userName = [Environment]::UserName
    $path = "C:\Users\$userName\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
    $x=0
  } # End of Begin

  Process {
    $TaskbarShortcuts = Get-ChildItem $path -Recurse -Include *.lnk
    
    ForEach($ShortCut in $TaskbarShortcuts) {
      $Shell = New-Object -ComObject WScript.Shell 
      $Properties = @{
        ShortcutName = $Shortcut.Name 
        LinkTarget = $Shell.CreateShortcut($Shortcut).targetpath 
      }
      
      New-Object PSObject -Property $Properties 
      $x ++
      # Write-Host $ShortCut
    } #End of ForEach
    
    [Runtime.InteropServices.Marshal]::ReleaseComObject($Shell) | Out-Null
  } # End of Process

  End{}
}

function Get-TaskbarShortcutPath {
  param(
      [Parameter(Mandatory=$true)][string]$appName
  )

  $userName = [Environment]::UserName
  $path = "C:\Users\$userName\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"

  return (Get-ChildItem $path -Recurse -Include "*$appName*.lnk").FullName
}

function Set-UnpinTaskbarApp {
  param(
      [Parameter(Mandatory=$true)][string]$appNameOrPath
  )

  if (!(Test-Path "$appNameOrPath")) {
    $appNameOrPath = Get-TaskbarShortcutPath($appNameOrPath)

    if (!(Test-Path "$appNameOrPath")) {
      Write-Host "Cound not find a shortcut for $appNameOrPath"
    }
  }
  
  . "$PSScriptRoot\PinToTaskBar1903.ps1" $appNameOrPath "UNPIN"
}
Set-Alias unpintba Set-UnpinTaskbarApp

function Set-PinTaskbarApp {
  param(
      [Parameter(Mandatory=$true)][string]$appPath
  )

  # TODO 
  # see https://superuser.com/questions/786024/is-there-a-way-to-list-chocolatey-packages-with-their-install-directory
  # Note: Get-AppInstallLocation (import comment on top in this script)
  # gives app folder path when there is a match (not all the time)
  # but not the exact executable name
  # thus we can pin app only when we have full app path

  if (!(Test-Path "$appPath")) {
    Write-Host "Cound not find an app at $appPath"
  } 

  . "$PSScriptRoot\PinToTaskBar1903.ps1" $appPath "PIN"
}
Set-Alias pintba Set-PinTaskbarApp
