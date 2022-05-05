set Series=A

@echo off

del plot_mep.ump

set INPUT_FILE=%Series%1_MEP.ump

setlocal enabledelayedexpansion
for /f "tokens=1,2,3*"  %%a in (%INPUT_FILE%) do (
  if %%b==0.000 (
    echo. >> plot_mep.ump
  )
  echo %%a, %%b, %%c >> plot_mep.ump
)
endlocal

plot.gpl