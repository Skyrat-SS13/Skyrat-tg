<<<<<<< HEAD
//NTNet stuff, for modular computers

//Caps for NTNet logging. Less than 10 would make logging useless anyway, more than 500 may make the log browser too laggy. Defaults to 100 unless user changes it.
#define MAX_NTNET_LOGS 300
#define MIN_NTNET_LOGS 10

//Program bitflags
=======
/**
 * can_run_on_flags bitflags
 * Used by programs to tell what type of ModPC it can run on.
 * Everything a program can run on needs valid icons for each individual one.
 */
///Runs on everything.
>>>>>>> edbc7c56226 (PDA update (Messenger works while dead, Microwave works, etc). (#80069))
#define PROGRAM_ALL ALL
///Can run on Modular PC Consoles
#define PROGRAM_CONSOLE (1<<0)
///Can run on Laptops.
#define PROGRAM_LAPTOP (1<<1)
<<<<<<< HEAD
#define PROGRAM_TABLET (1<<2)
=======
///Can run on PDAs.
#define PROGRAM_PDA (1<<2)

/**
 * program_flags
 * Used by programs to tell the ModPC any special functions it has.
 */
///If the program requires NTNet to be online for it to work.
#define PROGRAM_REQUIRES_NTNET (1<<0)
///The program can be downloaded from the default NTNet downloader store.
#define PROGRAM_ON_NTNET_STORE (1<<1)
///The program can only be downloaded from the Syndinet store, usually nukie/emagged pda.
#define PROGRAM_ON_SYNDINET_STORE (1<<2)
///The program is unique and will delete itself upon being transferred to ensure only one copy exists.
#define PROGRAM_UNIQUE_COPY (1<<3)
///The program is a header and will show up at the top of the ModPC's UI.
#define PROGRAM_HEADER (1<<4)
///The program will run despite the ModPC not having any power in it.
#define PROGRAM_RUNS_WITHOUT_POWER (1<<5)

>>>>>>> edbc7c56226 (PDA update (Messenger works while dead, Microwave works, etc). (#80069))
//Program categories
#define PROGRAM_CATEGORY_CREW "Crew"
#define PROGRAM_CATEGORY_ENGI "Engineering"
#define PROGRAM_CATEGORY_SUPL "Supply"
#define PROGRAM_CATEGORY_SCI "Science"
#define PROGRAM_CATEGORY_MISC "Other"

#define DETOMATIX_RESIST_MINOR 1
#define DETOMATIX_RESIST_MAJOR 2

//NTNet transfer speeds, used when downloading/uploading a file/program.
#define NTNETSPEED_LOWSIGNAL 0.5 // GQ/s transfer speed when the device is wirelessly connected and on Low signal
#define NTNETSPEED_HIGHSIGNAL 1 // GQ/s transfer speed when the device is wirelessly connected and on High signal
#define NTNETSPEED_ETHERNET 2 // GQ/s transfer speed when the device is using wired connection

// NTNet connection signals
///When you're away from the station/mining base and not on a console, you can't access the internet
#define NTNET_NO_SIGNAL 0
///Low signal, so away from the station, but still connected
#define NTNET_LOW_SIGNAL 1
///On station, good signal
#define NTNET_GOOD_SIGNAL 2
///Using a Computer, ethernet-connected.
#define NTNET_ETHERNET_SIGNAL 3

/// The default ringtone of the Messenger app.
#define MESSENGER_RINGTONE_DEFAULT "beep"

/// The maximum length of the ringtone of the Messenger app.
#define MESSENGER_RINGTONE_MAX_LENGTH 20

///Default NtOS PDA theme
#define PDA_THEME_NTOS "ntos"
#define PDA_THEME_DARK_MODE "ntos_darkmode"
#define PDA_THEME_RETRO "ntOS95"
#define PDA_THEME_SYNTH "ntos_synth"
#define PDA_THEME_TERMINAL "ntos_terminal"

///Emagged/Syndicate NtOS (SyndiOS) PDA theme
#define PDA_THEME_SYNDICATE "syndicate"

//Maintenance-loot themes
#define PDA_THEME_CAT "ntos_cat"
#define PDA_THEME_LIGHT_MODE "ntos_lightmode"
#define PDA_THEME_SPOOKY "ntos_spooky"

//Defines for the names of all the themes
#define PDA_THEME_NTOS_NAME "NtOS"
#define PDA_THEME_DARK_MODE_NAME "NtOS Dark Mode"
#define PDA_THEME_RETRO_NAME "Retro"
#define PDA_THEME_SYNTH_NAME "Synth"
#define PDA_THEME_TERMINAL_NAME "Terminal"
#define SYNDICATE_THEME_NAME "Syndicate"
#define CAT_THEME_NAME "Cat"
#define LIGHT_THEME_NAME "NtOS Light Mode"
#define ELDRITCH_THEME_NAME "Eldritch"

///List of PDA themes that are accessible to everyone by default.
GLOBAL_LIST_INIT(default_pda_themes, list(
	PDA_THEME_NTOS_NAME = PDA_THEME_NTOS,
	PDA_THEME_DARK_MODE_NAME = PDA_THEME_DARK_MODE,
	PDA_THEME_RETRO_NAME = PDA_THEME_RETRO,
	PDA_THEME_SYNTH_NAME = PDA_THEME_SYNTH,
	PDA_THEME_TERMINAL_NAME = PDA_THEME_TERMINAL,
))

///List of PDA themes that are accessible to everyone by default.
GLOBAL_LIST_INIT(pda_name_to_theme, list(
	PDA_THEME_NTOS_NAME = PDA_THEME_NTOS,
	PDA_THEME_DARK_MODE_NAME = PDA_THEME_DARK_MODE,
	PDA_THEME_RETRO_NAME = PDA_THEME_RETRO,
	PDA_THEME_SYNTH_NAME = PDA_THEME_SYNTH,
	PDA_THEME_TERMINAL_NAME = PDA_THEME_TERMINAL,
	SYNDICATE_THEME_NAME = PDA_THEME_SYNDICATE,
	CAT_THEME_NAME = PDA_THEME_CAT,
	LIGHT_THEME_NAME = PDA_THEME_LIGHT_MODE,
	ELDRITCH_THEME_NAME = PDA_THEME_SPOOKY,
))
