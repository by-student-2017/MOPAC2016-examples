@echo off

"C:\Program Files\MOPAC\MOPAC2016.exe" saddle.mop

for /F "tokens=5" %%i in ('findstr "DISTANCE" saddle.out') do (
  echo %%i >> path.dat1
)
for /F "tokens=2" %%i in ('findstr "HEAT" saddle.out') do (
  if not "%%i" == "HEAT" (echo %%i >> path.dat2)
)
for /F "tokens=4" %%i in ('findstr "STRUCTURE" saddle.out') do (
  echo %%i >> list.dat
)
paste -d " " path.dat1 path.dat2 list.dat >> tpath.dat

echo # Distance A-B, HEAT [kcal/mol] > path_1st.dat
for /F "tokens=1,2" %%i in ('findstr "FIRST" tpath.dat') do (
  echo %%i %%j >> path_1st.dat
)
echo # Distance A-B, HEAT [kcal/mol] > path_2nd.dat
for /F "tokens=1,2" %%i in ('findstr "SECOND" tpath.dat') do (
  echo %%i %%j >> path_2nd.dat
)
plot.gpl

del path.dat1 path.dat2 list.dat tpath.dat

pause