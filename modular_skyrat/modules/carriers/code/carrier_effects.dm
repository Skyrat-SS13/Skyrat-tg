/datum/carrier_effect
	/// What is the current name of the effect?
	var/name = "carrier effect"
	/// What does the effect do?
	var/desc = "does something"
	/// A weakref to the carrier that made the datum
	var/datum/weakref/current_carrier

/// See if the effect can be applied to the mob inside of the carrier and returns `TRUE` or `FALSE` respectively.
/datum/carrier_effect/proc/check_carrier_mob(mob/living/target_mob)
	if(!istype(target_mob))
		return FALSE

	return TRUE

/// See if the effect can be applied to the mob that owns the carrier, if there is one, and returns `TRUE` or `FALSE` respectively.
/datum/carrier_effect/proc/get_owner_mob()
	var/datum/component/carrier/master_carrier = current_carrier?.resolve()
	if(!istype(master_carrier))
		return FALSE

	var/mob/living/current_carrier_owner = master_carrier.get_current_holder()
	if(!istype(current_carrier_owner))
		return FALSE

	return current_carrier_owner

/// Attemps to apply an effect to the targeted carrier mob
/datum/carrier_effect/proc/apply_to_carrier_mob(mob/living/target_mob)
	if(!check_carrier_mob(target_mob))
		return FALSE

	return TRUE

/// Attemps to remove an effect to the targeted carrier mob
/datum/carrier_effect/proc/remove_from_carrier_mob(mob/living/target_mob)
	if(!check_carrier_mob(target_mob))
		return FALSE

	return TRUE

/datum/carrier_effect/proc/apply_to_owner()
	var/mob/living/carrier_owner = get_owner_mob()
	if(!istype(carrier_owner))
		return FALSE

	return carrier_owner

/// Creates a carrier effect based off `effect to create`
/datum/carrier_room/proc/create_effect(datum/carrier_effect/effect_to_create)
	if(!ispath(effect_to_create))
		return FALSE

	var/datum/component/carrier/parent_carrier = master_carrier?.resolve()
	if(!parent_carrier)
		return FALSE

	var/datum/carrier_effect/created_effect = new effect_to_create (src)
	created_effect.current_carrier = WEAKREF(parent_carrier)
	carrier_effects += created_effect
	return TRUE

