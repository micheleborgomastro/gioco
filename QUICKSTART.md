# Guida Rapida - CheatMod per C&C Remastered

Una guida veloce per iniziare subito con la mod!

## Setup Rapido (5 minuti)

### Prerequisiti

Assicurati di avere:
- ✅ Command & Conquer Remastered Collection (su Steam)
- ✅ Visual Studio 2017 con Windows SDK 8.1
- ✅ 10 GB di spazio libero su disco

### Opzione 1: Usa la DLL Pre-compilata (PIÙ VELOCE)

> **Nota**: Attualmente non è disponibile una DLL pre-compilata. Devi compilare la mod seguendo l'Opzione 2.

1. Scarica `TiberianDawn.dll` dalla sezione Releases
2. Crea la cartella: `Documents\CnCRemastered\Mods\CheatMod\`
3. Copia `TiberianDawn.dll` e `CCMOD.JSON` nella cartella
4. Avvia il gioco → Mod Manager → Attiva "CheatMod"
5. Gioca! 🎮

### Opzione 2: Compila da Codice Sorgente

#### Passo 1: Clone dei Repository

```bash
# Clona questo repository (se non l'hai già fatto)
git clone https://github.com/tuousername/gioco.git
cd gioco

# Clona il repository ufficiale C&C Remastered
cd ..
git clone https://github.com/electronicarts/CnC_Remastered_Collection.git
cd gioco
```

#### Passo 2: Setup Automatico

**Su Linux/Mac/WSL:**
```bash
./build.sh
```

**Su Windows:**
```cmd
build.bat
```

Lo script ti guiderà attraverso il processo!

#### Passo 3: Applicare le Modifiche Manuali

Apri `../CnC_Remastered_Collection/TIBERIANDAWN/CONQUER.CPP` e:

1. **Aggiungi l'include** (circa linea 30):
```cpp
#include "CHEAT_MOD.H"
```

2. **Inizializza il sistema** nella funzione `Select_Game()`:
```cpp
void Select_Game(bool fade)
{
    // ... codice esistente ...
    Init_Cheat_Mod();  // <-- AGGIUNGI QUESTA RIGA
    // ... resto del codice ...
}
```

3. **Aggiungi il processing dei tasti** nella funzione `Main_Game()` (cerca `KeyNumType input`):
```cpp
KeyNumType input = KN_NONE;
if (Map.Input != KN_NONE) {
    input = Map.Input;
}
Process_Cheat_Keys(input);  // <-- AGGIUNGI QUESTA RIGA
```

4. **Applica gli effetti** nel main loop (cerca `Buildings.AI()`, `Units.AI()`):
```cpp
// ... dopo le chiamate AI esistenti ...
Apply_Unlimited_Power();     // <-- AGGIUNGI
Apply_Instant_Build();       // <-- QUESTE
Apply_Instant_Research();    // <-- QUATTRO
Apply_God_Mode();            // <-- RIGHE
```

> **Tip**: Cerca le sezioni esatte consultando `src/PATCH_INSTRUCTIONS.md` per riferimenti precisi alle linee.

#### Passo 4: Compilazione

**Windows (Visual Studio):**
1. Apri `../CnC_Remastered_Collection/CnCRemastered.sln`
2. Seleziona: **Release** | **Win32**
3. Menu → Build → Batch Build → Select All → Rebuild
4. Aspetta 5-10 minuti ☕
5. Trova la DLL in: `../CnC_Remastered_Collection/bin/Win32/Release/TiberianDawn.dll`

**Windows (Script):**
```cmd
build.bat
```
Il script farà tutto automaticamente!

#### Passo 5: Installazione

1. Crea la cartella:
```
%USERPROFILE%\Documents\CnCRemastered\Mods\CheatMod\
```

2. Copia questi file nella cartella:
   - `bin/TiberianDawn.dll`
   - `CCMOD.JSON`

3. Avvia C&C Remastered Collection

4. Vai su: **Menu Principale → Mod Manager**

5. Trova **"CheatMod - Shortcut Personalizzate"** e attivala

6. Riavvia il gioco se richiesto

7. Gioca! 🎮

## Shortcut Principali

Una volta in gioco, usa queste shortcut:

| Tasto | Funzione |
|-------|----------|
| `Ctrl + M` | +10,000 crediti |
| `Ctrl + Shift + M` | +100,000 crediti |
| `Ctrl + P` | Energia illimitata |
| `Ctrl + U` | Sblocca tutto |
| `Ctrl + B` | Costruzione istantanea |
| `Ctrl + G` | God Mode |

> Consulta `docs/SHORTCUTS.md` per la lista completa!

## Test Veloce

Per verificare che tutto funzioni:

1. Avvia una partita **Skirmish** (contro IA)
2. Una volta in gioco, premi `Ctrl + M`
3. Dovresti vedere i tuoi crediti aumentare di 10,000
4. Funziona? Perfetto! 🎉
5. Non funziona? Vedi "Risoluzione Problemi" sotto

## Risoluzione Problemi

### La mod non appare nel Mod Manager

❌ **Problema**: Mod non visibile
✅ **Soluzione**:
- Verifica che `CCMOD.JSON` sia nella stessa cartella della DLL
- Controlla il percorso: `Documents\CnCRemastered\Mods\CheatMod\`
- Riavvia il gioco

### La mod non si attiva

❌ **Problema**: Mod visibile ma non attivabile
✅ **Soluzione**:
- Controlla i log in: `Documents\CnCRemastered\Logs\`
- Verifica che la DLL sia compatibile (compilata per Win32 Release)
- Prova a disattivare altre mod

### Le shortcut non funzionano

❌ **Problema**: I tasti non fanno nulla in gioco
✅ **Soluzione**:
- Assicurati di essere in **Single-player** o **Skirmish** (non Multiplayer!)
- Verifica di aver applicato tutte le modifiche a `CONQUER.CPP`
- Ricompila la mod dopo aver applicato le modifiche

### Errori di compilazione

❌ **Problema**: Build fallisce in Visual Studio
✅ **Soluzione**:
- Usa **Visual Studio 2017** (non versioni più recenti)
- Installa **Windows SDK 8.1**
- Installa **MFC** (Microsoft Foundation Classes)
- Verifica che tutti i file siano stati copiati correttamente

## Supporto e Documentazione

Per maggiori dettagli:

- 📖 **README.md** - Panoramica completa del progetto
- ⌨️ **docs/SHORTCUTS.md** - Lista dettagliata di tutte le shortcut
- 🔧 **src/PATCH_INSTRUCTIONS.md** - Istruzioni passo-passo per le modifiche
- 💬 **Issues** - Segnala problemi o chiedi aiuto

## Prossimi Passi

Ora che la mod funziona:

1. 🎮 **Gioca** e divertiti con i cheat!
2. 🛠️ **Personalizza** - Modifica le shortcut o aggiungine di nuove
3. 📤 **Condividi** - Fai sapere ad altri della tua mod
4. 🌟 **Contribuisci** - Migliora la mod e condividi le tue modifiche

## Esempi di Uso

### Scenario: Vuoi testare una strategia late-game

```
1. Avvia partita Skirmish
2. Ctrl + Shift + M (100k crediti)
3. Ctrl + U (sblocca tutto)
4. Ctrl + B (costruzione istantanea)
5. Costruisci la tua armata!
```

### Scenario: Difesa contro ondate nemiche

```
1. Ctrl + P (energia illimitata)
2. Ctrl + U (sblocca difese)
3. Ctrl + B (costruzione istantanea)
4. Piazza torrette ovunque!
5. Ctrl + G (god mode opzionale)
```

### Scenario: Sandbox creativo

```
1. Ctrl + Shift + M (crediti)
2. Ctrl + P (energia)
3. Ctrl + U (tutto sbloccato)
4. Ctrl + B (costruzione istantanea)
5. Ctrl + G (invincibilità)
6. Costruisci la base dei tuoi sogni!
```

---

**Hai domande?** Apri una Issue su GitHub o consulta la documentazione completa!

**Buon divertimento con C&C Remastered! 🎮✨**
