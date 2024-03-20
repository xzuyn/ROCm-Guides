@echo off

REM Create the "SD-Zluda" folder
mkdir "SD-Zluda"

REM Change directory to "SD-Zluda"
cd "SD-Zluda"

REM Download the latest release zip file of Zluda and save its name
for /f "delims=" %%i in ('powershell -Command "$latestRelease = Invoke-RestMethod -Uri https://api.github.com/repos/lshqqytiger/ZLUDA/releases/latest; $asset = $latestRelease.assets | Where-Object { $_.name -like '*.zip' } | Select-Object -First 1; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $asset.name; Write-Output $asset.name"') do set "fileName=%%i"

REM Extract the downloaded zip file
for /f "delims=" %%i in ('powershell -Command "$folderName = [System.IO.Path]::GetFileNameWithoutExtension('%fileName%'); Write-Output $folderName; Expand-Archive -Path '%fileName%' -DestinationPath $folderName"') do set "folderName=%%i"

for /f "delims=" %%i in ('powershell -Command "Resolve-Path %folderName%"') do set "folderPath=%%i"

REM Delete the zip file
powershell -Command "Remove-Item -Path '%fileName%'"

REM Clone the repository and initialize submodules
git clone https://github.com/lshqqytiger/stable-diffusion-webui-directml
cd stable-diffusion-webui-directml
git submodule init
git submodule update

REM Adding the needed flags to the webui-user.bat file
powershell -Command "(Get-Content webui-user.bat) | ForEach-Object { $_ -replace 'set COMMANDLINE_ARGS=', 'set COMMANDLINE_ARGS=--use-zluda --medvram-sdxl --update-all-extensions --update-check --skip-ort --no-download-sd-model' } | Set-Content webui-user.bat"

REM Modify the webui-user.bat file
powershell -Command "$specificLine = 'set COMMANDLINE_ARGS='; $newLines = 'set PATH=%PATH%;%folderPath%;%HIP_PATH%\bin'; $found=$false; (Get-Content webui-user.bat) | ForEach-Object { if ($_ -match $specificLine) { $found=$true }; $_; if ($found) { $newLines; $found=$false } } | Set-Content webui-user-temp.bat; Move-Item -Path webui-user-temp.bat -Destination webui-user.bat -Force"

REM Launch the webui-user.bat file
start webui-user.bat

