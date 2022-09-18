/**
 * Contains some overrides and our sec levels.
 */

/datum/security_level/green
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/green.ogg'

/datum/security_level/blue
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/blue.ogg'

/datum/security_level/red
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/red.ogg'

/datum/security_level/delta
	lowering_to_configuration_key = /datum/config_entry/string/alert_delta_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_delta_upto
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/delta.ogg'
	looping_sound = 'modular_skyrat/modules/alerts/sound/misc/alarm_delta.ogg'
	looping_sound_interval = 8 SECONDS


/**
 * Violet
 *
 * Medical emergency
 */
/datum/security_level/violet
	name = "violet"
	number_level = SEC_LEVEL_VIOLET
	lowering_to_configuration_key = /datum/config_entry/string/alert_violet_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_violet_upto
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/violet.ogg'

/**
 * Orange
 *
 * Engineering emergency
 */
/datum/security_level/orange
	name = "orange"
	number_level = SEC_LEVEL_ORANGE
	lowering_to_configuration_key = /datum/config_entry/string/alert_orange_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_orange_upto
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/orange.ogg'

/**
 * Amber
 *
 * Securty emergency
 */

/datum/security_level/amber
	name = "amber"
	number_level = SEC_LEVEL_AMBER
	lowering_to_configuration_key = /datum/config_entry/string/alert_amber_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_amber_upto
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/amber.ogg'


/**
 * Gamma
 *
 * XK-Class EOW Event
 */
/datum/security_level/gamma
	name = "gamma"
	number_level = SEC_LEVEL_GAMMA
	elevating_to_configuration_key = /datum/config_entry/string/alert_gamma
	shuttle_call_time_mod = 0.25
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/gamma_alert.ogg'
