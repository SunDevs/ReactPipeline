#
# builder.ps1
#
# Este script se encarga de construir el programa,
# la ejecucion viene dada desde la tarea programada,
# que se ejecuta en "scheduler.ps1".
#

cd $PSScriptRoot

$env:Path = "C:\Python39\Scripts\;C:\Python39\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Amazon\cfn-bootstrap\;C:\Program Files\nodejs\;C:\ProgramData\chocolatey\bin;C:\Program Files\Git\cmd;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;C:\Users\Administrator\AppData\Roaming\npm;C:\Program Files\Git\usr\bin;C:\Program Files\Git\mingw64\libexec\git-core;"; 

npm install

yarn
yarn package
