# 🚀 AutoPatcher - Installazione Automatica in 3 Passi

## La Soluzione Più Semplice!

Hai chiesto, ho creato! Ora puoi installare la mod **AUTOMATICAMENTE** senza modificare nulla manualmente.

## 📋 Prerequisiti (Solo Questi!)

Prima di eseguire l'autopatcher, assicurati di avere:

1. **Windows** (lo script è per Windows)
2. **Visual Studio 2017** installato con:
   - C++ Build Tools
   - Windows SDK 8.1
   - MFC (Microsoft Foundation Classes)
3. **Git** installato ([Download Git](https://git-scm.com/download/win))
4. **Command & Conquer Remastered Collection** su Steam

> **Nota**: Se non hai Visual Studio 2017, scaricalo da [qui](https://visualstudio.microsoft.com/vs/older-downloads/)

## 🎯 Installazione in 3 Passi

### Passo 1: Scarica il Progetto

Se non l'hai già fatto:
```bash
git clone https://github.com/tuousername/gioco.git
cd gioco
```

### Passo 2: Esegui l'AutoPatcher

**Doppio click** su `autopatcher.bat`

oppure da terminale:
```cmd
autopatcher.bat
```

### Passo 3: Aspetta e Bevi un Caffè ☕

Lo script farà **TUTTO AUTOMATICAMENTE**:

```
✓ Clona il repository C&C Remastered
✓ Copia i file della mod
✓ Patcha automaticamente CONQUER.CPP (nessuna modifica manuale!)
✓ Aggiunge i file al progetto Visual Studio
✓ Compila la DLL (5-15 minuti)
✓ Installa la mod nella cartella gioco
```

**Tempo totale**: 10-30 minuti (a seconda del PC)

## ✅ Fatto!

Quando lo script finisce:

1. Avvia **Command & Conquer Remastered Collection**
2. Vai al **Mod Manager**
3. Attiva **"CheatMod - Shortcut Personalizzate"**
4. Gioca! 🎮

## 🎮 Shortcut Disponibili

In gioco, premi:

| Tasto | Funzione |
|-------|----------|
| `Ctrl + M` | +10,000 crediti |
| `Ctrl + Shift + M` | +100,000 crediti |
| `Ctrl + P` | Energia illimitata |
| `Ctrl + U` | Sblocca tutto |
| `Ctrl + B` | Costruzione istantanea |
| `Ctrl + R` | Ricerca istantanea |
| `Ctrl + G` | God Mode |

## ❓ Cosa Fare Se Qualcosa Va Storto

### L'autopatcher non parte

**Errore**: "MSBuild non trovato"
- **Soluzione**: Installa Visual Studio 2017 con i componenti C++

**Errore**: "Git non trovato"
- **Soluzione**: Installa Git da https://git-scm.com/download/win

### La compilazione fallisce

**Errore**: Errori durante la compilazione
- **Soluzione 1**: Verifica che Visual Studio 2017 abbia:
  - Windows SDK 8.1
  - MFC
  - C++ Build Tools
- **Soluzione 2**: Apri `CnCRemastered.sln` in Visual Studio e compila manualmente

### La mod non appare nel gioco

**Problema**: Mod non nel Mod Manager
- **Soluzione**: Verifica che i file siano in:
  ```
  C:\Users\TuoNome\Documents\CnCRemastered\Mods\CheatMod\
  ```
- Dovrebbero esserci:
  - `TiberianDawn.dll`
  - `CCMOD.JSON`

### Le shortcut non funzionano

**Problema**: I tasti non fanno nulla
- **Soluzione**: Assicurati di essere in **Single-player** o **Skirmish**
- Le shortcut NON funzionano in multiplayer online

## 🔄 Aggiornare la Mod

Se esce una nuova versione:

1. Scarica la nuova versione del progetto
2. Esegui di nuovo `autopatcher.bat`
3. Lo script aggiornerà automaticamente tutto

## 🗑️ Disinstallare la Mod

Per rimuovere la mod:

1. Vai a: `Documents\CnCRemastered\Mods\CheatMod\`
2. Elimina la cartella `CheatMod`
3. Riavvia il gioco

oppure usa `uninstall.bat` (se presente)

## 📚 Documentazione Completa

Se vuoi saperne di più:

- **README.md** - Panoramica del progetto
- **docs/SHORTCUTS.md** - Lista dettagliata shortcut
- **QUICKSTART.md** - Guida manuale (se non vuoi usare l'autopatcher)
- **src/PATCH_INSTRUCTIONS.md** - Come funziona il patching

## 🎉 Fatto!

Ora hai la mod installata e funzionante.

**Divertiti con i cheat in C&C Remastered!** 🚀

---

### Nota Tecnica

L'AutoPatcher usa PowerShell per applicare automaticamente le modifiche al codice sorgente di C&C Remastered. Non devi più modificare manualmente nessun file!

**Script intelligente**: Se esegui l'autopatcher più volte, rileverà automaticamente cosa è già stato fatto e non duplicherà le modifiche.

---

**Hai problemi?** Apri una Issue su GitHub o consulta la documentazione completa!
