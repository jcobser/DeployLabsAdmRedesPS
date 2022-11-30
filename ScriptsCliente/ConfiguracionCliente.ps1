###################################################
####
#### Autor: Juan Marcos Cobelo Serantes
####
####
#### Configuración de los primeros pasos para un 
#### cliente de dominio
####
####
####
#### Copiar el Script a Documentos\Scripts\
####
###################################################

Param (
    [Parameter(Mandatory=$true)] [int]$PuestoLaboratorio,
    [Parameter(Mandatory=$true)] [int]$NumeroEquipo,
    [Parameter(Mandatory=$false)] [switch]$IpEstatica
)


If ($PuestoLaboratorio -lt 0 -or $PuestoLaboratorio -gt 31){
    Write-host -ForegroundColor Cyan "Numero de puesto inválido (Entre 0 y 31)"
    break
}
If ($NumeroEquipo -lt 1 -or $NumeroEquipo -gt 99){
    Write-host -ForegroundColor Cyan "El numero del equipo debe estar entre 1 y 99"
    break
}
else {
    If ($Puesto -eq 0) { $strPuesto = "PROFE" } else { $strPuesto = "DOM" + $PuestoLaboratorio.ToString().PadLeft(2,'0') }
    [string] $strNumeroEquipo = $NumeroEquipo.ToString().PadLeft(4,'0')
    [string] $NetBiosCmp = "ZFN" + $strPuesto + $strNumeroEquipo
    [string] $NetBiosDOM = $strPuesto
    [string] $DOM        = $NetBiosDOM + ".LOCAL"
    $NumeroEquipo += 20
    [string] $Ip         = "172.16." + $PuestoLaboratorio + "." + ($NumeroEquipo)
    [string] $DefaultGw  = "172.16." + $PuestoLaboratorio + ".1"
    $DNS        = @("172.16." + $PuestoLaboratorio + ".254";"172.16." + $PuestoLaboratorio + ".253")
}


if ($IpEstatica){
    #Si no se pone estática se entiende que coje la dirección de DHCP de los servidores.
    New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress $Ip -DefaultGateway $DefaultGw -PrefixLength 24
    Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ($DNS -join ',')
}

#Unión del equipo al dominio
Add-Computer -Credential (Get-Credential) -DomainName $DOM

#Deshabilitar IPv6
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\TCPIP6\Parameters -Name "DisabledComponents" -PropertyType "DWORD" -Value 0x000000ff
New-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\TCPIP6\Parameters -Name "DisableIPSourceRouting" -PropertyType "DWORD" -Value 0x00000002

#Cambio de nombre del equipo
Rename-Computer $NetBiosCmp

Restart-computer