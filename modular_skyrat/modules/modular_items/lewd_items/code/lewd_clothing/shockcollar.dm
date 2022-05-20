/obj/item/electropack/shockcollar
	name = "shock collar"
	desc = "A reinforced metal collar. It has some sort of wiring near the front."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "shockcollar"
	inhand_icon_state = "shockcollar"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	strip_delay = 60
	// equip_delay_other = 60
	custom_materials = list(/datum/material/iron = 5000, /datum/material/glass = 2000)
	var/random = TRUE
	var/freq_in_name = TRUE
	var/tagname = null

/datum/design/electropack/shockcollar
	name = "Shockcollar"
	id = "shockcollar"
	build_type = AUTOLATHE
	build_path = /obj/item/electropack/shockcollar
	materials = list(/datum/material/iron = 5000, /datum/material/glass =2000)
	category = list("hacked", "Misc")

/obj/item/electropack/shockcollar/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK))
		to_chat(user, span_warning("The collar is fastened tight! You'll need help if you want to take it off!"))
		return
	return ..()

/obj/item/electropack/shockcollar/receive_signal(datum/signal/signal)
	if(!signal || signal.data["code"] != code)
		return

	if(isliving(loc) && on) //the "on" arg is currently useless
		var/mob/living/carbon/human/affected_mob = loc
		if(!affected_mob.get_item_by_slot(ITEM_SLOT_NECK)) //**properly** stops pocket shockers
			return
		if(shock_cooldown == TRUE)
			return
		shock_cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, shock_cooldown, FALSE), 100)
		step(affected_mob, pick(GLOB.cardinals))

		to_chat(affected_mob, span_danger("You feel a sharp shock from the collar!"))
		var/datum/effect_system/spark_spread/created_sparks = new /datum/effect_system/spark_spread
		created_sparks.set_up(3, 1, affected_mob)
		created_sparks.start()

		affected_mob.Paralyze(30)
		//affected_mob.adjustPain(10)
		affected_mob.adjust_timed_status_effect(30 SECONDS, /datum/status_effect/speech/stutter)

	if(master)
		if(isassembly(master))
			var/obj/item/assembly/master_as_assembly = master
			master_as_assembly.pulsed()
		master.receive_signal()
	return

/obj/item/electropack/shockcollar/attackby(obj/item/used_item, mob/user, params) // Moves it here because on_click is being bad
	if(istype(used_item, /obj/item/pen))
		var/tag_input = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", tagname ? tagname : "Spot", MAX_NAME_LEN)
		if(tag_input)
			tagname = tag_input
			name = "[initial(name)] - [tag_input]"
		return
	if(istype(used_item, /obj/item/clothing/head/helmet))
		return
	else
		return ..()

/obj/item/electropack/shockcollar/Initialize()
	if(random)
		code = rand(1, 100)
		frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2)) // Signaller frequencies are always uneven!
			frequency++
	if(freq_in_name)
		name = initial(name) + " - freq: [frequency/10] code: [code]"
	. = ..()

/obj/item/electropack/shockcollar/pacify
	name = "pacifying collar"
	desc = "A reinforced metal collar that latches onto the wearer and prevents harmful thoughts."

/obj/item/electropack/shockcollar/pacify/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_NECK)
		ADD_TRAIT(user, TRAIT_PACIFISM, "pacifying-collar")

/obj/item/electropack/shockcollar/pacify/dropped(mob/living/carbon/human/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_PACIFISM, "pacifying-collar")
