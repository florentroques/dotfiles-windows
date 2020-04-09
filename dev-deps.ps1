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

choco sync

#using choco upgrade on evergreen apps like chrome is redundant
#pinning choco packages ignores them in choco upgrade

# browsers
choco upgrade GoogleChrome -y        --limit-output; <# pin; evergreen #> choco pin add --name GoogleChrome        --limit-output
choco upgrade GoogleChrome.Canary -y --limit-output; <# pin; evergreen #> choco pin add --name GoogleChrome.Canary --limit-output
choco upgrade Firefox -y             --limit-output; <# pin; evergreen #> choco pin add --name Firefox             --limit-output
choco upgrade Opera -y               --limit-output; <# pin; evergreen #> choco pin add --name Opera               --limit-output

choco upgrade filezilla -y
choco upgrade github-desktop -y
choco upgrade docker-desktop -y
choco upgrade vscode -y
choco upgrade postman -y
choco install chocolateygui
