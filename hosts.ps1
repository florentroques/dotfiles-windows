##########
# Local Hosts management
# Functions to add, remove, print hosts from the hosts file
# located at C:\Windows\system32\drivers\etc\hosts
#
# Requirements:
# Carbon module
# > http://get-carbon.org/about_Carbon_Installation.html
##########

Import-Module 'Carbon'

function Add-Host() {
    param(
        [Parameter(Mandatory=$true)][string]$ip,
        [Parameter(Mandatory=$true)][string]$hostname,
        [Parameter(Mandatory=$false)][string]$description
    )

    #Set-HostsEntry from Get Carbon package
    Set-HostsEntry -IPAddress $ip -HostName $hostname -Description description
}

function Remove-Host([string]$hostname) {
    #Remove-HostsEntry from Get Carbon package
	Remove-HostsEntry -HostName $hostname
}

function Get-Hosts() {
    #Get-PathToHostsFile from Get Carbon package
    $hostsFilePath = Get-PathToHostsFile
    Get-Content $hostsFilePath
}

function Edit-Hosts() {
    $hostsFilePath = Get-PathToHostsFile
    code $hostsFilePath
}

Set-Alias ha Add-Host
Set-Alias hrm Remove-Host
Set-Alias hg Get-Hosts
Set-Alias he Edit-Hosts
