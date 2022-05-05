set Series=C

@echo off

set INPUT_FILE=pre_%Series%2_TS.mop
REM set OUTPUT_FILE=%Series%2_TS.mop

set INPUT_MEP=%Series%1_MEP.mop

setlocal enabledelayedexpansion
for /f "usebackq tokens=*" %%a in (%INPUT_MEP%) do @set HEAD=%%a&goto :exit_for
:exit_for
echo %HEAD% > tmp0.mop
endlocal


set BEFORE_STRING=EF
set AFTER_STRING=TS PRTCHAR

setlocal enabledelayedexpansion
for /f "delims=" %%a in (tmp0.mop) do (
  set line=%%a
  echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> tmp.mop
)
endlocal

echo Title >> tmp.mop
echo Transition States calculation >> tmp.mop


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
  echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> tmp2.mop
)
endlocal


set BEFORE_STRING= ^+
set AFTER_STRING= 1

setlocal enabledelayedexpansion
for /f "delims=" %%a in (tmp2.mop) do (
  set line=%%a
  echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> tmp3.mop
)
endlocal


REM Distance
set BEFORE_STRING=0.00000000   
set AFTER_STRING=0.00000000  0

setlocal enabledelayedexpansion
for /f "delims=" %%a in (tmp3.mop) do (
  set line=%%a
  echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> tmp4.mop
)
endlocal


REM Angle and Dihedral angle
set BEFORE_STRING=0.0000000   
set AFTER_STRING=0.0000000  0

setlocal enabledelayedexpansion
for /f "delims=" %%a in (tmp4.mop) do (
  set line=%%a
  echo !line:%BEFORE_STRING%=%AFTER_STRING%! >> tmp.mop
)
endlocal


move tmp.mop %Series%2_TS.mop

del tmp.mop tmp0.mop tmp1.mop tmp2.mop tmp3.mop tmp4.mop

