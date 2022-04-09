#define PLANE_STATUS -12 //Status Indicators that show over mobs' heads when certain things like stuns affect them.

#define VIS_STATUS			24

#define VIS_COUNT			24 //Must be highest number from above.
#define STATUS_LAYER -2.1
#define STATUS_INDICATOR_Y_OFFSET 2 // Offset from the edge of the icon sprite, so 32 pixels plus whatever number is here.
#define STATUS_INDICATOR_ICON_X_SIZE 16 // Don't need to care about the Y size due to the origin being on the bottom side.
#define STATUS_INDICATOR_ICON_MARGIN 2 // The space between two status indicators.

/datum/preference/toggle/enable_status_indicators
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "enable_status_indicators"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/enable_status_indicators/create_default_value()
	return TRUE

/datum/preference/toggle/enable_status_indicators/apply_to_client(client/client, value)
	. = ..()
	var/atom/movable/screen/plane_master/runechat/status/status = locate() in client?.screen
	if(!status)
		return
	if(value)
		status.alpha = 255
	else
		status.alpha = 0
/mob
	var/status_enabled = TRUE
/mob/living
	var/list/status_indicators = null // Will become a list as needed.

/mob/living/carbon/proc/is_critical()
	if(HAS_TRAIT(src, TRAIT_CRITICAL_CONDITION))
		return TRUE

/mob/living/carbon/proc/is_weakened()
	if(HAS_TRAIT_FROM(src, TRAIT_FLOORED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || has_status_effect(/datum/status_effect/incapacitating/knockdown))
		return TRUE

/mob/living/carbon/proc/is_stunned()
	if(HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || HAS_TRAIT_FROM(src, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || HAS_TRAIT_FROM(src, TRAIT_IMMOBILIZED, CHOKEHOLD_TRAIT))
		return TRUE

/mob/living/carbon/proc/is_paralyzed()
	if(HAS_TRAIT_FROM(src, TRAIT_FLOORED, CHOKEHOLD_TRAIT) || HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, STAMINA) || HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) && HAS_TRAIT_FROM(src, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) && HAS_TRAIT_FROM(src, TRAIT_FLOORED, TRAIT_STATUS_EFFECT(STAT_TRAIT)))
		return TRUE

/mob/living/carbon/proc/is_unconcious()
	if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
		return TRUE

/mob/living/carbon/proc/is_confused()
	if(has_status_effect(/datum/status_effect/confusion))
		return TRUE

/* /mob/living/carbon/proc/is_blind_status()
	if(HAS_TRAIT_FROM(src, TRAIT_BLIND, STATUS_EFFECT_TRAIT) || HAS_TRAIT_FROM(src, TRAIT_BLIND, EYES_COVERED) && !HAS_TRAIT_FROM(src, TRAIT_BLIND, QUIRK_TRAIT)) // We don't want permanently blind users (those who took the trait) to have this forever.
		return TRUE */ // Disabled, uncomment if we want this.

/mob/living/carbon/death(gibbed) // On death, we clear the indiciators
	..() // Call the TG death. Do not . = ..()!
	for(var/iteration in status_indicators) // When we die, clear the indicators.
		remove_status_indicator(icon_state) // The indicators are named after their icon_state and type

/* /datum/status_effect/on_apply()
	. = ..()
	owner.immediate_combat_update(owner)

/datum/status_effect/on_remove()
	. = ..()
	owner.immediate_combat_update(owner) */
/mob/living/apply_effect()
	. = ..()
	handle_status_effects()

/mob/living/proc/immediate_combat_update(owner)
	if(iscarbon(owner))
		handle_status_effects()

/mob/living/carbon/handle_status_effects()
	..() // Yea, this makes it so the OG proc is called too! Do not . = ..()!
	is_weakened() ? add_status_indicator("weakened") : remove_status_indicator("weakened") // Critical condition handling - Jank, but otherwise it doesn't show up when you are critical!
	is_paralyzed() ? add_status_indicator("paralysis") : remove_status_indicator("paralysis")
	is_stunned() ? add_status_indicator("stunned") : remove_status_indicator("stunned")
	is_unconcious() ? add_status_indicator("sleeping") : remove_status_indicator("sleeping")
	is_confused() ? add_status_indicator("confused") : remove_status_indicator("confused")
//	is_blind_status() ? add_status_indicator("blinded") : remove_status_indicator("blinded") // Disabled, keeping for IF we decide we want this.
	is_critical() ? add_status_indicator("critical") : remove_status_indicator("critical")

/mob/living/proc/add_status_indicator(image/thing)
	if(get_status_indicator(thing)) // No duplicates, please.
		return
	if(!istype(thing, /image))
		thing = image(icon = 'modular_skyrat/master_files/icons/mob/status_indicators.dmi', loc = src, icon_state = thing)

	LAZYADD(status_indicators, thing)
	handle_status_indicators()

// Similar to above but removes it instead, and nulls the list if it becomes empty as a result.
/mob/living/proc/remove_status_indicator(image/thing)
	thing = get_status_indicator(thing)

	cut_overlay(thing)
	LAZYREMOVE(status_indicators, thing)
	handle_status_indicators()

/mob/living/proc/get_status_indicator(image/thing)
	if(!istype(thing, /image))
		for(var/image/I in status_indicators)
			if(I.icon_state == thing)
				return I
	return LAZYACCESS(status_indicators, LAZYFIND(status_indicators, thing))

// Refreshes the indicators over a mob's head. Should only be called when adding or removing a status indicator with the above procs,
// or when the mob changes size visually for some reason.
/mob/living/proc/handle_status_indicators()
	// First, get rid of all the overlays.
	for(var/thing in status_indicators)
		cut_overlay(thing)

	if(!LAZYLEN(status_indicators))
		return

	if(stat == DEAD)
		return
	var/mob/living/carbon/carbon = src
	// Now put them back on in the right spot.
	var/our_sprite_x = 32 * carbon.dna.current_body_size
	var/our_sprite_y = 24 * carbon.dna.current_body_size

	var/x_offset = our_sprite_x // Add your own offset here later if you want.
	var/y_offset = our_sprite_y + STATUS_INDICATOR_Y_OFFSET

	// Calculates how 'long' the row of indicators and the margin between them should be.
	// The goal is to have the center of that row be horizontally aligned with the sprite's center.
	var/expected_status_indicator_length = (STATUS_INDICATOR_ICON_X_SIZE * status_indicators.len) + (STATUS_INDICATOR_ICON_MARGIN * max(status_indicators.len - 1, 0))
	var/current_x_position = (x_offset / 2) - (expected_status_indicator_length / 2)

	// In /mob/living's `update_transform()`, the sprite is horizontally shifted when scaled up, so that the center of the sprite doesn't move to the right.
	// Because of that, this adjustment needs to happen with the future indicator row as well, or it will look bad.
	current_x_position -= (32 / 2) * (get_icon_scale() - 1)

	// Now the indicator row can actually be built.
	for(var/thing in status_indicators)
		var/image/I = thing

		// This is a semi-HUD element, in a similar manner as medHUDs, in that they're 'above' everything else in the world,
		// but don't pierce obfuscation layers such as blindness or darkness, unlike actual HUD elements like inventory slots.
		I.plane = PLANE_STATUS
		I.layer = STATUS_LAYER
		I.appearance_flags = PIXEL_SCALE|TILE_BOUND|NO_CLIENT_COLOR|RESET_COLOR|RESET_ALPHA|RESET_TRANSFORM|KEEP_APART
		I.pixel_y = y_offset
		I.pixel_x = current_x_position
		add_overlay(I)
		// Adding the margin space every time saves a conditional check on the last iteration,
		// and it won't cause any issues since no more icons will be added, and the var is not used for anything else.
		current_x_position += STATUS_INDICATOR_ICON_X_SIZE + STATUS_INDICATOR_ICON_MARGIN

/mob/living/proc/get_icon_scale()
	if(!iscarbon(src)) // normal mobs are always 1 for scale - not borg compatible but ok
		return 1
	var/mob/living/carbon/carbon = src // we're possibly a player! We have size prefs!

	return carbon?.dna.current_body_size

/atom/movable/screen/plane_master/runechat/status
	name = "status plane master"
	plane = PLANE_STATUS
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_NON_GAME

#undef STATUS_INDICATOR_Y_OFFSET
#undef STATUS_INDICATOR_ICON_X_SIZE
#undef STATUS_INDICATOR_ICON_MARGIN
