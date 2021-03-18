cd $PSScriptRoot

Invoke-Expression "& 'C:\Program Files\Git\usr\bin\ls.exe'"
Invoke-Expression "& 'C:\Program Files\nodejs\npm.cmd' install"
Invoke-Expression "& 'C:\Users\Administrator\AppData\Roaming\npm\yarn.cmd'"
Invoke-Expression "& 'C:\Users\Administrator\AppData\Roaming\npm\yarn.cmd' package"
