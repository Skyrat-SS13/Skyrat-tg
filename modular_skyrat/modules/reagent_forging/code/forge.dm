#define DEFAULT_TIMED 4 SECONDS

#define DEFAULT_HEATED 25 SECONDS

#define MAX_FORGE_TEMP 100
#define MIN_FORGE_TEMP 51 //the minimum temp to actually use it

#define FORGE_LEVEL_ZERO 0
#define FORGE_LEVEL_ONE 1
#define FORGE_LEVEL_TWO 2
#define FORGE_LEVEL_THREE 3

#define MAX_UPGRADE_SINEW 10
#define MAX_UPGRADE_GOLIATH 3
#define MAX_UPGRADE_REGEN 6

#define MIN_IMBUE_REQUIRED 100

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
	///how many sinews have been used
	var/current_sinew = 0
	///the number of extra sheets an ore will produce, up to 3
	var/goliath_ore_improvement = 0
	///the fuel amount (in seconds) that the forge has (wood)
	var/forge_fuel_weak = 0
	///the fuel amount (in seconds) that the forge has (stronger than wood)
	var/forge_fuel_strong = 0
	///whether the forge is capable of allowing reagent forging of the forged item.
	//normal forges are false; to turn into true, use 6 (active) legion cores.
	var/reagent_forging = FALSE
	///counting how many cores used to turn forge into a reagent forging forge.
	var/current_core = 0
	//cooldown between each process for the forge
	COOLDOWN_DECLARE(forging_cooldown)
	///the variable that stops spamming
	var/in_use = FALSE
	///if it isn't on the station zlevel, it is primitive (different icon)
	var/primitive = FALSE
	///the forge level, which will upgrade the forge (goliath/sinew/core upgrades)
	var/forge_level = FORGE_LEVEL_ZERO
	var/static/list/choice_list = list(
		"Chain" = /obj/item/forging/incomplete/chain,
		"Plate" = /obj/item/forging/incomplete/plate,
		"Sword" = /obj/item/forging/incomplete/sword,
		"Katana" = /obj/item/forging/incomplete/katana,
		"Dagger" = /obj/item/forging/incomplete/dagger,
		"Staff" = /obj/item/forging/incomplete/staff,
		"Spear" = /obj/item/forging/incomplete/spear,
		"Axe" = /obj/item/forging/incomplete/axe,
		"Hammer" = /obj/item/forging/incomplete/hammer,
		"Pickaxe" = /obj/item/forging/incomplete/pickaxe,
		"Shovel" = /obj/item/forging/incomplete/shovel,
		"Arrowhead" = /obj/item/forging/incomplete/arrowhead,
	)
	///radial button for acting as an oven on a food object
	var/static/radial_oven = image(icon = 'modular_skyrat/modules/reagent_forging/icons/hud/forge_radials.dmi', icon_state = "oven")
	///radial button for acting as a microwave on a food object
	var/static/radial_microwave = image(icon = 'modular_skyrat/modules/reagent_forging/icons/hud/forge_radials.dmi', icon_state = "microwave")

	///list containing cooking radial buttons, for when anything of /obj/item/food is used on the forge
	var/static/list/radial_options = list("oven" = radial_oven, "microwave" = radial_microwave)

/obj/structure/reagent_forge/examine(mob/user)
	. = ..()
	. += span_warning("<br>Perhaps using your hand on [src] when skilled will do something...<br>")
	. += span_notice("You could probably use [src] to <b>bake</b> or <b>cook</b> food...<br>")
	switch(forge_level)
		if(FORGE_LEVEL_ZERO)
			. += span_notice("[src] has not yet been touched by a smithy.<br>")
		if(FORGE_LEVEL_ONE)
			. += span_notice("[src] has been touched by an apprentice smithy.<br>")
		if(FORGE_LEVEL_TWO)
			. += span_notice("[src] has been touched by an expert smithy.<br>")
		if(FORGE_LEVEL_THREE)
			. += span_boldwarning("[src] has been touched by a master smithy; It is fully upgraded!<br>")
	if(forge_level < FORGE_LEVEL_THREE)
		. += span_notice("[src] has [goliath_ore_improvement]/[MAX_UPGRADE_GOLIATH] goliath hides.")
		. += span_notice("[src] has [current_sinew]/[MAX_UPGRADE_SINEW] watcher sinews.")
		. += span_notice("[src] has [current_core]/[MAX_UPGRADE_REGEN] regenerative cores.")
	. += span_notice("<br>[src] is currently [forge_temperature] degrees hot, going towards [target_temperature] degrees.<br>")
	if(reagent_forging)
		. += span_warning("[src] has a red tinge, it is ready to imbue chemicals into reagent objects.")

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
		forge_fuel_strong -= 5 SECONDS
		target_temperature = 100
		return
	if(forge_fuel_weak) //then weak fuel second
		forge_fuel_weak -= 5 SECONDS
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
	desc = "[initial(desc)]<br>It has the ability to imbue forged metals with chemicals!"

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
		icon_state = "[primitive ? "primitive_" : ""]forge_full"
		set_light(3, 1, LIGHT_COLOR_FIRE)
	else if(forge_temperature <= 0)
		icon_state = "[primitive ? "primitive_" : ""]forge_empty"
		set_light(0)

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
	var/obj/item/stack/sheet/mineral/coal/spawn_coal = new(get_turf(src))
	spawn_coal.name = "charcoal"

/obj/structure/reagent_forge/process()
	if(!COOLDOWN_FINISHED(src, forging_cooldown)) //every 5 seconds to not be too intensive, also balanced around 5 seconds
		return
	COOLDOWN_START(src, forging_cooldown, 5 SECONDS)
	check_fuel()
	check_temp()
	check_in_use() //plenty of weird bugs, this should hopefully fix the in_use bugs

/obj/structure/reagent_forge/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/user_smithing_skill = user.mind.get_skill_level(/datum/skill/smithing)
	var/previous_level = forge_level
	if(user_smithing_skill <= SKILL_LEVEL_NOVICE)
		to_chat(user, span_notice("[src] requires you to be more experienced!"))
		return
	if(user_smithing_skill >= SKILL_LEVEL_APPRENTICE)
		goliath_ore_improvement = MAX_UPGRADE_GOLIATH
		forge_level = FORGE_LEVEL_ONE
	if(user_smithing_skill >= SKILL_LEVEL_EXPERT)
		sinew_lower_chance = MAX_UPGRADE_SINEW * 10 //100, just written funny!
		current_sinew = MAX_UPGRADE_SINEW
		forge_level = FORGE_LEVEL_TWO
	if(user_smithing_skill >= SKILL_LEVEL_MASTER)
		current_core = MAX_UPGRADE_REGEN
		forge_level = FORGE_LEVEL_THREE
		create_reagent_forge()
	if(forge_level == previous_level)
		to_chat(user, span_notice("[src] was already upgraded by your level of expertise!"))
		return
	to_chat(user, span_notice("As you work with [src], you note the purity caused by heating metal with nothing but exposed flame. Examine to view what has improved!"))
	playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)

/obj/structure/reagent_forge/attackby(obj/item/attacking_item, mob/living/user, params)
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER)

	if(istype(attacking_item, /obj/item/stack/sheet/mineral/wood)) //used for weak fuel
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_fuel_weak >= 5 MINUTES) //cannot insert too much
			fail_message(user, "You only need one to two pieces of wood at a time! You have [forge_fuel_weak/10] seconds remaining!")
			return
		to_chat(user, span_warning("You start to throw [attacking_item] into [src]..."))
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail fueling [src].")
			return
		var/obj/item/stack/sheet/stack_sheet = attacking_item
		if(!stack_sheet.use(1)) //you need to be able to use the item, so no glue.
			fail_message(user, "You fail fueling [src].")
			return
		forge_fuel_weak += 5 MINUTES
		in_use = FALSE
		to_chat(user, span_notice("You successfully fuel [src]."))
		user.mind.adjust_experience(/datum/skill/smithing, 5) //useful fueling means you get some experience
		if(prob(45))
			to_chat(user, span_notice("[src]'s fuel is packed densely enough to have made some charcoal!"))
			addtimer(CALLBACK(src, .proc/spawn_coal), 1 MINUTES)
		return

	//why use coal over wood? the target temp is set to 100 under coal, while only 50 with wood
	//which means you have to use the billows with wood, but not with coal
	if(istype(attacking_item, /obj/item/stack/sheet/mineral/coal)) //used for strong fuel
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(forge_fuel_strong >= 5 MINUTES) //cannot insert too much
			fail_message(user, "You only need one piece of coal at a time! You have [forge_fuel_strong/10] seconds remaining!")
			return
		to_chat(user, span_warning("You start to throw [attacking_item] into [src]..."))
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail fueling [src].")
			return
		var/obj/item/stack/sheet/stack_sheet = attacking_item
		if(!stack_sheet.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You fail fueling [src].")
			return
		forge_fuel_strong += 5 MINUTES
		in_use = FALSE
		to_chat(user, span_notice("You successfully fuel [src]."))
		user.mind.adjust_experience(/datum/skill/smithing, 15) //useful fueling means you get some experience
		return

	if(istype(attacking_item, /obj/item/stack/sheet/sinew))
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(sinew_lower_chance >= (MAX_UPGRADE_SINEW * 10)) //max is 100
			fail_message(user, "You cannot insert any more of [attacking_item]!")
			return
		to_chat(user, span_warning("You start lining [src] with [attacking_item]..."))
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail lining [src] with [attacking_item].")
			return
		var/obj/item/stack/sheet/stack_sheet = attacking_item
		if(!stack_sheet.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You fail lining [src] with [attacking_item].")
			return
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		sinew_lower_chance += 10
		current_sinew++
		in_use = FALSE
		to_chat(user, span_notice("You successfully line [src] with [attacking_item]."))
		return

	if(istype(attacking_item, /obj/item/organ/regenerative_core))
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(reagent_forging) //if its already able to reagent forge, why continue wasting?
			fail_message(user, "[src] is already upgraded.")
			return
		var/obj/item/organ/regenerative_core/used_core = attacking_item
		if(used_core.inert) //no inert cores allowed
			fail_message(user, "You cannot use an inert [used_core].")
			return
		to_chat(user, span_warning("You start to sacrifice [used_core] to [src]..."))
		if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
			fail_message(user, "You fail sacrificing [used_core] to [src].")
			return
		to_chat(user, span_notice("You successfully sacrifice [used_core] to [src]."))
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		qdel(attacking_item)
		current_core++
		in_use = FALSE
		if(current_core >= MAX_UPGRADE_REGEN) //use six regenerative cores to get reagent forging capabilities on the forge
			create_reagent_forge()
		return

	if(istype(attacking_item, /obj/item/stack/sheet/animalhide/goliath_hide))
		var/obj/item/stack/sheet/animalhide/goliath_hide/goliath_hide = attacking_item
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(goliath_ore_improvement >= MAX_UPGRADE_GOLIATH)
			fail_message(user, "You have applied the max amount of [goliath_hide]!")
			return
		to_chat(user, span_warning("You start to improve [src] with [goliath_hide]..."))
		if(!do_after(user, skill_modifier * 6 SECONDS, target = src))
			fail_message(user, "You fail improving [src].")
			return
		if(!goliath_hide.use(1)) //need to be able to use the item, so no glue
			fail_message(user, "You cannot use [goliath_hide]!")
			return
		goliath_ore_improvement++
		in_use = FALSE
		to_chat(user, span_notice("You successfully upgrade [src] with [goliath_hide]."))
		return

	if(istype(attacking_item, /obj/item/stack/ore))
		smelt_ore(attacking_item, user)
		return

	if(attacking_item.GetComponent(/datum/component/reagent_weapon))
		var/obj/item/attacking_weapon = attacking_item
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(!reagent_forging)
			fail_message(user, "You must enchant [src] to allow reagent imbuing!")
			return
		var/datum/component/reagent_weapon/weapon_component = attacking_weapon.GetComponent(/datum/component/reagent_weapon)
		if(!weapon_component)
			fail_message(user, "[attacking_weapon] is unable to be imbued!")
			return
		if(length(weapon_component.imbued_reagent))
			fail_message(user, "[attacking_weapon] has already been imbued!")
			return
		if(!do_after(user, skill_modifier * 10 SECONDS, target = src))
			fail_message(user, "You fail imbuing [attacking_weapon]!")
			return
		for(var/datum/reagent/weapon_reagent in attacking_weapon.reagents.reagent_list)
			if(weapon_reagent.volume < MIN_IMBUE_REQUIRED)
				attacking_weapon.reagents.remove_all_type(weapon_reagent.type)
				continue
			weapon_component.imbued_reagent += weapon_reagent.type
			attacking_weapon.name = "[weapon_reagent.name] [attacking_weapon.name]"
		if(attacking_weapon.name == initial(attacking_weapon.name))
			fail_message(user, "You failed imbuing [attacking_weapon]...")
			return
		attacking_weapon.color = mix_color_from_reagents(attacking_weapon.reagents.reagent_list)
		to_chat(user, span_notice("You finish imbuing [attacking_weapon]..."))
		user.mind.adjust_experience(/datum/skill/smithing, 60) //successfully imbuing will grant great experience!
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return TRUE

	if(attacking_item.GetComponent(/datum/component/reagent_clothing))
		var/obj/item/attacking_clothing = attacking_item
		if(in_use) //only insert one at a time
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		in_use = TRUE
		if(!reagent_forging)
			fail_message(user, "You must enchant [src] to allow reagent imbuing!")
			return
		var/datum/component/reagent_clothing/clothing_component = attacking_clothing.GetComponent(/datum/component/reagent_clothing)
		if(!clothing_component)
			fail_message(user, "[attacking_clothing] is unable to be imbued!")
			return
		if(length(clothing_component.imbued_reagent))
			fail_message(user, "[attacking_clothing] has already been imbued!")
			return
		if(!do_after(user, skill_modifier * 10 SECONDS, target = src))
			fail_message(user, "You fail imbuing [attacking_clothing]!")
			return
		for(var/datum/reagent/clothing_reagent in attacking_clothing.reagents.reagent_list)
			if(clothing_reagent.volume < MIN_IMBUE_REQUIRED)
				attacking_clothing.reagents.remove_all_type(clothing_reagent.type)
				continue
			clothing_component.imbued_reagent += clothing_reagent.type
			attacking_clothing.name = "[clothing_reagent.name] [attacking_clothing.name]"
		if(attacking_clothing.name == initial(attacking_clothing.name))
			fail_message(user, "You failed imbuing [attacking_clothing]...")
			return
		attacking_clothing.color = mix_color_from_reagents(attacking_clothing.reagents.reagent_list)
		to_chat(user, span_notice("You finish imbuing [attacking_clothing]..."))
		user.mind.adjust_experience(/datum/skill/smithing, 60) //successfully imbuing will grant great experience!
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		in_use = FALSE
		return TRUE

	if(istype(attacking_item, /obj/item/ceramic))
		var/obj/item/ceramic/ceramic_item = attacking_item
		var/ceramic_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * DEFAULT_TIMED
		if(forge_temperature < MIN_FORGE_TEMP)
			to_chat(user, span_warning("The temperature is not hot enough to start heating [ceramic_item]."))
			return
		if(!ceramic_item.forge_item)
			to_chat(user, span_warning("You feel that setting [ceramic_item] would not yield anything useful!"))
			return
		to_chat(user, span_notice("You start setting [ceramic_item]..."))
		if(!do_after(user, ceramic_speed, target = src))
			to_chat(user, span_warning("You stop setting [ceramic_item]!"))
			return
		to_chat(user, span_notice("You finish setting [ceramic_item]..."))
		var/obj/item/ceramic/spawned_ceramic = new ceramic_item.forge_item(get_turf(src))
		user.mind.adjust_experience(/datum/skill/production, 50)
		spawned_ceramic.color = ceramic_item.color
		qdel(ceramic_item)
		return

	if(istype(attacking_item, /obj/item/stack/sheet/glass))
		var/obj/item/stack/sheet/glass/glass_item = attacking_item
		var/glassblowing_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * DEFAULT_TIMED
		var/glassblowing_amount = DEFAULT_HEATED / user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER)
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
		if(!do_after(user, glassblowing_speed, target = src))
			fail_message(user, "You stop heating up [glass_item]!")
			return
		in_use = FALSE
		var/obj/item/glassblowing/molten_glass/spawned_glass = new /obj/item/glassblowing/molten_glass(get_turf(src))
		user.mind.adjust_experience(/datum/skill/production, 10)
		COOLDOWN_START(spawned_glass, remaining_heat, glassblowing_amount)
		return

	if(istype(attacking_item, /obj/item/glassblowing/metal_cup))
		var/obj/item/glassblowing/metal_cup/metal_item = attacking_item
		var/glassblowing_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * DEFAULT_TIMED
		var/glassblowing_amount = DEFAULT_HEATED / user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER)
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
		if(!do_after(user, glassblowing_speed, target = src))
			fail_message(user, "You stop heating up [metal_item]!")
			return
		in_use = FALSE
		metal_item.has_sand = FALSE
		metal_item.icon_state = "metal_cup_empty"
		var/obj/item/glassblowing/molten_glass/spawned_glass = new /obj/item/glassblowing/molten_glass(get_turf(src))
		user.mind.adjust_experience(/datum/skill/production, 10)
		COOLDOWN_START(spawned_glass, remaining_heat, glassblowing_amount)
		return TRUE

	if(istype(attacking_item, /obj/item/food))
		var/obj/item/food/thing_to_cook = attacking_item

		if(in_use)
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return FALSE

		in_use = TRUE

		if(forge_temperature < MIN_FORGE_TEMP)
			fail_message(user, "The [src] is not hot enough to start cooking [thing_to_cook]!")
			return FALSE

		var/user_input = show_radial_menu(user, src, radial_options)
		var/obj/item_to_spawn

		if(!user_input)
			fail_message(user, "No choice made")
			return FALSE

		in_use = TRUE
		balloon_alert_to_viewers("cooking...")

		if(!do_after(user, 10 SECONDS, target = src))
			fail_message(user, "You stop trying to cook [thing_to_cook]!")
			in_use = FALSE
			return FALSE

		switch(user_input)
			if("oven")
				var/datum/component/bakeable/item_bakeable_component = thing_to_cook.GetComponent(/datum/component/bakeable)
				item_to_spawn = item_bakeable_component.bake_result ? item_bakeable_component.bake_result : /obj/item/food/badrecipe
			if("microwave")
				item_to_spawn = thing_to_cook.microwaved_type ? thing_to_cook.microwaved_type : /obj/item/food/badrecipe

		qdel(thing_to_cook)
		new item_to_spawn(get_turf(src))
		in_use = FALSE
		return TRUE

	return ..()

/obj/structure/reagent_forge/proc/smelt_ore(obj/item/stack/ore/ore_item, mob/living/user)
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER)
	if(in_use) //only insert one at a time
		to_chat(user, span_warning("You cannot do multiple things at the same time!"))
		return
	in_use = TRUE
	if(forge_temperature < MIN_FORGE_TEMP)
		fail_message(user, "The temperature is not hot enough to start heating [ore_item].")
		return
	if(!ore_item.refined_type)
		fail_message(user, "It is impossible to smelt [ore_item].")
		return
	to_chat(user, span_warning("You start to smelt [ore_item]..."))
	if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
		fail_message(user, "You fail smelting [ore_item].")
		return
	var/src_turf = get_turf(src)
	var/spawning_item = ore_item.refined_type
	var/spawning_amount = max(1, round((1 + goliath_ore_improvement) * ore_item.amount * (is_species(user, /datum/species/lizard/ashwalker) ? 1 : 0.5)))
	var/experience_amount = spawning_amount * ore_item.mine_experience
	for(var/spawn_ore in 1 to spawning_amount)
		new spawning_item(src_turf)
	in_use = FALSE
	to_chat(user, span_notice("You successfully smelt [ore_item]."))
	user.mind.adjust_experience(/datum/skill/smithing, experience_amount) //useful smelting means you get some experience
	user.mind.adjust_experience(/datum/skill/mining, experience_amount) //useful smelting means you get some experience
	qdel(ore_item)
	return FALSE

/obj/structure/reagent_forge/billow_act(mob/living/user, obj/item/tool)
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER)
	var/obj/item/forging/forge_item = tool
	if(in_use) //no spamming the billows
		to_chat(user, span_warning("You cannot do multiple things at the same time!"))
		return FALSE
	in_use = TRUE
	if(!forge_fuel_strong && !forge_fuel_weak) //if there isnt any fuel, no billow use
		fail_message(user, "You cannot use [forge_item] without some sort of fuel in [src]!")
		return FALSE
	if(forge_temperature >= MAX_FORGE_TEMP) //we don't want the "temp" to overflow or something somehow
		fail_message(user, "You can't heat [src] to be any hotter!")
		return FALSE
	to_chat(user, span_warning("You start to pump [forge_item] into [src]..."))
	while(forge_temperature < 91)
		if(!do_after(user, skill_modifier * forge_item.toolspeed, target = src))
			fail_message(user, "You fail billowing [src].")
			return FALSE
		forge_temperature += 10
		user.mind.adjust_experience(/datum/skill/smithing, 5) //useful heating means you get some experience
	in_use = FALSE
	to_chat(user, span_notice("You successfully increase the temperature inside [src]."))
	return FALSE

/obj/structure/reagent_forge/tong_act(mob/living/user, obj/item/tool)
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER)
	var/obj/item/forging/forge_item = tool
	if(in_use || forge_item.in_use) //only insert one at a time
		to_chat(user, span_warning("You cannot do multiple things at the same time!"))
		return FALSE
	in_use = TRUE
	forge_item.in_use = TRUE
	if(forge_temperature < MIN_FORGE_TEMP)
		fail_message(user, "The temperature is not hot enough to start heating the metal.")
		forge_item.in_use = FALSE
		return FALSE
	var/obj/item/forging/incomplete/search_incomplete = locate(/obj/item/forging/incomplete) in forge_item.contents
	if(search_incomplete)
		if(!COOLDOWN_FINISHED(search_incomplete, heating_remainder))
			fail_message(user, "[search_incomplete] is still hot, try to keep hammering!")
			forge_item.in_use = FALSE
			return FALSE
		to_chat(user, span_warning("You start to heat up [search_incomplete]..."))
		if(!do_after(user, skill_modifier * forge_item.toolspeed, target = src))
			fail_message(user, "You fail heating up [search_incomplete].")
			forge_item.in_use = FALSE
			return FALSE
		COOLDOWN_START(search_incomplete, heating_remainder, 1 MINUTES)
		in_use = FALSE
		forge_item.in_use = FALSE
		user.mind.adjust_experience(/datum/skill/smithing, 5) //heating up stuff gives just a little experience
		to_chat(user, span_notice("You successfully heat up [search_incomplete]."))
		return FALSE
	var/obj/item/stack/rods/search_rods = locate(/obj/item/stack/rods) in forge_item.contents
	if(search_rods)
		var/user_choice = tgui_input_list(user, "What would you like to work on?", "Forge Selection", choice_list)
		if(!user_choice)
			fail_message(user, "You decide against continuing to forge.")
			forge_item.in_use = FALSE
			return FALSE
		if(!search_rods.use(1))
			fail_message(user, "You cannot use [search_rods]!")
			forge_item.in_use = FALSE
			return FALSE
		to_chat(user, span_warning("You start to heat up [search_rods]..."))
		if(!do_after(user, skill_modifier * forge_item.toolspeed, target = src))
			fail_message(user, "You fail heating up [search_rods].")
			forge_item.in_use = FALSE
			return FALSE
		var/spawn_item = choice_list[user_choice]
		var/obj/item/forging/incomplete/incomplete_item = new spawn_item(get_turf(src))
		COOLDOWN_START(incomplete_item, heating_remainder, 1 MINUTES)
		in_use = FALSE
		forge_item.in_use = FALSE
		user.mind.adjust_experience(/datum/skill/smithing, 10) //creating an item gives you some experience, not a lot
		to_chat(user, span_notice("You successfully heat up [search_rods], ready to forge a [user_choice]."))
		search_rods = locate(/obj/item/stack/rods) in forge_item.contents
		if(!search_rods)
			forge_item.icon_state = "tong_empty"
		return FALSE
	in_use = FALSE
	forge_item.in_use = FALSE
	return FALSE

/obj/structure/reagent_forge/blowrod_act(mob/living/user, obj/item/tool)
	var/obj/item/glassblowing/blowing_rod/blowing_item = tool
	var/glassblowing_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * DEFAULT_TIMED
	var/glassblowing_amount = DEFAULT_HEATED / user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER)
	if(in_use) //only insert one at a time
		to_chat(user, span_warning("You cannot do multiple things at the same time!"))
		return FALSE
	in_use = TRUE
	if(forge_temperature < MIN_FORGE_TEMP)
		fail_message(user, "The temperature is not hot enough to start heating [blowing_item].")
		return FALSE
	var/obj/item/glassblowing/molten_glass/find_glass = locate() in blowing_item.contents
	if(!find_glass)
		fail_message(user, "[blowing_item] does not have any glass to heat up.")
		return FALSE
	if(!COOLDOWN_FINISHED(find_glass, remaining_heat))
		fail_message(user, "[find_glass] is still has remaining heat.")
		return FALSE
	to_chat(user, span_notice("You begin heating up [blowing_item]."))
	if(!do_after(user, glassblowing_speed, target = src))
		fail_message(user, "[blowing_item] is interrupted in its heating process.")
		return FALSE
	COOLDOWN_START(find_glass, remaining_heat, glassblowing_amount)
	to_chat(user, span_notice("You finish heating up [blowing_item]."))
	user.mind.adjust_experience(/datum/skill/smithing, 10) //creating an item gives you some experience, not a lot
	user.mind.adjust_experience(/datum/skill/production, 5)
	in_use = FALSE
	return FALSE

/obj/structure/reagent_forge/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	new /obj/item/stack/sheet/iron/ten(get_turf(src))
	qdel(src)
	return TRUE

/obj/structure/reagent_forge/ready
	current_core = MAX_UPGRADE_REGEN
	reagent_forging = TRUE
	sinew_lower_chance = 100
	forge_temperature = 1000

#undef DEFAULT_TIMED

#undef DEFAULT_HEATED

#undef MAX_FORGE_TEMP
#undef MIN_FORGE_TEMP

#undef FORGE_LEVEL_ZERO
#undef FORGE_LEVEL_ONE
#undef FORGE_LEVEL_TWO
#undef FORGE_LEVEL_THREE

#undef MAX_UPGRADE_SINEW
#undef MAX_UPGRADE_GOLIATH
#undef MAX_UPGRADE_REGEN

#undef MIN_IMBUE_REQUIRED
