/// This is the original NIF that other NIFs are based on.
/obj/item/organ/cyberimp/brain/nif
	name = "Nanite Implant Frameworkk"
	desc = "a brain implant that infuses the user with nanites" //Coder-lore. Change this later
	w_class = WEIGHT_CLASS_NORMAL
	actions_types = list(/datum/action/item_action/nif/open_menu)

	//NIF Variables

	//Hardware Variables
	///What user is currently linked with the NIF?
	var/mob/living/carbon/human/linked_mob
	///What access does the user have? This is used for role restricted NIFSofts.
	var/list/user_access_list
	///What is the maximum power level of the NIF?
	var/max_power = 1000
	///How much power is currently inside of the NIF?
	var/power_level
	///What level of durability is the NIF at?
	var/durability = 100
	///Does the NIF stay between rounds? By default, they do.
	var/nif_persistence

	//Software Variables
	///How many programs can the NIF store at once?
	var/max_nifsofts = 5
	///What types of programs are the NIF compatible with?
	var/list/program_compatibilty = list()
	///What programs are currently loaded onto the NIF?
	var/list/loaded_programs = list()
	///This shows up in the NIF settings screen, it servers as a way to ICly display lore.
	var/manufacturer_notes = "There is no data currently avalible for this product"

/obj/item/organ/cyberimp/brain/nif/Initialize(mapload)
	. = ..()
	power_level = max_power

/obj/item/organ/cyberimp/brain/nif/Insert(mob/living/carbon/insertee)
	. = ..()
	linked_mob = insertee
	loc = insertee // This needs to be done, otherwise TGUI will not pull up.

/obj/item/organ/cyberimp/brain/nif/Remove(mob/living/carbon/removee)
	. = ..()
	linked_mob = null //This is going to need to be changed later on.

// Action used to pull up the NIF menu
/datum/action/item_action/nif
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	icon_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/nif/open_menu
	name = "Open NIF Menu"
	button_icon_state = "weapon" // This is a placeholder

/datum/action/item_action/nif/open_menu/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return

	var/datum/action/item_action/nif/bridge = target
	bridge.ui_interact(usr)

/obj/item/autosurgeon/organ/nif
	starting_organ = /obj/item/organ/cyberimp/brain/nif
