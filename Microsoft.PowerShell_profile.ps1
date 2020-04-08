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



foreach ( $includeFile in ("aws", "defaults", "openssl", "aws", "unix", "development", "node") ) {
	Unblock-File $profileDir\$includeFile.ps1
. "$profileDir\$includeFile.ps1"
}

#start Powershell directly in $defaultSessionPath folder
Set-Location $defaultSessionPath
