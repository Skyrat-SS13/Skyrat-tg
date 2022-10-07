/datum/quirk/equipping/nerve_staple
	name = "Nerve Stapled"
	desc = "You're a pacifist. Not because you want to be, but because of the device stapled into your eye."
	value = -10 // pacifism = -8, losing eye slots = -2
	gain_text = span_danger("You suddenly can't raise a hand to hurt others!")
	lose_text = span_notice("You think you can defend yourself again.")
	medical_record_text = "Patient is nerve stapled and is unable to harm others."
	icon = "hand-peace"
	forced_items = list(/obj/item/clothing/glasses/nerve_staple = list(ITEM_SLOT_EYES))
	/// The nerve staple attached to the quirk
	var/obj/item/clothing/glasses/nerve_staple/staple

/datum/quirk/equipping/nerve_staple/on_equip_item(obj/item/equipped, successful)
	if (!istype(equipped, /obj/item/clothing/glasses/nerve_staple))
		return
	staple = equipped

/datum/quirk/equipping/nerve_staple/remove()
	. = ..()
	if (!staple || staple != quirk_holder.get_item_by_slot(ITEM_SLOT_EYES))
		return
	to_chat(quirk_holder, span_warning("The nerve staple suddenly falls off your face and melts[istype(quirk_holder.loc, /turf/open/floor) ? " on the floor" : ""]!"))
	qdel(staple)

// Re-labels TG brainproblems to be more generic. There never was a tumor anyways!
/datum/quirk/item_quirk/brainproblems
	name = "Brain Degeneration"
	desc = "You have a lethal condition in your brain that is slowly destroying it. Better bring some mannitol!"

// Override of Brain Tumor quirk for robotic/synthetic species with posibrains.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/item_quirk/brainproblems/synth
	name = "Positronic Cascade Anomaly"
	desc = "Your positronic brain is slowly corrupting itself due to a cascading anomaly. Better bring some liquid solder!"
	gain_text = "<span class='danger'>You feel glitchy.</span>"
	lose_text = "<span class='notice'>You no longer feel glitchy.</span>"
	medical_record_text = "Patient has a cascading anomaly in their brain that is slowly causing brain death."
	mail_goodies = list(/obj/item/storage/pill_bottle/liquid_solder/braintumor)
	hidden_quirk = TRUE

// If brainproblems is added to a synth, this detours to the brainproblems/synth quirk.
// TODO: Add more brain-specific detours when PR #16105 is merged
/datum/quirk/item_quirk/brainproblems/add_to_holder(mob/living/new_holder, quirk_transfer)
	if(!(is_species(new_holder, /datum/species/robotic) && (src.type == /datum/quirk/item_quirk/brainproblems)))
		// Defer to TG brainproblems if the character isn't robotic.
		return ..()
	qdel(src)
	// TODO: Check brain type and detour to appropriate brainproblems quirk
	var/datum/quirk/item_quirk/brainproblems/synth/_bp_synth = new
	return _bp_synth.add_to_holder(new_holder, quirk_transfer)

// Synthetics get liquid_solder with Brain Tumor instead of mannitol.
/datum/quirk/item_quirk/brainproblems/synth/add_unique()
	give_item_to_holder(
		/obj/item/storage/pill_bottle/liquid_solder/braintumor,
		list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		),
		flavour_text = "These will keep you alive until you can secure a supply of medication. Don't rely on them too much!",
	)

// Override of Blood Deficiency quirk for robotic/synthetic species.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/blooddeficiency/synth
	name = "Hydraulic Leak"
	desc = "Your body's hydraulic fluids are leaking through their seals."
	medical_record_text = "Patient requires regular treatment for hydraulic fluid loss."
	hidden_quirk = TRUE

// If blooddeficiency is added to a synth, this detours to the blooddeficiency/synth quirk.
/datum/quirk/blooddeficiency/add_to_holder(mob/living/new_holder, quirk_transfer)
	if(!(is_species(new_holder, /datum/species/robotic) && (src.type == /datum/quirk/blooddeficiency)))
		// Defer to TG blooddeficiency if the character isn't robotic.
		return ..()
	qdel(src)
	var/datum/quirk/blooddeficiency/synth/_bd_synth = new
	return _bd_synth.add_to_holder(new_holder, quirk_transfer)

// Synthetics lose more fluids than organics. Rebalances the quirk for synths!
/datum/quirk/blooddeficiency/synth/process(delta_time)
	if(quirk_holder.stat == DEAD)
		return
	var/mob/living/carbon/carbon_quirk_holder = quirk_holder
	// Can't lose blood if your species doesn't have any.
	if(NOBLOOD in carbon_quirk_holder.dna.species.species_traits)
		return
	// Survivable without treatment, but causes lots of fainting.
	if (carbon_quirk_holder.blood_volume > BLOOD_VOLUME_BAD)
		carbon_quirk_holder.blood_volume -= 0.275 * delta_time
