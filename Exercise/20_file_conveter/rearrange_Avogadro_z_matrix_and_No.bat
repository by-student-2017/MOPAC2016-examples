set Series=A

set keyword_flag="ON"

REM Avogadro ver.1.2.0
REM Open Babel ver. 2.3.90
@echo off

set INPUT_FILE=z.mop
set OUTPUT_FILE=%Series%1_MEP.mop
set OUTPUT_FILE_OPT=%Series%0_OPT.mop

del %OUTPUT_FILE%
del %OUTPUT_FILE_OPT%

set BEFORE_STRING=0.000000  1
set AFTER_STRING=0.000000  0

setlocal enabledelayedexpansion
set /a counter=0
for /f "tokens=1,*" %%a in (%INPUT_FILE%) do (
  set /a counter=counter+1
  set /a natom=counter-2
  set line=%%a %%b
  if !counter!==1 (
    if %keyword_flag%=="OFF" (
      echo !line! >> %OUTPUT_FILE%
      echo !line! >> %OUTPUT_FILE_OPT%
    ) else (
      echo PM7 CHARGE=0 EF PRECISE >> %OUTPUT_FILE%
      echo PM7 CHARGE=0 EF ESP XYZ VECTORS >> %OUTPUT_FILE_OPT%
    )
  ) else if !counter!==2 (
    if %keyword_flag%=="OFF" (
      echo !line! >> %OUTPUT_FILE%
      echo !line! >> %OUTPUT_FILE_OPT%
    ) else (
      echo comment line >> %OUTPUT_FILE%
      echo comment line >> %OUTPUT_FILE_OPT%
    )
  ) else if !counter!==3 (
    set line=%%a^(0!natom!^) %%b
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE%
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==4 (
    set line=%%a^(0!natom!^) %%b
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE%
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==5 (
    set line=%%a^(0!natom!^) %%b
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE%
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==6 (
    set line=%%a^(0!natom!^) %%b
    echo !line! >> %OUTPUT_FILE%
    echo !line! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==7 (
    set line=%%a^(0!natom!^) %%b
    echo !line! >> %OUTPUT_FILE%
    echo !line! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==8 (
    set line=%%a^(0!natom!^) %%b
    echo !line! >> %OUTPUT_FILE%
    echo !line! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==9 (
    set line=%%a^(0!natom!^) %%b
    echo !line! >> %OUTPUT_FILE%
    echo !line! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==10 (
    set line=%%a^(0!natom!^) %%b
    echo !line! >> %OUTPUT_FILE%
    echo !line! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==11 (
    set line=%%a^(0!natom!^) %%b
    echo !line! >> %OUTPUT_FILE%
    echo !line! >> %OUTPUT_FILE_OPT%
  ) else if "!line!"=="  " (
    REM pass
  ) else (
    set line=%%a^(!natom!^) %%b
    echo !line! >> %OUTPUT_FILE%
    echo !line! >> %OUTPUT_FILE_OPT%
  )
  if !counter!==2 (
    if %keyword_flag%=="OFF" (
      echo. >> %OUTPUT_FILE%
      echo. >> %OUTPUT_FILE_OPT%
    ) else (
      echo input file for minimum energy path >> %OUTPUT_FILE%
      echo structure optimization + other options >> %OUTPUT_FILE_OPT%
    )
  )
)
endlocal

echo. >> %OUTPUT_FILE%
echo 1.6 1.7 1.8 1.9 2.0 2.1 2.2 2.3 >> %OUTPUT_FILE%