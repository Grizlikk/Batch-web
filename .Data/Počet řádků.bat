@echo off
title Pocet radku

set /a radky = 0
set /a soubory = 0
cd..

for /f %%z in (.Data\Pripony.txt) do (
    call :count %%z
    for /d %%c in (*) do (if "%%c" neq "stare_verze" call :find %%c %%z)
    )

cd stare_verze & for /f %%z in (..\.Data\Pripony.txt) do (call :count %%z)

echo Pocet radku kodu: %radky%
echo Pocet souboru: %soubory%
pause > nul
exit /b 0

:find
    cd %~1 & call :count %~2
    for /d %%d in (*) do (
        cd %%d & call :count %~2
        for /d %%e in (*) do (
            cd %%e & call :count %~2
            cd..
            )
        cd..
        )
    cd..
goto :eof

:count
    if %~1 == .htm for %%s in (*) do (set /a soubory += 1)
    for %%a in (*%~1) do (
        for /f "tokens=*" %%b in (%%a) do (
            set /a radky += 1))
goto :eof