//==================================//
// !           Armaments          ! //
//==================================//
/datum/clockcult/scripture/clockwork_armaments
	name = "Clockwork Armaments"
	desc = "Summon clockwork armor and weapons, to be ready for battle."
	tip = "Summon clockwork armor and weapons, to be ready for battle."
	button_icon_state = "clockwork_armor"
	power_cost = 150
	invokation_time = 20
	invokation_text = list("Through courage and hope...", "we shall protect thee!")
	category = SPELLTYPE_PRESERVATION
	cogs_required = 0

/datum/clockcult/scripture/clockwork_armaments/invoke_success()
	var/mob/living/M = invoker
	var/weapon
	var/choice = input(M,"What weapon do you want to call upon?", "Clockwork Armaments") as anything in list("Brass Spear","Brass Battlehammer","Brass Sword", "Brass Bow")
	var/datum/antagonist/servant_of_ratvar/servant = is_servant_of_ratvar(M)
	var/static/datum/outfit/clockcult/armaments/H = new
	if(!servant)
		return FALSE
	//Equip mob with gamer gear
	switch(choice)
		if("Brass Spear")
			H.equip(M)
			weapon = /obj/item/twohanded/clockwork/brass_spear
		if("Brass Battlehammer")
			H.equip(M)
			weapon = /obj/item/twohanded/clockwork/brass_battlehammer
		if("Brass Sword")
			H.equip(M)
			weapon = /obj/item/twohanded/clockwork/brass_sword
		if("Brass Bow")
			H.equip(M)
			weapon = /obj/item/gun/ballistic/bow/clockwork
		
	var/weapon_to_spawn = new weapon(get_turf(M))
	M.put_in_inactive_hand(weapon_to_spawn)