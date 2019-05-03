REM Name: Clean-up Project Directory Tree
REM Author: Christoph Stepper (christoph.stepper@gfk.com)
REM Description: Helpful tool to recursively remove all empty folders in project directory tree after finishing the project.

REM Alternatives might be:
REM Remove Empty Directories GUI; http://www.jonasjohn.de/red.htm
REM DelEmpty.exe command line tool; http://www.intelliadmin.com/index.php/downloads/

REM Make sure, that correct sort command is selected
REM Check with where sort --> should be "C:\Windows\System32\sort.exe"
REM Remove all Rtools related entries from System PATH if necessary and restart your machine

@ECHO OFF

CLS

SETLOCAL EnableExtensions EnableDelayedExpansion

set ANSWERBATCH=Y

TITLE Clean-up Project - Delete empty Directories

ECHO.
ECHO Clean-up Project Structure - Delete empty Directories
ECHO.

REM Security Question
IF /I "%1"=="!ANSWERBATCH!" (
	REM don't ask anything, as a batch process is running.
	timeout 10 >NUL
) ELSE (
	CHOICE /C YN /N /T 10 /D N /M "Do you wish to continue? (Y/N):"
	 IF errorlevel 2 (
	    ECHO.
	    pause>nul|set/p =Press any key to exit ...
	    EXIT
	 )
	REM IF errorlevel 1 goto ...
)
REM CLS

SET workdir=%cd%
SET batchdir=%~dp0
SET batchdir=%batchdir:~0,-1%

REM This is the core for folder removal.

ECHO.
ECHO Current working directory: 
ECHO   %cd%
ECHO.
CHOICE /C YN /N /T 10 /D N /M "Should all empty folders in the current directory be removed? (Y/N):"
IF errorlevel 2 (
	ECHO.
	pause>nul|set/p =Press any key to exit ...
	EXIT
)
REM IF errorlevel 1 goto ...

for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do (
  set abs=%%d
  ECHO Try to remove: !abs:%cd%\=! 
  rd "%%d"
  )

REM CLS

ECHO.
ECHO All empty directories removed in:
ECHO   %cd%.
ECHO.

IF /I "%1"=="!ANSWERBATCH!" (
	REM don't ask anything, as a batch process is running.
	timeout 10 >NUL
) ELSE (
    IF NOT %workdir% == %batchdir% (
      REM if current working directory is identical with the full path to the batch file's directory
      pause>nul|set/p =Press any key to exit ...
      EXIT
    ) ELSE (
	    CHOICE /C YN /N /T 10 /D N /M "Should the cmd-file be deleted? (Y/N):"
	    IF errorlevel 2 (
	      ECHO.
	      pause>nul|set/p =Press any key to exit ...
	      EXIT
	    )
	    REM IF errorlevel 1 goto ...
    )
)

DEL "%~f0"

ECHO.
pause>nul|set/p =Press any key to exit ...

ENDLOCAL
