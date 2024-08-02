///NIFSoft Remover. This is mostly here so that security and antags have a way to remove NIFSofts from someome
/obj/item/nifsoft_remover
	name = "Lopland 'Wrangler' NIF-Cutter"
	desc = "A small device that lets the user remove NIFSofts from a NIF user"
	special_desc = "Given the relatively recent and sudden proliferation of NIFs, their use in crime both petty and organized has skyrocketed in recent years. \
	The existence of nanomachine-based real-time burst communication that cannot be effectively monitored or hacked into has given most PMCs cause enough for concern \
	to invent their own devices. This one is a 'Wrangler' model NIF-Cutter, used for crudely wiping programs directly off a user's Framework."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "nifsoft_remover"

	///Is a disk with the corresponding NIFSoft created when said NIFSoft is removed?
	var/create_disk = FALSE

/obj/item/nifsoft_remover/attack(mob/living/carbon/human/target_mob, mob/living/user)
	. = ..()
	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = target_mob.get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)

	if(!target_nif || !length(target_nif.loaded_nifsofts))
		balloon_alert(user, "[target_mob] has no NIFSofts!")
		return

	var/list/installed_nifsofts = target_nif.loaded_nifsofts
	var/datum/nifsoft/nifsoft_to_remove = tgui_input_list(user, "Chose a NIFSoft to remove.", "[src]", installed_nifsofts)

	if(!nifsoft_to_remove)
		return FALSE

	user.visible_message(span_warning("[user] starts to use [src] on [target_mob]"), span_notice("You start to use [src] on [target_mob]"))
	if(!do_after(user, 5 SECONDS, target_mob))
		balloon_alert(user, "removal cancelled!")
		return FALSE

	if(!target_nif.remove_nifsoft(nifsoft_to_remove))
		balloon_alert(user, "removal failed!")
		return FALSE

	to_chat(user, span_notice("You successfully remove [nifsoft_to_remove]."))
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
	special_desc = "The effects of capitalism and industry run deep, and they run within the Nanite Implant Framework industry as well. \
	Frameworks, complicated devices as they are, are normally locked at the firmware level to requiring specific 'approved' brands of repair paste or repair-docks. \
	This hacked-kit has been developed by the Altspace Coven as a freeware alternative, spread far and wide throughout extra-Solarian space for quality of life \
	for users located on the peripheries of society."
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

/obj/item/nif_hud_adapter
	name = "Scrying Lens Adapter"
	desc = "A kit that modifies select glasses to display HUDs for NIFs"
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit"

	/// Can this item be used multiple times? If not, it will delete itself after being used.
	var/multiple_uses = FALSE
	/// List containing all of the glasses that we want to work with this.
	var/static/list/glasses_whitelist = list(
		/obj/item/clothing/glasses/trickblindfold,
		/obj/item/clothing/glasses/monocle,
		/obj/item/clothing/glasses/fake_sunglasses,
		/obj/item/clothing/glasses/regular,
		/obj/item/clothing/glasses/eyepatch,
		/obj/item/clothing/glasses/osi,
		/obj/item/clothing/glasses/phantom,
		/obj/item/clothing/glasses/salesman, // Now's your chance.
		/obj/item/clothing/glasses/nice_goggles,
		/obj/item/clothing/glasses/thin,
		/obj/item/clothing/glasses/biker,
		/obj/item/clothing/glasses/sunglasses/gar,
		/obj/item/clothing/glasses/hypno,
		/obj/item/clothing/glasses/heat,
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/glasses/orange,
		/obj/item/clothing/glasses/red,
		/obj/item/clothing/glasses/psych,
	)

/obj/item/nif_hud_adapter/examine(mob/user)
	. = ..()
	var/list/compatible_glasses_names = list()
	for(var/obj/item/glasses_type as anything in glasses_whitelist)
		var/glasses_name = initial(glasses_type.name)
		if(!glasses_name)
			continue

		compatible_glasses_names += glasses_name

	if(length(compatible_glasses_names))
		. += span_cyan("\n This item will work on the following glasses: [english_list(compatible_glasses_names)].")

	return .

/obj/item/nif_hud_adapter/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	var/obj/item/clothing/glasses/target_glasses = interacting_with
	if(!istype(target_glasses) || !is_type_in_list(target_glasses, glasses_whitelist))
		balloon_alert(user, "incompatible!")
		return NONE

	if(HAS_TRAIT(target_glasses, TRAIT_NIFSOFT_HUD_GRANTER))
		balloon_alert(user, "already upgraded!")
		return ITEM_INTERACT_BLOCKING

	user.visible_message(span_notice("[user] upgrades [target_glasses] with [src]."), span_notice("You upgrade [target_glasses] to be NIF HUD compatible."))
	target_glasses.name = "\improper HUD-upgraded " + target_glasses.name
	target_glasses.AddElement(/datum/element/nifsoft_hud)
	playsound(target_glasses.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)

	if(!multiple_uses)
		qdel(src)
	return ITEM_INTERACT_SUCCESS

