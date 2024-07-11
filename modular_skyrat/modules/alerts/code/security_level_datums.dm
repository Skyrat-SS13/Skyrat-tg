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
	announcement_color = "pink"
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
	announcement_color = "purple"
	number_level = SEC_LEVEL_VIOLET
	status_display_icon_state = "violetalert"
	fire_alarm_light_color = COLOR_VIOLET
	lowering_to_configuration_key = /datum/config_entry/string/alert_violet_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_violet_upto
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/violet.ogg'
	shuttle_call_time_mod = 0.75

/**
 * Orange
 *
 * Engineering emergency
 */
/datum/security_level/orange
	name = "orange"
	announcement_color = "orange"
	number_level = SEC_LEVEL_ORANGE
	status_display_icon_state = "orangealert"
	fire_alarm_light_color = LIGHT_COLOR_ORANGE
	lowering_to_configuration_key = /datum/config_entry/string/alert_orange_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_orange_upto
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/orange.ogg'
	shuttle_call_time_mod = 0.75

/**
 * Amber
 *
 * Securty emergency
 */

/datum/security_level/amber
	name = "amber"
	announcement_color = "yellow"
	number_level = SEC_LEVEL_AMBER
	status_display_icon_state = "amberalert"
	fire_alarm_light_color = LIGHT_COLOR_DIM_YELLOW
	lowering_to_configuration_key = /datum/config_entry/string/alert_amber_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_amber_upto
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/amber.ogg'
	shuttle_call_time_mod = 0.5

/**
 * Epsilon
 *
 * Deathsquad comes to KILL ALL
 */
/datum/security_level/epsilon
	name = "epsilon"
	announcement_color = "grey"
	number_level = SEC_LEVEL_EPSILON
	status_display_icon_state = "epsilonalert"
	fire_alarm_light_color = COLOR_ASSEMBLY_WHITE
	lowering_to_configuration_key = /datum/config_entry/string/alert_epsilon_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_epsilon_upto
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/epsilon.ogg'
	looping_sound = 'modular_skyrat/modules/alerts/sound/misc/alarm_delta.ogg'
	looping_sound_interval = 8 SECONDS

/**
 * Gamma
 *
 * XK-Class EOR Event
 */
/datum/security_level/gamma
	name = "gamma"
	announcement_color = "pink"
	number_level = SEC_LEVEL_GAMMA
	status_display_icon_state = "gammaalert"
	fire_alarm_light_color = COLOR_ASSEMBLY_PURPLE
	elevating_to_configuration_key = /datum/config_entry/string/alert_gamma
	shuttle_call_time_mod = 0.25
	sound = 'modular_skyrat/modules/alerts/sound/security_levels/gamma_alert.ogg'
	looping_sound = 'modular_skyrat/modules/alerts/sound/security_levels/gamma_alert.ogg'
	looping_sound_interval = 13 SECONDS
