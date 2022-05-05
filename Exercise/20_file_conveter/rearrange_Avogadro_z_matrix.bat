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
for /f "delims=" %%a in (%INPUT_FILE%) do (
  set line=%%a
  set /a counter=counter+1
  if !counter!==1 (
    if %keyword_flag%=="OFF" (
      echo !line! >> %OUTPUT_FILE%
      echo !line! >> %OUTPUT_FILE_OPT%
    ) else (
      echo PM7 CHARGE=0 EF PRECISE >> %OUTPUT_FILE%
      echo PM7 CHARGE=0 EF ESP XYZ VECTORS >> %OUTPUT_FILE_OPT%
    )
  ) else if !counter!==3 (
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE%
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==4 (
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE%
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE_OPT%
  ) else if !counter!==5 (
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE%
    echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> %OUTPUT_FILE_OPT%
  ) else if "!line!"=="  " (
    REM pass
  ) else (
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