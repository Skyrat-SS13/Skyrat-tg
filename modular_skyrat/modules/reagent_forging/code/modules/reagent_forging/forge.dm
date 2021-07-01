/obj/structure/reagent_forge
	name = "forge"
	desc = "A structure built out of bricks, with the intended purpose of heating up metal."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "forge_empty"

	anchored = TRUE
	density = TRUE

	///the temperature of the forge
	//temperature reached by wood is not enough, requires billows. As long as fuel is in, temperature can be raised.
	var/forge_temperature = 0
	//what temperature the forge is trying to reach
	var/target_temperature = 0
	///the chance that the forges temperature will not lower; max of 100 sinew_lower_chance.
	//normal forges are 0; to increase value, use watcher sinew to increase by 10, to a max of 100.
	var/sinew_lower_chance = 0
	///the fuel amount (in seconds) that the forge has (wood)
	var/forge_fuel_weak = 0
	///the fuel amount (in seconds) that the forge has (stronger than wood)
	var/forge_fuel_strong = 0
	///whether the forge is capable of allowing reagent forging of the forged item.
	//normal forges are false; to turn into true, use 3 (active) legion cores.
	var/reagent_forging = FALSE
	//counting how many cores used to turn forge into a reagent forging forge.
	var/current_core = 0
	//the variable for the process checking to the world time
	var/world_check = 0
	//the variable that stops spamming
	var/in_use = FALSE

/obj/structure/reagent_forge/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/reagent_forge/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/reagent_forge/proc/check_fuel()
	if(forge_fuel_strong) //use strong fuel first
		forge_fuel_strong -= 5
		target_temperature = 100
		return
	if(forge_fuel_weak) //then weak fuel second
		forge_fuel_weak -=5
		target_temperature = 50
		return
	target_temperature = 0 //if no fuel, slowly go back down to zero

/obj/structure/reagent_forge/proc/check_temp()
	if(forge_temperature > target_temperature) //above temp needs to lower slowly
		if(sinew_lower_chance && prob(sinew_lower_chance))//chance to not lower the temp, up to 100 from 10 sinew
			return
		forge_temperature -= 5
		return
	else if(forge_temperature < target_temperature && (forge_fuel_weak || forge_fuel_strong)) //below temp with fuel needs to rise
		forge_temperature += 5

	if(forge_temperature > 0)
		icon_state = "forge_full"
		light_range = 3
	else if(forge_temperature <= 0)
		icon_state = "forge_empty"
		light_range = 0

/obj/structure/reagent_forge/process()
	if(world_check >= world.time) //to make it not too intensive, every 5 seconds
		return
	world_check += 5 SECONDS
	check_fuel()
	check_temp()

/obj/structure/reagent_forge/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/sheet/mineral/wood)) //used for weak fuel
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_fuel_weak >= 300) //cannot insert too much
			to_chat(user, span_warning("You only need one to two pieces of wood at a time! You have [forge_fuel_weak] seconds remaining!"))
			in_use = FALSE
			return
		to_chat(user, span_warning("You start to throw the fuel into the forge..."))
		if(!do_after(user, 3 SECONDS, target = src)) //need 3 seconds to fuel the forge
			to_chat(user, span_warning("You abandon fueling the forge."))
			in_use = FALSE
			return
		var/obj/item/stack/sheet/stackSheet = I
		if(!stackSheet.use(1)) //you need to be able to use the item, so no glue.
			to_chat(user, span_warning("You abandon fueling the forge."))
			in_use = FALSE
			return
		forge_fuel_weak += 300 //5 minutes
		in_use = FALSE
		to_chat(user, span_notice("You successfully fuel the forge."))
		return

	if(istype(I, /obj/item/stack/sheet/mineral/coal)) //used for strong fuel
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_fuel_strong >= 300) //cannot insert too much
			to_chat(user, span_warning("You only need one to two pieces of coal at a time! You have [forge_fuel_strong] seconds remaining!"))
			in_use = FALSE
			return
		to_chat(user, span_warning("You start to throw the fuel into the forge..."))
		if(!do_after(user, 3 SECONDS, target = src)) //need 3 seconds to fuel the forge
			to_chat(user, span_warning("You abandon fueling the forge."))
			in_use = FALSE
			return
		var/obj/item/stack/sheet/stackSheet = I
		if(!stackSheet.use(1)) //need to be able to use the item, so no glue
			to_chat(user, span_warning("You abandon fueling the forge."))
			in_use = FALSE
			return
		forge_fuel_strong += 300 //5 minutes
		in_use = FALSE
		to_chat(user, span_notice("You successfully fuel the forge."))
		return

	if(istype(I, /obj/item/forging/billow))
		if(in_use) //no spamming the billows
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(!forge_fuel_strong && !forge_fuel_weak) //if there isnt any fuel, no billow use
			to_chat(user, span_warning("You cannot use the billow without some sort of fuel in the forge!"))
			in_use = FALSE
			return
		if(forge_temperature >= 100) //we don't want the "temp" to overflow or something somehow
			to_chat(user, span_warning("You do not need to use a billow at this moment, the forge is already hot enough!"))
			in_use = FALSE
			return
		to_chat(user, span_warning("You start to pump the billow into the forge..."))
		if(!do_after(user, 3 SECONDS, target = src)) //3 seconds to increase the temperature
			to_chat(user, span_warning("You abandon billowing the forge."))
			in_use = FALSE
			return
		forge_temperature += 10
		in_use = FALSE
		to_chat(user, span_notice("You successfully increase the temperature inside the forge."))
		return

	if(istype(I, /obj/item/stack/sheet/sinew))
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(sinew_lower_chance >= 100) //max is 100
			to_chat(user, span_warning("You cannot insert any more sinew!"))
			in_use = FALSE
			return
		to_chat(user, span_warning("You start lining the forge with sinew..."))
		if(!do_after(user, 3 SECONDS, target = src)) //wait 3 seconds to upgrade
			to_chat(user, span_warning("You abandon lining the forge with sinew."))
			in_use = FALSE
			return
		var/obj/item/stack/sheet/stackSheet = I
		if(!stackSheet.use(1)) //need to be able to use the item, so no glue
			to_chat(user, span_warning("You abandon lining the forge with sinew."))
			in_use = FALSE
			return
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		sinew_lower_chance += 10
		in_use = FALSE
		to_chat(user, span_notice("You successfully line the forge with sinew."))
		return

	if(istype(I, /obj/item/organ/regenerative_core))
		if(reagent_forging) //if its already able to reagent forge, why continue wasting?
			to_chat(user, span_warning("This forge is already upgraded."))
			return
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		var/obj/item/organ/regenerative_core/usedCore = I
		if(usedCore.inert) //no inert cores allowed
			to_chat(user, span_warning("You cannot use an inert regenerative core."))
			in_use = FALSE
			return
		to_chat(user, span_warning("You start to sacrifice the regenerative core to the forge..."))
		if(!do_after(user, 3 SECONDS, target = src)) //wait 3 seconds to upgrade
			to_chat(user, span_warning("You abandon sacrificing the regenerative core to the forge."))
			in_use = FALSE
			return
		to_chat(user, span_notice("You successfully sacrifice the regenerative core to the forge."))
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		qdel(I)
		current_core++
		in_use = FALSE
		if(current_core >= 3) //use three regenerative cores to get reagent forging capabilities on the forge
			reagent_forging = TRUE
			to_chat(user, span_notice("You feel the forge has upgraded."))
			color = "#ff5151"
			name = "reagent forge"
			desc = "A structure built out of metal, with the intended purpose of heating up metal. It has the ability to imbue!"
		return

	if(istype(I, /obj/item/forging/tongs))
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_temperature <= 50)
			to_chat(user, span_warning("The temperature is not hot enough to start heating the metal."))
			in_use = FALSE
			return
		var/obj/item/forging/incomplete/searchIncomplete = locate(/obj/item/forging/incomplete) in I.contents
		if(searchIncomplete)
			to_chat(user, span_warning("You start to heat up the metal..."))
			if(!do_after(user, 3 SECONDS, target = src)) //wait 3 seconds to upgrade
				to_chat(user, span_warning("You abandon heating up the metal, breaking the metal."))
				in_use = FALSE
				return
			searchIncomplete.heat_world_compare = world.time + 1 MINUTES
			in_use = FALSE
			to_chat(user, span_notice("You successfully heat up the metal."))
			return
		var/obj/item/stack/rods/searchRods = locate(/obj/item/stack/rods) in I.contents
		if(searchRods)
			var/user_choice = input(user, "What would you like to work on?", "Forge Selection") as null|anything in list("Chain", "Sword", "Staff")
			if(!user_choice)
				to_chat(user, span_warning("You decide against continuing to forge."))
				in_use = FALSE
				return
			if(!searchRods.use(1))
				to_chat(user, span_warning("You cannot use the rods!"))
				in_use = FALSE
				return
			to_chat(user, span_warning("You start to heat up the metal..."))
			if(!do_after(user, 3 SECONDS, target = src)) //wait 3 seconds to upgrade
				to_chat(user, span_warning("You abandon heating up the metal, breaking the metal."))
				in_use = FALSE
				return
			var/obj/item/forging/incomplete/incompleteItem
			switch(user_choice)
				if("Chain")
					incompleteItem = new /obj/item/forging/incomplete/chain(get_turf(src))
				if("Sword")
					incompleteItem = new /obj/item/forging/incomplete/sword(get_turf(src))
				if("Staff")
					incompleteItem = new /obj/item/forging/incomplete/staff(get_turf(src))
			incompleteItem.heat_world_compare = world.time + 1 MINUTES
			in_use = FALSE
			to_chat(user, span_notice("You successfully heat up the metal, ready to forge a [user_choice]."))
			return

	if(I.tool_behaviour == TOOL_WRENCH)
		new /obj/item/stack/sheet/iron/ten(get_turf(src))
		qdel(src)

	if(istype(I, /obj/item/forging/reagent_weapon) && reagent_forging)
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		var/obj/item/forging/reagent_weapon/reagentWeapon = I
		if(reagentWeapon.imbued_reagent.len > 0)
			to_chat(user, span_warning("This weapon has already been imbued!"))
			in_use = FALSE
			return
		to_chat(user, span_warning("You start to imbue the weapon..."))
		if(!do_after(user, 10 SECONDS, target = src)) //wait 10 seconds to upgrade
			to_chat(user, span_warning("You abandon imbueing the weapon."))
			in_use = FALSE
			return
		for(var/datum/reagent/weaponReagent in reagentWeapon.reagents.reagent_list)
			if(weaponReagent.volume < 200)
				continue
			reagentWeapon.imbued_reagent += weaponReagent.type
			reagentWeapon.name = "[weaponReagent.name] [reagentWeapon.name]"
		reagentWeapon.color = mix_color_from_reagents(reagentWeapon.reagents.reagent_list)
		to_chat(user, span_notice("You finish imbueing the weapon..."))
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return

	if(istype(I, /obj/item/clothing/suit/armor/reagent_clothing) && reagent_forging)
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		var/obj/item/clothing/suit/armor/reagent_clothing/reagentClothing = I
		if(reagentClothing.imbued_reagent.len > 0)
			to_chat(user, span_warning("This clothing has already been imbued!"))
			in_use = FALSE
			return
		to_chat(user, span_warning("You start to imbue the clothing..."))
		if(!do_after(user, 10 SECONDS, target = src)) //wait 10 seconds to upgrade
			to_chat(user, span_warning("You abandon imbueing the clothing."))
			in_use = FALSE
			return
		for(var/datum/reagent/clothingReagent in reagentClothing.reagents.reagent_list)
			if(clothingReagent.volume < 200)
				continue
			reagentClothing.imbued_reagent += clothingReagent.type
			reagentClothing.name = "[clothingReagent.name] [reagentClothing.name]"
		reagentClothing.color = mix_color_from_reagents(reagentClothing.reagents.reagent_list)
		to_chat(user, span_notice("You finish imbueing the clothing..."))
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return

	if(istype(I, /obj/item/clothing/gloves/reagent_clothing) && reagent_forging)
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		var/obj/item/clothing/gloves/reagent_clothing/reagentClothing = I
		if(reagentClothing.imbued_reagent.len > 0)
			to_chat(user, span_warning("This clothing has already been imbued!"))
			in_use = FALSE
			return
		to_chat(user, span_warning("You start to imbue the clothing..."))
		if(!do_after(user, 10 SECONDS, target = src)) //wait 10 seconds to upgrade
			to_chat(user, span_warning("You abandon imbueing the clothing."))
			in_use = FALSE
			return
		for(var/datum/reagent/clothingReagent in reagentClothing.reagents.reagent_list)
			if(clothingReagent.volume < 200)
				continue
			reagentClothing.imbued_reagent += clothingReagent.type
			reagentClothing.name = "[clothingReagent.name] [reagentClothing.name]"
		reagentClothing.color = mix_color_from_reagents(reagentClothing.reagents.reagent_list)
		to_chat(user, span_notice("You finish imbueing the clothing..."))
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return

	return ..()

/obj/structure/reagent_forge/reagent_allow
	current_core = 3
	reagent_forging = TRUE
