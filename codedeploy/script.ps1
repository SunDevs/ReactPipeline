#
# Get into the caller script folder
#
cd $PSScriptRoot

#
# Set the PATH environment variable
#
$env:Path = "C:\Python39\Scripts\;C:\Python39\;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Amazon\cfn-bootstrap\;C:\Program Files\nodejs\;C:\ProgramData\chocolatey\bin;C:\Program Files\Git\cmd;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;C:\Users\Administrator\AppData\Roaming\npm;C:\Program Files\Git\usr\bin;C:\Program Files\Git\mingw64\libexec\git-core;"; 

#
# Install dependencies
#
npm install
yarn

#
# Package the source
#
yarn package
