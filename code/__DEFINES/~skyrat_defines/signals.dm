//Movable signals
///When someone talks into a radio
#define COMSIG_MOVABLE_RADIO_TALK_INTO "movable_radio_talk_into"				//from radio talk_into(): (obj/item/radio/radio, message, channel, list/spans, datum/language/language, direct)

//Mob signals
///Resting position for living mob updated
#define COMSIG_LIVING_UPDATED_RESTING "living_updated_resting" //from base of (/mob/living/proc/update_resting): (resting)
///Horror form bombastic flag
#define COMSIG_HORRORFORM_EXPLODE "horrorform_explode"

//Gun signals
///When a gun is switched to automatic fire mode
#define COMSIG_AUTOFIRE_SELECTED "autofire_selected"
///When a gun is switched off of automatic fire mode
#define COMSIG_AUTOFIRE_DESELECTED "autofire_deselected"
