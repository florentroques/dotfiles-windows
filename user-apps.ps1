# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

# browsers
choco install GoogleChrome        --limit-output; <# pin; evergreen #> choco pin add --name GoogleChrome        --limit-output
choco install Firefox             --limit-output; <# pin; evergreen #> choco pin add --name Firefox             --limit-output

#utilities
choco install adobereader
choco install vlc
choco install 7zip.install
choco install jre8
choco install ccleaner
choco install avastfreeantivirus
choco install malwarebytes
choco install teamviewer
choco install zoom-client
choco install notepadplusplus.install
choco install libreoffice-fresh
choco install lastpass
choco install lastpass-chrome
choco install skype
choco install paint.net
choco install spotify
choco install gimp
choco install whatsapp
