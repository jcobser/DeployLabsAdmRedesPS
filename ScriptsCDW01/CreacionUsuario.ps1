<#

Les dejo este script para que no tengan problemas a la hora de 
copiar y pegar desde el pdf

Deben cambiar la cadena de caracteres <DOMINIO> 
por el nombre que le hayan puesto a su dominio

El símbolo ` está seguido de un [Enter] para poder romper la sentencia en varias líneas 
y hacer que quede más vistoso el script. Este símbolo es el acento que está al lado de la [P]

GUARDEN EL FICHERO COMO CreacionUsuario.ps1 
EN LA MISMA RUTA QUE EL CSV PARA PODER EJECUTAR LA SENTENCIA DE Import-Csv del manual 
de laboratorio

#>

Param ([Parameter(Mandatory=$true)] [string]$Nombre,
[Parameter(Mandatory=$true)] [string]$Apellido1,
[Parameter(Mandatory=$true)] [string]$Apellido2,
[Parameter(Mandatory=$true)] [string]$Logon)
$Dominio=(Get-ADDomain).DNSRoot
New-ADUser -DisplayName "$Nombre $Apellido1 $Apellido2" `
-GivenName "$Nombre" `
-Surname "$Apellido1 $Apellido2" `
-Name "$Nombre $Apellido1 $Apellido2" `
-SamAccountName "$Logon" `
-UserPrincipalName:"$Logon@$Dominio" `
-ChangePasswordAtLogon $false `
-PasswordNeverExpires $true `
-AccountPassword (ConvertTo-SecureString -AsPlainText -String "UsrP@55w0rd" -Force) `
-Enabled $true
