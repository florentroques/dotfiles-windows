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

Set-Alias ds  Start-Containers
Set-Alias dd  Stop-Containers # dd = docker down
Set-Alias dsb  Start-ContainerBash 
Set-Alias drm  Remove-StoppedContainers
Set-Alias drmf  Remove-AllContainers
Set-Alias dip  Get-ContainerIPAddress
Set-Alias d2h  Add-ContainerIpToHosts
