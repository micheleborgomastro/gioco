@echo off
REM ============================================================================
REM Uninstall Script per CheatMod
REM ============================================================================

setlocal enabledelayedexpansion

echo.
echo ============================================================================
echo CheatMod - Disinstallazione
echo ============================================================================
echo.

set "MOD_INSTALL_DIR=%USERPROFILE%\Documents\CnCRemastered\Mods\CheatMod"
set "CNC_REPO=..\CnC_Remastered_Collection"
set "CONQUER_BACKUP=%CNC_REPO%\TIBERIANDAWN\CONQUER.CPP.backup"
set "CONQUER_CPP=%CNC_REPO%\TIBERIANDAWN\CONQUER.CPP"

echo Questo script rimuovera' la mod CheatMod dal tuo sistema.
echo.
echo Cosa sara' rimosso:
echo  - File della mod da: %MOD_INSTALL_DIR%
echo  - File compilati dalla cartella bin\
echo.
set /p CONTINUE="Vuoi continuare? (S/N): "

if /i not "%CONTINUE%"=="S" (
    echo.
    echo Disinstallazione annullata.
    pause
    exit /b 0
)

echo.
echo Rimozione in corso...
echo.

REM Rimuovi directory mod
if exist "%MOD_INSTALL_DIR%" (
    echo Rimozione directory mod...
    rmdir /S /Q "%MOD_INSTALL_DIR%"
    echo [OK] Directory mod rimossa
) else (
    echo [OK] Directory mod non trovata
)

REM Rimuovi file compilati locali
if exist "bin\TiberianDawn.dll" (
    echo Rimozione file compilati locali...
    del /Q "bin\TiberianDawn.dll" 2>nul
    del /Q "bin\TiberianDawn.pdb" 2>nul
    echo [OK] File compilati rimossi
)

REM Chiedi se ripristinare il backup
if exist "%CONQUER_BACKUP%" (
    echo.
    set /p RESTORE="Vuoi ripristinare il backup di CONQUER.CPP originale? (S/N): "

    if /i "!RESTORE!"=="S" (
        echo Ripristino backup...
        copy /Y "%CONQUER_BACKUP%" "%CONQUER_CPP%" >nul
        echo [OK] Backup ripristinato
    )
)

echo.
echo ============================================================================
echo Disinstallazione completata!
echo ============================================================================
echo.
echo La mod e' stata rimossa dal sistema.
echo.
echo Nota: Il repository C^&C Remastered clonato non e' stato rimosso.
echo Se vuoi rimuoverlo manualmente, elimina la cartella:
echo %CNC_REPO%
echo.
echo Per reinstallare la mod in futuro, esegui di nuovo autopatcher.bat
echo.
pause
endlocal
