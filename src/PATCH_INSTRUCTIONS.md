# Istruzioni per Applicare la Mod al Codice Sorgente

Questo documento spiega come integrare il codice della mod nel codice sorgente originale di C&C Remastered Collection.

## Prerequisiti

1. Clone del repository ufficiale:
   ```bash
   git clone https://github.com/electronicarts/CnC_Remastered_Collection.git
   cd CnC_Remastered_Collection
   ```

2. Visual Studio 2017 installato con:
   - Windows SDK 8.1
   - MFC (Microsoft Foundation Classes)
   - C++ build tools

## Passaggi per l'Integrazione

### 1. Copia i File della Mod

Copia i file della mod nella directory del progetto:

```bash
# Dalla directory della mod (gioco/)
cp src/CHEAT_MOD.H ../CnC_Remastered_Collection/TIBERIANDAWN/
cp src/CONQUER_CHEAT_MOD.CPP ../CnC_Remastered_Collection/TIBERIANDAWN/
```

### 2. Modifica CONQUER.CPP

Apri `TIBERIANDAWN/CONQUER.CPP` e applica le seguenti modifiche:

#### A. Aggiungi l'include all'inizio del file

Trova la sezione degli include (circa linea 20-40) e aggiungi:

```cpp
#include "CHEAT_MOD.H"
```

#### B. Inizializza il sistema di cheat

Trova la funzione `Select_Game()` e all'inizio della funzione aggiungi:

```cpp
void Select_Game(bool fade)
{
    // ... codice esistente ...

    // Inizializza il sistema di cheat mod
    Init_Cheat_Mod();

    // ... resto del codice ...
}
```

#### C. Integra il processing dei tasti

Trova il main game loop nella funzione `Main_Game()` (cerca la sezione che gestisce `KeyNumType input`).

Circa alla linea 2500-3000, troverai un blocco simile a:

```cpp
KeyNumType input = KN_NONE;
if (Map.Input != KN_NONE) {
    input = Map.Input;
}
```

Subito dopo questo blocco, PRIMA del processing dei tasti esistente, aggiungi:

```cpp
// Processing dei cheat mod
Process_Cheat_Keys(input);
```

#### D. Applica gli effetti dei cheat nel game loop

Trova il main loop dove vengono aggiornati gli oggetti (cerca `Buildings.AI()`, `Units.AI()`, ecc.).

Subito dopo queste chiamate, aggiungi:

```cpp
// Applica gli effetti dei cheat attivi
Apply_Unlimited_Power();
Apply_Instant_Build();
Apply_Instant_Research();
Apply_God_Mode();
```

### 3. Modifica il File di Progetto

#### Opzione A: Tramite Visual Studio (Consigliato)

1. Apri `CnCRemastered.sln` in Visual Studio 2017
2. Nel Solution Explorer, trova il progetto "TiberianDawn"
3. Tasto destro su "Source Files" → Add → Existing Item
4. Seleziona `CONQUER_CHEAT_MOD.CPP`
5. Tasto destro su "Header Files" → Add → Existing Item
6. Seleziona `CHEAT_MOD.H`

#### Opzione B: Modifica Manuale del .vcxproj

Apri `TIBERIANDAWN/TiberianDawn.vcxproj` e aggiungi:

Nella sezione `<ItemGroup>` con gli altri file `.cpp`:
```xml
<ClCompile Include="CONQUER_CHEAT_MOD.CPP" />
```

Nella sezione `<ItemGroup>` con gli altri file `.h`:
```xml
<ClInclude Include="CHEAT_MOD.H" />
```

### 4. Compilazione

1. Apri `CnCRemastered.sln` in Visual Studio 2017
2. Seleziona la configurazione: **Release** (oppure Debug per testing)
3. Seleziona la piattaforma: **Win32**
4. Menu: Build → Batch Build
5. Clicca "Select All"
6. Clicca "Rebuild"

La compilazione richiederà alcuni minuti. Al termine, i file compilati saranno in:
```
CnC_Remastered_Collection/bin/Win32/Release/
```

### 5. Installazione della Mod Compilata

1. Crea la cartella della mod:
   ```
   Documents\CnCRemastered\Mods\CheatMod\
   ```

2. Copia i file compilati:
   ```bash
   # Da CnC_Remastered_Collection/bin/Win32/Release/
   cp TiberianDawn.dll Documents/CnCRemastered/Mods/CheatMod/
   cp TiberianDawn.pdb Documents/CnCRemastered/Mods/CheatMod/
   ```

3. Copia il file di configurazione:
   ```bash
   # Dalla directory della mod (gioco/)
   cp CCMOD.JSON Documents/CnCRemastered/Mods/CheatMod/
   ```

### 6. Attivazione nel Gioco

1. Avvia Command & Conquer Remastered Collection
2. Vai al menu principale
3. Seleziona "Mod Manager" o "Gestione Mod"
4. Trova "CheatMod - Shortcut Personalizzate" nella lista
5. Attiva la mod
6. Riavvia il gioco se richiesto

## Testing

Una volta avviato il gioco con la mod attiva:

1. Avvia una partita single-player o skirmish
2. Durante il gioco, prova le shortcut:
   - `Ctrl+M` - Dovresti vedere i tuoi crediti aumentare di 10,000
   - `Ctrl+Shift+M` - Dovresti vedere i tuoi crediti aumentare di 100,000
   - `Ctrl+P` - Dovrebbe attivare/disattivare l'energia illimitata
   - `Ctrl+G` - Dovrebbe attivare/disattivare il god mode

## Troubleshooting

### Errori di Compilazione

**Errore**: `Cannot find CHEAT_MOD.H`
- **Soluzione**: Verifica di aver copiato correttamente il file nella directory TIBERIANDAWN/

**Errore**: `Unresolved external symbol`
- **Soluzione**: Assicurati di aver aggiunto `CONQUER_CHEAT_MOD.CPP` al progetto

**Errore**: `Packing mismatch`
- **Soluzione**: Usa Visual Studio 2017 invece di versioni più recenti

### La Mod Non Si Carica

**Problema**: La mod non appare nel Mod Manager
- **Soluzione**: Verifica che `CCMOD.JSON` sia nella stessa directory della DLL

**Problema**: La mod appare ma non si attiva
- **Soluzione**: Controlla i log del gioco in `Documents\CnCRemastered\Logs\`

### Le Shortcut Non Funzionano

**Problema**: I tasti non fanno nulla
- **Soluzione**: Verifica di aver integrato correttamente `Process_Cheat_Keys()` in CONQUER.CPP
- **Soluzione**: Assicurati di essere in una partita single-player o skirmish, non in multiplayer

## Estensione della Mod

### Aggiungere Nuove Shortcut

1. Definisci la nuova combinazione in `CHEAT_MOD.H`:
   ```cpp
   #define CHEAT_MYANEW_CHEAT (KN_X | CTRL_BIT) // Ctrl+X
   ```

2. Aggiungi il processing in `Process_Cheat_Keys()` in `CONQUER_CHEAT_MOD.CPP`:
   ```cpp
   if (input == CHEAT_MY_NEW_CHEAT) {
       // Il tuo codice qui
       Show_Cheat_Message("Nuovo Cheat Attivato");
       input = KN_NONE;
       return;
   }
   ```

3. Ricompila e testa

### Modificare Altri Parametri

Il codice ti dà accesso a:
- `PlayerPtr->Credits` - Crediti del giocatore
- `PlayerPtr->Power` - Energia disponibile
- `PlayerPtr->Drain` - Consumo energia
- `Units`, `Infantry`, `Buildings` - Array di tutte le unità/edifici
- E molto altro nel codice sorgente originale

Esplora il codice in `TIBERIANDAWN/` per trovare altri parametri modificabili.

## Riferimenti Utili

- [Codice Sorgente Originale](https://github.com/electronicarts/CnC_Remastered_Collection)
- [Documentazione CONQUER.CPP](https://github.com/electronicarts/CnC_Remastered_Collection/blob/master/TIBERIANDAWN/CONQUER.CPP)
- [Forum Modding](https://ppmforums.com/topic-48338/cc-remastered-dlls-source-code-is-available-on-github/)

## Note Importanti

- Fai sempre un backup della DLL originale prima di sostituirla
- I cheat funzionano solo in single-player e skirmish
- Non usare i cheat in multiplayer online - potrebbe violare i ToS
- Questa mod è solo per uso personale ed educativo
