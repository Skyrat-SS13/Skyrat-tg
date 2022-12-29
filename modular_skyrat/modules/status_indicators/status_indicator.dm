
GLOBAL_LIST_INIT(potential_indicators, list(
	STUNNED = image(icon = 'modular_skyrat/master_files/icons/mob/status_indicators.dmi', icon_state = STUNNED),
	WEAKEN = image(icon = 'modular_skyrat/master_files/icons/mob/status_indicators.dmi', icon_state = WEAKEN),
	PARALYSIS = image(icon = 'modular_skyrat/master_files/icons/mob/status_indicators.dmi', icon_state = PARALYSIS),
	SLEEPING = image(icon = 'modular_skyrat/master_files/icons/mob/status_indicators.dmi', icon_state = SLEEPING),
	CONFUSED = image(icon = 'modular_skyrat/master_files/icons/mob/status_indicators.dmi', icon_state = CONFUSED),
))

/datum/component/status_indicator
	var/list/status_indicators = null // Will become a list as needed. Contains our status indicator objects. Note, they are actually added to overlays, this just keeps track of what exists.
	var/mob/living/attached_mob

/// Returns true if the mob is weakened. Also known as floored.
/datum/component/status_indicator/proc/is_weakened()
	if(!indicator_fakeouts() && \
	attached_mob.IsKnockdown() || \
	HAS_TRAIT(attached_mob, TRAIT_FLOORED) && \
	!HAS_TRAIT_FROM(attached_mob, TRAIT_FLOORED, BUCKLED_TRAIT)
	)
		return TRUE

/// Returns true if the mob is stunned.
/datum/component/status_indicator/proc/is_stunned()
	if(!indicator_fakeouts() && \
	HAS_TRAIT_FROM(attached_mob, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || \
	HAS_TRAIT(attached_mob, TRAIT_CRITICAL_CONDITION) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_IMMOBILIZED, CHOKEHOLD_TRAIT) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_INCAPACITATED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT))
	)
		return TRUE

/// Returns true if the mob is paralyzed - for can't fight back purposes.
/datum/component/status_indicator/proc/is_paralyzed()
	if(!indicator_fakeouts() && \
	attached_mob.IsParalyzed() || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_FLOORED, CHOKEHOLD_TRAIT) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_IMMOBILIZED, TRAIT_STATUS_EFFECT(STAT_TRAIT)) || \
	HAS_TRAIT(attached_mob, TRAIT_CRITICAL_CONDITION) || \
	HAS_TRAIT_FROM(attached_mob, TRAIT_INCAPACITATED, STAMINA))
		return TRUE

/// Returns true if the mob is unconcious for any reason.
/datum/component/status_indicator/proc/is_unconcious()
	if(!indicator_fakeouts() && HAS_TRAIT(attached_mob, TRAIT_KNOCKEDOUT))
		return TRUE

/// Returns true if the mob has confusion.
/datum/component/status_indicator/proc/is_confused()
	if(!indicator_fakeouts() && attached_mob.has_status_effect(/datum/status_effect/confusion))
		return TRUE

/datum/component/status_indicator/RegisterWithParent()
	attached_mob = parent
	// The Basics
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(cut_indicators_overlays))
	RegisterSignal(parent, COMSIG_CARBON_HEALTH_UPDATE, PROC_REF(status_indicator_evaluate))
	RegisterSignal(parent, COMSIG_LIVING_LIFE, PROC_REF(check_indicators))
	// When things actually happen
	RegisterSignal(parent, COMSIG_LIVING_STATUS_STUN, PROC_REF(status_indicator_evaluate))
	RegisterSignal(parent, COMSIG_LIVING_STATUS_KNOCKDOWN, PROC_REF(status_indicator_evaluate))
	RegisterSignal(parent, COMSIG_LIVING_STATUS_PARALYZE, PROC_REF(status_indicator_evaluate))
	RegisterSignal(parent, COMSIG_LIVING_STATUS_IMMOBILIZE, PROC_REF(status_indicator_evaluate))
	RegisterSignal(parent, COMSIG_LIVING_STATUS_UNCONSCIOUS, PROC_REF(status_indicator_evaluate))
	RegisterSignal(parent, COMSIG_MOB_LOGIN, PROC_REF(apply_pref_on_login))

/datum/component/status_indicator/proc/apply_pref_on_login()
	var/atom/movable/screen/plane_master/game_world_upper_fov_hidden/status_indicator/local_status = locate() in attached_mob.client.screen
	if(local_status)
		. = attached_mob.client.prefs.read_preference(/datum/preference/toggle/enable_status_indicators)
		local_status.alpha = (.) ? 255 : 0

/datum/component/status_indicator/UnregisterFromParent()
	QDEL_NULL(status_indicators)
	UnregisterSignal(attached_mob, COMSIG_LIVING_DEATH)
	UnregisterSignal(attached_mob, COMSIG_CARBON_HEALTH_UPDATE)
	UnregisterSignal(attached_mob, COMSIG_LIVING_LIFE)
	UnregisterSignal(attached_mob, COMSIG_LIVING_STATUS_STUN)
	UnregisterSignal(attached_mob, COMSIG_LIVING_STATUS_KNOCKDOWN)
	UnregisterSignal(attached_mob, COMSIG_LIVING_STATUS_PARALYZE)
	UnregisterSignal(attached_mob, COMSIG_LIVING_STATUS_IMMOBILIZE)
	UnregisterSignal(attached_mob, COMSIG_LIVING_STATUS_UNCONSCIOUS)
	attached_mob = null
/// This proc makes it so that mobs that have status indicators are checked to remove them, especially in fakeout situations.
/datum/component/status_indicator/proc/check_indicators()
	if(status_indicators)
		status_indicator_evaluate()

/// Receives signals to update on carbon health updates. Checks if the mob is dead - if true, removes all the indicators. Then, we determine what status indicators the mob should carry or remove.
/datum/component/status_indicator/proc/status_indicator_evaluate()
	SIGNAL_HANDLER
	if(attached_mob.stat == DEAD)
		return
	else
		weaken_indicator_update()
		paralyzed_indicator_update()
		stunned_indicator_update()
		unconcious_indicator_update()
		confused_indicator_update()
		return
/// Cases in which no status indicators should appear above a mob, such as changeling revive and regen coma.
/datum/component/status_indicator/proc/indicator_fakeouts()
	if(HAS_TRAIT(attached_mob, TRAIT_DEATHCOMA))
		return TRUE
	return FALSE

/datum/component/status_indicator/proc/weaken_indicator_update()
	SIGNAL_HANDLER
	is_weakened() ? add_status_indicator(WEAKEN) : remove_status_indicator(WEAKEN)
/datum/component/status_indicator/proc/paralyzed_indicator_update()
	SIGNAL_HANDLER
	is_paralyzed() ? add_status_indicator(PARALYSIS) : remove_status_indicator(PARALYSIS)
/datum/component/status_indicator/proc/stunned_indicator_update()
	SIGNAL_HANDLER
	is_stunned() ? add_status_indicator(STUNNED) : remove_status_indicator(STUNNED)
/datum/component/status_indicator/proc/unconcious_indicator_update()
	SIGNAL_HANDLER
	is_unconcious() ? add_status_indicator(SLEEPING) : remove_status_indicator(SLEEPING)
/datum/component/status_indicator/proc/confused_indicator_update()
	SIGNAL_HANDLER
	is_confused() ? add_status_indicator(CONFUSED) : remove_status_indicator(CONFUSED)

/// Adds a status indicator to the mob. Takes an image as an argument. If it exists, it won't dupe it.
/datum/component/status_indicator/proc/add_status_indicator(image/prospective_indicator)
	if(get_status_indicator(prospective_indicator)) // No duplicates, please.
		return

	prospective_indicator = GLOB.potential_indicators[prospective_indicator]
	prospective_indicator.loc = src
	LAZYADD(status_indicators, prospective_indicator)
	handle_status_indicators(prospective_indicator)

/// Similar to add_status_indicator() but removes it instead, and nulls the list if it becomes empty as a result.
/datum/component/status_indicator/proc/remove_status_indicator(image/prospective_indicator)
	prospective_indicator = get_status_indicator(prospective_indicator)

	attached_mob.cut_overlay(prospective_indicator)
	LAZYREMOVE(status_indicators, prospective_indicator)
	handle_status_indicators(prospective_indicator)

/// Finds a status indicator on a mob.
/datum/component/status_indicator/proc/get_status_indicator(image/prospective_indicator)

	for(var/image/indicator in status_indicators)
		if(indicator.icon_state == prospective_indicator)
			return indicator
	return LAZYACCESS(status_indicators, LAZYFIND(status_indicators, prospective_indicator))

/// Cuts all the indicators on a mob in a loop.
/datum/component/status_indicator/proc/cut_indicators_overlays()
	SIGNAL_HANDLER
	for(var/prospective_indicator in status_indicators)
		attached_mob.cut_overlay(prospective_indicator)

/// Refreshes the indicators over a mob's head. Should only be called when adding or removing a status indicator with the above procs,
/// or when the mob changes size visually for some reason.
/datum/component/status_indicator/proc/handle_status_indicators(image/prospective_indicator)
	// First, get rid of all the overlays.

	cut_indicators_overlays()

	if(!LAZYLEN(status_indicators))
		return

	var/mob/living/carbon/my_carbon_mob = attached_mob

	var/icon_scale = get_icon_scale(my_carbon_mob)

	if(my_carbon_mob.stat == DEAD)
		cut_indicators_overlays()
		return

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
	current_x_position -= 16 * (icon_scale - DEFAULT_MOB_SCALE)

	// Now the indicator row can actually be built.
	for(var/all_indicators in status_indicators)
		var/image/indicator = all_indicators

		// This is a semi-HUD element, in a similar manner as medHUDs, in that they're 'above' everything else in the world,
		// but don't pierce obfuscation layers such as blindness or darkness, unlike actual HUD elements like inventory slots.
		indicator.plane = GAME_PLANE_UPPER_FOV_HIDDEN
		indicator.layer = STATUS_LAYER
		indicator.appearance_flags = PIXEL_SCALE|TILE_BOUND|NO_CLIENT_COLOR|RESET_COLOR|RESET_ALPHA|RESET_TRANSFORM|KEEP_APART
		indicator.pixel_y = y_offset
		indicator.pixel_x = current_x_position
		my_carbon_mob.add_overlay(indicator)
		// Adding the margin space every time saves a conditional check on the last iteration,
		// and it won't cause any issues since no more icons will be added, and the var is not used for anything else.
		current_x_position += STATUS_INDICATOR_ICON_X_SIZE + STATUS_INDICATOR_ICON_MARGIN

/datum/component/status_indicator/proc/get_icon_scale(livingmob)
	if(!iscarbon(livingmob)) // normal mobs are always 1 for scale - hopefully all borgs and simplemobs get this one
		return DEFAULT_MOB_SCALE
	var/mob/living/carbon/passed_mob = livingmob // we're possibly a player! We have size prefs!
	var/mysize = (passed_mob.dna?.current_body_size ? passed_mob.dna.current_body_size : DEFAULT_MOB_SCALE)
	return mysize

/atom/movable/screen/plane_master/game_world_upper_fov_hidden/status_indicator
	name = "Status Indicator Plane"
	documentation = "Status Indicator Plane"
	plane = GAME_PLANE_UPPER_FOV_HIDDEN
	start_hidden = FALSE

#undef STATUS_INDICATOR_Y_OFFSET
#undef STATUS_INDICATOR_ICON_X_SIZE
#undef STATUS_INDICATOR_ICON_MARGIN
