/obj/item/rsd_interface
	name = "RSD Interface"
	desc = "A small device that when inserted to an inert brain, allows the brain to recieve souls from an RSD Soulcatcher."
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit" //Make something better later

/// Attempts to use the item on the target brain.
/obj/item/rsd_interface/afterattack(obj/item/organ/internal/brain/target_brain, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag || !istype(target_brain))
		return FALSE

	if(HAS_TRAIT(target_brain, TRAIT_NIFSOFT_HUD_GRANTER))
		balloon_alert("already upgraded!")
		return FALSE

	user.visible_message(span_notice("[user] upgrades [target_brain] with [src]."), span_notice("You upgrade [target_brain] to be RSD compatible."))
	target_brain.AddElement(/datum/element/rsd_interface)
	playsound(target_brain.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)

	qdel(src)

/datum/element/rsd_interface/Attach(datum/target)
	. = ..()
	if(!istype(target, /obj/item/organ/internal/brain))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	ADD_TRAIT(target, TRAIT_RSD_COMPTAIBLE, INNATE_TRAIT)

/// Adds text to the examine text of the parent item, explaining that the item can be used to enable the use of NIFSoft HUDs
/datum/element/rsd_interface/proc/on_examine(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER
	examine_text += span_cyan("Souls can be transfered to [source], assuming it is inert.")

/datum/element/rsd_interface/Detach(datum/target)
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	REMOVE_TRAIT(target, TRAIT_RSD_COMPTAIBLE, INNATE_TRAIT)

	return ..()

