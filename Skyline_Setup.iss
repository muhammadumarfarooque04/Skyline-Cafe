; ----------------------------------------------------------------------------------
; Skyline Cafe Management System - Inno Setup Script
; This script builds a professional installer for Windows.
; ----------------------------------------------------------------------------------

[Setup]
AppId={{C6E2D4F0-A1B2-4C3D-9E5F-7G8H9I0J1K2L}
AppName=Skyline Cafe
AppVersion=1.0
AppPublisher=Skyline Cafe Team
DefaultDirName={pf}\SkylineCafe
DefaultGroupName=Skyline Cafe
AllowNoIcons=yes
OutputDir=installer
OutputBaseFilename=SkylineCafe_Setup
SetupIconFile=logo.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Main JAR and Libraries
Source: "dist\CafeMS.jar"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\sqlite-jdbc.jar"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\slf4j-api-2.0.9.jar"; DestDir: "{app}"; Flags: ignoreversion
Source: "dist\slf4j-simple-2.0.9.jar"; DestDir: "{app}"; Flags: ignoreversion
; Include the logo for the UI
Source: "src\cafe\logo.jpeg"; DestDir: "{app}\src\cafe"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\Skyline Cafe"; Filename: "{app}\CafeMS.jar"; IconFilename: "{app}\logo.ico"
Name: "{commondesktop}\Skyline Cafe"; Filename: "{app}\CafeMS.jar"; Tasks: desktopicon; IconFilename: "{app}\logo.ico"

[Run]
; Run the app after installation using javaw
Filename: "{cmd}"; Parameters: "/c start javaw -cp ""{app}\CafeMS.jar;{app}\sqlite-jdbc.jar;{app}\slf4j-api-2.0.9.jar;{app}\slf4j-simple-2.0.9.jar"" cafe.ui.LoginFrame"; Description: "Launch Skyline Cafe"; Flags: nowait postinstall skipifsilent
