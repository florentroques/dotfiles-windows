function Verify-Elevated {
    # Get the ID and security principal of the current user account
    $myIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $myPrincipal=new-object System.Security.Principal.WindowsPrincipal($myIdentity)
    # Check to see if we are currently running "as Administrator"
    return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

# Reload the $env object from the registry
function Refresh-Environment {
    $locations = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
                 'HKCU:\Environment'

    $locations | ForEach-Object {
        $k = Get-Item $_
        $k.GetValueNames() | ForEach-Object {
            $name  = $_
            $value = $k.GetValue($_)
            Set-Item -Path Env:\$name -Value $value
        }
    }

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

# browsers
choco upgrade GoogleChrome -y        --limit-output; <# pin; evergreen #> choco pin add --name GoogleChrome        --limit-output
choco upgrade Firefox -y             --limit-output; <# pin; evergreen #> choco pin add --name Firefox             --limit-output

#utilities
choco upgrade adobereader -y
choco upgrade vlc -y
choco upgrade 7zip.install -y
choco upgrade jre8 -y
choco upgrade ccleaner -y
choco upgrade avastfreeantivirus -y
choco upgrade malwarebytes -y
choco upgrade teamviewer -y
choco upgrade zoom-client -y
choco upgrade notepadplusplus.install -y
choco upgrade libreoffice-fresh -y
choco upgrade lastpass -y
choco upgrade lastpass-chrome -y
choco upgrade skype -y
#choco upgrade paint.net -y
#choco upgrade spotify -y
#choco upgrade gimp -y
#choco upgrade whatsapp -y
choco upgrade ublockorigin-chrome -y
choco upgrade ublockorigin-firefox -y
