@echo off
title Rec Utilities
:menu
cls
echo Rec Utilities
echo By: DJ PAIN#5195 and BrahMan                                                                                                                                      
echo Thanks for using<33

echo Menu:
echo 1. RecTerminator
echo 2. RecTester
echo 3. Exit

set /p choice=Enter your choice (1, 2, or 3): 

if "%choice%"=="1" (
    call :RecTerminator
    goto :menu
) else if "%choice%"=="2" (
    call :RecTester
    goto :menu
) else if "%choice%"=="3" (
    exit /b 0
) else (
    echo Invalid choice.
    pause
    goto :menu
)

exit /b 0

:RecTerminator
cls

@echo off

tasklist | find /i "Recroom_Release.exe" >nul 2>&1
if errorlevel 1 (
    echo Recroom_Release.exe is not running. Exiting...
    pause
    exit /b 1
)

echo Identifying Recroom_Release.exe...
echo Killing Recroom_Release.exe...
taskkill /F /IM Recroom_Release.exe >nul 2>&1
echo Recroom_Release.exe terminated.

echo Killing SteamVR processes...
taskkill /F /IM vrcmd.exe >nul 2>&1
taskkill /F /IM vrcompositor.exe >nul 2>&1
taskkill /F /IM vrdashboard.exe >nul 2>&1
taskkill /F /IM vrmonitor.exe >nul 2>&1
taskkill /F /IM vrserver.exe >nul 2>&1
echo SteamVR processes terminated.
echo Thank you!
pause
exit /b 0

:RecTester
cls

@echo off
echo RecTester.bat By: DJ Pain and the OpenRecV2 Team
echo RecTester.bat is made to test the Recroom_Release.exe process
set RESULT_FILE=results.txt

set MODDED=False

echo Please ensure that YOU HAVE PUT THIS BAT FILE IN THE DIRECTORY WITH YOUR Rec Room installation directory with Recroom_Release.exe.
echo Press any key to continue...
pause > nul

if not exist Recroom_Release.exe (
    echo Error: Recroom_Release.exe not found in the current directory.
    exit /b 1
)

if not exist Recroom_Release_Data (
    echo Error: Recroom_Release_Data folder not found. Try redownloading the build or seek assistance on our Discord server.
    exit /b 1
)

echo Running additional checks...

rem Check for required files
echo Recroom_Release.exe - Yes
echo Recroom_Release.exe - Yes >> %RESULT_FILE%

echo Recroom_Release_Data - Yes
echo Recroom_Release_Data - Yes >> %RESULT_FILE%

echo Checking for steam_appid.txt...
timeout /t 1 > nul
if not exist steam_appid.txt (
    echo Error: steam_appid.txt file not found. Your old Rec Room build may not start. Try redownloading the build or seek assistance on our Discord server.
    exit /b 1
)

rem Additional file checks
echo Checking for Config.cfg...
timeout /t 1 > nul
if not exist Config.cfg (
    echo Config.cfg - No
) else (
    echo Config.cfg - Yes
    echo Config.cfg - Yes >> %RESULT_FILE%
)

echo Checking for GizmoBuildInfo.txt...
timeout /t 1 > nul
if not exist GizmoBuildInfo.txt (
    echo GizmoBuildInfo.txt - No
) else (
    echo GizmoBuildInfo.txt - Yes
    echo GizmoBuildInfo.txt - Yes >> %RESULT_FILE%
)

echo Checking for NOTICE.txt...
timeout /t 1 > nul
if not exist NOTICE.txt (
    echo NOTICE.txt - No
) else (
    echo NOTICE.txt - Yes
    echo NOTICE.txt - Yes >> %RESULT_FILE%
)

echo Checking for Config.json...
timeout /t 1 > nul
if not exist Config.json (
    echo Config.json - No
) else (
    echo Config.json - Yes
    echo Config.json - Yes >> %RESULT_FILE%
)

echo Additional checks completed.

echo Checking for modded installation...

if exist MelonLoader (
    echo MelonLoader - Yes
    echo MelonLoader - Yes >> %RESULT_FILE%
    set MODDED=True
)

if exist Mods (
    echo Mods - Yes
    echo Mods - Yes >> %RESULT_FILE%
    set MODDED=True
)

if exist Plugins (
    echo Plugins - Yes
    echo Plugins - Yes >> %RESULT_FILE%
    set MODDED=True
)

if exist UserData (
    echo UserData - Yes
    echo UserData - Yes >> %RESULT_FILE%
    set MODDED=True
)

echo Modded: %MODDED%
echo Modded: %MODDED% >> %RESULT_FILE%

findstr /C:"Yes" %RESULT_FILE%

pause

start notepad.exe %RESULT_FILE%

cls
echo Testing completed.
echo.
pause
exit /b 0
