@echo off
set DOCKER_IMAGE=leon/usd-from-gltf:latest

set /p INPUT_FOLDER="Enter input folder path: "

REM Replace backslashes with forward slashes in input folder path
set INPUT_FOLDER=%INPUT_FOLDER:\=/%

REM Change working directory to input folder
cd /d "%INPUT_FOLDER%"

REM Get the current user's SID
for /f "tokens=2 delims= " %%a in ('whoami /user /nh') do set SIDS=%%a
set SIDS=%SIDS:-=%

REM Extract the RID (relative identifier) from the SID and calculate the UID and GID
set /a RID=%SIDS:~-4%
set /a UID=%RID%+1000
set /a GID=%RID%+513

REM Run the conversion loop with the manually set UID and GID values
for %%i in (*.glb) do (
    echo Converting "%%i" to USDZ...
    docker run --rm -v "%CD%:/usr/app" --user %UID%:%GID% %DOCKER_IMAGE% "%%i" "/usr/app/%%~ni.usdz"
    echo Output file saved as: %CD%\%%~ni.usdz
)

REM Change working directory back to original directory
cd /d "%~dp0"

echo Done!
