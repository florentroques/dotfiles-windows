$profileDir = $PSScriptRoot;
$defaultSessionPath = "$HOME/Documents/Github"

# Edit whole dir, so we can edit included files etc
function edit-powershell-profile {
	edit $profileDir
}

# Kinda like $EDITOR in nix
# TODO: check out edit-file from PSCX
# You may prefer eg 'subl' or 'code' or whatever else
function edit {
	& "code" -g @args
}

# From http://stackoverflow.com/questions/7330187/how-to-find-the-windows-version-from-the-powershell-command-line
function get-windows-build {
	[Environment]::OSVersion
}

function get-serial-number {
  Get-CimInstance -ClassName Win32_Bios | select-object serialnumber
}

function get-process-for-port($port) {
	Get-Process -Id (Get-NetTCPConnection -LocalPort $port).OwningProcess
}

function Verify-Elevated {
    # Get the ID and security principal of the current user account
    $myIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent()
    $myPrincipal=new-object System.Security.Principal.WindowsPrincipal($myIdentity)
    # Check to see if we are currently running "as Administrator"
    return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

#show commands history
function hist {
    $find = $args;
    Write-Host "Finding in full history using {`$_ -like `"*$find*`"}";
    Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -like "*$find*"} | Get-Unique | more
}

#Reload Powershell profiles
function Invoke-PowershellProfiles {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost,
        $Profile
    ) | % {
        if(Test-Path $_){
            Write-Verbose "Running $_"
            . $_
        }
    }
}

#pr = powershell reload
Set-Alias pr Invoke-PowershellProfiles #Run as . pr otherwise doesn't reload profile(s)


function Edit-Profile {
    #launch current user powershell profile file in vscode for editing 
    code $PROFILE
}
#aliases
#pe = powershell edit
Set-Alias pe Edit-profile

#Import all subscripts in Powershell profile
Push-Location (Split-Path -parent $profile)
$subscripts = @(
 "aliases",
 "docker",
 "defaults",
 "unix",
)
$subscripts | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {Invoke-Expression ". .\$_.ps1"}
Pop-Location


#start Powershell directly in $defaultSessionPath folder
Set-Location $defaultSessionPath
