/obj/item/zombie_extractor
	name = "Advanced virus RNA extractor"
	desc = "A tool used to extract the RNA from viruses. Apply to skin."
	icon = 'modular_skyrat/modules/better_zombies/icons/extractor.dmi'
	icon_state = "extractor"
	var/obj/item/zombie_extract_vial/loaded_vial

/obj/item/zombie_extractor/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(istype(I, loaded_vial))
		if(!user.transferItemToLoc(I, src))
			return FALSE
		to_chat(user, "<span class='notce'>You insert [I] into [src]!")
		loaded_vial = I
		playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)
		update_appearance()

/obj/item/zombie_extractor/attack_self(mob/living/user)
	if(user.incapacitated())
		return
	unload_vial(user)

/obj/item/zombie_extractor/attack(mob/living/M, mob/living/user, params)
	. = ..()
	if(!loaded_vial)
		return
	if(loaded_vial.extracted_carbon)
		to_chat(user, "<span class='danger'>[src] already has RNA data in it, upload it to the combinator!</span>")
		return
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(!iszombie(C))
			to_chat(user, "<span class='danger'>[C] does not register as infected!</span>")
			return
		if(!C.GetComponent(/datum/component/zombie_infection))
			to_chat(user, "<span class='danger'>[C] does not register as infected!</span>")
			return
		if(C.stat == DEAD)
			to_chat(user, "<span class='danger'>[src] only works on living targets!</span>")
			return
		loaded_vial.load_rna(C)
		to_chat(user, "<span class='notice'>[src] successfully scanned [C], and now holds a sample virus RNA data.</span>")
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE, -6)
		update_appearance()

/obj/item/zombie_extractor/proc/unload_vial(mob/living/user)
	if(loaded_vial)
		loaded_vial.forceMove(user.loc)
		user.put_in_hands(loaded_vial)
		to_chat(user, "<span class='notice'>You remove [loaded_vial] from [src].</span>")
		loaded_vial = null
		update_appearance()
		playsound(loc, 'sound/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, "<span class='notice'>[src]] isn't loaded!</span>")
		return

/obj/item/zombie_extractor/update_overlays()
	. = ..()
	if(loaded_vial)
		. += "extracted"

/obj/item/zombie_extractor/examine(mob/user)
	. = ..()
	if(loaded_vial)
		. += "It has an extracted RNA sample in it."

/obj/item/zombie_extractor/Destroy()
	. = ..()
	loaded_vial.forceMove(loc)
	loaded_vial = null

/obj/item/zombie_extract_vial
	name = "Raw RNA vial"
	desc = "A glass vial containing raw virus RNA. Slot this into the combinator to upload the sample."
	icon = 'modular_skyrat/modules/better_zombies/icons/extractor.dmi'
	icon_state = "rnavial"
	var/mob/living/carbon/extracted_carbon

/obj/item/zombie_extract_vial/proc/load_rna(mob/living/carbon/C)
	extracted_carbon = C
	update_appearance()

/obj/item/zombie_extract_vial/update_overlays(updates)
	. = ..()
	if(extracted_carbon)
		. += "rnavial_load"

#define ZOMBIE_CURE_TIME 10 SECONDS

/obj/item/zombie_cure
	name = "HNZ-1 Cure vial"
	desc = "A counter to the HNZ-1 virus, used to rapidly reverse the effects of the virus."
	icon = 'modular_skyrat/modules/better_zombies/icons/extractor.dmi'
	icon_state = "tvirus_cure"
	var/used = FALSE

/obj/item/zombie_cure/attack(mob/living/M, mob/living/user, params)
	. = ..()
	if(used)
		to_chat(user, "<span class='danger'>[src] has been used and is useless!</span>")
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(!iszombie(C))
			to_chat(user, "<span class='danger'>[C] does not register as infected!</span>")
			return
		if(!C.GetComponent(/datum/component/zombie_infection))
			to_chat(user, "<span class='danger'>[C] does not register as infected!</span>")
			return
		to_chat(user, "<span class='notice'>You begin injecting [C] wth [src]!")
		if(do_after(user, ZOMBIE_CURE_TIME))
			cure_target(C)
			to_chat(user, "<span class='notice'>You inject [C] wth [src]!")
			used = TRUE
			update_appearance()

/obj/item/zombie_cure/update_icon_state()
	. = ..()
	if(used)
		icon_state = "tvirus_used"

/obj/item/zombie_cure/proc/cure_target(mob/living/carbon/C)
	SIGNAL_HANDLER

	SEND_SIGNAL(C, COMSIG_ZOMBIE_CURED)

#undef ZOMBIE_CURE_TIME

/obj/machinery/rnd/rna_extractor
	name = "RNA Combinator"
	desc = "This machine is used to recombine RNA sequences from extracted vials of raw virus."
	icon = 'modular_skyrat/modules/better_zombies/icons/cure_machine.dmi'
	icon_state = "combinator"
	density = TRUE
	use_power = IDLE_POWER_USE
	circuit = /obj/item/circuitboard/machine/experimentor
	var/extracts = 0

/obj/machinery/rnd/rna_extractor/Insert_Item(obj/item/I, mob/user)
	. = ..()
	if(istype(I, /obj/item/zombie_extract_vial))
