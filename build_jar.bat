@echo off
echo ============================================
echo    Skyline Cafe - JAR Build Script
echo ============================================

:: 1. Setup Directories
if not exist "out" mkdir out
if not exist "dist" mkdir dist

:: 2. Compile Java Files
echo Compiling source code...
javac -cp "lib\sqlite-jdbc.jar;lib\slf4j-api-2.0.9.jar;lib\slf4j-simple-2.0.9.jar" -d out -sourcepath src src\cafe\ui\LoginFrame.java src\cafe\ui\MainFrame.java src\cafe\ui\DashboardPanel.java src\cafe\ui\MenuPanel.java src\cafe\ui\OrderPanel.java src\cafe\ui\OrdersListPanel.java src\cafe\ui\UserManagementPanel.java src\cafe\dao\UserDAO.java src\cafe\dao\MenuDAO.java src\cafe\dao\OrderDAO.java src\cafe\utils\DatabaseManager.java src\cafe\utils\UIConstants.java src\cafe\models\User.java src\cafe\models\MenuItem.java src\cafe\models\Order.java

if %errorlevel% neq 0 (
    echo [ERROR] Compilation failed!
    pause
    exit /b 1
)

:: 3. Copy Resources (Logo etc.)
echo Copying resources...
if not exist "out\cafe" mkdir "out\cafe"
copy /Y "src\cafe\logo.jpeg" "out\cafe\logo.jpeg" >nul

:: 4. Build JAR
echo Packaging JAR file...
jar cvfm dist\CafeMS.jar manifest.txt -C out .

if %errorlevel% neq 0 (
    echo [ERROR] JAR creation failed!
    pause
    exit /b 1
)

echo.
echo ============================================
echo   SUCCESS! Naya JAR 'dist\CafeMS.jar' ban gaya.
echo   Ab aap 'Skyline_Setup.iss' ko run kar sakte hain.
echo ============================================
pause
