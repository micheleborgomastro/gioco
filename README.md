# C&C Remastered Collection - Mod Shortcut Cheat

Mod per Command & Conquer Remastered Collection che aggiunge shortcut personalizzate per modificare parametri di gioco come soldi, potenza, e altro.

## Caratteristiche

Questa mod aggiunge le seguenti shortcut durante il gioco:

- **Ctrl + M**: Aggiunge 10.000 crediti
- **Ctrl + Shift + M**: Aggiunge 100.000 crediti
- **Ctrl + P**: Abilita energia illimitata
- **Ctrl + U**: Sblocca tutte le unità
- **Ctrl + B**: Costruzione istantanea
- **Ctrl + R**: Ricerca istantanea
- **Ctrl + G**: Modalità God Mode (unità invincibili)

## Requisiti

- Command & Conquer Remastered Collection (acquistato su Steam)
- Microsoft Visual Studio 2017 o superiore
- Windows SDK 8.1
- MFC (Microsoft Foundation Classes) per Visual Studio C++

## Installazione

> **⚠️ IMPORTANTE**: Non esiste una DLL pre-compilata. Devi compilare la mod dal codice sorgente.

### Compilazione e Installazione

1. Clona il repository ufficiale di C&C Remastered:
   ```bash
   git clone https://github.com/electronicarts/CnC_Remastered_Collection.git
   ```

2. Copia i file modificati da questo progetto:
   - `src/CONQUER_CHEAT_MOD.CPP` → `TIBERIANDAWN/`
   - `src/CHEAT_MOD.H` → `TIBERIANDAWN/`

3. Modifica `TIBERIANDAWN/CONQUER.CPP` per includere il nostro codice (vedi istruzioni sotto)

4. Apri `CnCRemastered.sln` in Visual Studio 2017

5. Vai su Build → Batch Build → Select All → Rebuild

6. I file compilati saranno in `bin/`

7. Copia `TiberianDawn.dll` e `TiberianDawn.pdb` in:
   `Documents\CnCRemastered\Mods\CheatMod\`

8. Copia `CCMOD.JSON` nella stessa cartella

## Struttura del Progetto

```
gioco/
├── README.md                    # Questo file
├── QUICKSTART.md                # Guida rapida per iniziare
├── CCMOD.JSON                   # Configurazione della mod
├── build.bat / build.sh         # Script di build automatici
├── src/                         # Codice sorgente della mod
│   ├── CONQUER_CHEAT_MOD.CPP   # Implementazione delle shortcut
│   ├── CHEAT_MOD.H             # Header con le dichiarazioni
│   └── PATCH_INSTRUCTIONS.md   # Istruzioni dettagliate per compilazione
├── bin/                         # DLL compilate (vuoto - da generare)
└── docs/                        # Documentazione aggiuntiva
    └── SHORTCUTS.md            # Lista completa delle shortcut
```

> **Nota**: La cartella `bin/` è vuota nel repository. Le DLL vengono generate dopo la compilazione.

## Come Funziona

La mod modifica il file `CONQUER.CPP` del gioco Tiberian Dawn per intercettare gli input da tastiera e modificare i parametri di gioco in tempo reale.

Il codice principale si trova in `src/CONQUER_CHEAT_MOD.CPP` e viene integrato nel loop principale del gioco.

## Limitazioni

- Funziona solo in modalità single-player o skirmish
- Non funziona nelle partite multiplayer online
- Richiede che il gioco sia installato tramite Steam

## Riferimenti

- [Repository Ufficiale C&C Remastered](https://github.com/electronicarts/CnC_Remastered_Collection)
- [Guida al Modding](https://gameplay.tips/guides/7816-command-and-conquer-remastered-collection.html)
- [Forum Project Perfect Mod](https://ppmforums.com/topic-48338/cc-remastered-dlls-source-code-is-available-on-github/)

## Licenza

Questo progetto è basato sul codice sorgente di C&C Remastered Collection, rilasciato sotto licenza GPL v3.0.

Il codice originale è © Electronic Arts Inc.
Le modifiche della mod sono rilasciate sotto la stessa licenza GPL v3.0.

## Contributi

Per modificare o estendere questa mod, consulta `src/PATCH_INSTRUCTIONS.md` per le istruzioni dettagliate.

## Disclaimer

Questa mod è solo per uso personale in single-player. L'uso di cheat in partite multiplayer online potrebbe violare i termini di servizio di Steam/EA.

---

**Divertiti con la tua mod personalizzata di Command & Conquer!**
