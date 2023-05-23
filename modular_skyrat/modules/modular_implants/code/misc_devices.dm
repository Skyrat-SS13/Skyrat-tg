///NIFSoft Remover. This is mostly here so that security and antags have a way to remove NIFSofts from someome
/obj/item/nifsoft_remover
	name = "Lopland 'Wrangler' NIF-Cutter"
	desc = "A small device that lets the user remove NIFSofts from a NIF user"
	special_desc = "Given the relatively recent and sudden proliferation of NIFs, their use in crime both petty and organized has skyrocketed in recent years. The existence of nanomachine-based real-time burst communication that cannot be effectively monitored or hacked into has given most PMCs cause enough for concern to invent their own devices. This one is a 'Wrangler' model NIF-Cutter, used for crudely wiping programs directly off a user's Framework.."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "nifsoft_remover"

	///Is a disk with the corresponding NIFSoft created when said NIFSoft is removed?
	var/create_disk = FALSE

/obj/item/nifsoft_remover/attack(mob/living/carbon/human/target_mob, mob/living/user)
	. = ..()
	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = target_mob.get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)

	if(!target_nif || !length(target_nif.loaded_nifsofts))
		balloon_alert(user, "[target_mob] has no NIFSofts")
		return

	var/list/installed_nifsofts = target_nif.loaded_nifsofts
	var/datum/nifsoft/nifsoft_to_remove = tgui_input_list(user, "Chose a NIFSoft to remove.", "[src]", installed_nifsofts)

	if(!nifsoft_to_remove)
		return FALSE

	user.visible_message(span_warning("[user] starts to use [src] on [target_mob]"), span_notice("You start to use [src] on [target_mob]"))
	if(!do_after(user, 5 SECONDS, target_mob))
		balloon_alert(user, "removal cancelled")
		return FALSE

	if(!target_nif.remove_nifsoft(nifsoft_to_remove))
		balloon_alert(user, "removal failed")
		return FALSE

	to_chat(user, span_notice("You successfully remove [nifsoft_to_remove]"))
	user.log_message("removed [nifsoft_to_remove] from [target_mob]" ,LOG_GAME)

	if(create_disk)
		var/obj/item/disk/nifsoft_uploader/new_disk = new
		new_disk.loaded_nifsoft = nifsoft_to_remove.type
		new_disk.name = "[nifsoft_to_remove] datadisk"

		user.put_in_hands(new_disk)

	qdel(nifsoft_to_remove)

	return TRUE

/obj/item/nifsoft_remover/syndie
	name = "Cybersun 'Scalpel' NIF-Cutter"
	desc = "A modified version of a NIFSoft remover that allows the user to remove a NIFSoft and have a blank copy of the removed NIFSoft saved to a disk."
	special_desc = "In the upper echelons of the corporate world, Nanite Implant Frameworks are everywhere. Valuable targets will almost always be in constant NIF communication with at least one or two points of contact in the event of an emergency. To bypass this unfortunate conundrum, Cybersun Industries invented the 'Scalpel' NIF-Cutter. A device no larger than a PDA, this gift to the field of neurological theft is capable of extracting specific programs from a target in five seconds or less. On top of that, high-grade programming allows for the tool to copy the specific 'soft to a disk for the wielder's own use."
	icon_state = "nifsoft_remover_syndie"
	create_disk = TRUE

/datum/uplink_item/device_tools/nifsoft_remover
	name = "Cybersun 'Scalpel' NIF-Cutter"
	desc = "A modified version of a NIFSoft remover that allows the user to remove a NIFSoft and have a blank copy of the removed NIFSoft saved to a disk."
	item = /obj/item/nifsoft_remover/syndie
	cost = 3

///NIF Repair Kit.
/obj/item/nif_repair_kit
	name = "Cerulean NIF Regenerator"
	desc = "A repair kit that allows for NIFs to be repaired without the use of surgery"
	special_desc = "The effects of capitalism and industry run deep, and they run within the Nanite Implant Framework industry as well. Frameworks, complicated devices as they are, are normally locked at the firmware level to requiring specific 'approved' brands of repair paste or repair-docks. This hacked-kit has been developed by the Altspace Coven as a freeware alternative, spread far and wide throughout extra-Solarian space for quality of life for users located on the peripheries of society."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "repair_paste"
	w_class = WEIGHT_CLASS_SMALL
	///How much does this repair each time it is used?
	var/repair_amount = 20
	///How many times can this be used?
	var/uses = 5

/obj/item/nif_repair_kit/attack(mob/living/carbon/human/mob_to_repair, mob/living/user)
	. = ..()

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = mob_to_repair.get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)
	if(!installed_nif)
		balloon_alert(user, "[mob_to_repair] lacks a NIF")

	if(!do_after(user, 5 SECONDS, mob_to_repair))
		balloon_alert(user, "repair cancelled")
		return FALSE

	if(!installed_nif.adjust_durability(repair_amount))
		balloon_alert(user, "target NIF is at max duarbility")
		return FALSE

	to_chat(user, span_notice("You successfully repair [mob_to_repair]'s NIF"))
	to_chat(mob_to_repair, span_notice("[user] successfully repairs your NIF"))

	uses -= 1
	if(!uses)
		qdel(src)

