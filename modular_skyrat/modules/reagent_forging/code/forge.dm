#define DEFAULT_TIMED 5 SECONDS
#define MASTER_TIMED 2 SECONDS

#define DEFAULT_HEATED 25 SECONDS
#define MASTER_HEATED 50 SECONDS

#define MAX_FORGE_TEMP 100
#define MIN_FORGE_TEMP 51 //the minimum temp to actually use it

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
	var/current_sinew = 0
	///the number of extra sheets an ore will produce, up to 3
	var/goliath_ore_improvement = 0
	///the fuel amount (in seconds) that the forge has (wood)
	var/forge_fuel_weak = 0
	///the fuel amount (in seconds) that the forge has (stronger than wood)
	var/forge_fuel_strong = 0
	///whether the forge is capable of allowing reagent forging of the forged item.
	//normal forges are false; to turn into true, use 3 (active) legion cores.
	var/reagent_forging = FALSE
	///counting how many cores used to turn forge into a reagent forging forge.
	var/current_core = 0
	//cooldown between each process for the forge
	COOLDOWN_DECLARE(forging_cooldown)
	///the variable that stops spamming
	var/in_use = FALSE
	///if it isn't on the station zlevel, it is primitive (different icon)
	var/primitive = FALSE

/obj/structure/reagent_forge/examine(mob/user)
	. = ..()
	. += span_notice("[src] has [goliath_ore_improvement]/3 goliath hides.")
	. += span_notice("[src] has [current_sinew]/10 watcher sinews.")
	. += span_notice("[src] has [current_core]/3 regenerative cores.")
	. += span_notice("[src] is currently [forge_temperature] degrees hot, going towards [target_temperature] degrees.")
	if(reagent_forging)
		. += span_notice("[src] has a red tinge, it is ready to imbue chemicals into reagent objects.")

/obj/structure/reagent_forge/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	if(is_mining_level(z))
		primitive = TRUE
		icon_state = "primitive_forge_empty"

/obj/structure/reagent_forge/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/**
 * Here we check both strong (coal) and weak (wood) fuel
 */
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

/**
 * Here we make the reagent forge reagent imbuing
 */
/obj/structure/reagent_forge/proc/create_reagent_forge()
	reagent_forging = TRUE
	balloon_alert_to_viewers("gurgles!")
	color = "#ff5151"
	name = "reagent forge"
	desc = "A structure built out of metal, with the intended purpose of heating up metal. It has the ability to imbue!"

/**
 * Here we give a fail message as well as set the in_use to false
 */
/obj/structure/reagent_forge/proc/fail_message(mob/living/fail_user, message)
	to_chat(fail_user, span_warning(message))
	in_use = FALSE

/**
 * Here we adjust our temp to the target temperature
 */
/obj/structure/reagent_forge/proc/check_temp()
	if(forge_temperature > target_temperature) //above temp needs to lower slowly
		if(sinew_lower_chance && prob(sinew_lower_chance))//chance to not lower the temp, up to 100 from 10 sinew
			return
		forge_temperature -= 5
		return
	else if(forge_temperature < target_temperature && (forge_fuel_weak || forge_fuel_strong)) //below temp with fuel needs to rise
		forge_temperature += 5

	if(forge_temperature > 0)
		if(primitive)
			icon_state = "primitive_forge_full"
		else
			icon_state = "forge_full"
		light_range = 3
	else if(forge_temperature <= 0)
		if(primitive)
			icon_state = "primitive_forge_empty"
		else
			icon_state = "forge_empty"
		light_range = 0

/**
 * Here we fix any weird in_use bugs
 */
/obj/structure/reagent_forge/proc/check_in_use()
	if(!in_use)
		return
	for(var/mob/living/living_mob in range(1,src))
		if(!living_mob)
			in_use = FALSE

/**
 * Here we spawn coal depending on a chance of using wood
 */
/obj/structure/reagent_forge/proc/spawn_coal()
	new /obj/item/stack/sheet/mineral/coal(get_turf(src))

/obj/structure/reagent_forge/process()
	if(!COOLDOWN_FINISHED(src, forging_cooldown)) //every 5 seconds to not be too intensive, also balanced around 5 seconds
		return
	COOLDOWN_START(src, forging_cooldown, 5 SECONDS)
	check_fuel()
	check_temp()
	check_in_use() //plenty of weird bugs, this should hopefully fix the in_use bugs

/obj/structure/reagent_forge/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/sheet/mineral/wood)) //used for weak fuel
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_fuel_weak >= 5 MINUTES) //cannot insert too much
			fail_message(user, "You only need one to two pieces of wood at a time! You have [forge_fuel_weak] seconds remaining!")
			return
		to_chat(user, span_warning("You start to throw [I] into [src]..."))
		if(!do_after(user, 3 SECONDS, target = src)) //need 3 seconds to fuel the forge
			fail_message(user, "You abandon fueling [src].")
			return
		var/obj/item/stack/sheet/stack_sheet = I
		if(!stack_sheet.use(1)) //you need to be able to use the item, so no glue.
			fail_message(user, "You abandon fueling [src].")
			return
		forge_fuel_weak += 5 MINUTES
		in_use = FALSE
		to_chat(user, span_notice("You successfully fuel [src]."))
		if(prob(45))
			to_chat(user, span_notice("[src]'s fuel lights interestingly..."))
			addtimer(CALLBACK(src, .proc/spawn_coal), 1 MINUTES)
		return

	if(istype(I, /obj/item/stack/sheet/mineral/coal)) //used for strong fuel
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_fuel_strong >= 5 MINUTES) //cannot insert too much
			fail_message(user, "You only need one piece of coal at a time! You have [forge_fuel_strong] seconds remaining!")
			return
		to_chat(user, span_warning("You start to throw [I] into [src]..."))
		if(!do_after(user, 3 SECONDS, target = src)) //need 3 seconds to fuel the forge
			fail_message(user, "You abandon fueling [src].")
			return
		var/obj/item/stack/sheet/stack_sheet = I
		if(!stack_sheet.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You abandon fueling [src].")
			return
		forge_fuel_strong += 10 MINUTES // have to make coal useful!
		in_use = FALSE
		to_chat(user, span_notice("You successfully fuel [src]."))
		return

	if(istype(I, /obj/item/forging/billow))
		var/obj/item/forging/forge_item = I
		if(in_use) //no spamming the billows
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(!forge_fuel_strong && !forge_fuel_weak) //if there isnt any fuel, no billow use
			fail_message(user, "You cannot use [forge_item] without some sort of fuel in [src]!")
			return
		if(forge_temperature >= MAX_FORGE_TEMP) //we don't want the "temp" to overflow or something somehow
			fail_message(user, "You do not need to use [forge_item] at this moment, [src] is already hot enough!")
			return
		to_chat(user, span_warning("You start to pump [forge_item] into [src]..."))
		if(!do_after(user, forge_item.work_time, target = src)) //wait 3 seconds to upgrade (6 for primitive)
			fail_message(user, "You abandon billowing [src].")
			return
		forge_temperature += 10
		in_use = FALSE
		to_chat(user, span_notice("You successfully increase the temperature inside [src]."))
		return

	if(istype(I, /obj/item/stack/sheet/sinew))
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(sinew_lower_chance >= 100) //max is 100
			fail_message(user, "You cannot insert any more of [I]!")
			return
		to_chat(user, span_warning("You start lining [src] with [I]..."))
		if(!do_after(user, 3 SECONDS, target = src)) //wait 3 seconds to upgrade
			fail_message(user, "You abandon lining [src] with [I].")
			return
		var/obj/item/stack/sheet/stack_sheet = I
		if(!stack_sheet.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You abandon lining [src] with [I].")
			return
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		sinew_lower_chance += 10
		current_sinew++
		in_use = FALSE
		to_chat(user, span_notice("You successfully line [src] with [I]."))
		return

	if(istype(I, /obj/item/organ/regenerative_core))
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(reagent_forging) //if its already able to reagent forge, why continue wasting?
			fail_message(user, "[src] is already upgraded.")
			return
		var/obj/item/organ/regenerative_core/used_core = I
		if(used_core.inert) //no inert cores allowed
			fail_message(user, "You cannot use an inert [used_core].")
			return
		to_chat(user, span_warning("You start to sacrifice [used_core] to [src]..."))
		if(!do_after(user, 3 SECONDS, target = src)) //wait 3 seconds to upgrade
			fail_message(user, "You abandon sacrificing [used_core] to [src].")
			return
		to_chat(user, span_notice("You successfully sacrifice [used_core] to [src]."))
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		qdel(I)
		current_core++
		in_use = FALSE
		if(current_core >= 3) //use three regenerative cores to get reagent forging capabilities on the forge
			create_reagent_forge()
		return

	if(istype(I, /obj/item/stack/sheet/animalhide/goliath_hide))
		var/obj/item/stack/sheet/animalhide/goliath_hide/goliath_hide = I
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(goliath_ore_improvement >= 3)
			fail_message(user, "You have applied the max amount of [goliath_hide]!")
			return
		to_chat(user, span_warning("You start to improve [src] with [goliath_hide]..."))
		if(!do_after(user, 6 SECONDS, target = src)) //wait 6 seconds to upgrade
			fail_message(user, "You abandon improving [src].")
			return
		if(!goliath_hide.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You cannot use [goliath_hide]!")
			return
		goliath_ore_improvement++
		in_use = FALSE
		to_chat(user, span_notice("You successfully upgrade [src] with [goliath_hide]."))
		return

	if(istype(I, /obj/item/stack/ore))
		var/obj/item/stack/ore/ore_stack = I
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_temperature < MIN_FORGE_TEMP)
			fail_message(user, "The temperature is not hot enough to start heating [ore_stack].")
			return
		if(!ore_stack.refined_type)
			fail_message(user, "It is impossible to smelt [ore_stack].")
			return
		to_chat(user, span_warning("You start to smelt [ore_stack]..."))
		if(!do_after(user, 3 SECONDS, target = src)) //wait 3 seconds to upgrade
			fail_message(user, "You abandon smelting [ore_stack].")
			return
		var/src_turf = get_turf(src)
		var/spawning_item = ore_stack.refined_type
		var/spawning_amount = max(1, (1 + goliath_ore_improvement) * ore_stack.amount)
		for(var/spawn_ore in 1 to spawning_amount)
			new spawning_item(src_turf)
		in_use = FALSE
		to_chat(user, span_notice("You successfully smelt [ore_stack]."))
		qdel(I)
		return

	if(istype(I, /obj/item/forging/tongs))
		var/obj/item/forging/forge_item = I
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_temperature < MIN_FORGE_TEMP)
			fail_message(user, "The temperature is not hot enough to start heating the metal.")
			return
		var/obj/item/forging/incomplete/search_incomplete = locate(/obj/item/forging/incomplete) in I.contents
		if(search_incomplete)
			to_chat(user, span_warning("You start to heat up [search_incomplete]..."))
			if(!do_after(user, forge_item.work_time, target = src)) //wait 3 seconds to heat (6 for primitive)
				fail_message(user, "You abandon heating up [search_incomplete].")
				return
			search_incomplete.heat_world_compare = world.time + 1 MINUTES
			in_use = FALSE
			to_chat(user, span_notice("You successfully heat up [search_incomplete]."))
			return
		var/obj/item/stack/rods/search_rods = locate(/obj/item/stack/rods) in I.contents
		if(search_rods)
			var/user_choice = input(user, "What would you like to work on?", "Forge Selection") as null|anything in list("Chain", "Sword", "Staff", "Spear", "Axe", "Hammer", "Plate")
			if(!user_choice)
				fail_message(user, "You decide against continuing to forge.")
				return
			if(!search_rods.use(1))
				fail_message(user, "You cannot use	[search_rods]!")
				return
			to_chat(user, span_warning("You start to heat up [search_rods]..."))
			if(!do_after(user, forge_item.work_time, target = src)) //wait 3 seconds to upgrade (6 for primitive)
				fail_message(user, "You abandon heating up [search_rods].")
				return
			var/obj/item/forging/incomplete/incomplete_item
			switch(user_choice)
				if("Chain")
					incomplete_item = new /obj/item/forging/incomplete/chain(get_turf(src))
				if("Sword")
					incomplete_item = new /obj/item/forging/incomplete/sword(get_turf(src))
				if("Staff")
					incomplete_item = new /obj/item/forging/incomplete/staff(get_turf(src))
				if("Spear")
					incomplete_item = new /obj/item/forging/incomplete/spear(get_turf(src))
				if("Axe")
					incomplete_item = new /obj/item/forging/incomplete/axe(get_turf(src))
				if("Hammer")
					incomplete_item = new /obj/item/forging/incomplete/hammer(get_turf(src))
				if("Plate")
					incomplete_item = new /obj/item/forging/incomplete/plate(get_turf(src))
			incomplete_item.heat_world_compare = world.time + 1 MINUTES
			in_use = FALSE
			to_chat(user, span_notice("You successfully heat up [search_rods], ready to forge a [user_choice]."))
			return
		in_use = FALSE
		return

	if(I.tool_behaviour == TOOL_WRENCH)
		new /obj/item/stack/sheet/iron/ten(get_turf(src))
		for(var/loopone in 1 to current_core)
			new /obj/item/organ/regenerative_core(get_turf(src))
		for(var/looptwo in 1 to current_sinew)
			new /obj/item/stack/sheet/sinew(get_turf(src))
		for(var/loopthree in 1 to goliath_ore_improvement)
			new /obj/item/stack/sheet/animalhide/goliath_hide(get_turf(src))
		qdel(src)

	if(I.GetComponent(/datum/component/reagent_weapon))
		var/obj/item/attacking_item = I
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(!reagent_forging)
			fail_message(user, "You must enchant [src] to allow reagent imbueing!")
			return
		var/datum/component/reagent_weapon/weapon_component = attacking_item.GetComponent(/datum/component/reagent_weapon)
		if(!weapon_component)
			fail_message(user, "[attacking_item] is unable to be imbued!")
			return
		if(length(weapon_component.imbued_reagent))
			fail_message(user, "[attacking_item] has already been imbued!")
			return
		if(!do_after(user, 10 SECONDS, target = src))
			fail_message(user, "You abandon imbueing [attacking_item]!")
			return
		for(var/datum/reagent/weapon_reagent in attacking_item.reagents.reagent_list)
			if(weapon_reagent.volume < 200)
				attacking_item.reagents.remove_all_type(weapon_reagent.type)
				continue
			weapon_component.imbued_reagent += weapon_reagent.type
			attacking_item.name = "[weapon_reagent.name] [attacking_item.name]"
		attacking_item.color = mix_color_from_reagents(attacking_item.reagents.reagent_list)
		to_chat(user, span_notice("You finish imbueing [attacking_item]..."))
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return

	if(I.GetComponent(/datum/component/reagent_clothing))
		var/obj/item/attacking_item = I
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(!reagent_forging)
			fail_message(user, "You must enchant [src] to allow reagent imbueing!")
			return
		var/datum/component/reagent_clothing/clothing_component = attacking_item.GetComponent(/datum/component/reagent_clothing)
		if(!clothing_component)
			fail_message(user, "[attacking_item] is unable to be imbued!")
			return
		if(length(clothing_component.imbued_reagent))
			fail_message(user, "[attacking_item] has already been imbued!")
			return
		if(!do_after(user, 10 SECONDS, target = src))
			fail_message(user, "You abandon imbueing [attacking_item]!")
			return
		for(var/datum/reagent/clothing_reagent in attacking_item.reagents.reagent_list)
			if(clothing_reagent.volume < 200)
				attacking_item.reagents.remove_all_type(clothing_reagent.type)
				continue
			clothing_component.imbued_reagent += clothing_reagent.type
			attacking_item.name = "[clothing_reagent.name] [attacking_item.name]"
		attacking_item.color = mix_color_from_reagents(attacking_item.reagents.reagent_list)
		to_chat(user, span_notice("You finish imbueing [attacking_item]..."))
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return

	if(istype(I, /obj/item/ceramic))
		var/obj/item/ceramic/ceramic_item = I
		if(forge_temperature < MIN_FORGE_TEMP)
			to_chat(user, span_warning("The temperature is not hot enough to start heating [ceramic_item]."))
			return
		if(!ceramic_item.forge_item)
			to_chat(user, span_warning("You feel that setting [ceramic_item] would not yield anything useful!"))
			return
		to_chat(user, span_notice("You start setting [ceramic_item]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("You stop setting [ceramic_item]!"))
			return
		to_chat(user, span_notice("You finish setting [ceramic_item]..."))
		var/obj/item/ceramic/spawned_ceramic = new ceramic_item.forge_item(get_turf(src))
		spawned_ceramic.color = ceramic_item.color
		qdel(ceramic_item)
		return

	if(istype(I, /obj/item/glassblowing/blowing_rod))
		var/obj/item/glassblowing/blowing_rod/blowing_item = I
		var/actioning_speed = HAS_TRAIT(user, TRAIT_GLASSBLOWING_MASTER) ? MASTER_TIMED : DEFAULT_TIMED
		var/actioning_amount = HAS_TRAIT(user, TRAIT_GLASSBLOWING_MASTER) ? MASTER_HEATED : DEFAULT_HEATED
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_temperature < MIN_FORGE_TEMP)
			fail_message(user, "The temperature is not hot enough to start heating [blowing_item].")
			return
		var/obj/item/glassblowing/molten_glass/find_glass = locate() in blowing_item.contents
		if(!find_glass)
			fail_message(user, "[blowing_item] does not have any glass to heat up.")
			return
		to_chat(user, span_notice("You begin heating up [blowing_item]."))
		if(!do_after(user, actioning_speed, target = src))
			fail_message(user, "[blowing_item] is interrupted in its heating process.")
			return
		find_glass.world_molten = world.time + actioning_amount
		to_chat(user, span_notice("You finish heating up [blowing_item]."))
		in_use = FALSE
		return

	if(istype(I, /obj/item/stack/sheet/glass))
		var/obj/item/stack/sheet/glass/glass_item = I
		var/actioning_speed = HAS_TRAIT(user, TRAIT_GLASSBLOWING_MASTER) ? MASTER_TIMED : DEFAULT_TIMED
		var/actioning_amount = HAS_TRAIT(user, TRAIT_GLASSBLOWING_MASTER) ? MASTER_HEATED : DEFAULT_HEATED
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_temperature < MIN_FORGE_TEMP)
			fail_message(user, "The temperature is not hot enough to start heating [glass_item].")
			return
		if(!glass_item.use(1))
			fail_message(user, "You need to be able to use [glass_item]!")
			return
		if(!do_after(user, actioning_speed, target = src))
			fail_message(user, "You stop heating up [glass_item]!")
			return
		in_use = FALSE
		var/obj/item/glassblowing/molten_glass/spawned_glass = new /obj/item/glassblowing/molten_glass(get_turf(src))
		spawned_glass.world_molten = world.time + actioning_amount
		return

	if(istype(I, /obj/item/glassblowing/metal_cup))
		var/obj/item/glassblowing/metal_cup/metal_item = I
		var/actioning_speed = HAS_TRAIT(user, TRAIT_GLASSBLOWING_MASTER) ? MASTER_TIMED : DEFAULT_TIMED
		var/actioning_amount = HAS_TRAIT(user, TRAIT_GLASSBLOWING_MASTER) ? MASTER_HEATED : DEFAULT_HEATED
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_temperature < MIN_FORGE_TEMP)
			fail_message(user, "The temperature is not hot enough to start heating [metal_item]!")
			return
		if(!metal_item.has_sand)
			fail_message(user, "There is no sand within [metal_item]!")
			return
		if(!do_after(user, actioning_speed, target = src))
			fail_message(user, "You stop heating up [metal_item]!")
			return
		in_use = FALSE
		metal_item.has_sand = FALSE
		metal_item.icon_state = "metal_cup_empty"
		var/obj/item/glassblowing/molten_glass/spawned_glass = new /obj/item/glassblowing/molten_glass(get_turf(src))
		spawned_glass.world_molten = world.time + actioning_amount
		return

	return ..()

/obj/structure/reagent_forge/ready
	current_core = 3
	reagent_forging = TRUE
	sinew_lower_chance = 100
	forge_temperature = 1000

#undef DEFAULT_TIMED
#undef MASTER_TIMED

#undef DEFAULT_HEATED
#undef MASTER_HEATED

#undef MAX_FORGE_TEMP
#undef MIN_FORGE_TEMP
