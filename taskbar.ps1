function Get-TaskbarShortcuts
{
Begin{
  Clear-Host
        $userName = [Environment]::UserName
        $Path = "C:\Users\$userName\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
        $x=0
      } # End of Begin

Process
    {
        $TaskbarShortcuts = Get-ChildItem $Path -Recurse -Include *.lnk
            ForEach($ShortCut in $TaskbarShortcuts)
            {
                $Shell = New-Object -ComObject WScript.Shell 
                    $Properties = @{
                    ShortcutName = $Shortcut.Name 
                    LinkTarget = $Shell.CreateShortcut($Shortcut).targetpath 
                                    }
                New-Object PSObject -Property $Properties 
                $x ++
                Write-Host $ShortCut
            } #End of ForEach
        [Runtime.InteropServices.Marshal]::ReleaseComObject($Shell) | Out-Null
    } # End of Process
  End{}
}
