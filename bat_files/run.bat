@echo off
set PARAM=.mop
for /f "usebackq tokens=*" %%A in (`dir /b ^| find "%PARAM%"`) do set FILE=%%A
echo %FILE%

"C:\Program Files\MOPAC\MOPAC2016.exe" "%FILE%"

pause