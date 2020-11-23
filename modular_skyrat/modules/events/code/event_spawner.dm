/obj/character_event_spawner
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"

	var/list/species_whitelist
	var/list/ckey_whitelist
	var/used_outfit = /datum/outfit/centcom/ert/engineer
	var/job_name
	var/gets_loadout = TRUE
	var/access_override
	var/headset_override
	var/flavor_text = ""
	var/list/additional_equipment
	var/disappear_after_spawn

	var/used = FALSE

/obj/character_event_spawner/attack_ghost(mob/user)
	TrySpawn(user)	

/obj/character_event_spawner/proc/TrySpawn(mob/dead/observer/user)
	if(!user || !user.client)
		return
	if(used)
		return
	if(ckey_whitelist && !(user.ckey in ckey_whitelist))
		alert(user, "Sorry, This spawner is not for you!", "", "Ok")
		return
	var/action = alert(user, "WARNING: This spawner will use your currently selected character in prefs ([user.client.prefs.real_name])\nMake sure that the character is not used as a station crew, or would have a good reason to be this role.\nDo you wanna proceed?", "", "Yes", "No")
	if(action && action == "Yes")
		if(!user || !user.client)
			return
		if(species_whitelist && !(user.client.prefs.pref_species.id in species_whitelist))
			var/species_string = ""
			var/first = TRUE
			for(var/spec_key in species_whitelist)
				if(!first)
					species_string += ", "
				species_string += "[spec_key]"
				first = FALSE
			alert(user, "Sorry, This spawner is limited to those species: [species_string]. Please change your character.", "", "Ok")
			return
		SpawnPerson(user)

/obj/character_event_spawner/proc/SpawnPerson(mob/dead/observer/user, alias)
	if(!user || !user.client)
		return
	used = TRUE
	icon_state = "cryopod-open"
	//Spawn and copify prefs
	var/mob/living/carbon/human/H = new(src)
	user.client.prefs.copy_to(H)
	H.dna.update_dna_identity()

	if(alias)
		H.real_name = alias

	//Pre-job equips so Voxes dont die
	H.dna.species.before_equip_job(null, H)

	if(used_outfit && used_outfit != "Naked")
		H.equipOutfit(used_outfit)

	var/list/packed_items
	if(gets_loadout)
		packed_items = user.client.prefs.equip_preference_loadout(H, FALSE, null)

	if(packed_items)
		user.client.prefs.add_packed_items(H, packed_items)

	//Override access of the ID card here
	var/obj/item/card/id/ID
	if(length(access_override))
		var/obj/item/id_slot = H.get_item_by_slot(ITEM_SLOT_ID)
		if(!id_slot)
			var/obj/item/temp_id = new /obj/item/card/id()
			if(!H.equip_to_slot_if_possible(temp_id, ITEM_SLOT_ID, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
				qdel(temp_id)
			else
				id_slot = temp_id

		if(id_slot)
			ID = id_slot.GetID()
			if(ID)
				ID.access = access_override
	//Override name and job of the ID card here
	if(!ID)
		var/obj/item/id_slot = H.get_item_by_slot(ITEM_SLOT_ID)
		if(id_slot)
			ID = id_slot.GetID()
	if(ID)
		ID.registered_name = H.real_name
		ID.assignment = job_name
		ID.update_label()
	//Override headset key here

	H.regenerate_icons()
	//Give control
	if(user.mind)
		user.mind.transfer_to(H, TRUE)
	else
		H.ckey = user.ckey

	H.forceMove(get_turf(src))
	//Greet!
	to_chat(H, "You are the [job_name]")
	to_chat(H, "[flavor_text]")
