@echo off

:: =============================
:: Build script for PRS Solution
:: =============================

:: generate logFilename and set logFilename environment variable
for /F %%a in ('cscript //NoLogo .\Build\logfilename.js') do (
    set logFilename=%%a
)

:: ensure logs directory is present
set logDir=build.logs
if not exist %logDir% (
    mkdir "%logDir%"
)

set logFilePath=%logDir%\%logFilename%

if "%1" == "" (
    if "%2" == "" (
        if "%3" == "" (
            if "%4" == "" (
                msbuild .\build-prompt.msbuild /clp:verbosity=normal /flp:Logfile="%logFilePath%";verbosity=normal
                if errorlevel 1 (
                    goto failed
                ) else (
                    goto end
                )
            )
        )
    )
)

:check-target
if "%1" == "Build" (
    goto check-configuration
)
 
if "%1" == "Rebuild" (
    goto check-configuration
)

if "%1" == "Clean" (
    goto check-configuration
)

if "%1" == "Publish" (
    goto check-configuration
)
 
if "%1" == "Install" (
    goto start
) else (
    goto usage
)

:check-configuration
if "%2" == "Debug" (
    goto check-platform
)

if "%2" == "Release" (
    goto check-platform
) else (
    goto usage
)

:check-platform
if "%3" == "" (
    goto start
)

if "%3" == "AnyCPU" (
    goto start
)

if "%3" == "x86" (
    goto start
)

if "%3" == "x64" (
    goto start
) else (
    goto usage
)

:start
msbuild .\build.msbuild /t:%1 /clp:verbosity=normal /flp:Logfile="%logFilePath%";verbosity=normal /p:Configuration=%2;Plaform=%3
if errorlevel 1 (
    goto failed
) else (
    goto end
)

:usage
echo.
echo =======================================================
echo ^|     Usage if supplying arguments to this script     ^|   
echo =======================================================
echo build.bat [Build^|Rebuild^|Clean^|Publish^|Install] [Debug^|Release] [AnyCPU^|x86^|x64]
echo.
echo eg.
echo build.bat Build Debug AnyCPU
goto failed

:failed
echo.
echo ===============================
echo ^|  B u i l d   F a i l e d !  ^|  
echo ===============================

:: remove temporary environment variables
set logDir=
set logFilename=
set logFilePath=

exit /B 1

:end
:: remove temporary environment variables
set logDir=
set logFilename=
set logFilePath=

:: set return code
exit /B errorlevel
