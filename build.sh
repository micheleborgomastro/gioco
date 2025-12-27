#!/bin/bash

################################################################################
# Build Script per CheatMod - C&C Remastered Collection
################################################################################
#
# Questo script automatizza il processo di setup della mod
#
# Nota: La compilazione richiede Windows e Visual Studio 2017
# Questo script prepara i file per la compilazione
#
################################################################################

set -e  # Exit on error

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Funzione per stampare messaggi colorati
print_header() {
    echo -e "${BLUE}============================================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}============================================================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

################################################################################
# Banner
################################################################################

clear
print_header "CheatMod - Setup Script"

################################################################################
# Configurazione Percorsi
################################################################################

CNC_REPO="../CnC_Remastered_Collection"
OUTPUT_DIR="bin"
DOCS_DIR="docs"

################################################################################
# Funzione per clonare il repository
################################################################################

clone_repository() {
    print_info "Il repository C&C Remastered non è presente."
    echo ""
    read -p "Vuoi clonarlo ora? (s/n): " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[Ss]$ ]]; then
        print_info "Clonazione del repository in corso..."
        echo ""

        cd ..
        git clone https://github.com/electronicarts/CnC_Remastered_Collection.git
        cd - > /dev/null

        print_success "Repository clonato con successo!"
        echo ""
    else
        print_error "Repository necessario per continuare."
        echo ""
        echo "Clonalo manualmente con:"
        echo "git clone https://github.com/electronicarts/CnC_Remastered_Collection.git"
        exit 1
    fi
}

################################################################################
# [1/5] Verifica Prerequisiti
################################################################################

print_info "[1/5] Verifica prerequisiti..."
echo ""

# Verifica repository C&C Remastered
if [ ! -d "$CNC_REPO" ]; then
    clone_repository
else
    print_success "Repository C&C Remastered trovato"
fi

# Verifica file sorgente della mod
if [ ! -f "src/CHEAT_MOD.H" ]; then
    print_error "File src/CHEAT_MOD.H non trovato!"
    exit 1
fi

if [ ! -f "src/CONQUER_CHEAT_MOD.CPP" ]; then
    print_error "File src/CONQUER_CHEAT_MOD.CPP non trovato!"
    exit 1
fi

print_success "Tutti i file sorgente presenti"
echo ""

################################################################################
# [2/5] Copia File della Mod
################################################################################

print_info "[2/5] Copia file della mod nel repository C&C..."
echo ""

# Crea directory TIBERIANDAWN se non esiste
mkdir -p "$CNC_REPO/TIBERIANDAWN"

# Copia i file della mod
cp -v "src/CHEAT_MOD.H" "$CNC_REPO/TIBERIANDAWN/"
cp -v "src/CONQUER_CHEAT_MOD.CPP" "$CNC_REPO/TIBERIANDAWN/"

print_success "File copiati con successo"
echo ""

################################################################################
# [3/5] Backup e Preparazione CONQUER.CPP
################################################################################

print_info "[3/5] Preparazione modifiche a CONQUER.CPP..."
echo ""

CONQUER_CPP="$CNC_REPO/TIBERIANDAWN/CONQUER.CPP"
CONQUER_BACKUP="$CNC_REPO/TIBERIANDAWN/CONQUER.CPP.backup"

# Crea backup se non esiste
if [ -f "$CONQUER_CPP" ] && [ ! -f "$CONQUER_BACKUP" ]; then
    print_info "Creazione backup di CONQUER.CPP..."
    cp "$CONQUER_CPP" "$CONQUER_BACKUP"
    print_success "Backup creato: CONQUER.CPP.backup"
fi

print_warning "ATTENZIONE: Le modifiche a CONQUER.CPP devono essere applicate manualmente!"
echo ""
echo "Consulta il file: src/PATCH_INSTRUCTIONS.md per le istruzioni dettagliate."
echo ""
echo "Modifiche necessarie:"
echo "  1. Include CHEAT_MOD.H"
echo "  2. Chiamata a Init_Cheat_Mod() in Select_Game()"
echo "  3. Chiamata a Process_Cheat_Keys() nel main game loop"
echo "  4. Chiamate agli Apply_* functions nel main loop"
echo ""

read -p "Hai applicato tutte le modifiche a CONQUER.CPP? (s/n): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    print_warning "Setup interrotto."
    echo ""
    echo "Applica le modifiche seguendo src/PATCH_INSTRUCTIONS.md e riprova."
    exit 1
fi

print_success "Procedo con il setup"
echo ""

################################################################################
# [4/5] Genera Script Helper
################################################################################

print_info "[4/5] Generazione script helper..."
echo ""

# Crea directory bin se non esiste
mkdir -p "$OUTPUT_DIR"

# Genera uno script helper per ricordarsi i comandi
cat > "$OUTPUT_DIR/README.txt" << 'EOF'
============================================================================
CheatMod - Compilazione e Installazione
============================================================================

NOTA: La compilazione richiede Windows e Visual Studio 2017

PASSI PER LA COMPILAZIONE (Windows):

1. Apri CnC_Remastered_Collection\CnCRemastered.sln in Visual Studio 2017

2. Seleziona configurazione: Release | Win32

3. Menu: Build → Batch Build → Select All → Rebuild

4. I file compilati saranno in:
   CnC_Remastered_Collection\bin\Win32\Release\TiberianDawn.dll

5. Copia in questa directory (bin\):
   - TiberianDawn.dll
   - TiberianDawn.pdb (opzionale, per debug)

PASSI PER L'INSTALLAZIONE:

1. Crea la directory:
   Windows: %USERPROFILE%\Documents\CnCRemastered\Mods\CheatMod\
   Linux: ~/.local/share/Steam/userdata/<ID>/1213210/local/Mods/CheatMod/

2. Copia i file:
   - bin\TiberianDawn.dll
   - CCMOD.JSON

3. Avvia il gioco e attiva la mod dal Mod Manager

============================================================================
Per supporto, consulta: README.md e docs/SHORTCUTS.md
============================================================================
EOF

print_success "Script helper creato in $OUTPUT_DIR/README.txt"
echo ""

################################################################################
# [5/5] Riepilogo e Prossimi Passi
################################################################################

print_header "Setup Completato!"

echo "✓ File della mod copiati nel repository C&C Remastered"
echo "✓ Backup di CONQUER.CPP creato (se necessario)"
echo "✓ Script helper generati"
echo ""

print_info "PROSSIMI PASSI:"
echo ""
echo "1. COMPILAZIONE (richiede Windows + Visual Studio 2017):"
echo "   - Usa build.bat su Windows, oppure"
echo "   - Compila manualmente con Visual Studio (vedi $OUTPUT_DIR/README.txt)"
echo ""
echo "2. INSTALLAZIONE:"
echo "   - Copia TiberianDawn.dll e CCMOD.JSON nella directory della mod"
echo "   - Percorso: Documents/CnCRemastered/Mods/CheatMod/"
echo ""
echo "3. ATTIVAZIONE:"
echo "   - Avvia C&C Remastered Collection"
echo "   - Apri il Mod Manager"
echo "   - Attiva 'CheatMod - Shortcut Personalizzate'"
echo ""

print_info "DOCUMENTAZIONE:"
echo ""
echo "  README.md                    - Panoramica generale"
echo "  docs/SHORTCUTS.md            - Lista completa shortcut"
echo "  src/PATCH_INSTRUCTIONS.md    - Istruzioni dettagliate per modifiche"
echo "  $OUTPUT_DIR/README.txt       - Guida rapida compilazione"
echo ""

print_header "Buon Divertimento!"

################################################################################
# Opzione per aprire la documentazione
################################################################################

echo ""
read -p "Vuoi visualizzare la lista delle shortcut? (s/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Ss]$ ]]; then
    if command -v less &> /dev/null; then
        less "docs/SHORTCUTS.md"
    elif command -v more &> /dev/null; then
        more "docs/SHORTCUTS.md"
    else
        cat "docs/SHORTCUTS.md"
    fi
fi

echo ""
print_success "Script completato!"
echo ""
