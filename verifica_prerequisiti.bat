@echo off
REM ============================================================================
REM Script di Verifica Prerequisiti per CheatMod
REM ============================================================================
REM
REM Questo script verifica che tutti i prerequisiti siano installati
REM e fornisce link diretti per scaricare quelli mancanti.
REM
REM ============================================================================

setlocal enabledelayedexpansion

echo.
echo ============================================================================
echo CheatMod - Verifica Prerequisiti
echo ============================================================================
echo.
echo Questo script verifichera' che tutti i prerequisiti necessari siano
echo installati correttamente.
echo.
pause
echo.

set "ALL_OK=1"
set "MISSING_ITEMS="

REM ============================================================================
REM Verifica Git
REM ============================================================================

echo [1/4] Verifica Git...
echo.

where git >nul 2>&1
if errorlevel 1 (
    echo [X] Git NON trovato!
    echo.
    echo     Git e' necessario per clonare il repository C^&C Remastered.
    echo.
    echo     Download: https://git-scm.com/download/win
    echo.
    echo     Dopo l'installazione:
    echo     1. Riavvia il Prompt dei Comandi
    echo     2. Esegui di nuovo questo script
    echo.
    set "ALL_OK=0"
    set "MISSING_ITEMS=!MISSING_ITEMS! Git"
) else (
    for /f "tokens=*" %%i in ('git --version') do set GIT_VERSION=%%i
    echo [OK] Git installato: !GIT_VERSION!
)

echo.

REM ============================================================================
REM Verifica Visual Studio e MSBuild
REM ============================================================================

echo [2/4] Verifica Visual Studio e MSBuild...
echo.

set "MSBUILD_FOUND=0"
set "MSBUILD_PATH="
set "VS_VERSION="

REM Cerca VS 2022
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" (
    set "MSBUILD_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
    set "MSBUILD_FOUND=1"
    set "VS_VERSION=2022 Community"
)
if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" (
    set "MSBUILD_PATH=C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe"
    set "MSBUILD_FOUND=1"
    set "VS_VERSION=2022 Professional"
)
if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe" (
    set "MSBUILD_PATH=C:\Program Files\Microsoft Visual Studio\2022\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
    set "MSBUILD_FOUND=1"
    set "VS_VERSION=2022 Enterprise"
)

REM Cerca VS 2019
if !MSBUILD_FOUND!==0 (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" (
        set "MSBUILD_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"
        set "MSBUILD_FOUND=1"
        set "VS_VERSION=2019 Community"
    )
)

REM Cerca VS 2017
if !MSBUILD_FOUND!==0 (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe" (
        set "MSBUILD_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe"
        set "MSBUILD_FOUND=1"
        set "VS_VERSION=2017 Community"
    )
)

if !MSBUILD_FOUND!==1 (
    echo [OK] Visual Studio !VS_VERSION! trovato
    echo     MSBuild: !MSBUILD_PATH!
) else (
    echo [X] Visual Studio NON trovato!
    echo.
    echo     Visual Studio e' necessario per compilare la mod.
    echo     NON e' la stessa cosa di Visual Studio Code!
    echo.
    echo     Download Visual Studio 2022 Community (GRATUITO):
    echo     https://visualstudio.microsoft.com/it/downloads/
    echo.
    echo     Durante l'installazione, seleziona:
    echo     - Sviluppo di applicazioni desktop con C++
    echo     - Windows SDK 8.1
    echo     - MFC (nella sezione componenti individuali)
    echo.
    set "ALL_OK=0"
    set "MISSING_ITEMS=!MISSING_ITEMS! VisualStudio"
)

echo.

REM ============================================================================
REM Verifica Windows SDK 8.1
REM ============================================================================

echo [3/4] Verifica Windows SDK 8.1...
echo.

set "SDK_FOUND=0"

REM Cerca SDK 8.1 in diverse posizioni
if exist "C:\Program Files (x86)\Windows Kits\8.1\" (
    set "SDK_FOUND=1"
)
if exist "C:\Program Files\Windows Kits\8.1\" (
    set "SDK_FOUND=1"
)

REM Cerca anche tramite registry (più affidabile)
reg query "HKLM\SOFTWARE\Microsoft\Windows Kits\Installed Roots" /v KitsRoot81 >nul 2>&1
if !errorlevel!==0 (
    set "SDK_FOUND=1"
)

if !SDK_FOUND!==1 (
    echo [OK] Windows SDK 8.1 installato
) else (
    echo [?] Windows SDK 8.1 non rilevato
    echo.
    echo     Il Windows SDK 8.1 e' necessario per la compatibilita' con
    echo     il codice sorgente di C^&C Remastered.
    echo.
    echo     Installazione:
    echo     1. Apri Visual Studio Installer
    echo     2. Clicca "Modifica" sulla tua versione di Visual Studio
    echo     3. Vai su "Singoli componenti"
    echo     4. Cerca "Windows 8.1 SDK"
    echo     5. Selezionalo e clicca "Modifica"
    echo.
    echo     NOTA: Alcuni sistemi potrebbero funzionare anche senza.
    echo     Procedi con autopatcher.bat e vedi se compila correttamente.
    echo.
)

echo.

REM ============================================================================
REM Verifica Spazio su Disco
REM ============================================================================

echo [4/4] Verifica spazio su disco...
echo.

for /f "tokens=3" %%a in ('dir /-c ^| find "bytes free"') do set BYTES_FREE=%%a
set /a GB_FREE=%BYTES_FREE:~0,-9%

if %GB_FREE% GEQ 10 (
    echo [OK] Spazio su disco sufficiente: ~%GB_FREE% GB disponibili
) else (
    echo [!] Spazio su disco limitato: ~%GB_FREE% GB disponibili
    echo.
    echo     Sono consigliati almeno 10 GB di spazio libero per:
    echo     - Repository C^&C Remastered: ~3 GB
    echo     - File di build intermedi: ~5 GB
    echo     - Margine di sicurezza: ~2 GB
    echo.
    echo     Potresti incontrare problemi durante la compilazione.
    echo.
)

echo.

REM ============================================================================
REM Verifica Opzionale: C&C Remastered Collection
REM ============================================================================

echo [Extra] Verifica C^&C Remastered Collection...
echo.

set "GAME_FOUND=0"

REM Cerca nelle posizioni comuni di Steam
if exist "%PROGRAMFILES(X86)%\Steam\steamapps\common\CnCRemastered\" (
    set "GAME_FOUND=1"
    echo [OK] C^&C Remastered Collection trovato in Steam
)

if exist "%USERPROFILE%\Documents\CnCRemastered\" (
    echo [OK] Directory documenti C^&C trovata
    set "GAME_FOUND=1"
)

if !GAME_FOUND!==0 (
    echo [?] C^&C Remastered Collection non rilevato
    echo.
    echo     Per usare la mod, devi possedere il gioco su Steam.
    echo.
    echo     Link Steam:
    echo     https://store.steampowered.com/app/1213210/
    echo.
    echo     NOTA: Il gioco potrebbe essere installato in una posizione
    echo     diversa da quella standard. Se ce l'hai gia', ignora questo.
    echo.
)

echo.

REM ============================================================================
REM Riepilogo
REM ============================================================================

echo ============================================================================
echo Riepilogo Verifica
echo ============================================================================
echo.

if !ALL_OK!==1 (
    echo [OK] TUTTI I PREREQUISITI ESSENZIALI SONO INSTALLATI!
    echo.
    echo Sei pronto per eseguire autopatcher.bat
    echo.
    echo Prossimi passi:
    echo   1. Chiudi questo prompt
    echo   2. Apri un nuovo Prompt dei Comandi
    echo   3. Vai nella cartella della mod
    echo   4. Esegui: autopatcher.bat
    echo.
) else (
    echo [X] MANCANO ALCUNI PREREQUISITI
    echo.
    echo Prerequisiti mancanti:!MISSING_ITEMS!
    echo.
    echo Consulta PREREQUISITI.md per istruzioni dettagliate:
    echo   - Link di download diretti
    echo   - Istruzioni passo-passo
    echo   - Risoluzione problemi
    echo.
    echo Oppure apri PREREQUISITI.md ora?
)

echo ============================================================================
echo.

if !ALL_OK!==0 (
    set /p OPEN_GUIDE="Vuoi aprire PREREQUISITI.md ora? (S/N): "
    if /i "!OPEN_GUIDE!"=="S" (
        if exist "PREREQUISITI.md" (
            start notepad "PREREQUISITI.md"
        ) else (
            echo PREREQUISITI.md non trovato in questa cartella.
            echo.
        )
    )
)

echo.
echo Per informazioni dettagliate sui prerequisiti, vedi:
echo   PREREQUISITI.md
echo.
echo Per procedere con l'installazione automatica:
echo   autopatcher.bat
echo.
pause
endlocal
