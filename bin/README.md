# Cartella bin/

Questa cartella è destinata a contenere le DLL compilate della mod.

## ⚠️ Cartella Vuota

Inizialmente questa cartella è **vuota**. NON ci sono DLL pre-compilate disponibili per il download.

## Come Ottenere la DLL

Devi compilare la mod dal codice sorgente seguendo questi passi:

### 1. Usa gli Script di Build

**Windows:**
```cmd
build.bat
```

**Linux/Mac (per preparazione):**
```bash
./build.sh
```

### 2. Compila con Visual Studio 2017

1. Segui le istruzioni in `../src/PATCH_INSTRUCTIONS.md`
2. Compila il progetto C&C Remastered con le modifiche applicate
3. La DLL risultante (`TiberianDawn.dll`) verrà copiata automaticamente qui

### 3. File che Troverai Dopo la Compilazione

Dopo una compilazione riuscita, questa cartella conterrà:

- `TiberianDawn.dll` - La DLL della mod compilata
- `TiberianDawn.pdb` - File di debug (opzionale)
- `README.txt` - Istruzioni per installazione (generato dagli script)

## Installazione

Una volta che hai la DLL compilata:

1. Crea la cartella della mod:
   ```
   Documents\CnCRemastered\Mods\CheatMod\
   ```

2. Copia in quella cartella:
   - `bin/TiberianDawn.dll`
   - `../CCMOD.JSON`

3. Avvia il gioco e attiva la mod dal Mod Manager

## Guida Rapida

Per istruzioni complete, consulta:
- `../QUICKSTART.md` - Guida rapida passo-passo
- `../src/PATCH_INSTRUCTIONS.md` - Istruzioni dettagliate di compilazione
- `../README.md` - Panoramica del progetto

## Perché Non C'è una DLL Pre-compilata?

1. **Dimensioni**: La DLL è grande e cambierebbe ad ogni modifica
2. **Sicurezza**: È meglio che gli utenti compilino il proprio codice da sorgente verificabile
3. **Licenza**: La DLL include codice di C&C Remastered (GPL v3.0) che richiede distribuzione del sorgente
4. **Personalizzazione**: Compilando tu stesso puoi facilmente modificare e personalizzare la mod

## Problemi?

Se hai difficoltà con la compilazione:

1. Verifica di avere Visual Studio 2017 (non versioni più recenti)
2. Assicurati di aver installato Windows SDK 8.1 e MFC
3. Controlla `../src/PATCH_INSTRUCTIONS.md` per troubleshooting
4. Consulta la sezione "Risoluzione Problemi" in `../QUICKSTART.md`
