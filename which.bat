@ECHO OFF

IF "%1"=="" (
ECHO usage: %0 command
GOTO END
)

::adjust PATH
::FOR statement can not process parenthesis and space
::so enclose them in double quotes
SET PATH_ADJUSTED=%PATH:(="("%
SET PATH_ADJUSTED=%PATH_ADJUSTED:)=")"%
SET PATH_ADJUSTED=%CD%;%PATH_ADJUSTED: =" "%
SET PREFIX=

FOR %%i IN (%PATH_ADJUSTED%) DO (
IF EXIST %%i\%1 (
SET PATH_FOUND=%%i\
SET PREFIX=
GOTO FOUND
) ELSE IF EXIST %%i\%1.exe (
SET PATH_FOUND=%%i\
SET PREFIX=.exe
GOTO FOUND
) ELSE IF EXIST %%i\%1.bat (
SET PATH_FOUND=%%i\
SET PREFIX=.bat
GOTO FOUND
)
)
GOTO NOT_FOUND

:FOUND
::remove the double quotes
SET PATH_FOUND=%PATH_FOUND:"=%
::remove the redundant backslash at the end 
IF \\==%PATH_FOUND:~-2% SET PATH_FOUND=%PATH_FOUND:~0,-1%

ECHO %PATH_FOUND%%1%PREFIX%
GOTO END

:NOT_FOUND
ECHO %1 was not found.

:END
::unset variables
SET PATH_ADJUSTED=
SET PATH_FOUND=
SET PREFIX=