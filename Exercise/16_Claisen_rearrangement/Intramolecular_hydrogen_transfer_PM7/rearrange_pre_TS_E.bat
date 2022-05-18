set Series=E

@echo off

set INPUT_FILE=pre_%Series%2_TS.mop
REM set OUTPUT_FILE=%Series%2_TS.mop

set INPUT_SADDLE=%Series%1_SADDLE.mop

setlocal enabledelayedexpansion
for /f "usebackq tokens=*" %%a in (%INPUT_SADDLE%) do @set HEAD=%%a&goto :exit_for
:exit_for
echo %HEAD% > tmp0.mop
endlocal


set BEFORE_STRING=XYZ SADDLE
set AFTER_STRING=TS PRTCHAR

setlocal enabledelayedexpansion
for /f "delims=" %%a in (tmp0.mop) do (
  set line=%%a
  echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> tmp.mop
)
endlocal

REM echo Title >> tmp.mop
REM echo Transition States calculation >> tmp.mop
echo. >> tmp.mop
echo. >> tmp.mop

setlocal enabledelayedexpansion
for /f "delims=" %%a in (%INPUT_FILE%) do (
  set line=%%a
  echo !line:%string:~12,76%! >> tmp1.mop
)
endlocal


set BEFORE_STRING= ^*
set AFTER_STRING= 1

setlocal enabledelayedexpansion
for /f "delims=" %%a in (tmp1.mop) do (
  set line=%%a
  echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> tmp.mop
)
endlocal


move tmp.mop %Series%2_TS.mop

del tmp.mop tmp0.mop tmp1.mop