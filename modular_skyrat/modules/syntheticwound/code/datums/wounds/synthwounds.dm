/datum/wound
	var/typeofwound = WOUND_TYPE_ORGANIC //All wounds start as organic by default




/datum/wound/proc/apply_wound_synthetic(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE)
	if(!istype(L) || !L.owner || !(L.body_zone in viable_zones) || L.is_organic_limb() || HAS_TRAIT(L.owner, TRAIT_NEVER_WOUNDED))
		qdel(src)
		return

	if(ishuman(L.owner))
		var/mob/living/carbon/human/H = L.owner
		if(((wound_flags & BONE_WOUND) && !(HAS_BONE in H.dna.species.species_traits)) || ((wound_flags & FLESH_WOUND) && !(HAS_FLESH in H.dna.species.species_traits)))
			qdel(src)
			return

	// we accept promotions and demotions, but no point in redundancy. This should have already been checked wherever the wound was rolled and applied for (see: bodypart damage code), but we do an extra check
	// in case we ever directly add wounds
	for(var/i in L.wounds)
		var/datum/wound/preexisting_wound = i
		if((preexisting_wound.type == type) && (preexisting_wound != old_wound))
			qdel(src)
			return

	set_victim(L.owner)
	set_limb(L)
	LAZYADD(victim.all_wounds, src)
	LAZYADD(limb.wounds, src)
	limb.update_wounds()
	if(status_effect_type)
		victim.apply_status_effect(status_effect_type, src)
	SEND_SIGNAL(victim, COMSIG_CARBON_GAIN_WOUND, src, limb)
	if(!victim.alerts["wound"]) // only one alert is shared between all of the wounds
		victim.throw_alert("wound", /atom/movable/screen/alert/status_effect/wound)

	var/demoted
	if(old_wound)
		demoted = (severity <= old_wound.severity)

	if(severity == WOUND_SEVERITY_TRIVIAL)
		return

	if(!(silent || demoted))
		var/msg = span_danger("[victim]'s [limb.name] [occur_text]!")
		var/vis_dist = COMBAT_MESSAGE_RANGE

		if(severity != WOUND_SEVERITY_MODERATE)
			msg = "<b>[msg]</b>"
			vis_dist = DEFAULT_MESSAGE_RANGE

		victim.visible_message(msg, span_userdanger("Your [limb.name] [occur_text]!"), vision_distance = vis_dist)
		if(sound_effect)
			playsound(L.owner, sound_effect, 70 + 20 * severity, TRUE)

	if(!demoted)
		wound_injury(old_wound)
		second_wind()

/datum/wound/proc/null_victim()
	SIGNAL_HANDLER
	set_victim(null)

