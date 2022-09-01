/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/humanoid/skyrat
	name = "rare bugged alien"
	icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/big_xenos.dmi'
	rotate_on_lying = FALSE
	base_pixel_x = -16 //All of the xeno sprites are 64x64, and we want them to be level with the tile they are on, much like oversized quirk users
	/// Holds the ability for making an alien's sprite smaller to only themselves
	var/datum/action/small_sprite/skyrat_xeno/small_sprite
	/// Holds the ability for quick resting without using the ic panel, and without editing xeno huds
	var/datum/action/cooldown/alien/skyrat/sleepytime/rest_button
	/// Holds the ability for allowing a xeno to devolve back into a larve if they so choose
	var/datum/action/cooldown/alien/skyrat/devolve/devolve_ability
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles
	plane = GAME_PLANE_UPPER_FOV_HIDDEN
	maptext_height = 64
	maptext_width = 64
	pressure_resistance = 200
	/// What icon file update_held_items will look for when making inhands for xenos
	var/alt_inhands_file = 'modular_skyrat/modules/xenos_skyrat_redo/icons/big_xenos.dmi'
	/// Setting this will give a xeno generic_evolve set to evolve them into this type
	var/next_evolution
	/// Holds the ability for evolving into whatever type next_evolution is set to
	var/datum/action/cooldown/alien/skyrat/generic_evolve/evolve_ability
	/// Keeps track of if a xeno has evolved recently, if so then we prevent them from evolving until that time is up
	var/has_evolved_recently = FALSE
	/// How long xenos should be unable to evolve after recently evolving
	var/evolution_cooldown_time = 1.5 MINUTES
	/// Determines if a xeno is unable to use abilities
	var/unable_to_use_abilities = FALSE
	/// Pixel X shifting of the on fire overlay
	var/on_fire_pixel_x = 16
	/// Pixel Y shifting of the on fire overlay
	var/on_fire_pixel_y = 16


/mob/living/carbon/alien/humanoid/skyrat/Initialize(mapload)
	. = ..()
	small_sprite = new /datum/action/small_sprite/skyrat_xeno()
	small_sprite.Grant(src)

	rest_button = new /datum/action/cooldown/alien/skyrat/sleepytime()
	rest_button.Grant(src)

	devolve_ability = new /datum/action/cooldown/alien/skyrat/devolve()
	devolve_ability.Grant(src)

	if(next_evolution)
		evolve_ability = new /datum/action/cooldown/alien/skyrat/generic_evolve()
		evolve_ability.Grant(src)

	pixel_x = -16

	ADD_TRAIT(src, TRAIT_XENO_HEAL_AURA, TRAIT_XENO_INNATE)
	real_name = "alien [caste]"

/mob/living/carbon/alien/humanoid/skyrat/Destroy()
	QDEL_NULL(small_sprite)
	QDEL_NULL(rest_button)
	QDEL_NULL(devolve_ability)
	if(evolve_ability)
		QDEL_NULL(evolve_ability)
	return ..()

/// Called when a larva or xeno evolves, adds a configurable timer on evolving again to the xeno
/mob/living/carbon/alien/humanoid/skyrat/proc/has_just_evolved()
	if(has_evolved_recently)
		return
	has_evolved_recently = TRUE
	addtimer(CALLBACK(src, .proc/can_evolve_once_again), evolution_cooldown_time)

/// Allows xenos to evolve again if they are currently unable to
/mob/living/carbon/alien/humanoid/skyrat/proc/can_evolve_once_again()
	if(!has_evolved_recently)
		return
	has_evolved_recently = FALSE

/datum/action/cooldown/alien/skyrat
	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	/// Some xeno abilities block other abilities from being used, this allows them to get around that in cases where it is needed
	var/can_be_used_always = FALSE

/datum/action/cooldown/alien/skyrat/IsAvailable()
	. = ..()
	if(!isalien(owner))
		return FALSE
	var/mob/living/carbon/alien/humanoid/skyrat/owner_alien = owner
	if(!can_be_used_always)
		if(owner_alien.unable_to_use_abilities)
			return FALSE

/datum/action/small_sprite/skyrat_xeno
	small_icon = 'icons/obj/toys/plushes.dmi'
	small_icon_state = "rouny"

/datum/action/cooldown/alien/skyrat/sleepytime //I don't think this has a mechanical advantage but they have cool resting sprites so...
	name = "Rest"
	desc = "Sometimes even murder aliens need to have a little lie down."
	button_icon_state = "sleepytime"

/datum/action/cooldown/alien/skyrat/sleepytime/Activate()
	var/mob/living/carbon/sleepytime_mob = owner
	if(!isalien(owner))
		return FALSE
	if(!sleepytime_mob.resting)
		sleepytime_mob.set_resting(new_resting = TRUE, silent = FALSE, instant = TRUE)
		return TRUE
	sleepytime_mob.set_resting(new_resting = FALSE, silent = FALSE, instant = FALSE)
	return TRUE

/datum/action/cooldown/alien/skyrat/generic_evolve
	name = "Evolve"
	desc = "Allows us to evolve to a higher caste of our type, if there is not one already."
	button_icon_state = "evolution"
	/// What type this ability will turn the owner into upon completion
	var/type_to_evolve_into

/datum/action/cooldown/alien/skyrat/generic_evolve/Grant(mob/grant_to)
	. = ..()
	if(!isalien(owner))
		return
	var/mob/living/carbon/alien/target_alien = owner
	plasma_cost = target_alien.get_max_plasma() //This ability should always require that a xeno be at their max plasma capacity to use

/datum/action/cooldown/alien/skyrat/generic_evolve/Activate()
	var/mob/living/carbon/alien/humanoid/skyrat/evolver = owner

	if(!istype(evolver))
		to_chat(owner, span_warning("You aren't an alien, you can't evolve!"))
		return FALSE

	type_to_evolve_into = evolver.next_evolution
	if(!type_to_evolve_into)
		to_chat(evolver, span_bolddanger("Something is wrong... We can't evolve into anything? (This is broken report it on GitHub)"))
		CRASH("Couldn't find an evolution for [owner] ([owner.type]).")

	if(!isturf(evolver.loc))
		return FALSE

	if(get_alien_type(type_to_evolve_into))
		evolver.balloon_alert(evolver, "too many of our evolution already")
		return FALSE

	var/obj/item/organ/internal/alien/hivenode/node = evolver.getorgan(/obj/item/organ/internal/alien/hivenode)
	if(!node)
		to_chat(evolver, span_bolddanger("We can't sense our node's connection to the hive... We can't evolve!"))
		return FALSE

	if(node.recent_queen_death)
		to_chat(evolver, span_bolddanger("The death of our queen... We can't seem to gather the mental energy required to evolve..."))
		return FALSE

	if(evolver.has_evolved_recently)
		evolver.balloon_alert(evolver, "can evolve in [round(evolver.evolution_cooldown_time / 1 MINUTES, 0.01)] minutes")
		return FALSE

	var/new_beno = new type_to_evolve_into(evolver.loc)
	evolver.alien_evolve(new_beno)
	return TRUE

/datum/action/cooldown/alien/skyrat/devolve
	name = "Devolve"
	desc = "We can gather our energy and shed our current form, reverting back to a simple larva from which we can evolve down a different path."
	button_icon_state = "larba"

/datum/action/cooldown/alien/skyrat/devolve/Activate()
	var/mob/living/carbon/alien/devolve_target = owner
	if(!isalien(devolve_target))
		to_chat(devolve_target, span_bolddanger("Wait a minute... You're not an alien, why would you even think of that?! How did you even get to this point???"))
		return FALSE
	if(tgui_alert(devolve_target, "Do you REALLY want to devolve?", "Message", list("Yes", "No")) != "Yes")
		return FALSE
	var/new_larva = new /mob/living/carbon/alien/larva(devolve_target.loc)
	devolve_target.alien_evolve(new_larva)
	return TRUE

/datum/movespeed_modifier/alien_quick
	multiplicative_slowdown = -0.5

/datum/movespeed_modifier/alien_slow
	multiplicative_slowdown = 0.5

/datum/movespeed_modifier/alien_heavy
	multiplicative_slowdown = 1

/datum/movespeed_modifier/alien_big
	multiplicative_slowdown = 2

/mob/living/carbon/alien/humanoid/skyrat/update_held_items()
	..()
	remove_overlay(HANDS_LAYER)
	var/list/hands = list()

	var/obj/item/l_hand = get_item_for_held_index(1)
	if(l_hand)
		var/itm_state = l_hand.inhand_icon_state
		if(!itm_state)
			itm_state = l_hand.icon_state
		var/mutable_appearance/l_hand_item = mutable_appearance(alt_inhands_file, "[itm_state][caste]_l", -HANDS_LAYER)
		if(l_hand.blocks_emissive)
			l_hand_item.overlays += emissive_blocker(l_hand_item.icon, l_hand_item.icon_state, alpha = l_hand_item.alpha)
		hands += l_hand_item

	var/obj/item/r_hand = get_item_for_held_index(2)
	if(r_hand)
		var/itm_state = r_hand.inhand_icon_state
		if(!itm_state)
			itm_state = r_hand.icon_state
		var/mutable_appearance/r_hand_item = mutable_appearance(alt_inhands_file, "[itm_state][caste]_r", -HANDS_LAYER)
		if(r_hand.blocks_emissive)
			r_hand_item.overlays += emissive_blocker(r_hand_item.icon, r_hand_item.icon_state, alpha = r_hand_item.alpha)
		hands += r_hand_item

	overlays_standing[HANDS_LAYER] = hands
	apply_overlay(HANDS_LAYER)

/mob/living/carbon/proc/get_max_plasma()
	var/obj/item/organ/internal/alien/plasmavessel/vessel = getorgan(/obj/item/organ/internal/alien/plasmavessel)
	if(!vessel)
		return -1
	return vessel.max_plasma

/mob/living/carbon/alien/humanoid/skyrat/alien_evolve(mob/living/carbon/alien/new_xeno)
	var/mob/living/carbon/alien/humanoid/skyrat/new_xeno = new_xeno

	new_xeno.setDir(dir)
	new_xeno.has_just_evolved()
	if(mind)
		mind.name = new_xeno.real_name
		mind.transfer_to(new_xeno)
	qdel(src)

/mob/living/carbon/alien/humanoid/skyrat/update_fire_overlay(stacks, on_fire, last_icon_state, suffix = "")
	var/fire_icon = "generic_fire[suffix]"

	if(!GLOB.fire_appearances[fire_icon])
		var/mutable_appearance/xeno_fire_overlay = mutable_appearance('icons/mob/onfire.dmi', fire_icon, -FIRE_LAYER, appearance_flags = RESET_COLOR)
		xeno_fire_overlay.pixel_x = on_fire_pixel_x
		xeno_fire_overlay.pixel_y = on_fire_pixel_y
		GLOB.fire_appearances[fire_icon] = xeno_fire_overlay

	if((stacks > 0 && on_fire) || HAS_TRAIT(src, TRAIT_PERMANENTLY_ONFIRE))
		if(fire_icon == last_icon_state)
			return last_icon_state

		remove_overlay(FIRE_LAYER)
		overlays_standing[FIRE_LAYER] = GLOB.fire_appearances[fire_icon]
		apply_overlay(FIRE_LAYER)
		return fire_icon

	if(!last_icon_state)
		return last_icon_state

	remove_overlay(FIRE_LAYER)
	apply_overlay(FIRE_LAYER)
	return null
