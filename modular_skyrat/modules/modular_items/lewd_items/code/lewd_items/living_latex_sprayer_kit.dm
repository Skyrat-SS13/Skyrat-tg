////////////////////////////////
/// LIVING LATEX SPRAYER KIT ///
////////////////////////////////
// The kit is a box.
// There are several items in the box that you can take out and put back in a strictly defined order.
// When closed, the kit can be carried by hand, but cannot be placed in a backpack.
// It is impossible to open in your hands, only on the floor
/obj/item/latex_kit
	name = "latex sprayer kit"
	desc = "Live latex spray kit. Includes: programmer, chip, solvent, one latex canister for one shot and user manual."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "latex_box_closed"
	base_icon_state = "latex_box_closed"
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	//custom_materials = list(/datum/material/cardboard = 2000)
	w_class = WEIGHT_CLASS_BULKY // We can carry it only in hands

	var/isopened = FALSE // Kit opened / closed state

	//Variabel for store content
	var/obj/item/book/manual/latex_pulv_manual/note = /obj/item/book/manual/latex_pulv_manual // Stored note
	var/obj/item/gun/ballistic/revolver/latexpulv/pulv = /obj/item/gun/ballistic/revolver/latexpulv // Stored pulv
	var/obj/item/ammo_casing/latexbin/bin = /obj/item/ammo_casing/latexbin // Stored latex bin
	var/obj/item/pda/latex_pulv_encoder/encoder = /obj/item/pda/latex_pulv_encoder // Stored encoder
	var/obj/item/firing_pin/latexpulvmodule/pin = /obj/item/firing_pin/latexpulvmodule // Stored latex module
	var/obj/item/reagent_containers/spray/chemsprayer/living_latex_dissolver/dissolver = /obj/item/reagent_containers/spray/chemsprayer/living_latex_dissolver // Stored dissolver

	//Overlays
	var/mutable_appearance/note_overlay = null
	var/mutable_appearance/pulv_overlay = null
	var/mutable_appearance/bin_overlay = null
	var/mutable_appearance/encoder_overlay = null
	var/mutable_appearance/pin_overlay = null
	var/mutable_appearance/dissolver_overlay = null

// Extending the initialization procedure
/obj/item/latex_kit/Initialize(mapload)
	. = ..()

	// Create content of kit
	if(pulv)
		pulv = new pulv
	if(bin)
		bin = new bin
	if(pin)
		pin = new pin
	if(encoder)
		encoder = new encoder
	if(note)
		note = new note
	if(dissolver)
		dissolver = new dissolver
	update_appearance()

	// Create overlays
	note_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "box_note", BELOW_MOB_LAYER + 0.1)
	pulv_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "box_pulv", BELOW_MOB_LAYER + 0.1)
	bin_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "box_canister", BELOW_MOB_LAYER + 0.1)
	encoder_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "box_encoder", BELOW_MOB_LAYER + 0.1)
	pin_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "box_chip", BELOW_MOB_LAYER + 0.1)
	dissolver_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "box_dissolver", BELOW_MOB_LAYER + 0.1)

	update_kit_overlays()

// Overlay state update handler
/obj/item/latex_kit/proc/update_kit_overlays()

	cut_overlays(note_overlay)
	cut_overlays(pulv_overlay)
	cut_overlays(bin_overlay)
	cut_overlays(encoder_overlay)
	cut_overlays(pin_overlay)
	cut_overlays(dissolver_overlay)

	if(isopened && note)
		add_overlay(note_overlay)
	if(isopened && pulv)
		add_overlay(pulv_overlay)
	if(isopened && bin)
		add_overlay(bin_overlay)
	if(isopened && encoder)
		add_overlay(encoder_overlay)
	if(isopened && pin)
		add_overlay(pin_overlay)
	if(isopened && dissolver)
		add_overlay(dissolver_overlay)

	update_overlays()
	return

// Alt click handler for retrieving items from a set
/obj/item/latex_kit/AltClick(mob/user)

	// Checking that the kit is not on the character
	if(src.loc != user)
		if(note)
			user.put_in_hands(note)
			note.add_fingerprint(user)
			user.visible_message(span_notice("[user] removes [note] from [src]."), span_notice("You remove [note] from [src]."))
			note = null

		else if(pulv)
			user.put_in_hands(pulv)
			pulv.add_fingerprint(user)
			user.visible_message(span_notice("[user] removes [pulv] from [src]."), span_notice("You remove [pulv] from [src]."))
			pulv = null

		else if(bin)
			user.put_in_hands(bin)
			bin.add_fingerprint(user)
			user.visible_message(span_notice("[user] removes [bin] from [src]."), span_notice("You remove [bin] from [src]."))
			bin = null

		else if(encoder)
			user.put_in_hands(encoder)
			encoder.add_fingerprint(user)
			user.visible_message(span_notice("[user] removes [encoder] from [src]."), span_notice("You remove [encoder] from [src]."))
			encoder = null

		else if(pin)
			user.put_in_hands(pin)
			pin.add_fingerprint(user)
			user.visible_message(span_notice("[user] removes [pin] from [src]."), span_notice("You remove [pin] from [src]."))
			pin = null

		else if(dissolver)
			user.put_in_hands(dissolver)
			dissolver.add_fingerprint(user)
			user.visible_message(span_notice("[user] removes [dissolver] from [src]."), span_notice("You remove [dissolver] from [src]."))
			dissolver = null
		else
			user.visible_message(span_notice("[src] is empty."))
		update_kit_overlays()
	else
		. = ..()

// Icon update handler
/obj/item/latex_kit/update_icon_state()
	. = ..()
	if(isopened)
		icon_state = "latex_box_opened"
	else
		icon_state = "latex_box_closed"

//Kit use handler in hand
/obj/item/latex_kit/attack_self(mob/user, modifiers)
	// Checking that the kit is not on the character
	if(src.loc == user)
		// Kit is too large to open or hold
		if(!isopened)
			user.visible_message("The kit is too big to open by hand ... Try placing it on some surface.")
			return
	else
		. = ..()

// Handler for placing items in a kit
/obj/item/latex_kit/attackby(obj/item/I, mob/living/user, params)
	. = ..() // Standard procedure

	// Checking that the kit is not on the character
	if(src.loc != user)
		if(istype(I,/obj/item/reagent_containers/spray/chemsprayer/living_latex_dissolver/))
			if(!dissolver)
				if(!user.transferItemToLoc(I,src))
					return
				dissolver = I
				user.visible_message(span_notice("[user] inserts [I] into [src]."), span_notice("You insert [I] into [src]."))

			else
				user.visible_message(span_notice("[I] already in [src]. No room for one more."))
				return

		else if(istype(I,/obj/item/firing_pin/latexpulvmodule/))
			if(!pin)
				if(dissolver)
					if(!user.transferItemToLoc(I,src))
						return
					pin = I
					user.visible_message(span_notice("[user] inserts [I] into [src]."), span_notice("You insert [I] into [src]."))
				else
					user.visible_message(span_notice("You need to put the dissolver into the kit, before you can put the chip."))
					return
			else
				user.visible_message(span_notice("[I] already in [src]. No room for one more."))
				return

		else if(istype(I,/obj/item/pda/latex_pulv_encoder))
			if(!encoder)
				if(pin)
					if(!user.transferItemToLoc(I,src))
						return
					encoder = I
					user.visible_message(span_notice("[user] inserts [I] into [src]."), span_notice("You insert [I] into [src]."))
				else
					user.visible_message(span_notice("You need to put the chip into the kit, before you can put the encoder."))
					return
			else
				user.visible_message(span_notice("[I] already in [src]. No room for one more."))
				return

		else if(istype(I, /obj/item/ammo_casing/latexbin))
			if(!bin)
				if(encoder)
					if(!user.transferItemToLoc(I,src))
						return
					bin = I
					user.visible_message(span_notice("[user] inserts [I] into [src]."), span_notice("You insert [I] into [src]."))
				else
					user.visible_message(span_notice("You need to put the encoder into the kit, before you can put the latex bin."))
					return
			else
				user.visible_message(span_notice("[I] already in [src]. No room for one more."))
				return

		else if(istype(I, /obj/item/gun/ballistic/revolver/latexpulv))
			if(!pulv)
				if(bin)
					if(!user.transferItemToLoc(I,src))
						return
					pulv = I
					user.visible_message(span_notice("[user] inserts [I] into [src]."), span_notice("You insert [I] into [src]."))
				else
					user.visible_message(span_notice("You need to put the latex bin into the kit, before you can put the sprayer."))
					return
			else
				user.visible_message(span_notice("[I] already in [src]. No room for one more."))
				return

		else if(istype(I, /obj/item/book/manual/latex_pulv_manual))
			if(!note)
				if(pulv)
					if(!user.transferItemToLoc(I,src))
						return
					note = I
					user.visible_message(span_notice("[user] inserts [I] into [src]."), span_notice("You insert [I] into [src]."))
				else
					user.visible_message(span_notice("You need to put the sprayer into the kit, before you can put the note."))
					return
			else
				user.visible_message(span_notice("[I] already in [src]. No room for one more."))
				return
		else
			user.visible_message(span_notice("You see no room for [I] in [src]."))
			return
		update_kit_overlays()
	else
		return

// Latex kit hand click handler
/obj/item/latex_kit/attack_hand(mob/user, list/modifiers)
	// If the character does not have a latex kit, then when you click on it with your hand, the kit opens or closes,
	// otherwise the standard handling of a click with a hand

	// Checking that the kit is not on the character
	if(src.loc != user)
		if(!isopened)
			isopened = TRUE
			update_icon_state()
			update_kit_overlays()
			user.visible_message("You open [src].", "[user] open [src].")
			return
		else
			isopened = FALSE
			update_icon_state()
			update_kit_overlays()
			user.visible_message("You close [src].", "[user] close [src].")
			return
	else
		. = ..()

// Drag and drop latex kit onto character for pick up kit
/obj/item/latex_kit/MouseDrop(atom/over, src_location, over_location, src_control, over_control, params)

	// Checking if the kit has been dragged onto the character, then we are trying to pick up the kit.
	if(istype(src, /obj/item/latex_kit/) && istype(over, /mob/living/carbon/human/))
		var/mob/living/carbon/human/M = over
		M.put_in_hands(src)
		return
	. = ..()
