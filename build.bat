@echo off
REM ============================================================================
REM Build Script per CheatMod - C&C Remastered Collection
REM ============================================================================
REM
REM Questo script automatizza il processo di build della mod
REM
REM Prerequisiti:
REM - Visual Studio 2017 installato
REM - Repository C&C Remastered clonato
REM - Modifiche applicate come da PATCH_INSTRUCTIONS.md
REM
REM ============================================================================

setlocal enabledelayedexpansion

echo.
echo ============================================================================
echo CheatMod - Build Script
echo ============================================================================
echo.

REM ============================================================================
REM Configurazione Percorsi
REM ============================================================================

REM Percorso al repository C&C Remastered
set "CNC_REPO=..\CnC_Remastered_Collection"

REM Percorso alla solution Visual Studio
set "SOLUTION=%CNC_REPO%\CnCRemastered.sln"

REM Percorso a MSBuild (Visual Studio 2017)
set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe"

REM Se non trovato, prova la versione Professional
if not exist "%MSBUILD%" (
    set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\MSBuild.exe"
)

REM Se non trovato, prova la versione Enterprise
if not exist "%MSBUILD%" (
    set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSBuild.exe"
)

REM Cartella di output
set "OUTPUT_DIR=bin"

REM Cartella di installazione della mod
set "MOD_INSTALL_DIR=%USERPROFILE%\Documents\CnCRemastered\Mods\CheatMod"

REM ============================================================================
REM Verifica Prerequisiti
REM ============================================================================

echo [1/6] Verifica prerequisiti...

if not exist "%CNC_REPO%" (
    echo ERRORE: Repository C^&C Remastered non trovato!
    echo Percorso cercato: %CNC_REPO%
    echo.
    echo Clona il repository con:
    echo git clone https://github.com/electronicarts/CnC_Remastered_Collection.git
    echo.
    pause
    exit /b 1
)

if not exist "%MSBUILD%" (
    echo ERRORE: MSBuild non trovato!
    echo Visual Studio 2017 deve essere installato.
    echo.
    echo Percorso cercato: %MSBUILD%
    echo.
    pause
    exit /b 1
)

if not exist "%SOLUTION%" (
    echo ERRORE: Solution file non trovato!
    echo Percorso: %SOLUTION%
    echo.
    pause
    exit /b 1
)

echo OK - Prerequisiti verificati
echo.

REM ============================================================================
REM Copia File della Mod
REM ============================================================================

echo [2/6] Copia file della mod nel repository C^&C...

if not exist "src\CHEAT_MOD.H" (
    echo ERRORE: File src\CHEAT_MOD.H non trovato!
    pause
    exit /b 1
)

if not exist "src\CONQUER_CHEAT_MOD.CPP" (
    echo ERRORE: File src\CONQUER_CHEAT_MOD.CPP non trovato!
    pause
    exit /b 1
)

copy /Y "src\CHEAT_MOD.H" "%CNC_REPO%\TIBERIANDAWN\" >nul
if errorlevel 1 (
    echo ERRORE durante la copia di CHEAT_MOD.H
    pause
    exit /b 1
)

copy /Y "src\CONQUER_CHEAT_MOD.CPP" "%CNC_REPO%\TIBERIANDAWN\" >nul
if errorlevel 1 (
    echo ERRORE durante la copia di CONQUER_CHEAT_MOD.CPP
    pause
    exit /b 1
)

echo OK - File copiati
echo.

REM ============================================================================
REM Nota sulle Modifiche Manuali
REM ============================================================================

echo [3/6] Verifica modifiche al codice...
echo.
echo ATTENZIONE: Questo script NON applica automaticamente le modifiche
echo a CONQUER.CPP. Devi applicarle manualmente seguendo le istruzioni
echo in src\PATCH_INSTRUCTIONS.md
echo.
echo Modifiche necessarie in TIBERIANDAWN\CONQUER.CPP:
echo - Include CHEAT_MOD.H
echo - Chiamata a Init_Cheat_Mod() in Select_Game()
echo - Chiamata a Process_Cheat_Keys() nel main game loop
echo - Chiamate agli Apply_* nel main loop
echo.
set /p CONTINUE="Hai applicato tutte le modifiche? (S/N): "

if /i not "%CONTINUE%"=="S" (
    echo.
    echo Build annullata. Applica le modifiche e riprova.
    echo Consulta: src\PATCH_INSTRUCTIONS.md
    pause
    exit /b 1
)

echo OK - Procedo con il build
echo.

REM ============================================================================
REM Compilazione
REM ============================================================================

echo [4/6] Compilazione in corso...
echo.
echo Questo potrebbe richiedere diversi minuti...
echo.

REM Compila in Release mode per Win32
"%MSBUILD%" "%SOLUTION%" /t:TiberianDawn /p:Configuration=Release /p:Platform=Win32 /m /v:minimal

if errorlevel 1 (
    echo.
    echo ERRORE durante la compilazione!
    echo Controlla i messaggi di errore sopra.
    echo.
    pause
    exit /b 1
)

echo.
echo OK - Compilazione completata con successo!
echo.

REM ============================================================================
REM Copia Output
REM ============================================================================

echo [5/6] Copia file compilati...

REM Crea directory di output se non esiste
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Trova la DLL compilata
set "COMPILED_DLL=%CNC_REPO%\bin\Win32\Release\TiberianDawn.dll"
set "COMPILED_PDB=%CNC_REPO%\bin\Win32\Release\TiberianDawn.pdb"

if not exist "%COMPILED_DLL%" (
    echo ERRORE: DLL compilata non trovata in %COMPILED_DLL%
    pause
    exit /b 1
)

copy /Y "%COMPILED_DLL%" "%OUTPUT_DIR%\" >nul
if exist "%COMPILED_PDB%" (
    copy /Y "%COMPILED_PDB%" "%OUTPUT_DIR%\" >nul
)

echo OK - File copiati in %OUTPUT_DIR%\
echo.

REM ============================================================================
REM Installazione (Opzionale)
REM ============================================================================

echo [6/6] Installazione della mod...
echo.
set /p INSTALL="Vuoi installare la mod in %MOD_INSTALL_DIR%? (S/N): "

if /i "%INSTALL%"=="S" (
    echo.
    echo Installazione in corso...

    REM Crea directory se non esiste
    if not exist "%MOD_INSTALL_DIR%" mkdir "%MOD_INSTALL_DIR%"

    REM Copia DLL e PDB
    copy /Y "%OUTPUT_DIR%\TiberianDawn.dll" "%MOD_INSTALL_DIR%\" >nul
    if exist "%OUTPUT_DIR%\TiberianDawn.pdb" (
        copy /Y "%OUTPUT_DIR%\TiberianDawn.pdb" "%MOD_INSTALL_DIR%\" >nul
    )

    REM Copia CCMOD.JSON
    copy /Y "CCMOD.JSON" "%MOD_INSTALL_DIR%\" >nul

    echo OK - Mod installata!
    echo.
    echo La mod è stata installata in:
    echo %MOD_INSTALL_DIR%
    echo.
    echo Avvia il gioco e attiva la mod dal Mod Manager.
) else (
    echo.
    echo Installazione saltata.
    echo.
    echo Per installare manualmente:
    echo 1. Copia bin\TiberianDawn.dll in %MOD_INSTALL_DIR%\
    echo 2. Copia CCMOD.JSON in %MOD_INSTALL_DIR%\
)

echo.
echo ============================================================================
echo Build completato con successo!
echo ============================================================================
echo.
echo File compilati: %OUTPUT_DIR%\TiberianDawn.dll
echo.
echo Per usare la mod:
echo 1. Avvia Command ^& Conquer Remastered Collection
echo 2. Vai al Mod Manager
echo 3. Attiva "CheatMod - Shortcut Personalizzate"
echo 4. Gioca!
echo.
echo Consulta docs\SHORTCUTS.md per la lista delle shortcut disponibili.
echo.

pause
endlocal
