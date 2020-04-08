# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

### Update Help for Modules
Write-Host "Updating Help..." -ForegroundColor "Yellow"
Update-Help -Force

### Install PowerShell Modules
Write-Host "Installing PowerShell Modules..." -ForegroundColor "Yellow"
Install-Module Posh-Git -Scope CurrentUser -Force
Install-Module PSWindowsUpdate -Scope CurrentUser -Force

### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

#using choco upgrade on evergreen apps like chrome is redundant
#pinning choco packages ignores them in choco upgrade

# browsers
choco install GoogleChrome        --limit-output; <# pin; evergreen #> choco pin add --name GoogleChrome        --limit-output
choco install GoogleChrome.Canary --limit-output; <# pin; evergreen #> choco pin add --name GoogleChrome.Canary --limit-output
choco install Firefox             --limit-output; <# pin; evergreen #> choco pin add --name Firefox             --limit-output
choco install Opera               --limit-output; <# pin; evergreen #> choco pin add --name Opera               --limit-output
