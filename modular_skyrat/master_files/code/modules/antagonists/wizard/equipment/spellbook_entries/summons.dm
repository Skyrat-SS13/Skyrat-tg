/datum/spellbook_entry/summon/curse_of_hats
	name = "Curse of Hats"
	desc = "Curses the station into wearing random hats! Budget cuts have made for the hats to be removable, but at least it'll get a reaction out of them."
	cost = 0

/datum/spellbook_entry/summon/curse_of_hats/Buy(mob/living/carbon/human/user, obj/item/spellbook/book)
	var/list/hats = subtypesof(/obj/item/clothing/head)
	for(var/mob/living/carbon/human/to_curse in GLOB.player_list)
		if(to_curse.stat == DEAD)
			continue
		var/turf/curse_turf = get_turf(to_curse)
		if(curse_turf && !is_station_level(curse_turf.z))
			continue
		if(to_curse.can_block_magic(MAGIC_RESISTANCE|MAGIC_RESISTANCE_HOLY|MAGIC_RESISTANCE_MIND))
			to_chat(to_curse, span_notice("You feel something light on your head for a moment, but then it lifts."))
			continue
		if(!user.canUnEquip(user.head))
			return
		user.dropItemToGround(user.head)
		var/obj/item/picked_hat = pick(hats)
		user.equip_to_slot_if_possible(new picked_hat(user), ITEM_SLOT_HEAD, TRUE, TRUE, TRUE)
	return ..()
