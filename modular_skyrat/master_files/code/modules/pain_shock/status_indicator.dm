#define PLANE_STATUS_INDICATOR -12 //Status Indicators that show over mobs' heads when certain things like stuns affect them.

#define VIS_STATUS			24

#define VIS_COUNT			24 //Must be highest number from above.
#define STATUS_LAYER -2.1
#define STATUS_INDICATOR_Y_OFFSET 2 // Offset from the edge of the icon sprite, so 32 pixels plus whatever number is here.
#define STATUS_INDICATOR_ICON_X_SIZE 0 // Don't need to care about the Y size due to the origin being on the bottom side.
#define STATUS_INDICATOR_ICON_MARGIN 0 // The space between two status indicators. We don't do this with the current icons.

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

/mob/living
	var/list/status_indicators = null // Will become a list as needed. Contains our status indicator objects. Note, they are actually added to overlays, this just keeps track of what exists.

/// Returns true if the mob is weakened. Also known as floored.
/mob/living/proc/is_weakened()
	if(HAS_TRAIT(src, TRAIT_FLOORED) || has_status_effect(/datum/status_effect/incapacitating/knockdown))
		return TRUE

/// Returns true if the mob is stunned.
/mob/living/proc/is_stunned()
	if(HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || HAS_TRAIT_FROM(src, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || HAS_TRAIT_FROM(src, TRAIT_IMMOBILIZED, CHOKEHOLD_TRAIT))
		return TRUE

/// Returns true if the mob is paralyzed - for can't fight back purposes.
/mob/living/proc/is_paralyzed()
	if(HAS_TRAIT_FROM(src, TRAIT_FLOORED, CHOKEHOLD_TRAIT) || HAS_TRAIT(src, TRAIT_CRITICAL_CONDITION) || HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, STAMINA) || HAS_TRAIT_FROM(src, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || HAS_TRAIT_FROM(src, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT)))
		return TRUE

/// Returns true if the mob is unconcious for any reason.
/mob/living/proc/is_unconcious()
	if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
		return TRUE

/// Returns true if the mob has confusion.
/mob/living/proc/is_confused()
	if(has_status_effect(/datum/status_effect/confusion))
		return TRUE

/mob/living/carbon/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CARBON_HEALTH_UPDATE, .proc/status_sanity)
	RegisterSignal(src, COMSIG_LIVING_DEATH, .proc/cut_indicators_overlays)

/// Receives signals to update on carbon health updates. Checks if the mob is dead - if true, removes all the indicators. Then, we determine what status indicators the mob should carry or remove.
/mob/living/proc/status_sanity()
	SIGNAL_HANDLER
	if(stat == DEAD)
		return
	else
		is_weakened() ? add_status_indicator(WEAKEN) : remove_status_indicator(WEAKEN)
		is_paralyzed() ? add_status_indicator(PARALYSIS) : remove_status_indicator(PARALYSIS)
		is_stunned() ? add_status_indicator(STUNNED) : remove_status_indicator(STUNNED)
		is_unconcious() ? add_status_indicator(SLEEPING) : remove_status_indicator(SLEEPING)
		is_confused() ? add_status_indicator(CONFUSED) : remove_status_indicator(CONFUSED)
		return

/// Adds a status indicator to the mob. Takes an image as an argument. If it exists, it won't dupe it.
/mob/living/proc/add_status_indicator(image/prospective_indicator)
	if(get_status_indicator(prospective_indicator)) // No duplicates, please.
		return
	if(!istype(prospective_indicator, /image))
		prospective_indicator = image(icon = 'modular_skyrat/master_files/icons/mob/status_indicators.dmi', loc = src, icon_state = prospective_indicator)

	LAZYADD(status_indicators, prospective_indicator)
	handle_status_indicators()

/// Similar to add_status_indicator() but removes it instead, and nulls the list if it becomes empty as a result.
/mob/living/proc/remove_status_indicator(image/prospective_indicator)
	prospective_indicator = get_status_indicator(prospective_indicator)

	cut_overlay(prospective_indicator)
	LAZYREMOVE(status_indicators, prospective_indicator)
	handle_status_indicators()

/// Finds a status indicator on a mob.
/mob/living/proc/get_status_indicator(image/prospective_indicator)
	if(!istype(prospective_indicator, /image))
		for(var/image/I in status_indicators)
			if(I.icon_state == prospective_indicator)
				return I
	return LAZYACCESS(status_indicators, LAZYFIND(status_indicators, prospective_indicator))

/// Cuts all the indicators on a mob.
/mob/living/proc/cut_indicators_overlays()
	SIGNAL_HANDLER
	for(var/prospective_indicator in status_indicators)
		cut_overlay(prospective_indicator)

/// Refreshes the indicators over a mob's head. Should only be called when adding or removing a status indicator with the above procs,
/// or when the mob changes size visually for some reason.
/mob/living/proc/handle_status_indicators()
	// First, get rid of all the overlays.
	cut_indicators_overlays()

	if(!LAZYLEN(status_indicators))
		return

	if(stat == DEAD)
		return
	var/mob/living/carbon/carbon = src
	var/icon_scale = get_icon_scale(carbon)
	// Now put them back on in the right spot.
	var/our_sprite_x = 16 * icon_scale
	var/our_sprite_y = 24 * icon_scale

	var/x_offset = our_sprite_x // Add your own offset here later if you want.
	var/y_offset = our_sprite_y + STATUS_INDICATOR_Y_OFFSET

	// Calculates how 'long' the row of indicators and the margin between them should be.
	// The goal is to have the center of that row be horizontally aligned with the sprite's center.
	var/expected_status_indicator_length = (STATUS_INDICATOR_ICON_X_SIZE * status_indicators.len) + (STATUS_INDICATOR_ICON_MARGIN * max(status_indicators.len - 1, 0))
	var/current_x_position = (x_offset / 2) - (expected_status_indicator_length / 2)

	// In /mob/living's `update_transform()`, the sprite is horizontally shifted when scaled up, so that the center of the sprite doesn't move to the right.
	// Because of that, this adjustment needs to happen with the future indicator row as well, or it will look bad.
	current_x_position -= (32 / 2) * (icon_scale - 1)

	// Now the indicator row can actually be built.
	for(var/prospective_indicator in status_indicators)
		var/image/I = prospective_indicator

		// This is a semi-HUD element, in a similar manner as medHUDs, in that they're 'above' everything else in the world,
		// but don't pierce obfuscation layers such as blindness or darkness, unlike actual HUD elements like inventory slots.
		I.plane = PLANE_STATUS_INDICATOR
		I.layer = STATUS_LAYER
		I.appearance_flags = PIXEL_SCALE|TILE_BOUND|NO_CLIENT_COLOR|RESET_COLOR|RESET_ALPHA|RESET_TRANSFORM|KEEP_APART
		I.pixel_y = y_offset
		I.pixel_x = current_x_position
		add_overlay(I)
		// Adding the margin space every time saves a conditional check on the last iteration,
		// and it won't cause any issues since no more icons will be added, and the var is not used for anything else.
		current_x_position += STATUS_INDICATOR_ICON_X_SIZE + STATUS_INDICATOR_ICON_MARGIN

/mob/living/proc/get_icon_scale(livingmob)
	if(!iscarbon(livingmob)) // normal mobs are always 1 for scale - hopefully all borgs and simplemobs get this one
		return 1
	var/mob/living/carbon/passed_mob = livingmob // we're possibly a player! We have size prefs!
	var/mysize = (passed_mob.dna?.current_body_size ? passed_mob.dna.current_body_size : 1)
	return mysize

/atom/movable/screen/plane_master/runechat/status
	name = "status indicator plane master"
	plane = PLANE_STATUS_INDICATOR
	appearance_flags = PLANE_MASTER
	blend_mode = BLEND_OVERLAY
	render_relay_plane = RENDER_PLANE_NON_GAME

#undef STATUS_INDICATOR_Y_OFFSET
#undef STATUS_INDICATOR_ICON_X_SIZE
#undef STATUS_INDICATOR_ICON_MARGIN
