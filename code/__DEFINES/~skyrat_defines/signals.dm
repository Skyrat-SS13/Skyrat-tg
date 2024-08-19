//Movable signals
///When someone talks into a radio
#define COMSIG_MOVABLE_RADIO_TALK_INTO "movable_radio_talk_into"				//from radio talk_into(): (obj/item/radio/radio, message, channel, list/spans, datum/language/language, direct)

//Mob signals
///Resting position for living mob updated
#define COMSIG_LIVING_UPDATED_RESTING "living_updated_resting" //from base of (/mob/living/proc/update_resting): (resting)
///Horror form bombastic flag
#define COMSIG_HORRORFORM_EXPLODE "horrorform_explode"
///Fired in combat_indicator.dm, used for syncing CI between mech and pilot
#define COMSIG_MOB_CI_TOGGLED "mob_ci_toggled"
/// When a hostile simple mob loses it's target.
#define COMSIG_HOSTILE_MOB_LOST_TARGET "hostile_mob_lost_target"

//Gun signals
///When a gun is switched to automatic fire mode
#define COMSIG_GUN_AUTOFIRE_SELECTED "gun_autofire_selected"
///When a gun is switched off of automatic fire mode
#define COMSIG_GUN_AUTOFIRE_DESELECTED "gun_autofire_deselected"
///The gun needs to update the gun hud!
#define COMSIG_UPDATE_AMMO_HUD "update_ammo_hud"

/// Used by /obj/item/melee/breaching_hammer
#define COMSIG_BREACHING "breaching_signal_woop_woop"
///The gun has jammed.
#define COMSIG_GUN_JAMMED "gun_jammed"

//Mutant stuff
///When a mutant is cured of the virus
#define COMSIG_MUTANT_CURED "mutant_cured"

// Power signals
/// Sent when an obj/item calls item_use_power: (use_amount, user, check_only)
#define COMSIG_ITEM_POWER_USE "item_use_power"
	#define NO_COMPONENT NONE
	#define COMPONENT_POWER_SUCCESS (1<<0)
	#define COMPONENT_NO_CELL  (1<<1)
	#define COMPONENT_NO_CHARGE (1<<2)

/// Sent when supermatter begins its delam countdown/when the suppression system is triggered: (var/trigger_reason)
#define COMSIG_MAIN_SM_DELAMINATING "delam_time"

// Health signals
/// /mob/living/proc/updatehealth()
#define COMSIG_MOB_RUN_ARMOR "mob_run_armor"
///from base of /turf/handle_fall(): (mob/faller)
#define COMSIG_TURF_MOB_FALL "turf_mob_fall"
///from base of /obj/effect/abstract/liquid_turf/Initialize() (/obj/effect/abstract/liquid_turf/liquids)
#define COMSIG_TURF_LIQUIDS_CREATION "turf_liquids_creation"
/// From base of /turf/proc/liquids_change(new_state)
#define COMSIG_TURF_LIQUIDS_CHANGE "turf_liquids_change"

/// listens to wet_stacks, if wetting a mob above 10 stacks it will signal the akula race trait to apply its buffs and nerfs
#define COMSIG_MOB_TRIGGER_WET_SKIN "mob_trigger_wet_skin"

//when someone casts their fishing rod
#define COMSIG_START_FISHING "start_fishing"
//when someone pulls back their fishing rod
#define COMSIG_FINISH_FISHING "finish_fishing"

/// From mob/living/*/set_combat_mode(): (new_state)
#define COMSIG_LIVING_COMBAT_MODE_TOGGLE "living_combat_mode_toggle"

/// From /obj/item/organ/internal/stomach/after_eat(atom/edible)
#define COMSIG_STOMACH_AFTER_EAT "stomach_after_eat"

/// For when a Hemophage's pulsating tumor gets added to their body.
#define COMSIG_PULSATING_TUMOR_ADDED "pulsating_tumor_added"
/// For when a Hemophage's pulsating tumor gets removed from their body.
#define COMSIG_PULSATING_TUMOR_REMOVED "pulsating_tumor_removed"

/// when someone attempts to evolve through the rune
#define COMSIG_RUNE_EVOLUTION "rune_evolution"

/// To chambered round on gun's `process_fire()`: (list/iff_factions)
#define COMSIG_CHAMBERED_BULLET_FIRE "chambered_bullet_fire"

/// /datum/component/clockwork_trap signals: ()
#define COMSIG_CLOCKWORK_SIGNAL_RECEIVED "clock_received"

/// Called when a clock cultist uses a clockwork slab: (obj/item/clockwork/clockwork_slab/slab)
#define COMSIG_CLOCKWORK_SLAB_USED "clockwork_slab_used"

/// Engineering Override Access manual toggle
#define COMSIG_GLOB_FORCE_ENG_OVERRIDE "force_engineering_override"

/// Whenever we need to check if a mob is currently inside of soulcatcher.
#define COMSIG_SOULCATCHER_CHECK_SOUL "soulcatcher_check_soul"

/// Whenever we need to get the soul of the mob inside of the soulcatcher.
#define COMSIG_SOULCATCHER_SCAN_BODY "soulcatcher_scan_body"

/// Whenever we need to change the current room of a soulcatcher soul.
#define COMSIG_CARRIER_MOB_CHANGE_ROOM "carrier_mob_change_room"

/// Whenever we need to toggle the senses of a soulcatcher soul.
#define COMSIG_CARRIER_MOB_TOGGLE_SENSE "carrier_mob_toggle_sense"

/// Whenever we need to rename a soulcatcher soul.
#define COMSIG_CARRIER_MOB_RENAME "carrier_mob_rename"

/// Whenever we need to reset the name of a soulcatcher soul.
#define COMSIG_CARRIER_MOB_RESET_NAME "carrier_mob_reset_name"

/// Whenever we need to check if our soulcatcher soul is able to internally hear/see?
#define COMSIG_CARRIER_MOB_CHECK_INTERNAL_SENSES "carrier_mob_internal_senses"

/// Whenever we need to refresh the internal appearance of a soulcatcher soul.area
#define COMSIG_CARRIER_MOB_REFRESH_APPEARANCE "carrier_mob_refresh_appearance"

/// Whenever we need the soulcatcher soul to communicate something.
#define COMSIG_CARRIER_MOB_SAY "carrier_mob_communicate"
