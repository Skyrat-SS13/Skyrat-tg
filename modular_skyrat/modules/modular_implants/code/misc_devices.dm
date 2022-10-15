///NIFSoft Remover. This is mostly here so that security and antags have a way to remove NIFSofts from someome
/obj/item/nifsoft_remover
	name = "NIFSoft Remover"
	desc = "Removes a NIFSoft from someone." //Placeholder Description and name
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "nifsoft_remover"

	///Is a disk with the removed NIFSoft created?
	var/create_disk = FALSE

/obj/item/nifsoft_remover/attack(mob/living/carbon/human/target_mob, mob/living/user)
	. = ..()
	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = target_mob.installed_nif

	if(!target_nif || !length(target_nif.loaded_nifsofts))
		to_chat(user, span_warning("[user] does not posses a NIF with any installed NIFSofts"))
		return

	var/list/installed_nifsofts = target_nif.loaded_nifsofts
	var/datum/nifsoft/nifsoft_to_remove = tgui_input_list(user, "Chose a NIFSoft to remove", "[src]", installed_nifsofts)

	if(!nifsoft_to_remove)
		return FALSE

	user.visible_message(span_warning("[user] starts to use the [src] on [target_mob]"), span_notice("You start to use the [src] on [target_mob]"))
	if(!do_after(user, 5 SECONDS, target_mob))
		return FALSE

	if(!target_nif.remove_nifsoft(nifsoft_to_remove))
		return FALSE

	to_chat(user, span_notice("You successfully remove the [nifsoft_to_remove.name]"))
	user.log_message("[user] removed [nifsoft_to_remove.name] from [target_mob]",LOG_GAME)

	if(create_disk)
		var/obj/item/disk/nifsoft_uploader/new_disk = new /obj/item/disk/nifsoft_uploader
		new_disk.loaded_nifsoft = nifsoft_to_remove.type
		new_disk.name = "[nifsoft_to_remove.name] datadisk"

		user.put_in_hands(new_disk)

	return TRUE

/obj/item/nifsoft_remover/syndie
	name = "Syndicate NIFSoft Remover"
	desc = "A modified version of a NIFSoft remover that allows the user to remove a NIFSoft and have a blank copy of the removed NIFSoft saved to a disk"
	icon_state =  "nifsoft_remover_syndie"

	create_disk = TRUE

/datum/design/nifsoft_remover
	name = "NIFSoft remover"
	desc = "A small device that lets the user remove NIFSofts from a NIF user"
	id = "nifsoft_remover"
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/nifsoft_remover
	materials = list(/datum/material/iron = 200, /datum/material/silver = 500, /datum/material/uranium = 500)
	category = list(RND_CATEGORY_EQUIPMENT)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/uplink_item/device_tools/nifsoft_remover
	name = "Syndicate NIFSoft Remover"
	desc = "A modified version of a NIFSoft remover that allows the user to remove a NIFSoft and have a blank copy of the removed NIFSoft saved to a disk"
	item = /obj/item/nifsoft_remover/syndie
	cost = 3

///NIF Repair Kit.
/obj/item/nif_repair_kit
	name = "NIF repair kit"
	desc = "Repairs NIFs" //Placeholder
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "repair_paste"
	w_class = WEIGHT_CLASS_SMALL
	///How much does this repair each time it is used?
	var/repair_amount = 20
	///How many times can this be used?
	var/uses = 5

/obj/item/nif_repair_kit/attack(mob/living/carbon/human/mob_to_repair, mob/living/user)
	. = ..()
	if(!mob_to_repair.installed_nif)
		to_chat(user, span_warning("[mob_to_repair] lacks a NIF"))

	if(!do_after(user, 5 SECONDS, mob_to_repair))
		return FALSE

	if(!mob_to_repair.installed_nif.repair_nif(repair_amount))
		to_chat(user, span_warning("The NIF you are trying to repair is already at max durbility"))
		return FALSE

	to_chat(user, span_notice("You successfully repair [mob_to_repair]'s NIF"))
	to_chat(mob_to_repair, span_notice("[user] successfully repairs your NIF"))

	--uses
	if(!uses)
		qdel(src)

