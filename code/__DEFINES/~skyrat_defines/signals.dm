//Movable signals
///When someone talks into a radio
#define COMSIG_MOVABLE_RADIO_TALK_INTO "movable_radio_talk_into"				//from radio talk_into(): (obj/item/radio/radio, message, channel, list/spans, datum/language/language, direct)

//Mob signals
///Resting position for living mob updated
#define COMSIG_LIVING_UPDATED_RESTING "living_updated_resting" //from base of (/mob/living/proc/update_resting): (resting)
///Horror form bombastic flag
#define COMSIG_HORRORFORM_EXPLODE "horrorform_explode"
///Overlay for whitestuff
#define COMSIG_MOB_CUMFACED "mob_cumfaced" //from /datum/component/cumfaced/Initialize(), when you get covered in cum

//Gun signals
///When a gun is switched to automatic fire mode
#define COMSIG_GUN_AUTOFIRE_SELECTED "gun_autofire_selected"
///When a gun is switched off of automatic fire mode
#define COMSIG_GUN_AUTOFIRE_DESELECTED "gun_autofire_deselected"
///The gun needs to update the gun hud!
#define COMSIG_UPDATE_AMMO_HUD "update_ammo_hud"

/// Used by /obj/item/melee/hammer
#define COMSIG_BREACHING "breaching_signal_woop_woop"
///The gun has jammed.
#define COMSIG_GUN_JAMMED "gun_jammed"

//Mutant stuff
///When a mutant is cured of the virus
#define COMSIG_MUTANT_CURED "mutant_cured"

//Cell component stuff
/// Sent when a cell runs out of charge.
#define COMSIG_CELL_OUT_OF_CHARGE "cell_out_of_charge"
/// Sent when there is no cell.
#define COMSIG_CELL_NO_CELL "cell_no_cell"
/// Called to start draining from a cell
#define COMSIG_CELL_START_USE "cell_start_use"
/// Called to stop draining from a cell
#define COMSIG_CELL_STOP_USE "cell_stop_use"
/// Sent when a cell is successfully drawn from
#define COMSIG_CELL_POWER_USED "cell_ower_used"
/// Sent when a flashlight is toggled on.
#define COMSIG_FLASHLIGHT_TOGGLED_ON "flashlight_toggled_on"
/// Sent when a flashlight is toggled off.
#define COMSIG_FLASHLIGHT_TOGGLED_OFF "flashlight_toggled_off"
