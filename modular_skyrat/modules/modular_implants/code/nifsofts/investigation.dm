/obj/item/disk/nifsoft_uploader/investigation
	name = "Investigation Helper"
	loaded_nifsoft = /datum/nifsoft/investigation

/datum/nifsoft/investigation
	name = "Investigation Auxilium" //Temporary name
	program_desc = "Grants the user of the NIFSoft a tool to properly investigate crimes like a true detective."
	active_mode = TRUE
	active_cost = 5
	activation_cost = 50
	purchase_price = 380 //Nice
	buying_category = NIFSOFT_CATEGORY_UTILITY
	/// The "investigation" tool summoned by the NIFSoft
	var/obj/item/investigation_item
	/// What is the path we want to use for the summoned item?
	var/summon_path = /obj/item/gun/ballistic/revolver/c38/investigation

/datum/nifsoft/investigation/activate()
	. = ..()
	if(. == FALSE)
		return FALSE

	if(!active && investigation_item)
		qdel(investigation_item)
		investigation_item = null
		return TRUE

	investigation_item = new summon_path
	investigation_item.alpha = 220
	investigation_item.set_light(2)
	investigation_item.add_atom_colour("#acccff",FIXED_COLOUR_PRIORITY)

	linked_mob.put_in_hands(investigation_item)
	return TRUE

/obj/item/gun/ballistic/revolver/c38/investigation
	name = "Investigation tool"
	spawnwithmagazine = FALSE // we don't want this to be too overpowered :)
