# dotfiles-windows
A collection of PowerShell files for Windows, including common application installation through Chocolatey

### How to install

> **Note:** You must have your execution policy set to unrestricted (or at least in bypass) for this to work. To set this, run `Set-ExecutionPolicy Unrestricted` from a PowerShell running as Administrator.

To install these dotfiles from PowerShell without Git:

```powershell
iex ((new-object net.webclient).DownloadString('https://raw.github.com/florentroques/dotfiles-windows/master/setup/install.ps1'))
```

To update later on, just run that command again.


### Install dev dependencies and packages

```posh
iex ((new-object net.webclient).DownloadString('https://raw.github.com/florentroques/dotfiles-windows/master/dev-deps.ps1'))
```

> The scripts will install Chocolatey, node.js, and WebPI if necessary.

### Install user apps

```posh
iex ((new-object net.webclient).DownloadString('https://raw.github.com/florentroques/dotfiles-windows/master/user-apps.ps1'))
```

> **Note:** To create Powershell functions, it is recommended to follow the
"Approved Verbs for PowerShell Commands" naming scheme.  
See:
https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7


---

To list locally installed chocolatey packages
```powershell
choco list --local-only
```

---

### Inspired from:    
https://github.com/jayharris/dotfiles-windows  
https://github.com/mikemaccana/powershell-profile

### How to start a powershell script at startup
see https://blog.netwrix.com/2018/07/03/how-to-automate-powershell-scripts-with-task-scheduler/#text-post

### See also
- To customize Powershell  
https://github.com/pecigonzalo/Oh-My-Posh  
https://github.com/JanDeDobbeleer/oh-my-posh  
Note: had tried https://github.com/pecigonzalo/Oh-My-Posh which seemed to run better

- Carbon, Powerful Powershell module:  
http://get-carbon.org/  
https://github.com/webmd-health-services/Carbon/
