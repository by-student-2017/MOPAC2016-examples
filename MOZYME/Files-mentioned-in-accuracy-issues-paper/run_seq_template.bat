@echo off
for /f "usebackq tokens=*" %%i in (`dir /s /b *.arc`) do (
  @echo %%~ni.mop
  echo GEO_DAT="%%~ni.arc" + > %%~ni.mop
  findstr /v "GEO_DAT" template.mop >> %%~ni.mop
  
  findstr "CHARGE=" %%~ni.arc >NUL 2>&1 && (
    echo "Please, add CHARGE=n keywrod !!!"
  ) || (
    "C:\Program Files\MOPAC\MOPAC2016.exe" "%%~ni.mop"
  )
)
pause
