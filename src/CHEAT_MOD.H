//
// Copyright 2025 - Community Mod
// Basato sul codice sorgente di C&C Remastered Collection (GPL v3.0)
//
// CHEAT_MOD.H - Header per le shortcut personalizzate
//

#ifndef CHEAT_MOD_H
#define CHEAT_MOD_H

// Includi le definizioni necessarie dal gioco
#include "function.h"
#include "keyboard.h"

// Definizioni per le combinazioni di tasti
#define CHEAT_MONEY_SMALL       (KN_M | CTRL_BIT)           // Ctrl+M: +10,000 crediti
#define CHEAT_MONEY_LARGE       (KN_M | CTRL_BIT | SHIFT_BIT) // Ctrl+Shift+M: +100,000 crediti
#define CHEAT_POWER_UNLIMITED   (KN_P | CTRL_BIT)           // Ctrl+P: Energia illimitata
#define CHEAT_UNLOCK_UNITS      (KN_U | CTRL_BIT)           // Ctrl+U: Sblocca tutte le unità
#define CHEAT_INSTANT_BUILD     (KN_B | CTRL_BIT)           // Ctrl+B: Costruzione istantanea
#define CHEAT_INSTANT_RESEARCH  (KN_R | CTRL_BIT)           // Ctrl+R: Ricerca istantanea
#define CHEAT_GOD_MODE          (KN_G | CTRL_BIT)           // Ctrl+G: God Mode

// Valori per le modifiche
#define SMALL_CREDIT_AMOUNT     10000
#define LARGE_CREDIT_AMOUNT     100000

// Flag globali per i cheat attivi
extern bool CheatPowerUnlimited;
extern bool CheatInstantBuild;
extern bool CheatInstantResearch;
extern bool CheatGodMode;

// Funzioni per gestire i cheat
void Init_Cheat_Mod();
void Process_Cheat_Keys(KeyNumType &input);
void Apply_God_Mode();
void Apply_Instant_Build();
void Apply_Instant_Research();
void Apply_Unlimited_Power();

// Funzioni di utility
void Show_Cheat_Message(const char* message);
void Toggle_Cheat_Flag(bool &flag, const char* enable_msg, const char* disable_msg);

#endif // CHEAT_MOD_H
