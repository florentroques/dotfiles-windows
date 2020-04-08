# dotfiles-windows

### How to install

> **Note:** You must have your execution policy set to unrestricted (or at least in bypass) for this to work. To set this, run `Set-ExecutionPolicy Unrestricted` from a PowerShell running as Administrator.

To install these dotfiles from PowerShell without Git:

```bash
iex ((new-object net.webclient).DownloadString('https://raw.github.com/florentroques/dotfiles-windows/master/setup/install.ps1'))
```

To update later on, just run that command again.

### Inspired from:    
https://github.com/jayharris/dotfiles-windows  
https://github.com/mikemaccana/powershell-profile



> **Note:** To create Powershell functions, it is recommended to follow the
"Approved Verbs for PowerShell Commands" naming scheme.  
See:
https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7


---

To list locally installed chocolatey packages
```powershell
choco list --local-only
```
or
```powershell
clist -l
```

### See also
- To customize Powershell  
https://github.com/pecigonzalo/Oh-My-Posh  
https://github.com/JanDeDobbeleer/oh-my-posh  
Note: had tried https://github.com/pecigonzalo/Oh-My-Posh which seemed to run better

- Carbon, Powerful Powershell module:  
http://get-carbon.org/  
https://github.com/webmd-health-services/Carbon/



