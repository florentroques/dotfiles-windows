# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
# PoSh won't allow ${function:..} because of an invalid path error, so...
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

function home { Set-Location $HOME }

# Navigation Shortcuts
${function:drop} = { Set-Location ~\Documents\Dropbox }
${function:dt} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:dl} = { Set-Location ~\Downloads }

#start vscode typing c
Set-Alias -Name c -Value code

# curl: Use `curl.exe` if available | needs curl installed via chocolatey before
if (Get-Command curl.exe -ErrorAction SilentlyContinue | Test-Path) {
    rm alias:curl -ErrorAction SilentlyContinue
    ${function:curl} = { curl.exe @args }
    # Gzip-enabled `curl`
    ${function:gurl} = { curl --compressed @args }
} else {
    # Gzip-enabled `curl`
    ${function:gurl} = { curl -TransferEncoding GZip }
}

function Get-PowershellVersion {
 Get-Host | Select-Object Version
}
Set-Alias psversion Get-PowershellVersion

# Get definition of function and echo the code
function def ($funcname) { (Get-Command $funcname).Definition }
