GLOBAL_LIST_EMPTY_TYPED(ambitions, /datum/ambitions)
GLOBAL_PROTECT(ambitions)

#define INTENSITY_STEALTH "Stealth"
#define INTENSITY_MINOR "Minor"
#define INTENSITY_MAJOR "Major"
#define INTENSITY_HEAVY "Heavy"
#define INTENSITY_EXTREME "Extreme"
#define INTENSITY_ALL list(\
	INTENSITY_STEALTH,\
	INTENSITY_MINOR,\
	INTENSITY_MAJOR,\
	INTENSITY_HEAVY,\
	INTENSITY_EXTREME,\
)

GLOBAL_LIST_INIT_TYPED(ambition_templates, /datum/ambition_template, setup_ambition_templates())
GLOBAL_PROTECT(ambition_templates)

/proc/setup_ambition_templates()
	. = list()
	for(var/stype in subtypesof(/datum/ambition_template))
		. += new stype()
