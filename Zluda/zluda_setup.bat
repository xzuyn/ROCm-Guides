@echo off

REM Create the "SD-Zluda" folder
mkdir "SD-Zluda"

REM Change directory to "SD-Zluda"
cd "SD-Zluda"

REM Download the latest release zip file of Zluda and save its name
for /f "delims=" %%i in ('powershell -Command "$latestRelease = Invoke-RestMethod -Uri https://api.github.com/repos/lshqqytiger/ZLUDA/releases/latest; $asset = $latestRelease.assets | Where-Object { $_.name -like '*.zip' } | Select-Object -First 1; Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $asset.name; Write-Output $asset.name"') do set "fileName=%%i"

REM Extract the downloaded zip file
powershell -Command "$folderName = [System.IO.Path]::GetFileNameWithoutExtension('%fileName%'); Expand-Archive -Path '%fileName%' -DestinationPath $folderName"

REM Delete the zip file
powershell -Command "Remove-Item -Path '%fileName%'"

REM Clone the repository and initialize submodules
git clone https://github.com/lshqqytiger/stable-diffusion-webui-directml
cd stable-diffusion-webui-directml
git submodule init
git submodule update

REM Adding the needed flags to the webui-user.bat file
echo set COMMANDLINE_ARGS=--use-zluda --medvram-sdxl --update-all-extensions --update-check --skip-ort --no-download-sd-model >> webui-user.bat

REM Launch the webui-user.bat file
start webui-user.bat

