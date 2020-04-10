# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

### Update Help for Modules
# Write-Host "Updating Help..." -ForegroundColor "Yellow"
# Update-Help -Force

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

#choco upgrade achieves install if the package is not installed and upgraded if there is a newer version in your sources
#https://stackoverflow.com/a/47543832/1152843

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
choco upgrade chocolateygui -y
choco upgrade mkcert -y #easy way to create valid https certificates for localhost
choco upgrade picpick.portable -y #screenshot and editing tool

#nodejs tools
choco upgrade yarn -y
choco upgrade nodejs -y
npm install -g npx

#install vscode extensions, her emainly for php
code --install-extension be5invis.toml
code --install-extension bmewburn.vscode-intelephense-client
code --install-extension csicar.key-proof-language
code --install-extension dbaeumer.vscode-eslint
code --install-extension donjayamanne.githistory
code --install-extension eamodio.gitlens
code --install-extension EditorConfig.EditorConfig
code --install-extension fabiospampinato.vscode-install-vsix
code --install-extension felixfbecker.php-debug
code --install-extension felixfbecker.php-intellisense
code --install-extension felixfbecker.php-pack
code --install-extension geeksharp.openssl-configuration-file
code --install-extension junstyle.php-cs-fixer
code --install-extension kokororin.vscode-phpfmt
code --install-extension MehediDracula.php-namespace-resolver
code --install-extension mgmcdermott.vscode-language-babel
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension ms-vscode.powershell
code --install-extension neilbrayfield.php-docblocker
code --install-extension Nixon.env-cmd-file-syntax
code --install-extension OfHumanBondage.react-proptypes-intellisense
code --install-extension pflannery.vscode-versionlens
code --install-extension Prisma.prisma
code --install-extension walkme.PHP-extension-pack
code --install-extension whatwedo.twig
code --install-extension wix.vscode-import-cost
