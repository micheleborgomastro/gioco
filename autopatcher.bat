@echo off
REM ============================================================================
REM AutoPatcher per CheatMod - C&C Remastered Collection
REM ============================================================================
REM
REM Questo script automatizza TUTTO il processo:
REM - Clone del repository C&C (se necessario)
REM - Copia dei file della mod
REM - Patch automatica di CONQUER.CPP
REM - Compilazione della DLL
REM - Installazione nella cartella mods
REM
REM TUTTO AUTOMATICO! Devi solo eseguire questo script.
REM
REM ============================================================================

setlocal enabledelayedexpansion

echo.
echo ============================================================================
echo CheatMod - AutoPatcher Automatico
echo ============================================================================
echo.
echo Questo script automatizzera' TUTTO il processo di build e installazione.
echo.
echo Cosa fara' lo script:
echo  [1] Clonare il repository C^&C Remastered (se necessario)
echo  [2] Copiare i file della mod
echo  [3] PATCHARE AUTOMATICAMENTE CONQUER.CPP (nessuna modifica manuale!)
echo  [4] Aggiungere i file al progetto Visual Studio
echo  [5] Compilare la DLL
echo  [6] Installare la mod
echo.
echo Tempo stimato: 10-30 minuti (dipende dalla velocità del PC)
echo.
pause
echo.

REM ============================================================================
REM Configurazione
REM ============================================================================

set "CNC_REPO=..\CnC_Remastered_Collection"
set "SOLUTION=%CNC_REPO%\CnCRemastered.sln"
set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe"
set "OUTPUT_DIR=bin"
set "MOD_INSTALL_DIR=%USERPROFILE%\Documents\CnCRemastered\Mods\CheatMod"

REM Cerca MSBuild in diverse posizioni
if not exist "%MSBUILD%" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\MSBuild.exe"
if not exist "%MSBUILD%" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\MSBuild.exe"
if not exist "%MSBUILD%" set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe"

REM ============================================================================
REM [1/6] Verifica Prerequisiti
REM ============================================================================

echo [1/6] Verifica prerequisiti...
echo.

REM Verifica MSBuild
if not exist "%MSBUILD%" (
    echo [ERRORE] MSBuild non trovato!
    echo.
    echo Visual Studio 2017 deve essere installato con:
    echo  - C++ Build Tools
    echo  - Windows SDK 8.1
    echo  - MFC (Microsoft Foundation Classes^)
    echo.
    echo Scarica Visual Studio 2017 da:
    echo https://visualstudio.microsoft.com/vs/older-downloads/
    echo.
    pause
    exit /b 1
)

echo [OK] MSBuild trovato: %MSBUILD%

REM Verifica Git
where git >nul 2>&1
if errorlevel 1 (
    echo [ERRORE] Git non trovato!
    echo.
    echo Installa Git da: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)

echo [OK] Git trovato
echo.

REM ============================================================================
REM [2/6] Clone Repository C&C
REM ============================================================================

echo [2/6] Preparazione repository C^&C Remastered...
echo.

if not exist "%CNC_REPO%" (
    echo Repository C^&C non trovato. Clone in corso...
    echo Questo richiedera' alcuni minuti...
    echo.

    cd ..
    git clone https://github.com/electronicarts/CnC_Remastered_Collection.git
    if errorlevel 1 (
        echo [ERRORE] Clone fallito!
        cd gioco
        pause
        exit /b 1
    )
    cd gioco

    echo [OK] Repository clonato con successo
) else (
    echo [OK] Repository gia' presente
)

echo.

REM ============================================================================
REM [3/6] Copia File della Mod e Applicazione Patch
REM ============================================================================

echo [3/6] Copia file della mod e applicazione patch automatica...
echo.

REM Copia header e implementation
echo Copia CHEAT_MOD.H...
copy /Y "src\CHEAT_MOD.H" "%CNC_REPO%\TIBERIANDAWN\" >nul
if errorlevel 1 (
    echo [ERRORE] Copia di CHEAT_MOD.H fallita
    pause
    exit /b 1
)

echo Copia CONQUER_CHEAT_MOD.CPP...
copy /Y "src\CONQUER_CHEAT_MOD.CPP" "%CNC_REPO%\TIBERIANDAWN\" >nul
if errorlevel 1 (
    echo [ERRORE] Copia di CONQUER_CHEAT_MOD.CPP fallita
    pause
    exit /b 1
)

echo [OK] File copiati
echo.

REM Crea backup di CONQUER.CPP
set "CONQUER_CPP=%CNC_REPO%\TIBERIANDAWN\CONQUER.CPP"
set "CONQUER_BACKUP=%CNC_REPO%\TIBERIANDAWN\CONQUER.CPP.backup"

if not exist "%CONQUER_BACKUP%" (
    echo Creazione backup di CONQUER.CPP...
    copy /Y "%CONQUER_CPP%" "%CONQUER_BACKUP%" >nul
    echo [OK] Backup creato
) else (
    echo [OK] Backup esistente trovato
)

echo.
echo Applicazione patch automatica a CONQUER.CPP...
echo.

REM Usa PowerShell per applicare le modifiche automaticamente
powershell -Command "$content = Get-Content '%CONQUER_CPP%' -Raw; if ($content -notmatch 'CHEAT_MOD.H') { $content = $content -replace '(#include\s+\"function\.h\")', '$1`r`n#include \"CHEAT_MOD.H\"'; Set-Content '%CONQUER_CPP%' $content -NoNewline; Write-Host '[OK] Include aggiunto' } else { Write-Host '[OK] Include gia presente' }"

powershell -Command "$content = Get-Content '%CONQUER_CPP%' -Raw; if ($content -notmatch 'Init_Cheat_Mod') { $content = $content -replace '(void\s+Select_Game\([^{]+\{[^\}]*?GameActive\s*=\s*true;)', '$1`r`n`r`n`t// Inizializza il sistema di cheat mod`r`n`tInit_Cheat_Mod();'; Set-Content '%CONQUER_CPP%' $content -NoNewline; Write-Host '[OK] Init_Cheat_Mod() aggiunto' } else { Write-Host '[OK] Init_Cheat_Mod() gia presente' }"

powershell -Command "$content = Get-Content '%CONQUER_CPP%' -Raw; if ($content -notmatch 'Process_Cheat_Keys') { $content = $content -replace '(input\s*=\s*Map\.Input;[^\r\n]*)', '$1`r`n`t`t`tProcess_Cheat_Keys(input);'; Set-Content '%CONQUER_CPP%' $content -NoNewline; Write-Host '[OK] Process_Cheat_Keys() aggiunto' } else { Write-Host '[OK] Process_Cheat_Keys() gia presente' }"

powershell -Command "$content = Get-Content '%CONQUER_CPP%' -Raw; if ($content -notmatch 'Apply_God_Mode') { $content = $content -replace '(Buildings\.AI\(\);)', '$1`r`n`r`n`t`t// Applica effetti cheat`r`n`t`tApply_Unlimited_Power();`r`n`t`tApply_Instant_Build();`r`n`t`tApply_Instant_Research();`r`n`t`tApply_God_Mode();'; Set-Content '%CONQUER_CPP%' $content -NoNewline; Write-Host '[OK] Apply functions aggiunte' } else { Write-Host '[OK] Apply functions gia presenti' }"

echo.
echo [OK] Patch applicata con successo!
echo.

REM ============================================================================
REM [4/6] Aggiunta File al Progetto Visual Studio
REM ============================================================================

echo [4/6] Aggiunta file al progetto Visual Studio...
echo.

set "VCXPROJ=%CNC_REPO%\TIBERIANDAWN\TiberianDawn.vcxproj"

REM Verifica se i file sono già nel progetto
findstr /C:"CONQUER_CHEAT_MOD.CPP" "%VCXPROJ%" >nul
if errorlevel 1 (
    echo Aggiunta CONQUER_CHEAT_MOD.CPP al progetto...

    powershell -Command "$content = Get-Content '%VCXPROJ%' -Raw; $content = $content -replace '(<ClCompile Include=\"CONQUER\.CPP\" />)', '$1`r`n    <ClCompile Include=\"CONQUER_CHEAT_MOD.CPP\" />'; Set-Content '%VCXPROJ%' $content -NoNewline"

    echo [OK] File CPP aggiunto
) else (
    echo [OK] File CPP gia nel progetto
)

findstr /C:"CHEAT_MOD.H" "%VCXPROJ%" >nul
if errorlevel 1 (
    echo Aggiunta CHEAT_MOD.H al progetto...

    powershell -Command "$content = Get-Content '%VCXPROJ%' -Raw; $content = $content -replace '(<ClInclude Include=\"CONST\.H\" />)', '$1`r`n    <ClInclude Include=\"CHEAT_MOD.H\" />'; Set-Content '%VCXPROJ%' $content -NoNewline"

    echo [OK] File H aggiunto
) else (
    echo [OK] File H gia nel progetto
)

echo.

REM ============================================================================
REM [5/6] Compilazione
REM ============================================================================

echo [5/6] Compilazione in corso...
echo.
echo ATTENZIONE: Questo richiedera' 5-15 minuti a seconda del tuo PC.
echo Puoi prendere un caffe' nel frattempo... :^)
echo.

"%MSBUILD%" "%SOLUTION%" /t:TiberianDawn /p:Configuration=Release /p:Platform=Win32 /m /v:minimal /nologo

if errorlevel 1 (
    echo.
    echo [ERRORE] Compilazione fallita!
    echo.
    echo Controlla i messaggi di errore sopra.
    echo Se il problema persiste:
    echo  1. Apri %SOLUTION% in Visual Studio
    echo  2. Prova a compilare manualmente
    echo  3. Controlla che tutti i componenti siano installati
    echo.
    pause
    exit /b 1
)

echo.
echo [OK] Compilazione completata con successo!
echo.

REM ============================================================================
REM [6/6] Installazione
REM ============================================================================

echo [6/6] Installazione della mod...
echo.

REM Trova la DLL compilata
set "COMPILED_DLL=%CNC_REPO%\bin\Win32\Release\TiberianDawn.dll"

if not exist "%COMPILED_DLL%" (
    echo [ERRORE] DLL compilata non trovata!
    echo Percorso cercato: %COMPILED_DLL%
    pause
    exit /b 1
)

REM Crea directory di output
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Copia in bin locale
echo Copia DLL in bin locale...
copy /Y "%COMPILED_DLL%" "%OUTPUT_DIR%\" >nul

REM Crea directory mod
if not exist "%MOD_INSTALL_DIR%" mkdir "%MOD_INSTALL_DIR%"

REM Installa nella directory mod
echo Installa nella directory mod del gioco...
copy /Y "%COMPILED_DLL%" "%MOD_INSTALL_DIR%\" >nul
copy /Y "CCMOD.JSON" "%MOD_INSTALL_DIR%\" >nul

echo.
echo [OK] Installazione completata!
echo.

REM ============================================================================
REM Completamento
REM ============================================================================

echo ============================================================================
echo SUCCESSO! Mod installata con successo!
echo ============================================================================
echo.
echo La mod e' stata installata in:
echo %MOD_INSTALL_DIR%
echo.
echo PROSSIMI PASSI:
echo.
echo 1. Avvia Command ^& Conquer Remastered Collection
echo 2. Vai al menu Mod Manager
echo 3. Attiva "CheatMod - Shortcut Personalizzate"
echo 4. Inizia una partita Single-player o Skirmish
echo 5. Prova le shortcut (Ctrl+M per crediti, Ctrl+G per god mode, ecc.^)
echo.
echo Shortcut disponibili:
echo   Ctrl+M         - +10,000 crediti
echo   Ctrl+Shift+M   - +100,000 crediti
echo   Ctrl+P         - Energia illimitata
echo   Ctrl+U         - Sblocca tutto
echo   Ctrl+B         - Costruzione istantanea
echo   Ctrl+G         - God Mode
echo.
echo Per la lista completa, vedi docs\SHORTCUTS.md
echo.
echo ============================================================================
echo.

set /p OPEN_DOCS="Vuoi aprire la documentazione delle shortcut? (S/N): "
if /i "%OPEN_DOCS%"=="S" (
    start notepad "docs\SHORTCUTS.md"
)

echo.
echo Grazie per aver usato CheatMod AutoPatcher!
echo Buon divertimento con C^&C Remastered! :^)
echo.
pause
endlocal
