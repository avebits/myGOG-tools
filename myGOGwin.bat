@echo off
cd /d %~dp0
title myGOG-tools v1 (Windows)

::  user configs backup
set "gogpy=f:\gogrepoc.py" :: Where the main python script is
set "gogdir=f:\gog\" :: Where you want the games to be downloaded to 
::  user configs installing
set "NEW_TEMP=d:\Temp" :: New folder for temp/tmp
set "NEW_TMP=d:\Temp" :: New folder for temp/tmp
set "INITIAL_DIR=%USERPROFILE%\Downloads" :: Start folder to look after an applications .exe file. It can be as simple as t:\download


:menu
echo =======================================================================
echo   Select an option:
echo =======================================================================
echo     1. Run Script 1 - download/back up gog collection with gogrepoc
echo     2. Run Script 2 - Running the game with a temporarily temp/tmp
echo     3. Exit
echo =======================================================================
echo.

choice /c 123 /n /m "Press 1, 2, or 3: "

if errorlevel 3 goto end
if errorlevel 2 goto script2
if errorlevel 1 goto script1

:script1
echo Running backup...
python "%gogpy%" update -lang en -os windows -standard
python "%gogpy%" download "%gogdir%" -os windows -lang en -skipextras
python "%gogpy%" clean "%gogdir%"
python "%gogy%" verify "%gogdir%"
goto menu

:script2
echo Running Script 2...

::  save the current temp/tmp path
set "OLDTEMP=%TEMP%"
set "OLDTMP=%TMP%"

::  setting a new temp/tmp path
set "TEMP=%NEW_TEMP%"
set "TMP=%NEW_TMP%"

::  check if the new temp folder exists
if not exist "%TEMP%" mkdir "%TEMP%"

:: file explorer
for /f "usebackq delims=" %%i in (`powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.OpenFileDialog; $f.InitialDirectory='%INITIAL_DIR%'; $f.Filter='Executable Files (*.exe)|*.exe'; if($f.ShowDialog() -eq 'OK'){ Write-Output $f.FileName }"`) do set "SETUP=%%i"

:: check if user actually selected a file, if canceled --> just restore OLDTEMP
if "%SETUP%"=="" (
    echo No file selected. Exiting.
    :: Restore old temp/tmp path
    set "TEMP=%OLDTEMP%"
    set "TMP=%OLDTMP%"
    exit /b
)

:: ...and run it  
"%SETUP%"

:: -- restore temps to the old path again
set "TEMP=%OLDTEMP%"
set "TMP=%OLDTMP%"
goto menu

:: ending and exiting
:end
echo eol
exit
