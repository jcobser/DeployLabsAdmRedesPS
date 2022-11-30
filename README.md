# DeployLabsAdmRedesPS
Scritps para la implementación rápida de dos controladores de dominio en un aula. 
## Implementación
Se deben copiar los scrips de cada servidor (CDW01 y CDW02) en la carpeta de documentos del "Administrador"
> Cada script de CDW01 y CDW02 creará un registro para lanzar el siguiente.

### Scripts de ScriptsCDW01
|Paso | Script | Observaciones |
|:-:|--------|--------------|
| 1 | ConfiguracionPuesto.ps1 | .\ConfiguracionPuesto -Puesto (1..31) |
| 2 | PromocionCDw01.ps1 | Se lanza automáticamente al reiniciar el servidor cuando lo pide el paso anterior | 
| 3 | PostInstForest.ps1 | Se lanza automáticamente al reiniciar el servidor cuando lo pide el paso anterior |

Los demás scripts son necesarios por los scripts de los pasos.

### Scripts de ScriptsCDW02
|Paso | Script | Observaciones |
|:-:|--------|--------------|
| 1 | ConfiguracionCDW02Puesto.ps1 | .\ConfiguracionCDW02Puesto -Puesto (1..31) |
| 2 | PromocionCDw02.ps1 | Se lanza automáticamente al reiniciar el servidor cuando lo pide el paso anterior | 

### Scripts de ServidorFicheros
|Paso | Script | Observaciones |
|:-:|--------|--------------|
| 1 | ServFicheros.ps1 | .\ServFicheros.ps1 se lanza en el servidor de ficheros después de crear un volumen llamado G: |
| 2 | FSRMQuotas.ps1 | .\FSRMQuotas Se lanza en el servidor de ficheros después de ejecutado el paso 1 | 

- **CreaGrupoTrabajo.ps1** crea los grupos necesarios y la carpeta de grupo de trabajo dentro del servidor de ficheros.
- **CreacionCarpetaParticular.ps1** crea la carpeta particular del usuario según la normativa.


### Scripts en Cliente
|Paso | Script | Observaciones |
|:-:|--------|--------------|
| 1 | ConfiguracionCliente.ps1 | .\Configuracioncliente -PuestoLaboratorio (1..31) -NumeroEquipo (0..99) -IpEstatica |

El script genera automáticamente el nombre del cliente Windows a partir del número de puesto de laboratorio (igual que el puesto de CDW01 y CDW02), y el número de equipo. Para la dirección IP se suma 20 al número de equipo para que no coincidan las IPs.

> El script no controla duplicados de nombres.

**Sintaxis**

```powershell
.\configuracioncliente.ps1 -PuestoLaboratorio __integer__ -NumeroEquipo __integer__ [-IpEstatica]
```

**Ejemplo**

```powershell
.\configuracioncliente.ps1 -PuestoLaboratorio 12 -NumeroEquipo 12 -IpEstatica
```
