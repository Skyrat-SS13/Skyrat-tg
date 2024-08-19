/obj/character_event_spawner
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"

	var/list/species_whitelist
	var/list/gender_whitelist
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
	if(ckey_whitelist && !(lowertext(user.ckey) in ckey_whitelist))
		alert(user, "Sorry, This spawner is not for you!", "", "Ok")
		return
	if(is_banned_from(user.ckey, BAN_GHOST_ROLE_SPAWNER))
		to_chat(user, "Error, you are banned from playing ghost roles!")
		return
	var/species_string
	if(species_whitelist)
		species_string = ""
		var/first = TRUE
		for(var/spec_key in species_whitelist)
			if(!first)
				species_string += ", "
			species_string += "[spec_key]"
			first = FALSE
	var/gender_string
	if(gender_whitelist)
		gender_string = ""
		var/first = TRUE
		for(var/spec_key in gender_whitelist)
			if(!first)
				gender_string += ", "
			gender_string += "[spec_key]"
			first = FALSE
	var/warning_string = "WARNING: This spawner will use your currently selected character in prefs ([user.client.prefs?.read_preference(/datum/preference/name/real_name)])\nMake sure that the character is not used as a station crew, or would have a good reason to be this role.\nDo you wanna proceed?"
	if(species_string)
		warning_string += "\nThis role is restricted to those species: [species_string]"
	if(gender_string)
		warning_string += "\nThis role is restricted to those genders: [gender_string]"
	var/action = tgui_alert(user, warning_string, "", list("Yes", "Yes with Alias", "No"))
	if(!action || action == "No")
		return
	var/alias
	if(action == "Yes with Alias")
		var/msg = reject_bad_name(input(usr, "Set your character's alias for this role", "Alias") as text|null)
		if(!msg)
			return
		alias = msg
	if(!user || !user.client)
		return
	if(species_whitelist && !(user.client.prefs?.read_preference(/datum/preference/choiced/species) in species_whitelist))
		alert(user, "Sorry, This spawner is limited to those species: [species_string]. Please switch your character.", "", "Ok")
		return
	if(gender_whitelist && !(user.client.prefs?.read_preference(/datum/preference/choiced/gender) in gender_whitelist))
		alert(user, "Sorry, This spawner is limited to those genders: [gender_string]. Please switch your character.", "", "Ok")
		return
	if(used)
		return
	SpawnPerson(user, alias)

/obj/character_event_spawner/proc/SpawnPerson(mob/dead/observer/user, alias)
	if(!user || !user.client)
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] spawned as a [job_name] by using a spawner.")
	used = TRUE
	icon_state = "cryopod-open"
	name = "opened cryogenic sleeper"
	//Spawn and copify prefs
	var/mob/living/carbon/human/H = new(src)
	user.client.prefs.safe_transfer_prefs_to(H)
	H.dna.update_dna_identity()

	if(alias)
		H.name = alias
		H.real_name = alias

	H.forceMove(get_turf(src))
	//Pre-job equips so Voxes dont die
	H.dna.species.pre_equip_species_outfit(null, H)

	if(used_outfit && used_outfit != "Naked")
		H.equipOutfit(used_outfit)

	//Override headset here
	if(headset_override)
		var/obj/item/headset_slot = H.get_item_by_slot(ITEM_SLOT_EARS)
		if(headset_slot)
			qdel(headset_slot)
		var/obj/item/new_headset = new headset_override()
		if(new_headset)
			if(!H.equip_to_slot_if_possible(new_headset, ITEM_SLOT_EARS, disable_warning = TRUE, bypass_equip_delay_self = TRUE))
				new_headset.forceMove(get_turf(H))

	var/obj/item/back_item
	if(H.back && H.back.atom_storage)
		back_item = H.back
	//Spawn our character a backpack if they dont have any
	if(!back_item)
		var/obj/item/new_bp = new /obj/item/storage/backpack()
		if(H.equip_to_appropriate_slot(new_bp))
			back_item = new_bp
		else
			new_bp.forceMove(get_turf(H))
	if(additional_equipment)
		for(var/eq_path in additional_equipment)
			var/obj/item/equipped = new eq_path()
			if(!H.equip_to_appropriate_slot(equipped))
				if(back_item)
					equipped.forceMove(back_item)
				else
					equipped.forceMove(get_turf(H))

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

	H.regenerate_icons()
	//Give control
	if(user.mind)
		user.mind.transfer_to(H, TRUE)
	else
		H.ckey = user.ckey

	//Greet!
	to_chat(H, span_big("You are the [job_name]"))
	to_chat(H, span_bold("[flavor_text]"))
	if(disappear_after_spawn)
		qdel(src)
