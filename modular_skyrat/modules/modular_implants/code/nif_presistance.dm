/// How much damage is done to the NIF if the user ends the round with it uninstalled?
#define LOSS_WITH_NIF_UNINSTALLED 25

///Saves the NIF data for everyone inside of the server.
/datum/controller/subsystem/persistence/proc/save_nifs()
	for(var/player in GLOB.joined_player_list)
		var/mob/living/carbon/human/ending_human = get_mob_by_ckey(player)
		if(!istype(ending_human) || !ending_human.mind?.original_character_slot_index)
			continue

		var/mob/living/carbon/human/original_human = ending_human.mind.original_character.resolve()

		if(!original_human)
			continue

		original_human.save_nif_data()

///Saves the NIF data for a individual user.
/mob/living/carbon/human/proc/save_nif_data()
	if(!ckey || !mind?.original_character_slot_index)
		return

	var/path = "data/player_saves/[ckey[1]]/[ckey]/nif.sav"
	var/savefile/save = new /savefile(path)
	var/obj/item/organ/internal/cyberimp/brain/nif/saved_nif
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = getorgan(/obj/item/organ/internal/cyberimp/brain/nif)

	if(HAS_TRAIT(src, GHOSTROLE_TRAIT)) //Nothing is lost from playing a ghost role
		return FALSE

	if(installed_nif)
		if(installed_nif.durability <= 0)
			installed_nif = FALSE

	if(!installed_nif || (installed_nif && !installed_nif.nif_persistence))
		if(READ_FILE(save["nif_path"], saved_nif) != FALSE) // If you have a NIF on file but leave the round without one installed, you only take a durability loss instead of losing the implant.
			var/stored_nif_durability = save["nif_durability"]

			if(stored_nif_durability == 0) //There is one round to repair the NIF after it breaks, otherwise it will be lost.
				WRITE_FILE(save["nif_path"], FALSE)
				WRITE_FILE(save["nif_examine_text"], FALSE)
				return

			stored_nif_durability = max(stored_nif_durability - LOSS_WITH_NIF_UNINSTALLED, 0)


			WRITE_FILE(save["nif_durability"], stored_nif_durability)
			return

		WRITE_FILE(save["nif_path"], FALSE)
		WRITE_FILE(save["nif_examine_text"], FALSE)
		return

	var/nif_path = installed_nif.type

	WRITE_FILE(save["nif_path"], nif_path)
	WRITE_FILE(save["nif_durability"], installed_nif.durability)
	WRITE_FILE(save["saved_nif_theme"], installed_nif.current_theme)
	WRITE_FILE(save["nif_is_calibrated"], installed_nif.is_calibrated)

	var/examine_text = ""

	var/datum/component/nif_examine/examine_component = GetComponent(/datum/component/nif_examine)
	if(examine_component && examine_component.nif_examine_text)
		examine_text = examine_component.nif_examine_text

	WRITE_FILE(save["nif_examine_text"], examine_text)


///Loads the NIF data for an individual user.
/mob/living/carbon/human/proc/load_nif_data()
	if(!ckey || !mind?.original_character_slot_index)
		return

	var/path = "data/player_saves/[ckey[1]]/[ckey]/nif.sav"
	var/savefile/save = new /savefile(path)

	if(HAS_TRAIT(src, GHOSTROLE_TRAIT))
		return FALSE

	var/nif_path
	READ_FILE(save["nif_path"], nif_path)

	if(!nif_path)
		return

	var/obj/item/organ/internal/cyberimp/brain/nif/new_nif = new nif_path
	new_nif.Insert(src)

	new_nif.durability = save["nif_durability"]
	new_nif.current_theme = save["saved_nif_theme"]
	new_nif.is_calibrated = save["nif_is_calibrated"]

	var/datum/component/nif_examine/examine_component = GetComponent(/datum/component/nif_examine)
	if(examine_component)
		examine_component.nif_examine_text = save["nif_examine_text"]

#undef LOSS_WITH_NIF_UNINSTALLED
