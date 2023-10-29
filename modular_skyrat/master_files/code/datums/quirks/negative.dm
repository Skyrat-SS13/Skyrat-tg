/datum/quirk/equipping/nerve_staple
	name = "Nerve Stapled"
	desc = "You're a pacifist. Not because you want to be, but because of the device stapled into your eye."
	value = -10 // pacifism = -8, losing eye slots = -2
	gain_text = span_danger("You suddenly can't raise a hand to hurt others!")
	lose_text = span_notice("You think you can defend yourself again.")
	medical_record_text = "Patient is nerve stapled and is unable to harm others."
	icon = FA_ICON_FACE_ANGRY
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

/datum/quirk/item_quirk/diabetic
	name = "Diabetic"
	desc = "You have a condition which prevents you from metabolizing sugar correctly! Better bring some cookies and insulin!"
	icon = FA_ICON_COOKIE_BITE
	medical_record_text = "Patient has diabetes, and is at-risk of hypoglycemic shock when their blood sugar level is too low."
	value = -6
	gain_text = span_danger("You feel a dizzying craving for sugar.")
	lose_text = span_notice("Your craving for sugar subsides.")
	hardcore_value = 3
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_PROCESSES
	mail_goodies = list(/obj/item/storage/pill_bottle/insulin/diabetic)

/datum/quirk/item_quirk/diabetic/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/insulin/diabetic,
		list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		),
		flavour_text = "These will keep you alive until you can secure a supply of medication. Don't rely on them too much!",
	)
	give_item_to_holder(/obj/item/healthanalyzer/simple/disease, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK))
	give_item_to_holder(/obj/item/food/cookie/sugar, list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		))

/datum/quirk/item_quirk/diabetic/process(seconds_per_tick)
	if(!iscarbon(quirk_holder))
		return

	if(IS_IN_STASIS(quirk_holder))
		return

	if(quirk_holder.stat == DEAD)
		return

	var/mob/living/carbon/carbon_holder = quirk_holder
	var/datum/reagent/sugar = carbon_holder.reagents.has_reagent(/datum/reagent/consumable/sugar)

	if(sugar != FALSE)
		// Diabetics metabolize sugar 5x slower than normal.
		sugar.metabolization_rate = 0.05
		return
	
	// No sugar, get hypoglycemia.
	if(carbon_holder.HasDisease(/datum/disease/hypoglycemia))
		return

	var/datum/disease/hypoglycemic_shock = new /datum/disease/hypoglycemia()
	carbon_holder.ForceContractDisease(hypoglycemic_shock, FALSE, TRUE)

// Re-labels TG brainproblems to be more generic. There never was a tumor anyways!
/datum/quirk/item_quirk/brainproblems
	name = "Brain Degeneration"
	desc = "You have a lethal condition in your brain that is slowly destroying it. Better bring some mannitol!"
	medical_record_text = "Patient has a lethal condition in their brain that is slowly causing brain death."
	icon = FA_ICON_BRAIN

// Override of Brain Tumor quirk for robotic/synthetic species with posibrains.
// Does not appear in TGUI or the character preferences window.
/datum/quirk/item_quirk/brainproblems/synth
	name = "Positronic Cascade Anomaly"
	desc = "Your positronic brain is slowly corrupting itself due to a cascading anomaly. Better bring some liquid solder!"
	gain_text = "<span class='danger'>You feel glitchy.</span>"
	lose_text = "<span class='notice'>You no longer feel glitchy.</span>"
	medical_record_text = "Patient has a cascading anomaly in their brain that is slowly causing brain death."
	icon = FA_ICON_BRAZILIAN_REAL_SIGN
	mail_goodies = list(/obj/item/storage/pill_bottle/liquid_solder/braintumor)
	hidden_quirk = TRUE

// If brainproblems is added to a synth, this detours to the brainproblems/synth quirk.
// TODO: Add more brain-specific detours when PR #16105 is merged
/datum/quirk/item_quirk/brainproblems/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source)
	if(!issynthetic(new_holder) || type != /datum/quirk/item_quirk/brainproblems)
		// Defer to TG brainproblems if the character isn't robotic.
		return ..()

	// TODO: Check brain type and detour to appropriate brainproblems quirk
	var/datum/quirk/item_quirk/brainproblems/synth/bp_synth = new
	qdel(src)
	return bp_synth.add_to_holder(new_holder, quirk_transfer, client_source)

// Synthetics get liquid_solder with Brain Tumor instead of mannitol.
/datum/quirk/item_quirk/brainproblems/synth/add_unique(client/client_source)
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
	icon = FA_ICON_GLASS_WATER_DROPLET
	mail_goodies = list(/obj/item/reagent_containers/blood/oil)
	// min_blood = BLOOD_VOLUME_BAD - 25; // TODO: Uncomment after TG PR #70563
	hidden_quirk = TRUE

// If blooddeficiency is added to a synth, this detours to the blooddeficiency/synth quirk.
/datum/quirk/blooddeficiency/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source)
	if(!issynthetic(new_holder) || type != /datum/quirk/blooddeficiency)
		// Defer to TG blooddeficiency if the character isn't robotic.
		return ..()

	var/datum/quirk/blooddeficiency/synth/bd_synth = new
	qdel(src)
	return bd_synth.add_to_holder(new_holder, quirk_transfer)
