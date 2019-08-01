REM Name: Create Project Directories
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

SET workdir=%cd%
SET batchdir=%~dp0
SET batchdir=%batchdir:~0,-1%

REM Security Question
IF /I "%1"=="!ANSWERBATCH!" (
	REM don't ask anything, as a batch process is running.
	timeout 10 >NUL
) ELSE (
	CHOICE /C YN /N /T 10 /D N /M "Do you wish to continue? (Y/N):"
	 IF errorlevel 2 (
	    ECHO.
		  goto :exitprogram
	 )
	REM IF errorlevel 1 goto ...
)

ECHO.
ECHO You create a project as subdirectory of:
ECHO   %workdir%
ECHO.


:choosetype
SET "marketdata=[1] - marketdata study"
SET "clientproject=[2] - client project"

REM user input: marketdata study or client project?
ECHO Which kind of project do you want to create?
ECHO   %marketdata% (studyname_CTR_YYYY)
ECHO   %clientproject% (projectname_CTR_YYYYMM)
ECHO.
SET "choice="
set /P choice=Enter one number (1/2) %=%

if '%choice%'=='1' (
  ECHO.
  ECHO You chose project type: %marketdata%
  ECHO.
  goto :setname
)

if '%choice%'=='2' (
  ECHO.
  ECHO You chose project type: %clientproject%
  ECHO.
  goto :setname
)

ECHO "%choice%" is not valid, try again
ECHO.
goto :choosetype

REM user input (Name of current study)
ECHO Enter the study name you want to create the project structure for
ECHO   (naming convention: studyname_CTR_YYYY, e.g. superstudy_CZE_2018,
ECHO   for marketdata studies and projectname_CTR_YYYYMM for client projects.
ECHO   - NO spaces, NO german umlauts, etc; ISO3 Country codes):

:setname
SET "currentStudy="
set /P currentStudy=Enter Study Name: %=%
IF NOT DEFINED currentStudy GOTO :eof


REM check if study name contains only letters + underscore characters
echo.%currentStudy%| findstr /R "[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_]" >nul

if %ERRORLEVEL% EQU 0 (
	ECHO.
	echo %currentStudy% -- invalid: no spaces, no german umlauts, etc.
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
 ECHO %currentStudy% -- invalid for type %marketdata%:
 ECHO   last 5 characters must be an underscore followed by 4 digits, indicating the year, e.g. _2019
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
 echo %currentStudy% -- invalid:
 ECHO   central part must be an underscore followed by 3 capital letters, indicating the ISO3, e.g. _CZE
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
 ECHO %currentStudy% -- invalid for type %clientproject%:
 ECHO   last 7 characters must be an underscore followed by 6 digits, indicating the year and month, e.g. _201904
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
 echo %currentStudy% -- invalid:
 ECHO   central part must be an underscore followed by 3 capital letters, indicating the ISO3, e.g. _CZE
 ECHO.
 goto :setname
)


REM go to the directory creation
goto :dircreate


:dircreate
REM create directory structure for clear organisation of an analysis project

ECHO.
CHOICE /C YN /N /T 10 /D N /M "Create directory structure with current name: %currentStudy%? (Y/N):"
IF errorlevel 2 (
	ECHO.
	goto :exitprogram
)
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
md 0101_data 0110_code 0120_figures 0121_leaflets 0130_checks 0140_misc

REM make subfolders in 0110_code
cd 0110_code
md 01100_r_functions 01101_r_scripts 01102_r_markdowns

ECHO.
ECHO All subfolders created.


:rstudioproj
REM write rstudio proj file to directory if desired

ECHO.
ECHO It is recommended to work with RStudio Projects (Rproj File) in order to ensure a smooth workflow.
ECHO.
CHOICE /C YN /N /T 10 /D N /M "Do you want to setup an RStudio Project (Rproj File) in the current directory: %currentStudy%? (Y/N):"
IF errorlevel 2 (
	ECHO.
	goto :exitprogram
)
REM IF errorlevel 1 goto ...

cd %workdir%/%currentStudy%

(
  echo Version: 1.0
  echo.
  echo RestoreWorkspace: Default
  echo SaveWorkspace: Default
  echo AlwaysSaveHistory: Default
  echo.
  echo EnableCodeIndexing: Yes
  echo UseSpacesForTab: Yes
  echo NumSpacesForTab: 2
  echo Encoding: UTF-8
  echo.
  echo RnwWeave: Sweave
  echo LaTeX: pdfLaTeX
  echo.
  echo AutoAppendNewline: Yes
  echo StripTrailingWhitespace: Yes
) > %currentStudy%.Rproj

ECHO.
ECHO RStudio project successfully setup.
EcHO Open the project and have fun working with it.
ECHO.

:exitprogram
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

ECHO.
pause>nul|set/p =Press any key to delete cmd-file and exit ...

DEL "%~f0"

ENDLOCAL
