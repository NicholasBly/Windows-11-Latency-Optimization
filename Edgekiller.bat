@echo off
:: BatchGotAdmin
:-------------------------------------
REM --> Check for permissions
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    goto gotAdmin
) ELSE (
    goto UACPrompt
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    REM FIX: Set params correctly to preserve command-line arguments
    set "params=%*"
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    echo Failure: Current permissions inadequate.
    echo Please right-click the batch file and select "Run as administrator".
    pause
    exit /B

:gotAdmin
pushd "%CD%"
CD /D "%~dp0"
:--------------------------------------

echo Disclaimer: This can rarely break things, especially on insider program builds. If you don't want to take a small risk to partially free your PC from Microsoft's grasp, close now.

TIMEOUT /T 7

echo Deleting edge...

TIMEOUT /T 4 /nobreak
TASKKILL /F /IM msedge.exe >nul 2>&1

cd "C:\Program Files (x86)\Microsoft\Edge\Application"
DEL "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"


IF ERRORLEVEL 1 (
    ECHO.
    ECHO  WARNING: msedge.exe could not be deleted! Check path or manually kill the process.
    ECHO.
)

echo Edge deleted, making sure it won't come back...
REM FIX: Changed 3.5 to 4
TIMEOUT /T 4 /nobreak
RMDIR /S /Q "C:\Program Files (x86)\Microsoft\EdgeUpdate\Install"
RMDIR /S /Q "C:\Program Files (x86)\Microsoft\EdgeUpdate\Offline"
RMDIR /S /Q "C:\Program Files (x86)\Microsoft\EdgeUpdate\Download"
echo Edge is gone!

SET /P choice=This script can also delete some telemetry and windows spying, would you like to do this? (Y/N)

IF /I "%choice%" == "N" GOTO :EOF
IF /I "%choice%" == "Y" GOTO DisableTel

:DisableTel
echo Disabling Windows spying. Note that this blocks Windows Insider, if you want to enroll manually or use a script called OfflineInsiderEnroll. (linked in readme.md)
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

sc stop "DiagTrack" >nul 2>&1
sc config "DiagTrack" start=disabled >nul 2>&1
sc delete DiagTrack >nul 2>&1
sc delete dmwappushservice >nul 2>&1


IF NOT ERRORLEVEL 0 (
    ECHO.
    ECHO  Telemetry services disabled/deleted (Ignoring non-fatal "Service does not exist" warnings).
    ECHO.
)

echo. > c:\ProgramData\Microsoft\Diagnosis\ETLLogs\Autologger\AutoLogger-Diagtrack-Listener.etl
echo The easy part is over, launching settings in the privacy tab. I highly reccomend disabling nearly everything in here. The script is now done.
TIMEOUT /T 3 /nobreak
start ms-settings:privacy