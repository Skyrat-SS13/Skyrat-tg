/obj/effect/mob_spawn/corpse/human/prisoner
	name = "Prisoner"
	outfit = /datum/outfit/job/prisoner
	icon_state = "corpseminer"

/obj/effect/mob_spawn/corpse/human/clock_cultist
	name = "Clock Cultist"
	outfit = /datum/outfit/clock_cultist/corpse
	icon_state = "corpseminer"

/datum/outfit/clock_cultist/corpse/post_equip(mob/living/carbon/human/equipped, visualsOnly)
	. = ..()
	equipped.faction |= "clock"

/obj/effect/mob_spawn/corpse/human/blood_cultist
	name = "Blood Cultist"
	outfit = /datum/outfit/cultist/corpse
	icon_state = "corpseminer"

/datum/outfit/cultist/corpse
	name = "Cultist (Corpse)"
	r_hand = null

/obj/item/storage/box/stockparts/advanced
	name = "box of stock parts"
	desc = "Contains a variety of advanced stock parts."

/obj/item/storage/box/stockparts/advanced/PopulateContents()
	var/static/items_inside = list(
		/obj/item/stock_parts/capacitor/adv = 3,
		/obj/item/stock_parts/scanning_module/adv = 3,
		/obj/item/stock_parts/manipulator/nano = 3,
		/obj/item/stock_parts/micro_laser/high = 3,
		/obj/item/stock_parts/matter_bin/adv = 3)
	generate_items_inside(items_inside, src)

/obj/machinery/suit_storage_unit/standard_unit/with_jetpack
	storage_type = /obj/item/tank/jetpack/oxygen

/datum/action/outbound_objective
	name = "Recall Objective"
	button_icon_state = "round_end"

/datum/action/outbound_objective/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	OUTBOUND_CONTROLLER
	outbound_controller.tell_objective(owner)

/obj/item/reviver
	name = "strange injector"
	desc = "It contains a strange fluid, glowing a very light, neon blue. A label on the back reads, \"WARNING: ONLY USE ON DEAD\""
	icon = 'icons/obj/medical/syringe.dmi'
	icon_state = "combat_hypo"
	/// How many uses do we have left
	var/uses = 1

/obj/item/reviver/attack(mob/living/target_mob, mob/living/user, params)
	if(!istype(target_mob))
		return ..()
	if(!uses)
		to_chat(user, span_warning("There's no uses left in [src]!"))
		return
	to_chat(user, span_notice("You prepare to inject [target_mob]..."))
	if(!do_after(user, 5 SECONDS, target_mob))
		return
	if(target_mob.stat == DEAD)
		target_mob.revive(TRUE, TRUE) // One use omni-heal if you're dead
		to_chat(user, span_notice("You inject [target_mob] with [src], causing their limp body to move again!"))
	else
		SSradiation.irradiate(target_mob) // If you're not dead you're fucked up instead
		target_mob.adjustToxLoss(MAX_LIVING_HEALTH * 3)
		target_mob.Paralyze(15 SECONDS, ignore_canstun = TRUE)
		to_chat(user, span_warning("You inject [target_mob] with [src], causing them to seize up and collapse!"))
	uses--
