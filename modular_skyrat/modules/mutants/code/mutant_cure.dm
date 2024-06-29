/obj/item/rna_extractor
	name = "advanced virus RNA extractor"
	desc = "A tool used to extract the RNA from viruses. Apply to skin."
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "extractor"
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT,
	)
	/// Our loaded vial.
	var/obj/item/rna_vial/loaded_vial

/obj/item/rna_extractor/attackby(obj/item/O, mob/living/user)
	if((istype(O, /obj/item/rna_vial) && loaded_vial != null))
		to_chat(user, span_warning("[src] can not hold more than one vial!"))
		return FALSE
	if(istype(O, /obj/item/rna_vial))
		if(!user.transferItemToLoc(O, src))
			return FALSE
		to_chat(user, span_notice("You insert [O] into [src]!"))
		loaded_vial = O
		playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)
		update_appearance()

/obj/item/rna_extractor/attack_self(mob/living/user)
	if(user.incapacitated())
		return
	unload_vial(user)

/obj/item/rna_extractor/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	if(!loaded_vial)
		to_chat(user, span_danger("[src] is empty!"))
		return
	if(loaded_vial.contains_rna)
		to_chat(user, span_danger("[src] already has RNA data in it, upload it to the combinator!"))
		return
	if(!ismutant(H))
		to_chat(user, span_danger("[H] does not register as infected!"))
		return
	var/datum/component/mutant_infection/ZI = H.GetComponent(/datum/component/mutant_infection)
	if(!ZI)
		to_chat(user, span_danger("[H] does not register as infected!"))
		return
	if(ZI.extract_rna())
		loaded_vial.load_rna(H)
		to_chat(user, span_notice("[src] successfully scanned [H], and now holds a sample virus RNA data."))
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE, -6)
		update_appearance()
	else
		to_chat(user, span_warning("[H] has no useable RNA!"))

/obj/item/rna_extractor/proc/unload_vial(mob/living/user)
	if(loaded_vial)
		loaded_vial.forceMove(user.loc)
		user.put_in_hands(loaded_vial)
		to_chat(user, span_notice("You remove [loaded_vial] from [src]."))
		loaded_vial = null
		update_appearance()
		playsound(loc, 'sound/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, span_notice("[src] isn't loaded!"))
		return

/obj/item/rna_extractor/update_overlays()
	. = ..()
	if(loaded_vial)
		. += "extractor_load"

/obj/item/rna_extractor/examine(mob/user)
	. = ..()
	if(loaded_vial)
		. += "It has an extracted RNA sample in it."

/obj/item/rna_extractor/Destroy()
	. = ..()
	if(loaded_vial)
		loaded_vial.forceMove(loc)
		loaded_vial = null

/obj/item/rna_vial
	name = "raw RNA vial"
	desc = "A glass vial containing raw virus RNA. Slot this into the combinator to upload the sample."
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "rnavial"
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	var/contains_rna = FALSE

/obj/item/rna_vial/proc/load_rna(mob/living/carbon/human/H)
	contains_rna = TRUE
	update_appearance()

/obj/item/rna_vial/update_overlays(updates)
	. = ..()
	if(contains_rna)
		. += "rnavial_load"

/obj/item/rna_vial/examine(mob/user)
	. = ..()
	if(contains_rna)
		. += "It has an RNA sample in it."

/obj/item/hnz_cure
	name = "HNZ-1 cure vial"
	desc = "A counter to the HNZ-1 virus, used to rapidly reverse the effects of the virus."
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "tvirus_cure"
	var/used = FALSE

/obj/item/hnz_cure/attack(mob/living/M, mob/living/user, params)
	. = ..()
	if(used)
		to_chat(user, span_danger("[src] has been used and is useless!"))
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.GetComponent(/datum/component/mutant_infection))
			to_chat(user, span_danger("[H] does not register as infected!"))
			return
		if(do_after(user, 4 SECONDS))
			cure_target(H)
			playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE, -6)
			to_chat(user, span_notice("You inject [H] wth [src]!"))
			used = TRUE
			update_appearance()

/obj/item/hnz_cure/update_icon_state()
	. = ..()
	if(used)
		icon_state = "tvirus_used"

/obj/item/hnz_cure/proc/cure_target(mob/target)
	SIGNAL_HANDLER

	SEND_SIGNAL(target, COMSIG_MUTANT_CURED)


#define STATUS_IDLE "System Idle"
#define STATUS_RECOMBINATING_VIRUS "System Synthesising Virus"
#define STATUS_RECOMBINATING_CURE "System Synthesising Cure"
#define RECOMBINATION_STEP_TIME (15 SECONDS)
#define RECOMBINATION_STEP_AMOUNT 25

/obj/machinery/rnd/rna_recombinator
	name = "RNA recombinator"
	desc = "This machine is used to recombine RNA sequences from extracted vials of raw virus."
	icon = 'modular_skyrat/modules/mutants/icons/cure_machine.dmi'
	icon_state = "h_lathe"
	base_icon_state = "h_lathe"
	density = TRUE
	use_power = IDLE_POWER_USE
	circuit = /obj/item/circuitboard/machine/rna_recombinator
	var/status = STATUS_IDLE
	var/recombination_step_amount = RECOMBINATION_STEP_AMOUNT
	var/recombination_step_time = RECOMBINATION_STEP_TIME
	var/cure_progress = 0
	var/timer_id

/obj/machinery/rnd/rna_recombinator/Destroy()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	. = ..()

/obj/machinery/rnd/rna_recombinator/attackby(obj/item/weapon, mob/living/user, params)
	if(user.combat_mode)
		return FALSE
	if(!is_insertion_ready(user))
		return FALSE
	if(!istype(weapon, /obj/item/rna_vial))
		return FALSE
	if(!user.transferItemToLoc(weapon, src))
		return FALSE
	loaded_item = weapon
	to_chat(user, span_notice("You insert [weapon] to into [src] reciprocal."))
	flick("h_lathe_load", src)
	update_appearance()
	playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)


/obj/machinery/rnd/rna_recombinator/ui_interact(mob/user)
	var/obj/item/rna_vial/vial = loaded_item
	var/list/dat = list("<center>")
	dat += "<b>System Status: [status]</b>"
	dat += "System Efficency - Step time: [recombination_step_time / 10] SECONDS | Step percent: [recombination_step_amount]%"
	if(status != STATUS_IDLE)
		dat += "<b>Current RNA restructure progress: [cure_progress]%</b>"
	if(vial)
		dat += "<b>Loaded RNA vial:</b> [vial]"
		if(vial.contains_rna)
			dat += "<b>RNA structure: HNZ-1</b>"
			dat += "<b><a href='byond://?src=[REF(src)];item=[REF(loaded_item)];function=cure'>Synthesize Cure</A></b>"
			dat += "<b><a href='byond://?src=[REF(src)];item=[REF(loaded_item)];function=virus'>Synthesize Virus</A></b>"
		else
			dat += "RNA structure: <b>ERROR NO RNA</b>"
		dat += "<b><a href='byond://?src=[REF(src)];function=eject'>Eject</A></b>"
	else
		dat += "<b>Nothing loaded.</b>"
	dat += "<a href='byond://?src=[REF(src)];function=refresh'>Refresh</A>"
	dat += "<a href='byond://?src=[REF(src)];close=1'>Close</A></center>"
	var/datum/browser/popup = new(user, "rna_recombinator","RNA Recombinator", 700, 400, src)
	popup.set_content(dat.Join("<br>"))
	popup.open()
	onclose(user, "rna_recombinator")

/obj/machinery/rnd/rna_recombinator/Topic(href, href_list)
	if(..())
		return
	if(machine_stat & (NOPOWER|BROKEN|MAINT))
		return

	var/operation = href_list["function"]
	var/obj/item/process = locate(href_list["item"]) in src

	if(href_list["close"])
		usr << browse(null, "window=rna_recombinator")
		return
	else if(operation == "eject")
		ejectItem()
	else if(operation == "refresh")
		SStgui.update_uis(src)
	else
		if(status != STATUS_IDLE)
			to_chat(usr, span_warning("[src] is currently recombinating!"))
		else if(!loaded_item)
			to_chat(usr, span_warning("[src] is not currently loaded!"))
		else if(!process || process != loaded_item) //Interface exploit protection (such as hrefs or swapping items with interface set to old item)
			to_chat(usr, span_danger("Interface failure detected in [src]. Please try again."))
		else
			if(operation == "virus")
				status = STATUS_RECOMBINATING_VIRUS
			else
				status = STATUS_RECOMBINATING_CURE
			recombinate_start()
			use_energy(3000 JOULES)

	SStgui.update_uis(src)

/obj/machinery/rnd/rna_recombinator/proc/ejectItem()
	if(loaded_item)
		var/turf/dropturf = get_turf(pick(view(1,src)))
		if(!dropturf) //Failsafe to prevent the object being lost in the void forever.
			dropturf = drop_location()
		loaded_item.forceMove(dropturf)
		loaded_item = null

/obj/machinery/rnd/rna_recombinator/proc/recombinate_start()
	if(machine_stat & (NOPOWER|BROKEN))
		cure_progress = 0
		status = STATUS_IDLE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return
	var/obj/item/rna_vial/vial = loaded_item
	vial.contains_rna = FALSE
	vial.update_appearance()
	ejectItem()
	playsound(loc, 'sound/items/rped.ogg', 60, 1)
	flick("h_lathe_wloop", src)
	use_energy(3000 JOULES)
	timer_id = addtimer(CALLBACK(src, PROC_REF(recombinate_step)), recombination_step_time, TIMER_STOPPABLE)

/obj/machinery/rnd/rna_recombinator/proc/recombinate_step()
	if(machine_stat & (NOPOWER|BROKEN))
		cure_progress = 0
		status = STATUS_IDLE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return
	cure_progress += recombination_step_amount
	if(cure_progress >= 100)
		recombinate_finish()
		return
	flick("h_lathe_wloop", src)
	use_energy(3000 JOULES)
	playsound(loc, 'sound/items/rped.ogg', 60, 1)
	timer_id = addtimer(CALLBACK(src, PROC_REF(recombinate_step)), recombination_step_time, TIMER_STOPPABLE)

/obj/machinery/rnd/rna_recombinator/proc/recombinate_finish()
	if(machine_stat & (NOPOWER|BROKEN))
		cure_progress = 0
		status = STATUS_IDLE
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		return
	cure_progress = 0
	if(status == STATUS_RECOMBINATING_CURE)
		new /obj/item/hnz_cure(get_turf(src))
		new /obj/item/hnz_cure(get_turf(src))
		new /obj/item/hnz_cure(get_turf(src))
	else
		new /obj/item/reagent_containers/cup/bottle/hnz/one(get_turf(src))
	flick("h_lathe_leave", src)
	use_energy(3000 JOULES)
	playsound(loc, 'sound/machines/ding.ogg', 60, 1)
	status = STATUS_IDLE

/obj/machinery/rnd/rna_recombinator/RefreshParts()
	. = ..()
	for(var/datum/stock_part/servo/servo in component_parts)
		if(recombination_step_time > 0 && (recombination_step_time - servo.tier) >= 1)
			recombination_step_time -= servo.tier
	for(var/datum/stock_part/scanning_module/scanning_module in component_parts)
		recombination_step_amount += scanning_module.tier * 2
	for(var/datum/stock_part/micro_laser/micro_laser in component_parts)
		recombination_step_amount += micro_laser.tier

/obj/machinery/rnd/rna_recombinator/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN|MAINT) || !loaded_item)
		. += "lathe_empty"

#undef STATUS_IDLE
#undef STATUS_RECOMBINATING_CURE
#undef STATUS_RECOMBINATING_VIRUS
#undef RECOMBINATION_STEP_TIME
#undef RECOMBINATION_STEP_AMOUNT

/*
*	Infection stuff
*	You didn't think I wouldn't include this did you?
*/

/datum/reagent/hnz
	name = "HNZ-1"
	description = "HNZ-1 is a highly experimental viral bioterror agent \
		which causes dormant nodules to be etched into the grey matter of \
		the subject. These nodules only become active upon death of the \
		host, upon which, the secondary structures activate and take control \
		of the host body."
	color = "#191dff"
	metabolization_rate = INFINITY
	taste_description = "brains"
	ph = 0.5

/datum/reagent/hnz/expose_mob(mob/living/carbon/human/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	try_to_mutant_infect(exposed_mob, TRUE)

/obj/item/reagent_containers/cup/bottle/hnz
	name = "HNZ-1 bottle"
	desc = "A small bottle of the HNZ-1 pathogen. Nanotrasen Bioweapons inc."
	icon = 'modular_skyrat/modules/mutants/icons/extractor.dmi'
	icon_state = "tvirus_infector"
	list_reagents = list(/datum/reagent/hnz = 30)
	custom_materials = list(
		/datum/material/glass=HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/reagent_containers/cup/bottle/hnz/one
	list_reagents = list(/datum/reagent/hnz = 1)


/obj/item/storage/briefcase/virology/hnz
	name = "\improper HNZ-1 biocontainer"
	desc = "An airtight biosealed box containing the highly reactive substance, HNZ1. Authorised personnel only."
	w_class = WEIGHT_CLASS_SMALL
	max_integrity = 500

/obj/item/storage/briefcase/virology/hnz/PopulateContents()
	new /obj/item/reagent_containers/cup/bottle/hnz/one(src)
	new /obj/item/reagent_containers/cup/bottle/hnz/one(src)
	new /obj/item/circuitboard/machine/rna_recombinator(src)
	new /obj/item/rna_extractor(src)
	new /obj/item/rna_vial(src)
