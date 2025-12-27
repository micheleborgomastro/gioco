//
// Copyright 2025 - Community Mod
// Basato sul codice sorgente di C&C Remastered Collection (GPL v3.0)
//
// CONQUER_CHEAT_MOD.CPP - Implementazione delle shortcut personalizzate
//

#include "CHEAT_MOD.H"
#include "function.h"

// Flag globali per i cheat attivi
bool CheatPowerUnlimited = false;
bool CheatInstantBuild = false;
bool CheatInstantResearch = false;
bool CheatGodMode = false;

/***********************************************************************************************
 * Init_Cheat_Mod -- Inizializza il sistema di cheat mod                                       *
 *                                                                                             *
 * INPUT:   none                                                                               *
 * OUTPUT:  none                                                                               *
 * WARNINGS:   none                                                                            *
 * HISTORY: 12/27/2025 - Creato                                                                *
 *=============================================================================================*/
void Init_Cheat_Mod()
{
    CheatPowerUnlimited = false;
    CheatInstantBuild = false;
    CheatInstantResearch = false;
    CheatGodMode = false;
}

/***********************************************************************************************
 * Show_Cheat_Message -- Mostra un messaggio a schermo quando un cheat viene attivato         *
 *                                                                                             *
 * INPUT:   message - Il messaggio da mostrare                                                 *
 * OUTPUT:  none                                                                               *
 * WARNINGS:   none                                                                            *
 * HISTORY: 12/27/2025 - Creato                                                                *
 *=============================================================================================*/
void Show_Cheat_Message(const char* message)
{
    // Mostra un messaggio temporaneo sullo schermo
    if (message) {
        Map.Override_Mouse_Shape(MOUSE_NORMAL);
        Map.Flag_To_Redraw(true);
        // Nota: questo usa il sistema di messaggi interno del gioco
        // Potrebbe richiedere l'integrazione con il sistema di messaggi esistente
    }
}

/***********************************************************************************************
 * Toggle_Cheat_Flag -- Attiva/disattiva un flag di cheat e mostra un messaggio               *
 *                                                                                             *
 * INPUT:   flag - Riferimento al flag da modificare                                           *
 *          enable_msg - Messaggio quando il cheat viene attivato                              *
 *          disable_msg - Messaggio quando il cheat viene disattivato                          *
 * OUTPUT:  none                                                                               *
 * WARNINGS:   none                                                                            *
 * HISTORY: 12/27/2025 - Creato                                                                *
 *=============================================================================================*/
void Toggle_Cheat_Flag(bool &flag, const char* enable_msg, const char* disable_msg)
{
    flag = !flag;
    Show_Cheat_Message(flag ? enable_msg : disable_msg);
}

/***********************************************************************************************
 * Process_Cheat_Keys -- Elabora gli input da tastiera per i cheat                            *
 *                                                                                             *
 * INPUT:   input - Il tasto premuto (con modificatori)                                        *
 * OUTPUT:  none                                                                               *
 * WARNINGS:   Modifica i parametri di gioco se i cheat vengono attivati                       *
 * HISTORY: 12/27/2025 - Creato                                                                *
 *=============================================================================================*/
void Process_Cheat_Keys(KeyNumType &input)
{
    // Verifica che ci sia un giocatore attivo
    if (!PlayerPtr) return;

    // Ctrl+M: Aggiungi 10,000 crediti
    if (input == CHEAT_MONEY_SMALL) {
        PlayerPtr->Credits += SMALL_CREDIT_AMOUNT;
        Show_Cheat_Message("+ 10,000 Crediti");
        input = KN_NONE;
        return;
    }

    // Ctrl+Shift+M: Aggiungi 100,000 crediti
    if (input == CHEAT_MONEY_LARGE) {
        PlayerPtr->Credits += LARGE_CREDIT_AMOUNT;
        Show_Cheat_Message("+ 100,000 Crediti");
        input = KN_NONE;
        return;
    }

    // Ctrl+P: Energia illimitata (toggle)
    if (input == CHEAT_POWER_UNLIMITED) {
        Toggle_Cheat_Flag(CheatPowerUnlimited,
            "Energia Illimitata: ON",
            "Energia Illimitata: OFF");
        input = KN_NONE;
        return;
    }

    // Ctrl+U: Sblocca tutte le unità
    if (input == CHEAT_UNLOCK_UNITS) {
        // Itera attraverso tutti i tipi di edifici e sbloccali
        for (StructType stype = STRUCT_FIRST; stype < STRUCT_COUNT; stype++) {
            PlayerPtr->UnitsBuilt[stype] = 1;
        }
        // Itera attraverso tutti i tipi di unità e sbloccale
        for (UnitType utype = UNIT_FIRST; utype < UNIT_COUNT; utype++) {
            PlayerPtr->UnitsKilled[utype] = 1;
        }
        // Itera attraverso tutti i tipi di fanteria e sbloccali
        for (InfantryType itype = INFANTRY_FIRST; itype < INFANTRY_COUNT; itype++) {
            PlayerPtr->InfantryKilled[itype] = 1;
        }
        Show_Cheat_Message("Tutte le Unità Sbloccate");
        input = KN_NONE;
        return;
    }

    // Ctrl+B: Costruzione istantanea (toggle)
    if (input == CHEAT_INSTANT_BUILD) {
        Toggle_Cheat_Flag(CheatInstantBuild,
            "Costruzione Istantanea: ON",
            "Costruzione Istantanea: OFF");
        input = KN_NONE;
        return;
    }

    // Ctrl+R: Ricerca istantanea (toggle)
    if (input == CHEAT_INSTANT_RESEARCH) {
        Toggle_Cheat_Flag(CheatInstantResearch,
            "Ricerca Istantanea: ON",
            "Ricerca Istantanea: OFF");
        input = KN_NONE;
        return;
    }

    // Ctrl+G: God Mode (toggle)
    if (input == CHEAT_GOD_MODE) {
        Toggle_Cheat_Flag(CheatGodMode,
            "God Mode: ON",
            "God Mode: OFF");
        input = KN_NONE;
        return;
    }
}

/***********************************************************************************************
 * Apply_Unlimited_Power -- Applica l'effetto dell'energia illimitata                         *
 *                                                                                             *
 * INPUT:   none                                                                               *
 * OUTPUT:  none                                                                               *
 * WARNINGS:   Chiamare ogni frame quando CheatPowerUnlimited è true                           *
 * HISTORY: 12/27/2025 - Creato                                                                *
 *=============================================================================================*/
void Apply_Unlimited_Power()
{
    if (!CheatPowerUnlimited || !PlayerPtr) return;

    // Imposta energia al massimo
    PlayerPtr->Power = PlayerPtr->Drain * 2;
}

/***********************************************************************************************
 * Apply_Instant_Build -- Applica l'effetto della costruzione istantanea                      *
 *                                                                                             *
 * INPUT:   none                                                                               *
 * OUTPUT:  none                                                                               *
 * WARNINGS:   Chiamare ogni frame quando CheatInstantBuild è true                             *
 * HISTORY: 12/27/2025 - Creato                                                                *
 *=============================================================================================*/
void Apply_Instant_Build()
{
    if (!CheatInstantBuild) return;

    // Itera attraverso tutti gli edifici del giocatore
    for (int index = 0; index < Buildings.Count(); index++) {
        BuildingClass * building = Buildings.Ptr(index);
        if (building && building->House == PlayerPtr) {
            // Se l'edificio sta costruendo qualcosa, completa istantaneamente
            if (building->IsFactory) {
                if (building->Factory) {
                    building->Factory->Set_Rate(100);
                    building->Factory->Set_Stage(100);
                }
            }
        }
    }
}

/***********************************************************************************************
 * Apply_Instant_Research -- Applica l'effetto della ricerca istantanea                       *
 *                                                                                             *
 * INPUT:   none                                                                               *
 * OUTPUT:  none                                                                               *
 * WARNINGS:   Chiamare ogni frame quando CheatInstantResearch è true                          *
 * HISTORY: 12/27/2025 - Creato                                                                *
 *=============================================================================================*/
void Apply_Instant_Research()
{
    if (!CheatInstantResearch) return;

    // Sblocca tutte le tecnologie disponibili
    // Questo dipende dal sistema di ricerca specifico del gioco
    // Potrebbe richiedere ulteriori modifiche basate sulla struttura interna
}

/***********************************************************************************************
 * Apply_God_Mode -- Applica l'effetto del God Mode                                           *
 *                                                                                             *
 * INPUT:   none                                                                               *
 * OUTPUT:  none                                                                               *
 * WARNINGS:   Chiamare ogni frame quando CheatGodMode è true                                  *
 * HISTORY: 12/27/2025 - Creato                                                                *
 *=============================================================================================*/
void Apply_God_Mode()
{
    if (!CheatGodMode) return;

    // Rendi invincibili tutte le unità del giocatore
    for (int index = 0; index < Units.Count(); index++) {
        UnitClass * unit = Units.Ptr(index);
        if (unit && unit->House == PlayerPtr) {
            // Ripristina la salute al massimo
            unit->Strength = unit->Class->MaxStrength;
        }
    }

    // Rendi invincibili tutta la fanteria del giocatore
    for (int index = 0; index < Infantry.Count(); index++) {
        InfantryClass * infantry = Infantry.Ptr(index);
        if (infantry && infantry->House == PlayerPtr) {
            // Ripristina la salute al massimo
            infantry->Strength = infantry->Class->MaxStrength;
        }
    }

    // Rendi invincibili tutti gli edifici del giocatore
    for (int index = 0; index < Buildings.Count(); index++) {
        BuildingClass * building = Buildings.Ptr(index);
        if (building && building->House == PlayerPtr) {
            // Ripristina la salute al massimo
            building->Strength = building->Class->MaxStrength;
        }
    }
}
