# 📋 Guida all'Installazione dei Prerequisiti

Questa guida ti aiuterà ad installare **TUTTI** i prerequisiti necessari per compilare la mod.

## ⚠️ IMPORTANTE: Visual Studio Code ≠ Visual Studio

**Visual Studio Code** (VS Code) è un editor di testo leggero.
**Visual Studio** è un IDE completo con compilatore C++ - **QUESTO** è quello che ti serve!

Se hai solo VS Code, devi installare Visual Studio separatamente.

---

## 📦 Prerequisito 1: Visual Studio (con C++ e MFC)

### Opzione A: Visual Studio 2022 (Consigliata - Più Recente)

Se hai già VS 2022, perfetto! Devi solo aggiungere i componenti necessari.

**1. Apri Visual Studio Installer**
   - Cerca "Visual Studio Installer" nel menu Start
   - Oppure scaricalo da: https://visualstudio.microsoft.com/it/downloads/

**2. Clicca su "Modifica" accanto a Visual Studio 2022**

**3. Seleziona questi componenti:**

   ✅ **Workload da installare:**
   - "Sviluppo di applicazioni desktop con C++"

   ✅ **Componenti individuali** (cerca nella tab "Singoli componenti"):
   - "MSVC v142 - Strumenti di compilazione C/C++ per VS 2019 (v14.29)" o simile
   - "Windows 10 SDK (10.0.19041.0)" o più recente
   - "Windows 8.1 SDK" (importante!)
   - "MFC C++ per build tools v142 più recenti" oppure "ATL/MFC per v142"
   - "Strumenti di compilazione C++/CLI per v142"

**4. Clicca "Modifica" e aspetta l'installazione** (può richiedere 30-60 minuti)

### Opzione B: Visual Studio 2017 (Originale - Più Compatibile)

Se preferisci la versione originalmente testata:

**Download:** https://visualstudio.microsoft.com/vs/older-downloads/

1. Accedi con un account Microsoft (gratuito)
2. Cerca "Visual Studio 2017"
3. Scarica "Visual Studio Community 2017" (gratuito)

**Durante l'installazione seleziona:**
- ✅ Sviluppo di applicazioni desktop con C++
- ✅ Windows 8.1 SDK
- ✅ MFC e ATL (nella sezione componenti individuali)

### Come Verificare l'Installazione

Dopo l'installazione, verifica che MSBuild sia presente:

```cmd
"C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe" -version
```

oppure per VS 2017:

```cmd
"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe" -version
```

Se vedi la versione di MSBuild, è installato correttamente! ✅

---

## 📦 Prerequisito 2: Git

Git è necessario per clonare il repository C&C Remastered.

### Download Git per Windows

**Link diretto:** https://git-scm.com/download/win

**Installazione:**
1. Scarica il file `.exe`
2. Esegui l'installer
3. Usa le impostazioni predefinite (clicca "Next" per tutto)
4. Riavvia il terminale/prompt dei comandi dopo l'installazione

### Verifica Installazione

Apri un nuovo Prompt dei Comandi e digita:

```cmd
git --version
```

Dovresti vedere qualcosa come: `git version 2.43.0.windows.1` ✅

---

## 📦 Prerequisito 3: Command & Conquer Remastered Collection

Devi possedere il gioco su Steam.

**Link Steam:** https://store.steampowered.com/app/1213210/Command__Conquer_Remastered_Collection/

**Prezzo:** ~€19,99 (spesso in sconto)

Se già ce l'hai, perfetto! ✅

---

## 📦 Prerequisito 4: Spazio su Disco

Assicurati di avere almeno **10 GB liberi** su disco:

- Repository C&C Remastered: ~3 GB
- Build intermedie: ~5 GB
- Visual Studio (se da installare): ~5-10 GB

---

## 🔧 Risoluzione Problemi Comuni

### Problema: "MSBuild non trovato" con VS 2022

**Causa:** L'autopatcher cerca MSBuild di VS 2017, ma tu hai VS 2022.

**Soluzione 1:** Modifica `autopatcher.bat`

Apri `autopatcher.bat` con un editor di testo e trova questa sezione (circa linea 30):

```batch
set "MSBUILD=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\MSBuild.exe"
```

Aggiungi PRIMA di questa riga:

```batch
set "MSBUILD=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
```

**Soluzione 2:** Usa lo script aggiornato

Ho creato `autopatcher_vs2022.bat` che cerca automaticamente VS 2022.

### Problema: "Windows SDK 8.1 non trovato"

**Causa:** Non hai installato Windows SDK 8.1

**Soluzione:**

1. Apri Visual Studio Installer
2. Clicca "Modifica"
3. Vai su "Singoli componenti"
4. Cerca "Windows 8.1 SDK"
5. Selezionalo
6. Clicca "Modifica" per installare

### Problema: "MFC non trovato durante la compilazione"

**Causa:** MFC non è installato

**Soluzione:**

1. Apri Visual Studio Installer
2. Clicca "Modifica"
3. Vai su "Singoli componenti"
4. Cerca "MFC"
5. Seleziona "MFC C++ per build tools v142/v143" (o simile)
6. Clicca "Modifica"

### Problema: Git non funziona dopo l'installazione

**Causa:** Il PATH non è aggiornato

**Soluzione:**

1. Chiudi TUTTI i prompt dei comandi aperti
2. Riapri un nuovo Prompt dei Comandi
3. Riprova `git --version`

Se ancora non funziona:
1. Riavvia il PC
2. Riprova

---

## ✅ Checklist Finale

Prima di eseguire `autopatcher.bat`, verifica:

- [ ] Visual Studio 2017/2019/2022 installato con C++
- [ ] Windows SDK 8.1 installato
- [ ] MFC installato
- [ ] Git installato e funzionante
- [ ] Almeno 10 GB di spazio libero
- [ ] C&C Remastered Collection posseduto su Steam

---

## 🚀 Pronto per Continuare?

Una volta installati tutti i prerequisiti:

1. Chiudi tutti i Prompt dei Comandi aperti
2. Riapri un nuovo Prompt dei Comandi (per ricaricare il PATH)
3. Vai nella cartella della mod: `cd percorso\gioco`
4. Esegui: `autopatcher.bat`

---

## 📞 Hai Ancora Problemi?

Se dopo aver seguito questa guida hai ancora problemi:

1. **Apri una Issue** su GitHub con:
   - Sistema operativo (es. Windows 11)
   - Versione di Visual Studio installata
   - Messaggi di errore esatti
   - Screenshot dell'errore

2. **Controlla i log** di Visual Studio in:
   `CnC_Remastered_Collection\bin\Win32\Release\`

3. **Prova la compilazione manuale** aprendo `CnCRemastered.sln` in Visual Studio per vedere errori più dettagliati

---

## 💡 Suggerimento: Verifica Automatica

Ho creato uno script `verifica_prerequisiti.bat` che controlla automaticamente se hai tutto installato!

Eseguilo prima di `autopatcher.bat` per vedere cosa manca.
