##########
#Docker functions and aliases
##########

#Docker-compose
function Start-Containers {docker-compose -f .\docker-compose.yml up --build -d --remove-orphans }
function Stop-Containers { docker-compose -f .\docker-compose.yml down --remove-orphans -v }
function Start-ContainerBash {
    param (
		[string] $containerName
    )
    
    docker exec -it $containerName /bin/bash
}
function Start-ContainerShell {
    param (
		[string] $containerName
    )
    
    docker exec -it $containerName /bin/sh
}
function Remove-StoppedContainers {
	docker container rm $(docker container ls -q)
}
function Remove-AllContainers {
	docker container rm -f $(docker container ls -aq)
}
function Get-ContainerIPAddress {
	param (
		[string] $id
	)
	& docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id
}
function Add-ContainerIpToHosts {
	param (
		[string] $name
	)
	$ip = docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $name
	$newEntry = "$ip  $name  #added by d2h# `r`n"
	$path = 'C:\Windows\System32\drivers\etc\hosts'
	$newEntry + (Get-Content $path -Raw) | Set-Content $path
}
function Write-DockerProcesses {
	docker ps
}

function Stop-DockerDesktop {
	$processes = Get-Process "*docker desktop*"
	if ($processes.Count -gt 0)
	{
			$processes[0].Kill()
			$processes[0].WaitForExit()
	}
}

function Start-DockerDesktop {
	Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
}
function Restart-DockerDesktop {
	Stop-DockerDesktop
	Start-DockerDesktop
}


Set-Alias ds    Start-Containers
Set-Alias dd    Stop-Containers # dd = docker down
Set-Alias dsb   Start-ContainerBash
Set-Alias dss   Start-ContainerShell 
Set-Alias drm   Remove-StoppedContainers
Set-Alias drmf  Remove-AllContainers
Set-Alias dip   Get-ContainerIPAddress
Set-Alias d2h   Add-ContainerIpToHosts
Set-Alias dps		Write-DockerProcesses
Set-Alias doff Stop-DockerDesktop
Set-Alias don Start-DockerDesktop
Set-Alias drestart Restart-DockerDesktop
