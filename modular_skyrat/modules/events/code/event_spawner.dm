/obj/character_event_spawner
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod-open"

	var/list/species_whitelist
	var/list/ckey_whitelist
	var/used_outfit = /datum/outfit/centcom/ert/engineer
	var/job_name
	var/gets_loadout = TRUE
	var/access_override
	var/headset_override
	var/flavor_text = ""
	var/list/additional_equipment

	var/used = FALSE

/obj/character_event_spawner/attack_ghost(mob/user)
	TrySpawn(user)	

/obj/character_event_spawner/proc/TrySpawn(mob/dead/observer/user)
	if(used)
		return
	SpawnPerson(user)

/obj/character_event_spawner/proc/SpawnPerson(mob/dead/observer/user, alias)
	if(!user || !user.client)
		return
	used = TRUE
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
