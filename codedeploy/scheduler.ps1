#
# scheduler.ps1
#
# Este script se encarga de configurar la tarea programada
# en la cual se ejecutara el script "builder.ps1".
#
# Una vez que se agenda la tarea programada, 
# se esperara a que esta termine.
#
# Nota: La maquina debe tener activado "autologon", 
# para que la tarea programada se ejecuta en primer plano.
#

$HOUR = (Get-Date).AddMinutes(1).ToString("HH:mm")

schtasks.exe /CREATE /SC ONCE /TN "builder" /TR "powershell.exe $PSScriptRoot\builder.ps1" /ST $HOUR /RU administrator /F

while ((Get-ScheduledTask -TaskName 'builder').State  -ne 'Running') {
    Write-Output "Waiting on scheduled task builder to be started..."
    Start-Sleep 1
}

while ((Get-ScheduledTask -TaskName 'builder').State  -ne 'Ready') {
    Write-Output "Waiting on scheduled task builder to be stopped..."
    Start-Sleep 5
}
