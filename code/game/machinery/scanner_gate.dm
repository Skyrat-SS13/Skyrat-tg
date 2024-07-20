#define SCANGATE_NONE "Off"
#define SCANGATE_MINDSHIELD "Mindshield"
#define SCANGATE_DISEASE "Disease"
#define SCANGATE_GUNS "Guns"
#define SCANGATE_WANTED "Wanted"
#define SCANGATE_SPECIES "Species"
#define SCANGATE_NUTRITION "Nutrition"
#define SCANGATE_CONTRABAND "Contraband"

#define SCANGATE_HUMAN "human"
#define SCANGATE_LIZARD "lizard"
#define SCANGATE_FELINID "felinid"
#define SCANGATE_FLY "fly"
#define SCANGATE_PLASMAMAN "plasma"
#define SCANGATE_MOTH "moth"
#define SCANGATE_JELLY "jelly"
#define SCANGATE_POD "pod"
#define SCANGATE_GOLEM "golem"
#define SCANGATE_ZOMBIE "zombie"
//SKYRAT EDIT BEGIN - MORE SCANNER GATE OPTIONS
#define SCANGATE_MAMMAL "mammal"
#define SCANGATE_VOX "vox"
#define SCANGATE_AQUATIC "aquatic"
#define SCANGATE_INSECT "insect"
#define SCANGATE_XENO "xeno"
#define SCANGATE_UNATHI "unathi"
#define SCANGATE_TAJARAN "tajaran"
#define SCANGATE_VULPKANIN "vulpkanin"
#define SCANGATE_SYNTH "synth"
#define SCANGATE_TESHARI "teshari"
#define SCANGATE_HEMOPHAGE "hemophage"
#define SCANGATE_SNAIL "snail"

#define SCANGATE_GENDER "Gender"
//SKYRAT EDIT END - MORE SCANNER GATE OPTIONS

/obj/machinery/scanner_gate
	name = "scanner gate"
	desc = "A gate able to perform mid-depth scans on any organisms who pass under it."
	icon = 'icons/obj/machines/scangate.dmi'
	icon_state = "scangate"
	circuit = /obj/item/circuitboard/machine/scanner_gate

	var/scanline_timer
	///Internal timer to prevent audio spam.
	var/next_beep = 0
	///Bool to check if the scanner's controls are locked by an ID.
	var/locked = FALSE
	///Which setting is the scanner checking for? See defines in scanner_gate.dm for the list.
	var/scangate_mode = SCANGATE_NONE
	///Is searching for a disease, what severity is enough to trigger the gate?
	var/disease_threshold = DISEASE_SEVERITY_MINOR
	///If scanning for a specific species, what species is it looking for?
	var/detect_species = SCANGATE_HUMAN
	///Flips all scan results for inverse scanning. Signals if scan returns false.
	var/reverse = FALSE
	///If scanning for nutrition, what level of nutrition will trigger the scanner?
	var/detect_nutrition = NUTRITION_LEVEL_FAT
	///Will the assembly on the pass wire activate if the scanner resolves green (Pass) on crossing?
	var/light_pass = FALSE
	///Will the assembly on the pass wire activate if the scanner resolves red (fail) on crossing?
	var/light_fail = FALSE
	///Does the scanner ignore light_pass and light_fail for sending signals?
	var/ignore_signals = FALSE
	var/detect_gender = "male" //SKYRAT EDIT - MORE SCANNER GATE OPTIONS
	///Is an n-spect scanner attached to the gate? Enables contraband scanning.
	var/obj/item/inspector/n_spect = null


/obj/machinery/scanner_gate/Initialize(mapload)
	. = ..()
	set_wires(new /datum/wires/scanner_gate(src))
	set_scanline("passive")
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	register_context()

/obj/machinery/scanner_gate/Destroy()
	qdel(wires)
	set_wires(null)
	. = ..()

/obj/machinery/scanner_gate/atom_deconstruct(disassembled)
	. = ..()
	if(n_spect)
		n_spect.forceMove(drop_location())
		n_spect = null

/obj/machinery/scanner_gate/examine(mob/user)
	. = ..()
	if(locked)
		. += span_notice("The control panel is ID-locked. Swipe a valid ID to unlock it.")
	else
		. += span_notice("The control panel is unlocked. Swipe an ID to lock it.")
	if(n_spect)
		. += span_notice("The scanner is equipped with an N-Spect scanner. Use a [span_boldnotice("crowbar")] to uninstall.")

/obj/machinery/scanner_gate/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(n_spect && held_item?.tool_behaviour == TOOL_CROWBAR)
		context[SCREENTIP_CONTEXT_LMB] = "Remove N-Spect scanner"
		return CONTEXTUAL_SCREENTIP_SET
	if(!n_spect && istype(held_item, /obj/item/inspector))
		context[SCREENTIP_CONTEXT_LMB] = "Install N-Spect scanner"
		return CONTEXTUAL_SCREENTIP_SET


/obj/machinery/scanner_gate/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(auto_scan), AM)

/obj/machinery/scanner_gate/proc/auto_scan(atom/movable/AM)
	if(!(machine_stat & (BROKEN|NOPOWER)) && isliving(AM) & (!panel_open))
		perform_scan(AM)

/obj/machinery/scanner_gate/proc/set_scanline(type, duration)
	cut_overlays()
	deltimer(scanline_timer)
	add_overlay(type)
	if(duration)
		scanline_timer = addtimer(CALLBACK(src, PROC_REF(set_scanline), "passive"), duration, TIMER_STOPPABLE)

/obj/machinery/scanner_gate/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/inspector))
		if(n_spect)
			to_chat(user, span_warning("The scanner is already equipped with an N-Spect scanner."))
			return ITEM_INTERACT_BLOCKING
		else
			to_chat(user, span_notice("You install an N-Spect scanner on [src]."))
			n_spect = tool
			if(!user.transferItemToLoc(tool, src))
				return ITEM_INTERACT_BLOCKING
			return ITEM_INTERACT_SUCCESS
	return NONE

/obj/machinery/scanner_gate/attackby(obj/item/W, mob/user, params)
	var/obj/item/card/id/card = W.GetID()
	if(card)
		if(locked)
			if(allowed(user))
				locked = FALSE
				req_access = list()
				to_chat(user, span_notice("You unlock [src]."))
		else if(!(obj_flags & EMAGGED))
			to_chat(user, span_notice("You lock [src] with [W]."))
			var/list/access = W.GetAccess()
			req_access = access
			locked = TRUE
		else
			to_chat(user, span_warning("You try to lock [src] with [W], but nothing happens."))
	else
		if(!locked && default_deconstruction_screwdriver(user, "[initial(icon_state)]_open", initial(icon_state), W))
			return
		if(panel_open && is_wire_tool(W))
			wires.interact(user)
	return ..()

/obj/machinery/scanner_gate/crowbar_act(mob/living/user, obj/item/tool)
	. = ..()
	if(n_spect)
		to_chat(user, span_notice("You uninstall [n_spect] from [src]."))
		n_spect.forceMove(drop_location())
		return ITEM_INTERACT_SUCCESS

/obj/machinery/scanner_gate/Exited(atom/gone)
	. = ..()
	if(gone == n_spect)
		n_spect = null
		if(scangate_mode == SCANGATE_CONTRABAND)
			scangate_mode = SCANGATE_NONE

/obj/machinery/scanner_gate/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	locked = FALSE
	req_access = list()
	obj_flags |= EMAGGED
	balloon_alert(user, "id checker disabled")
	return TRUE

/obj/machinery/scanner_gate/proc/perform_scan(mob/living/M)
	var/beep = FALSE
	var/color = null
	switch(scangate_mode)
		if(SCANGATE_NONE)
			return
		if(SCANGATE_WANTED)
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				var/perpname = H.get_face_name(H.get_id_name())
				var/datum/record/crew/target = find_record(perpname)
				if(!target || (target.wanted_status == WANTED_ARREST))
					beep = TRUE
		if(SCANGATE_MINDSHIELD)
			if(HAS_TRAIT(M, TRAIT_MINDSHIELD))
				beep = TRUE
		if(SCANGATE_DISEASE)
			if(iscarbon(M))
				var/mob/living/carbon/C = M
				if(get_disease_severity_value(C.check_virus()) >= get_disease_severity_value(disease_threshold))
					beep = TRUE
		if(SCANGATE_SPECIES)
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				var/datum/species/scan_species = /datum/species/human
				switch(detect_species)
					if(SCANGATE_LIZARD)
						scan_species = /datum/species/lizard
					if(SCANGATE_FLY)
						scan_species = /datum/species/fly
					if(SCANGATE_FELINID)
						scan_species = /datum/species/human/felinid
					if(SCANGATE_PLASMAMAN)
						scan_species = /datum/species/plasmaman
					if(SCANGATE_MOTH)
						scan_species = /datum/species/moth
					if(SCANGATE_JELLY)
						scan_species = /datum/species/jelly
					if(SCANGATE_POD)
						scan_species = /datum/species/pod
					if(SCANGATE_GOLEM)
						scan_species = /datum/species/golem
					if(SCANGATE_ZOMBIE)
						scan_species = /datum/species/zombie
					//SKYRAT EDIT BEGIN - MORE SCANNER GATE OPTIONS
					if(SCANGATE_MAMMAL)
						scan_species = /datum/species/mammal
					if(SCANGATE_VOX)
						scan_species = /datum/species/vox
					if(SCANGATE_AQUATIC)
						scan_species = /datum/species/aquatic
					if(SCANGATE_INSECT)
						scan_species = /datum/species/insect
					if(SCANGATE_XENO)
						scan_species = /datum/species/xeno
					if(SCANGATE_UNATHI)
						scan_species = /datum/species/unathi
					if(SCANGATE_TAJARAN)
						scan_species = /datum/species/tajaran
					if(SCANGATE_VULPKANIN)
						scan_species = /datum/species/vulpkanin
					if(SCANGATE_SYNTH)
						scan_species = /datum/species/synthetic
					if(SCANGATE_TESHARI)
						scan_species = /datum/species/teshari
					if(SCANGATE_HEMOPHAGE)
						scan_species = /datum/species/hemophage
					if(SCANGATE_SNAIL)
						scan_species = /datum/species/snail
					//SKYRAT EDIT END - MORE SCANNER GATE OPTIONS
				if(is_species(H, scan_species))
					beep = TRUE
				if(detect_species == SCANGATE_ZOMBIE) //Can detect dormant zombies
					if(H.get_organ_slot(ORGAN_SLOT_ZOMBIE))
						beep = TRUE
		if(SCANGATE_GUNS)
			for(var/I in M.get_contents())
				if(isgun(I))
					beep = TRUE
					break
		if(SCANGATE_NUTRITION)
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				if(H.nutrition <= detect_nutrition && detect_nutrition == NUTRITION_LEVEL_STARVING)
					beep = TRUE
				if(H.nutrition >= detect_nutrition && detect_nutrition == NUTRITION_LEVEL_FAT)
					beep = TRUE
		//SKYRAT EDIT BEGIN - MORE SCANNER GATE OPTIONS
		if(SCANGATE_GENDER)
			if(ishuman(M))
				var/mob/living/carbon/human/scanned_human = M
				if((scanned_human.gender in list("male", "female"))) //funny thing: nb people will always get by the scan B)
					if(scanned_human.gender == detect_gender)
						beep = TRUE
		//SKYRAT EDIT END - MORE SCANNER GATE OPTIONS
		if(SCANGATE_CONTRABAND)
			for(var/obj/item/content in M.get_all_contents_skipping_traits(TRAIT_CONTRABAND_BLOCKER))
				if(content.is_contraband())
					beep = TRUE
					break
			if(!n_spect.scans_correctly)
				beep = !beep //We do a little trolling

	if(reverse)
		beep = !beep
	if(beep)
		alarm_beep()
		SEND_SIGNAL(src, COMSIG_SCANGATE_PASS_TRIGGER, M)
		if(!ignore_signals)
			color = wires.get_color_of_wire(WIRE_ACCEPT)
			var/obj/item/assembly/assembly = wires.get_attached(color)
			assembly?.activate()
	else
		SEND_SIGNAL(src, COMSIG_SCANGATE_PASS_NO_TRIGGER, M)
		if(!ignore_signals)
			color = wires.get_color_of_wire(WIRE_DENY)
			var/obj/item/assembly/assembly = wires.get_attached(color)
			assembly?.activate()
		set_scanline("scanning", 10)

	use_energy(active_power_usage)

/obj/machinery/scanner_gate/proc/alarm_beep()
	if(next_beep <= world.time)
		next_beep = world.time + (2 SECONDS)
		playsound(src, 'sound/machines/scanbuzz.ogg', 100, FALSE)
	var/mutable_appearance/alarm_display = mutable_appearance(icon, "alarm_light")
	flick_overlay_view(alarm_display, 2 SECONDS)
	set_scanline("alarm", 2 SECONDS)

/obj/machinery/scanner_gate/can_interact(mob/user)
	if(locked)
		return FALSE
	return ..()

/obj/machinery/scanner_gate/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ScannerGate", name)
		ui.open()

/obj/machinery/scanner_gate/ui_data()
	var/list/data = list()
	data["locked"] = locked
	data["scan_mode"] = scangate_mode
	data["reverse"] = reverse
	data["disease_threshold"] = disease_threshold
	data["target_species"] = detect_species
	data["target_nutrition"] = detect_nutrition
	data["target_gender"] = detect_gender //SKYRAT EDIT - MORE SCANNER GATE OPTIONS
	data["contraband_enabled"] = !!n_spect
	return data

/obj/machinery/scanner_gate/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("set_mode")
			var/new_mode = params["new_mode"]
			scangate_mode = new_mode
			. = TRUE
		if("toggle_reverse")
			reverse = !reverse
			. = TRUE
		if("toggle_lock")
			if(allowed(usr))
				locked = !locked
			. = TRUE
		if("set_disease_threshold")
			var/new_threshold = params["new_threshold"]
			disease_threshold = new_threshold
			. = TRUE
		//Some species are not scannable, like abductors (too unknown), androids (too artificial) or skeletons (too magic)
		if("set_target_species")
			var/new_species = params["new_species"]
			detect_species = new_species
			. = TRUE
		if("set_target_nutrition")
			var/new_nutrition = params["new_nutrition"]
			var/nutrition_list = list(
				"Starving",
				"Obese"
			)
			if(new_nutrition && (new_nutrition in nutrition_list))
				switch(new_nutrition)
					if("Starving")
						detect_nutrition = NUTRITION_LEVEL_STARVING
					if("Obese")
						detect_nutrition = NUTRITION_LEVEL_FAT
			. = TRUE
		//SKYRAT EDIT BEGIN - MORE SCANNER GATE OPTIONS
		if("set_target_gender")
			var/new_gender = params["new_gender"]
			var/gender_list = list(
				"Male",
				"Female"
			)
			if(new_gender && (new_gender in gender_list))
				switch(new_gender)
					if("Male")
						detect_gender = "male"
					if("Female")
						detect_gender = "female"
			. = TRUE
		//SKYRAT EDIT END - MORE SCANNER GATE OPTIONS

#undef SCANGATE_NONE
#undef SCANGATE_MINDSHIELD
#undef SCANGATE_DISEASE
#undef SCANGATE_GUNS
#undef SCANGATE_WANTED
#undef SCANGATE_SPECIES
#undef SCANGATE_NUTRITION
#undef SCANGATE_CONTRABAND

#undef SCANGATE_HUMAN
#undef SCANGATE_LIZARD
#undef SCANGATE_FELINID
#undef SCANGATE_FLY
#undef SCANGATE_PLASMAMAN
#undef SCANGATE_MOTH
#undef SCANGATE_JELLY
#undef SCANGATE_POD
#undef SCANGATE_GOLEM
#undef SCANGATE_ZOMBIE
//SKYRAT EDIT BEGIN - MORE SCANNER GATE OPTIONS
#undef SCANGATE_MAMMAL
#undef SCANGATE_VOX
#undef SCANGATE_AQUATIC
#undef SCANGATE_INSECT
#undef SCANGATE_XENO
#undef SCANGATE_UNATHI
#undef SCANGATE_TAJARAN
#undef SCANGATE_VULPKANIN
#undef SCANGATE_SYNTH
#undef SCANGATE_TESHARI
#undef SCANGATE_HEMOPHAGE
#undef SCANGATE_SNAIL

#undef SCANGATE_GENDER
//SKYRAT EDIT END - MORE SCANNER GATE OPTIONS
