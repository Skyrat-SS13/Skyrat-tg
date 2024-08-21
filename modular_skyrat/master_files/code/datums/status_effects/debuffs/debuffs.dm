/datum/status_effect/crusher_mark
	id = "crusher_mark"
	duration = 300 //if you leave for 30 seconds you lose the mark, deal with it
	status_type = STATUS_EFFECT_MULTIPLE
	alert_type = null
	var/mutable_appearance/marked_underlay
	var/datum/component/kinetic_crusher/hammer_synced

/datum/status_effect/crusher_mark/on_creation(mob/living/new_owner, obj/item/kinetic_crusher/new_hammer_synced)
	hammer_synced = new_hammer_synced
	return ..()

/datum/status_effect/crusher_mark/on_apply()
	if(owner.mob_size >= MOB_SIZE_LARGE)
		marked_underlay = mutable_appearance('icons/effects/effects.dmi', "shield2")
		marked_underlay.pixel_x = -owner.pixel_x
		marked_underlay.pixel_y = -owner.pixel_y

		var/obj/item/crusher_trophy/watcher_eye/eye = locate() in hammer_synced.stored_trophies
		if(eye) //we must do this here as adding (and deleting!) to atom.underlays works by value, not reference
			marked_underlay.icon_state = "shield-grey"
			marked_underlay.color = eye.used_color

		owner.underlays += marked_underlay
		return TRUE
	return FALSE

/datum/status_effect/crusher_mark/Destroy()
	hammer_synced = null
	owner?.underlays -= marked_underlay
	QDEL_NULL(marked_underlay)
	return ..()

//we will only clear ourselves if the crusher is the one that owns us.
/datum/status_effect/crusher_mark/before_remove(datum/component/kinetic_crusher/attacking_hammer)
	return (attacking_hammer == hammer_synced)
