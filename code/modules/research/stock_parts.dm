/*Power cells are in code\modules\power\cell.dm

If you create T5+ please take a pass at mech_fabricator.dm. The parts being good enough allows it to go into minus values and create materials out of thin air when printing stuff.*/
/obj/item/storage/part_replacer //SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "rapid part exchange device"
	desc = "Special mechanical module made to store, sort, and apply standard machine parts."
	icon_state = "RPED"
	inhand_icon_state = "RPED"
	worn_icon_state = "RPED"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	var/works_from_distance = FALSE
	var/pshoom_or_beepboopblorpzingshadashwoosh = 'sound/items/rped.ogg'
	var/alt_sound = null

/obj/item/storage/part_replacer/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/rped)

/obj/item/storage/part_replacer/pre_attack(obj/attacked_object, mob/living/user, params)
	. = ..()
	if(.)
		return .

	return part_replace_action(attacked_object, user)

/obj/item/storage/part_replacer/proc/part_replace_action(obj/attacked_object, mob/living/user)
	if(!ismachinery(attacked_object) || istype(attacked_object, /obj/machinery/computer))
		return FALSE

	var/obj/machinery/attacked_machinery = attacked_object
	if(!LAZYLEN(attacked_machinery.component_parts))
		return FALSE

	if(attacked_machinery.exchange_parts(user, src) && works_from_distance)
		user.Beam(attacked_machinery, icon_state = "rped_upgrade", time = 0.5 SECONDS)
	return TRUE

/obj/item/storage/part_replacer/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(part_replace_action(interacting_with, user))
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/storage/part_replacer/ranged_interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!works_from_distance)
		return NONE
	if(part_replace_action(interacting_with, user))
		user.Beam(interacting_with, icon_state = "rped_upgrade", time = 0.5 SECONDS)
		return ITEM_INTERACT_SUCCESS
	if(istype(interacting_with, /obj/structure/frame))
		// Cursed snowflake but we need to handle frame ranged interaction here
		// Likely no longer necessary with the new framework, revisit later
		interacting_with.item_interaction(user, src)
		user.Beam(interacting_with, icon_state = "rped_upgrade", time = 0.5 SECONDS)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/storage/part_replacer/proc/play_rped_sound()
	//Plays the sound for RPED exhanging or installing parts.
	if(alt_sound && prob(1))
		playsound(src, alt_sound, 40, TRUE)
	else
		playsound(src, pshoom_or_beepboopblorpzingshadashwoosh, 40, TRUE)

/obj/item/storage/part_replacer/bluespace //SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "bluespace rapid part exchange device"
	desc = "A version of the RPED that allows for replacement of parts and scanning from a distance, along with higher capacity for parts."
	icon_state = "BS_RPED"
	inhand_icon_state = "BS_RPED"
	w_class = WEIGHT_CLASS_NORMAL
	works_from_distance = TRUE
	pshoom_or_beepboopblorpzingshadashwoosh = 'sound/items/pshoom.ogg'
	alt_sound = 'sound/items/pshoom_2.ogg'

/obj/item/storage/part_replacer/bluespace/Initialize(mapload)
	. = ..()

	atom_storage.max_slots = 400
	atom_storage.max_total_storage = 800
	atom_storage.max_specific_storage = WEIGHT_CLASS_GIGANTIC

	RegisterSignal(src, COMSIG_ATOM_ENTERED, PROC_REF(on_part_entered))
	RegisterSignal(src, COMSIG_ATOM_EXITED, PROC_REF(on_part_exited))

/**
 * Signal handler for when a part has been inserted into the BRPED.
 *
 * If the inserted item is a rigged or corrupted cell, does some logging.
 *
 * If it has a reagent holder, clears the reagents and registers signals to prevent new
 * reagents being added and registers clean up signals on inserted item's removal from
 * the BRPED.
 */
/obj/item/storage/part_replacer/bluespace/proc/on_part_entered(datum/source, obj/item/inserted_component)
	SIGNAL_HANDLER

	if(istype(inserted_component, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/inserted_cell = inserted_component
		if(inserted_cell.rigged || inserted_cell.corrupted)
			message_admins("[ADMIN_LOOKUPFLW(usr)] has inserted rigged/corrupted [inserted_cell] into [src].")
			usr.log_message("has inserted rigged/corrupted [inserted_cell] into [src].", LOG_GAME)
			usr.log_message("inserted rigged/corrupted [inserted_cell] into [src]", LOG_ATTACK)
		return

	if(inserted_component.reagents)
		if(length(inserted_component.reagents.reagent_list))
			inserted_component.reagents.clear_reagents()
			to_chat(usr, span_notice("[src] churns as [inserted_component] has its reagents emptied into bluespace."))
		RegisterSignal(inserted_component.reagents, COMSIG_REAGENTS_PRE_ADD_REAGENT, PROC_REF(on_insered_component_reagent_pre_add))

/**
 * Signal handler for when the reagents datum of an inserted part has reagents added to it.
 *
 * Registers the PRE_ADD variant which allows the signal handler to stop reagents being
 * added.
 *
 * Simply returns COMPONENT_CANCEL_REAGENT_ADD. We never want to allow people to add
 * reagents to beakers in BRPEDs as they can then be used for spammable remote bombing.
 */
/obj/item/storage/part_replacer/bluespace/proc/on_insered_component_reagent_pre_add(datum/source, reagent, amount, reagtemp, data, no_react)
	SIGNAL_HANDLER

	return COMPONENT_CANCEL_REAGENT_ADD

/**
 * Signal handler for a part is removed from the BRPED.
 *
 * Does signal registration cleanup on its reagents, if it has any.
 */
/obj/item/storage/part_replacer/bluespace/proc/on_part_exited(datum/source, obj/item/removed_component)
	SIGNAL_HANDLER

	if(removed_component.reagents)
		UnregisterSignal(removed_component.reagents, COMSIG_REAGENTS_PRE_ADD_REAGENT)


/obj/item/storage/part_replacer/bluespace/tier1

/obj/item/storage/part_replacer/bluespace/tier1/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor(src)
		new /obj/item/stock_parts/scanning_module(src)
		new /obj/item/stock_parts/servo(src)
		new /obj/item/stock_parts/micro_laser(src)
		new /obj/item/stock_parts/matter_bin(src)
		new /obj/item/stock_parts/cell/high(src)

/obj/item/storage/part_replacer/bluespace/tier2

/obj/item/storage/part_replacer/bluespace/tier2/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor/adv(src)
		new /obj/item/stock_parts/scanning_module/adv(src)
		new /obj/item/stock_parts/servo/nano(src)
		new /obj/item/stock_parts/micro_laser/high(src)
		new /obj/item/stock_parts/matter_bin/adv(src)
		new /obj/item/stock_parts/cell/super(src)

/obj/item/storage/part_replacer/bluespace/tier3

/obj/item/storage/part_replacer/bluespace/tier3/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor/super(src)
		new /obj/item/stock_parts/scanning_module/phasic(src)
		new /obj/item/stock_parts/servo/pico(src)
		new /obj/item/stock_parts/micro_laser/ultra(src)
		new /obj/item/stock_parts/matter_bin/super(src)
		new /obj/item/stock_parts/cell/hyper(src)

/obj/item/storage/part_replacer/bluespace/tier4

/obj/item/storage/part_replacer/bluespace/tier4/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor/quadratic(src)
		new /obj/item/stock_parts/scanning_module/triphasic(src)
		new /obj/item/stock_parts/servo/femto(src)
		new /obj/item/stock_parts/micro_laser/quadultra(src)
		new /obj/item/stock_parts/matter_bin/bluespace(src)
		new /obj/item/stock_parts/cell/bluespace(src)

/obj/item/storage/part_replacer/cargo //used in a cargo crate

/obj/item/storage/part_replacer/cargo/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/stock_parts/capacitor(src)
		new /obj/item/stock_parts/scanning_module(src)
		new /obj/item/stock_parts/servo(src)
		new /obj/item/stock_parts/micro_laser(src)
		new /obj/item/stock_parts/matter_bin(src)

/obj/item/storage/part_replacer/cyborg //SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "rapid part exchange device"
	desc = "Special mechanical module made to store, sort, and apply standard machine parts. This one has an extra large compartment for more parts."
	icon_state = "borgrped"
	inhand_icon_state = "RPED"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

/obj/item/storage/part_replacer/cyborg/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 400
	atom_storage.max_total_storage = 800
	atom_storage.max_specific_storage = WEIGHT_CLASS_GIGANTIC

/obj/item/storage/part_replacer/proc/get_sorted_parts(ignore_stacks = FALSE)
	var/list/part_list = list()
	//Assemble a list of current parts, then sort them by their rating!
	for(var/obj/item/component_part in contents)
		//No need to put circuit boards in this list or stacks when exchanging parts
		if(istype(component_part, /obj/item/circuitboard) || (ignore_stacks && istype(component_part, /obj/item/stack)))
			continue
		part_list += component_part
		//Sort the parts. This ensures that higher tier items are applied first.
	sortTim(part_list, GLOBAL_PROC_REF(cmp_rped_sort))
	return part_list

/proc/cmp_rped_sort(obj/item/first_item, obj/item/second_item)
	/**
	 * even though stacks aren't stock parts, get_part_rating() is defined on the item level (see /obj/item/proc/get_part_rating()) and defaults to returning 0.
	 */
	return second_item.get_part_rating() - first_item.get_part_rating()

/obj/item/stock_parts
	name = "stock part"
	desc = "What?"
	icon = 'icons/obj/devices/stock_parts.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/rating = 1
	///Used when a base part has a different name to higher tiers of part. For example, machine frames want any servo and not just a micro-servo.
	var/base_name
	var/energy_rating = 1
	///The generic category type that the stock part belongs to.  Generic objects that should not be instantiated should have the same type and abstract_type
	var/abstract_type = /obj/item/stock_parts

/obj/item/stock_parts/Initialize(mapload)
	. = ..()
	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

/obj/item/stock_parts/get_part_rating()
	return rating

//Rating 1

/obj/item/stock_parts/capacitor
	name = "capacitor"
	desc = "A basic capacitor used in the construction of a variety of devices."
	icon_state = "capacitor"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/stock_parts/scanning_module
	name = "scanning module"
	desc = "A compact, high resolution scanning module used in the construction of certain devices."
	icon_state = "scan_module"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.2)

/obj/item/stock_parts/servo
	name = "micro-servo"
	desc = "A tiny little servo motor used in the construction of certain devices."
	icon_state = "micro_servo"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3)
	base_name = "servo"

/obj/item/stock_parts/micro_laser
	name = "micro-laser"
	desc = "A tiny laser used in certain devices."
	icon_state = "micro_laser"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.1, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.2)

/obj/item/stock_parts/matter_bin
	name = "matter bin"
	desc = "A container designed to hold compressed matter awaiting reconstruction."
	icon_state = "matter_bin"
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.8)

//Rating 2

/obj/item/stock_parts/capacitor/adv
	name = "advanced capacitor"
	desc = "An advanced capacitor used in the construction of a variety of devices."
	icon_state = "adv_capacitor"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/stock_parts/scanning_module/adv
	name = "advanced scanning module"
	desc = "A compact, high resolution scanning module used in the construction of certain devices."
	icon_state = "adv_scan_module"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.2)

/obj/item/stock_parts/servo/nano
	name = "nano-servo"
	desc = "A tiny little servo motor used in the construction of certain devices."
	icon_state = "nano_servo"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3)

/obj/item/stock_parts/micro_laser/high
	name = "high-power micro-laser"
	desc = "A tiny laser used in certain devices."
	icon_state = "high_micro_laser"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.1, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.2)

/obj/item/stock_parts/matter_bin/adv
	name = "advanced matter bin"
	desc = "A container designed to hold compressed matter awaiting reconstruction."
	icon_state = "advanced_matter_bin"
	rating = 2
	energy_rating = 3
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.8)

//Rating 3

/obj/item/stock_parts/capacitor/super
	name = "super capacitor"
	desc = "A super-high capacity capacitor used in the construction of a variety of devices."
	icon_state = "super_capacitor"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/stock_parts/scanning_module/phasic
	name = "phasic scanning module"
	desc = "A compact, high resolution phasic scanning module used in the construction of certain devices."
	icon_state = "super_scan_module"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.2)

/obj/item/stock_parts/servo/pico
	name = "pico-servo"
	desc = "A tiny little servo motor used in the construction of certain devices."
	icon_state = "pico_servo"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3)

/obj/item/stock_parts/micro_laser/ultra
	name = "ultra-high-power micro-laser"
	icon_state = "ultra_high_micro_laser"
	desc = "A tiny laser used in certain devices."
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.1, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.2)

/obj/item/stock_parts/matter_bin/super
	name = "super matter bin"
	desc = "A container designed to hold compressed matter awaiting reconstruction."
	icon_state = "super_matter_bin"
	rating = 3
	energy_rating = 5
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.8)

//Rating 4

/obj/item/stock_parts/capacitor/quadratic
	name = "quadratic capacitor"
	desc = "A capacity capacitor used in the construction of a variety of devices."
	icon_state = "quadratic_capacitor"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/stock_parts/scanning_module/triphasic
	name = "triphasic scanning module"
	desc = "A compact, ultra resolution triphasic scanning module used in the construction of certain devices."
	icon_state = "triphasic_scan_module"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.2)

/obj/item/stock_parts/servo/femto
	name = "femto-servo"
	desc = "A tiny little servo motor used in the construction of certain devices."
	icon_state = "femto_servo"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3)

/obj/item/stock_parts/micro_laser/quadultra
	name = "quad-ultra micro-laser"
	icon_state = "quadultra_micro_laser"
	desc = "A tiny laser used in certain devices."
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.1, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.2)

/obj/item/stock_parts/matter_bin/bluespace
	name = "bluespace matter bin"
	desc = "A container designed to hold compressed matter awaiting reconstruction."
	icon_state = "bluespace_matter_bin"
	rating = 4
	energy_rating = 10
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.8)

// Subspace stock parts

/obj/item/stock_parts/subspace
	name = "subspace stock part"
	desc = "What?"
	abstract_type = /obj/item/stock_parts/subspace

/obj/item/stock_parts/subspace/ansible
	name = "subspace ansible"
	icon_state = "subspace_ansible"
	desc = "A compact module capable of sensing extradimensional activity."
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.1)

/obj/item/stock_parts/subspace/filter
	name = "hyperwave filter"
	icon_state = "hyperwave_filter"
	desc = "A tiny device capable of filtering and converting super-intense radiowaves."
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.1)

/obj/item/stock_parts/subspace/amplifier
	name = "subspace amplifier"
	icon_state = "subspace_amplifier"
	desc = "A compact micro-machine capable of amplifying weak subspace transmissions."
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.1)

/obj/item/stock_parts/subspace/treatment
	name = "subspace treatment disk"
	icon_state = "treatment_disk"
	desc = "A compact micro-machine capable of stretching out hyper-compressed radio waves."
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.1)

/obj/item/stock_parts/subspace/analyzer
	name = "subspace wavelength analyzer"
	icon_state = "wavelength_analyzer"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.3, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.1)

/obj/item/stock_parts/subspace/crystal
	name = "ansible crystal"
	icon_state = "ansible_crystal"
	desc = "A crystal made from pure glass used to transmit laser databursts to subspace."
	custom_materials = list(/datum/material/glass=SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/stock_parts/subspace/transmitter
	name = "subspace transmitter"
	icon_state = "subspace_transmitter"
	desc = "A large piece of equipment used to open a window into the subspace dimension."
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5)

// Misc. Parts

/obj/item/stock_parts/card_reader
	name = "card reader"
	icon_state = "card_reader"
	desc = "A small magnetic card reader, used for devices that take and transmit holocredits."
	custom_materials = list(/datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5, /datum/material/glass=SMALL_MATERIAL_AMOUNT*0.1)

/obj/item/stock_parts/water_recycler
	name = "water recycler"
	icon_state = "water_recycler"
	desc = "A chemical reclaimation component, which serves to re-accumulate and filter water over time."
	custom_materials = list(/datum/material/plastic=SMALL_MATERIAL_AMOUNT * 2, /datum/material/iron=SMALL_MATERIAL_AMOUNT*0.5)

/obj/item/research//Makes testing much less of a pain -Sieve
	name = "research"
	icon = 'icons/obj/devices/stock_parts.dmi'
	icon_state = "capacitor"
	desc = "A debug item for research."
