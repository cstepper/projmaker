REM Name: Make Project Directories
REM Author: Christoph Stepper (christoph.stepper@gfk.com)
REM Description: Helpful tool to create the folder structure for a GeoInsights project.

@ECHO OFF

CLS

SETLOCAL EnableExtensions EnableDelayedExpansion

set ANSWERBATCH=Y

TITLE Create Directories - GfK Geomarketing Project Structure

ECHO.
ECHO Create GfK Geomarketing Project Structure
ECHO.

REM Security Question
IF /I "%1"=="!ANSWERBATCH!" (
	REM don't ask anything, as a batch process is running.
	timeout 10 >NUL
) ELSE (
	CHOICE /C YN /N /T 10 /D N /M "Do you wish to continue? (Y/N):"
	IF errorlevel 2 EXIT
	REM IF errorlevel 1 goto ...
)
REM CLS
ECHO.


REM user input (Name of current study)
ECHO Enter the study name you want to create the project structure for
ECHO (naming convention: YYYY_StudyName_CTR, e.g. 2018_DistribionPartner_DEU
ECHO - NO spaces, german umlauts, etc; ISO3 Country codes):
:setname
SET "currentStudy="
set /P currentStudy=Enter Study Name: %=%
IF NOT DEFINED currentStudy GOTO :eof


REM check if study name contains only letters + underscore characters
echo.%currentStudy%| findstr /R "[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_]" >nul

REM if ErrorLevel 1 (
REM  REM echo %currentStudy% - OK
REM ) ELSE (
REM  echo %currentStudy% - invalid: no spaces, german umlauts, etc.
REM  goto :setname
REM  )

if %ERRORLEVEL% EQU 0 (
	echo %currentStudy% - invalid: no spaces, german umlauts, etc.
    goto :setname
)


REM check if first four characters are digits followed by an underscore

REM SET start=%currentStudy:~0,4%
REM echo.%start%| findstr /R "[^1234567890]" >nul

REM if ErrorLevel 0 (
REM  REM echo %currentStudy% - OK
REM ) ELSE (
REM  echo %currentStudy% - invalid: first four characters must be numbers
REM  goto :setname
REM )


SET start=%currentStudy:~0,5%
echo.%start%| findstr /R "^[0-9][0-9][0-9][0-9]_$" >nul

if %ERRORLEVEL% EQU 1 (
	echo %currentStudy% - invalid: first four characters must be numbers, e.g. 2018, followed by an underscore
    goto :setname
)


REM check if last 4 characters are underscore followed by 3 capital letters (ISO3)

SET end=%currentStudy:~-4%
echo.%end%| findstr /R "^_[ABCDEFGHIJKLMNOPQRSTUVWXYZ][ABCDEFGHIJKLMNOPQRSTUVWXYZ][ABCDEFGHIJKLMNOPQRSTUVWXYZ]" >nul

if %ErrorLevel% EQU 0 (
 echo %currentStudy% - OK
) ELSE (
 echo %currentStudy% - invalid: last four characters must be an underscore followed by 3 capital letters, indicating the ISO3, e.g. _deu
 goto :setname
)


ECHO.
CHOICE /C YN /N /T 10 /D N /M "Continue with current name: %currentStudy%? (Y/N):"
IF errorlevel 2 EXIT
REM IF errorlevel 1 goto ...


REM create directory structure for clear organisation of an analysis project

REM create study folder
md %currentStudy%
cd %currentStudy%

REM make main subfolders
md 00_basedata 01_analysis 02_docu 03_results 04_presentations

REM make subfolders in 00_basedata folder (might be adjusted in future)
cd 00_basedata
md 001_data 002_metadata

REM make subfolders in 01_analysis folder (might be adjusted in future)
cd ..
cd 01_analysis
md 0101_data
md 0110_code
md 0120_figures 0121_leaflets
md 0130_checks
md 0140_misc

REM make subfolders in 0110_code
cd 0110_code
md 01100_r_functions 01101_r_scripts 01102_r_markdowns

REM CLS

ECHO.
ECHO All subfolders created.
ECHO(
ECHO It is recommended to work with RStudio Projects (Rproj File) in order to ensure a smooth workflow.
ECHO(
ECHO Have fun with the analysis :-)
ECHO.


IF /I "%1"=="!ANSWERBATCH!" (
	REM don't ask anything, as a batch process is running.
	timeout 10 >NUL
) ELSE (
	CHOICE /C YN /N /T 10 /D N /M "Should the cmd-file be deleted? (Y/N):"
	IF errorlevel 2 EXIT
	REM IF errorlevel 1 goto ...
)

DEL "%~f0"

pause

ENDLOCAL
