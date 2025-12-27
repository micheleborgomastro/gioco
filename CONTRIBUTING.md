# Come Contribuire

Grazie per il tuo interesse nel contribuire a CheatMod! Questo documento fornisce linee guida per contribuire al progetto.

## Modi per Contribuire

### 🐛 Segnalare Bug

Se trovi un bug:

1. Controlla se il bug è già stato segnalato nelle [Issues](../../issues)
2. Se no, apri una nuova Issue includendo:
   - Descrizione chiara del problema
   - Passi per riprodurre il bug
   - Comportamento atteso vs. comportamento effettivo
   - Versione della mod, del gioco, e del sistema operativo
   - Screenshot o log se disponibili

### 💡 Suggerire Nuove Funzionalità

Per suggerire una nuova shortcut o funzionalità:

1. Apri una Issue con tag `enhancement`
2. Descrivi la funzionalità proposta
3. Spiega perché sarebbe utile
4. Se possibile, suggerisci come potrebbe essere implementata

### 🔧 Contribuire Codice

#### Setup dell'Ambiente di Sviluppo

1. Fai un fork del repository
2. Clona il tuo fork:
   ```bash
   git clone https://github.com/tuousername/gioco.git
   cd gioco
   ```
3. Segui le istruzioni in `QUICKSTART.md` per il setup

#### Processo di Contribuzione

1. **Crea un branch** per la tua modifica:
   ```bash
   git checkout -b feature/nome-della-funzionalita
   ```
   o
   ```bash
   git checkout -b bugfix/descrizione-del-bug
   ```

2. **Fai le tue modifiche**:
   - Segui lo stile del codice esistente
   - Commenta il codice dove necessario
   - Testa le tue modifiche

3. **Commit** con messaggi chiari:
   ```bash
   git commit -m "Aggiungi shortcut per velocità di gioco"
   ```

4. **Push** al tuo fork:
   ```bash
   git push origin feature/nome-della-funzionalita
   ```

5. **Apri una Pull Request**:
   - Vai su GitHub e apri una PR dal tuo branch
   - Descrivi le modifiche apportate
   - Collega eventuali Issues rilevanti

#### Standard del Codice

##### C++ (src/*.cpp, src/*.h)

- Usa lo stile del codice originale di C&C Remastered
- Commenta le funzioni usando il formato esistente:
  ```cpp
  /***********************************************************************************************
   * Nome_Funzione -- Breve descrizione                                                         *
   *                                                                                             *
   * INPUT:   descrizione parametri                                                              *
   * OUTPUT:  descrizione return value                                                           *
   * WARNINGS:   note importanti                                                                 *
   * HISTORY: DD/MM/YYYY - Creato                                                                *
   *=============================================================================================*/
  ```
- Mantieni consistenza con le convenzioni di naming esistenti
- Usa nomi di variabili descrittivi

##### Documentazione (*.md)

- Usa Markdown standard
- Mantieni una struttura chiara con headers appropriati
- Includi esempi dove utile
- Scrivi in italiano per coerenza con il progetto

##### Commit Messages

Usa il formato:
```
Tipo: Breve descrizione (max 50 caratteri)

Descrizione più dettagliata se necessaria (max 72 caratteri per riga)

Risolve #numero-issue
```

Tipi:
- `feat`: Nuova funzionalità
- `fix`: Correzione di bug
- `docs`: Modifiche alla documentazione
- `style`: Formattazione, punto e virgola mancanti, ecc.
- `refactor`: Refactoring del codice
- `test`: Aggiunta di test
- `chore`: Manutenzione

Esempi:
```
feat: Aggiungi shortcut per velocità di gioco

Implementa Ctrl+T per toggle velocità di gioco 2x/4x/normale
Include feedback visivo sullo schermo

Risolve #15
```

```
fix: Corregge crash quando God Mode è attivo

Il crash avveniva quando non c'erano unità da rendere invincibili.
Aggiunto controllo null prima di accedere agli array.

Risolve #23
```

### 📖 Migliorare la Documentazione

La documentazione è importante! Puoi contribuire:

- Correggendo errori di battitura
- Migliorando spiegazioni poco chiare
- Aggiungendo esempi
- Traducendo in altre lingue
- Aggiornando screenshot

## Idee per Contributi

### Nuove Shortcut da Implementare

Ecco alcune idee per nuove funzionalità:

- [ ] **Ctrl+T**: Toggle velocità di gioco (2x, 4x, normale)
- [ ] **Ctrl+V**: Rivela intera mappa
- [ ] **Ctrl+F**: Nebbia di guerra on/off
- [ ] **Ctrl+N**: Nuke istantaneo pronto
- [ ] **Ctrl+H**: Ripristina salute di tutte le unità
- [ ] **Ctrl+K**: Distruggi tutte le unità nemiche (testing)
- [ ] **Ctrl+L**: Livella tutti gli edifici nemici (testing)
- [ ] **Ctrl+1-9**: Salva/ripristina preset di risorse

### Miglioramenti al Codice

- [ ] Sistema di messaggi a schermo più elaborato
- [ ] Menu in-game per configurare i cheat
- [ ] Salvataggio delle preferenze dei cheat
- [ ] Supporto per Red Alert oltre a Tiberian Dawn
- [ ] Sistema di hotkey personalizzabili
- [ ] Statistiche d'uso dei cheat

### Documentazione

- [ ] Video tutorial per l'installazione
- [ ] FAQ più dettagliata
- [ ] Guida troubleshooting espansa
- [ ] Esempi di scenari d'uso
- [ ] Traduzione in inglese

## Codice di Condotta

### Nostre Aspettative

- Sii rispettoso verso gli altri contributori
- Accetta critiche costruttive con grazia
- Concentrati su ciò che è meglio per il progetto
- Mostra empatia verso altri membri della comunità

### Comportamenti Non Accettabili

- Linguaggio o immagini sessualizzate
- Trolling, insulti o commenti offensivi
- Molestie pubbliche o private
- Pubblicazione di informazioni private senza permesso
- Condotta non professionale

## Domande?

Se hai domande sul processo di contribuzione:

1. Leggi la documentazione esistente (README.md, QUICKSTART.md, ecc.)
2. Cerca nelle Issues esistenti
3. Apri una nuova Issue con tag `question`

## Licenza

Contribuendo a questo progetto, accetti che i tuoi contributi saranno rilasciati
sotto la stessa licenza GPL v3.0 del progetto.

Vedi il file [LICENSE](LICENSE) per i dettagli.

## Ringraziamenti

Grazie per voler contribuire a CheatMod! Ogni contributo, grande o piccolo,
è apprezzato e aiuta a migliorare il progetto per tutti.

### Contributori Attuali

- [Lista dei contributori](../../graphs/contributors)

---

**Ancora una volta, grazie per il tuo contributo! 🎉**
