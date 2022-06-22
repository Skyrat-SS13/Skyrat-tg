//Credit to Beestation for the original anesthetic machine code: https://github.com/BeeStation/BeeStation-Hornet/pull/3753

/obj/machinery/anesthetic_machine
	name = "Portable Anesthetic Tank Stand"
	desc = "A stand on wheels, similar to an IV drip, that can hold a canister of anesthetic along with a gas mask."
	icon = 'modular_skyrat/modules/medical/icons/obj/machinery.dmi'
	icon_state = "breath_machine"
	anchored = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	use_power = NO_POWER_USE
	/// The mask attached to the anesthetic machine
	var/obj/item/clothing/mask/breath/anesthetic/attached_mask
	/// the tank attached to the anesthetic machine, by default it does not come with one.
	var/obj/item/tank/attached_tank = null
	/// Is the attached mask currently out?
	var/mask_out = FALSE


/obj/machinery/anesthetic_machine/examine(mob/user)
	. = ..()

	. += "Click on the stand to retract the mask, if the mask is currently out"
	if(attached_tank)
		. += "Alt+Click to remove [attached_tank]"

/obj/machinery/anesthetic_machine/Initialize(mapload)
	. = ..()
	attached_mask = new /obj/item/clothing/mask/breath/anesthetic(src)
	attached_mask.attached_machine = src
	update_icon()

/obj/machinery/anesthetic_machine/update_icon()
	. = ..()
	cut_overlays()
	if(mask_out)
		add_overlay("mask_off")
	else
		add_overlay("mask_on")
	if(attached_tank)
		add_overlay("tank_on")


/obj/machinery/anesthetic_machine/attack_hand(mob/living/user)
	. = ..()
	if(!retract_mask())
		return FALSE
	visible_message(span_notice("[user] retracts the mask back into the [src]."))

/obj/machinery/anesthetic_machine/attacked_by(obj/item/used_item, mob/living/user)
	if(!istype(used_item, /obj/item/tank))
		return ..()

	if(attached_tank) // If there is an attached tank, remove it and drop it on the floor
		attached_tank.forceMove(loc)

	used_item.forceMove(src) // Put new tank in, set it as attached tank
	visible_message(span_notice("[user] inserts [used_item] into [src].</span>"))
	attached_tank = used_item
	update_icon()

/obj/machinery/anesthetic_machine/AltClick(mob/user)
	. = ..()
	if(!attached_tank)// If attached tank, remove it.
		return

	attached_tank.forceMove(loc)
	to_chat(user, span_notice("You remove the [attached_tank].</span>"))
	attached_tank = null
	update_icon()
	if(mask_out)
		retract_mask()

/obj/machinery/anesthetic_machine/proc/retract_mask()
	if(!mask_out)
		return FALSE

	if(iscarbon(attached_mask.loc)) // If mask is on a mob
		var/mob/living/carbon/attached_mob = attached_mask.loc
		attached_mob.transferItemToLoc(attached_mask, src, TRUE)
		attached_mob.internal = null
	else
		attached_mask.forceMove(src)

	mask_out = FALSE
	update_icon()
	return TRUE

/obj/machinery/anesthetic_machine/MouseDrop(mob/living/carbon/target)
	. = ..()
	if(!iscarbon(target))
		return

	if((!Adjacent(target)) || !(usr.Adjacent(target)))
		return FALSE

	if(!attached_tank || mask_out)
		to_chat(usr, span_warning("[mask_out ? "The machine is already in use!" : "The machine has no attached tank!"]"))
		return FALSE

	usr.visible_message("<span class='warning'>[usr] attemps to attach the [src] to [target].</span>", "<span class='notice'>You attempt to attach the [src] to [target].</span>")
	if(!do_after(usr, 5 SECONDS, target))
		return
	if(!target.equip_to_appropriate_slot(attached_mask))
		to_chat(usr, "<span class='warning'>You are unable to attach the [src] to [target]!</span>")
		return

	usr.visible_message("<span class='warning'>[usr] attaches the [src] to [target].</span>", "<span class='notice'>You attach the [src] to [target].</span>")
	target.internal = attached_tank
	mask_out = TRUE
	START_PROCESSING(SSmachines, src)
	target.update_internals_hud_icon(1)
	update_icon()

/obj/machinery/anesthetic_machine/process()
	if(!mask_out) // If not on someone, stop processing
		return PROCESS_KILL

	if(get_dist(src, get_turf(attached_mask)) > 1) // If too far away, detach
		to_chat(attached_mask.loc, span_warning("The [attached_mask] is ripped off of your face!"))
		retract_mask()
		return PROCESS_KILL

/obj/machinery/anesthetic_machine/Destroy()
	if(mask_out)
		retract_mask()
	QDEL_NULL(attached_mask)

	new /obj/item/clothing/mask/breath(src)
	. = ..()

/// This a special version of the breath mask used for the anesthetic machine.
/obj/item/clothing/mask/breath/anesthetic
	/// What machine is the mask currently attached to?
	var/obj/machinery/anesthetic_machine/attached_machine

	clothing_flags = MASKINTERNALS | MASKEXTENDRANGE

/obj/item/clothing/mask/breath/anesthetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/clothing/mask/breath/anesthetic/Destroy()
	attached_machine = null
	return ..()

/obj/item/clothing/mask/breath/anesthetic/dropped(mob/user)
	. = ..()

	if(loc != attached_machine) //If it isn't in the machine, then it retracts when dropped
		to_chat(user, span_notice("The [src] retracts back into the [attached_machine]"))
		attached_machine.retract_mask()
