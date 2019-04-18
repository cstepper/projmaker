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

:choosetype
REM user input: marketdata study or client project?
ECHO Which kind of project do you want to create?
ECHO [1] - marketdata study (studyname_CTR_YYYY)
ECHO [2] - client project (projectname_CTR_YYYYMM)
SET "choice="
set /P choice=Enter one number (1/2) %=%

ECHO: You chose project type: %choice%
ECHO.

if '%choice%'=='1' goto :setname
if '%choice%'=='2' goto :setname

ECHO "%choice%" is not valid, try again
ECHO.
goto :choosetype

REM user input (Name of current study)
ECHO Enter the study name you want to create the project structure for
ECHO (naming convention: studyname_CTR_YYYY, e.g. superproject_CZE_2018,
ECHO for marketdata studies and projectname_CTR_YYYYMM for client projects.
ECHO - NO spaces, NO german umlauts, etc; ISO3 Country codes):

:setname
SET "currentStudy="
set /P currentStudy=Enter Study Name: %=%
IF NOT DEFINED currentStudy GOTO :eof


REM check if study name contains only letters + underscore characters
echo.%currentStudy%| findstr /R "[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_]" >nul

if %ERRORLEVEL% EQU 0 (
	ECHO.
	echo %currentStudy% - invalid: no spaces, no german umlauts, etc.
  ECHO.
  goto :setname
)


REM check user input for currentStudy

if '%choice%'=='1' goto :marketdata
if '%choice%'=='2' goto :clientproject

:marketdata
REM check if last 5 characters are underscore followed by 4 digits (year)

SET end=%currentStudy:~-5%
echo.%end%| findstr /R "^_[0-9][0-9][0-9][0-9]$" >nul

if %ErrorLevel% EQU 0 (
 REM ECHO.
 REM echo %currentStudy% - OK
) ELSE (
 ECHO.
 echo %currentStudy% - invalid for type %choice%: last 5 characters must be an underscore followed by 4 digits, indicating the year, e.g. _2019
 ECHO.
 goto :setname
)


REM check if last 9 to 6 characters are underscore followed by 3 capital letters (ISO3)

SET mid=%currentStudy:~-9,4%
echo.%mid%| findstr /R "^_[ABCDEFGHIJKLMNOPQRSTUVWXYZ][ABCDEFGHIJKLMNOPQRSTUVWXYZ][ABCDEFGHIJKLMNOPQRSTUVWXYZ]$" >nul

if %ErrorLevel% EQU 0 (
 ECHO.
 echo %currentStudy% - OK
) ELSE (
 ECHO.
 echo %currentStudy% - invalid: central part must be an underscore followed by 3 capital letters, indicating the ISO3, e.g. _CZE
 ECHO.
 goto :setname
)

REM go to the directory creation
goto :dircreate


:clientproject
REM check if last 7 characters are underscore followed by 6 digits (year-month)

SET end=%currentStudy:~-7%
echo.%end%| findstr /R "^_[0-9][0-9][0-9][0-9][0-9][0-9]$" >nul

if %ErrorLevel% EQU 0 (
 REM ECHO.
 REM echo %currentStudy% - OK
) ELSE (
 ECHO.
 echo %currentStudy% - invalid for type %choice%: last 7 characters must be an underscore followed by 6 digits, indicating the year and month, e.g. _201904
 ECHO.
 goto :setname
)

REM check if last 11 to 8 characters are underscore followed by 3 capital letters (ISO3)

SET mid=%currentStudy:~-11,4%
echo.%mid%| findstr /R "^_[ABCDEFGHIJKLMNOPQRSTUVWXYZ][ABCDEFGHIJKLMNOPQRSTUVWXYZ][ABCDEFGHIJKLMNOPQRSTUVWXYZ]$" >nul

if %ErrorLevel% EQU 0 (
 ECHO.
 echo %currentStudy% - OK
) ELSE (
 ECHO.
 echo %currentStudy% - invalid: central part must be an underscore followed by 3 capital letters, indicating the ISO3, e.g. _CZE
 ECHO.
 goto :setname
)


REM go to the directory creation
goto :dircreate


:dircreate
REM create directory structure for clear organisation of an analysis project

ECHO.
CHOICE /C YN /N /T 10 /D N /M "Create directory structure with current name: %currentStudy%? (Y/N):"
IF errorlevel 2 EXIT
REM IF errorlevel 1 goto ...

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
