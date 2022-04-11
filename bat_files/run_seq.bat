@echo off
for /f "usebackq tokens=*" %%i in (`dir /s /b *.mop`) do (
  @echo %%i
  "C:\Program Files\MOPAC\MOPAC2016.exe" "%%i"
)