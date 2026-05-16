@echo off
setlocal
echo ============================================
echo    Skyline Cafe - Portable Installer
echo ============================================

:: 1. Define Target Path (Install Location)
set "INSTALL_DIR=%USERPROFILE%\SkylineCafe"
echo Installing to: %INSTALL_DIR%

:: 2. Create Folders
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
if not exist "%INSTALL_DIR%\lib" mkdir "%INSTALL_DIR%\lib"
if not exist "%INSTALL_DIR%\src\cafe" mkdir "%INSTALL_DIR%\src\cafe"

:: 3. Copy Files
echo Copying files...
copy /Y "dist\CafeMS.jar" "%INSTALL_DIR%\" >nul
copy /Y "dist\sqlite-jdbc.jar" "%INSTALL_DIR%\" >nul
copy /Y "dist\slf4j-api-2.0.9.jar" "%INSTALL_DIR%\" >nul
copy /Y "dist\slf4j-simple-2.0.9.jar" "%INSTALL_DIR%\" >nul
copy /Y "src\cafe\logo.jpeg" "%INSTALL_DIR%\src\cafe\" >nul
if exist "logo.ico" copy /Y "logo.ico" "%INSTALL_DIR%\" >nul

:: 4. Create Desktop Shortcut using PowerShell
echo Creating Desktop shortcut...
set "SCRIPT_PATH=%TEMP%\create_shortcut.ps1"
echo $s = (New-Object -ComObject WScript.Shell).CreateShortcut([System.IO.Path]::Combine([Environment]::GetFolderPath('Desktop'), 'Skyline Cafe.lnk')) > "%SCRIPT_PATH%"
echo $s.TargetPath = 'javaw.exe' >> "%SCRIPT_PATH%"
echo $s.Arguments = '-cp ""%INSTALL_DIR%\CafeMS.jar;%INSTALL_DIR%\sqlite-jdbc.jar;%INSTALL_DIR%\slf4j-api-2.0.9.jar;%INSTALL_DIR%\slf4j-simple-2.0.9.jar"" cafe.ui.LoginFrame' >> "%SCRIPT_PATH%"
echo $s.WorkingDirectory = '%INSTALL_DIR%' >> "%SCRIPT_PATH%"
if exist "%INSTALL_DIR%\logo.ico" (
    echo $s.IconLocation = '%INSTALL_DIR%\logo.ico' >> "%SCRIPT_PATH%"
)
echo $s.Save() >> "%SCRIPT_PATH%"

powershell -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"
del "%SCRIPT_PATH%"

echo.
echo ============================================
echo   SUCCESS! Skyline Cafe install ho gaya hai.
echo   Desktop par 'Skyline Cafe' shortcut check karein.
echo ============================================
pause
