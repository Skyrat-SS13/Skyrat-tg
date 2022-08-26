/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/humanoid/skyrat
	name = "rare bugged alien"
	icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/big_xenos.dmi'
	rotate_on_lying = FALSE
	base_pixel_x = -16 //All of the xeno sprites are 64x64, and we want them to be level with the tile they are on, much like oversized quirk users
	var/datum/action/small_sprite/skyrat_xeno/small_sprite
	var/datum/action/cooldown/alien/skyrat/sleepytime/rest_button //There's no resting on the hud for xenos, and I don't think players want to use the ic panel
	var/datum/action/cooldown/alien/skyrat/devolve/devolve_ability
	mob_size = MOB_SIZE_LARGE
	layer = LARGE_MOB_LAYER //above most mobs, but below speechbubbles
	plane = GAME_PLANE_UPPER_FOV_HIDDEN
	maptext_height = 64
	maptext_width = 64
	pressure_resistance = 200
	var/alt_inhands_file = 'modular_skyrat/modules/xenos_skyrat_redo/icons/big_xenos.dmi'
	var/next_evolution
	var/datum/action/cooldown/alien/skyrat/generic_evolve/evolve_ability
	var/has_evolved_recently = FALSE

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

/mob/living/carbon/alien/humanoid/skyrat/Destroy()
	QDEL_NULL(small_sprite)
	QDEL_NULL(rest_button)
	QDEL_NULL(devolve_ability)
	if(evolve_ability)
		QDEL_NULL(evolve_ability)
	return ..()

/datum/action/cooldown/alien/skyrat
	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'

/datum/action/small_sprite/skyrat_xeno
	small_icon = 'icons/obj/plushes.dmi'
	small_icon_state = "rouny"

/datum/action/cooldown/alien/skyrat/sleepytime //I don't think this has a mechanical advantage but they have cool resting sprites so...
	name = "Rest"
	desc = "Sometimes even murder aliens need to have a little lie down."
	button_icon_state = "sleepytime"

/datum/action/cooldown/alien/skyrat/sleepytime/Activate()
	var/mob/living/carbon/sleepytime_mob = owner
	if(isalien(owner))
		if(!sleepytime_mob.resting)
			sleepytime_mob.set_resting(new_resting = TRUE, silent = FALSE, instant = TRUE)
			return TRUE
		sleepytime_mob.set_resting(new_resting = FALSE, silent = FALSE, instant = FALSE)
		return TRUE
	else
		return FALSE //Somehow you failed standing up/lying down school, congrats

/datum/action/cooldown/alien/skyrat/generic_evolve
	name = "Evolve"
	desc = "Allows us to evolve to a higher caste of our type, if there is not one already."
	button_icon_state = "evolution"
	var/mob/living/carbon/alien/humanoid/skyrat/evolver = owner
	var/type_to_evolve_into

/datum/action/cooldown/alien/skyrat/generic_evolve/Activate()
	type_to_evolve_into = evolver.next_evolution
	if(evolver.has_evolved_recently)
		evolver.balloon_alert(evolver, "evolved too recently")
	if(!type_to_evolve_into)
		to_chat(evolver, span_bolddanger("Something is wrong... we can't evolve into anything? (This is broken report it on github)"))
		return FALSE
	if(!isturf(evolver.loc))
		return FALSE
	if(get_alien_type(type_to_evolve_into))
		evolver.balloon_alert(evolver, "too many of our evolution already")
		return FALSE
	var/obj/item/organ/internal/alien/hivenode/node = evolver.getorgan(/obj/item/organ/internal/alien/hivenode)
	if(!node || node.recent_queen_death)
		return FALSE
	var/new_beno = new type_to_evolve_into(evolver.loc)
	evolver.alien_evolve(new_beno)
	evolver.has_evolved_recently = TRUE
	addtimer(CALLBACK(src, .proc/allow_evolution_again), 5 MINUTES)
	return TRUE

/datum/action/cooldown/alien/skyrat/proc/allow_evolution_again()
	evolver.has_evolved_recently = FALSE
	evolver.balloon_alert(owner, "can evolve once again")

/datum/action/cooldown/alien/skyrat/devolve
	name = "Devolve"
	desc = "We can gather our energy and shed our current form, reverting back to a simple larva from which we can evolve down a different path."
	button_icon_state = "larba"

/datum/action/cooldown/alien/skyrat/devolve/Activate()
	var/mob/living/carbon/alien/reddit_user = owner
	if(!isalien(reddit_user))
		to_chat(reddit_user, span_bolddanger("Wait a minute... You're not an alien, why would you even think of that?! How did you even get to this point???"))
		return FALSE
	if(tgui_alert(reddit_user, "Do you REALLY want to devolve?", "Message", list("Yes", "No")) != "Yes")
		return FALSE
	var/new_larva = new /mob/living/carbon/alien/larva(reddit_user.loc)
	reddit_user.alien_evolve(new_larva)
	return TRUE

/datum/movespeed_modifier/alien_quick
	multiplicative_slowdown = -1

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
