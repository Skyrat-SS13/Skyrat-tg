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

/mob/living/carbon/alien/humanoid/skyrat/Initialize(mapload)
	. = ..()
	small_sprite = new /datum/action/small_sprite/skyrat_xeno()
	small_sprite.Grant(src)

	rest_button = new /datum/action/cooldown/alien/skyrat/sleepytime()
	rest_button.Grant(src)

	devolve_ability = new /datum/action/cooldown/alien/skyrat/devolve()
	devolve_ability.Grant(src)

	pixel_x = -16

	ADD_TRAIT(src, TRAIT_XENO_HEAL_AURA, TRAIT_XENO_INNATE)

/datum/action/cooldown/alien/skyrat
	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'

/datum/config_entry/keyed_list/multiplicative_movespeed //I couldn't find a better way to do this :(
	default = list(
	/mob/living/simple_animal = 1,
	/mob/living/silicon/pai = 1,
	/mob/living/carbon/alien/humanoid/hunter = -1,
	/mob/living/carbon/alien/humanoid/royal/praetorian = 1,
	/mob/living/carbon/alien/humanoid/royal/queen = 3,
	/mob/living/carbon/alien/humanoid/skyrat/runner = -1,
	/mob/living/carbon/alien/humanoid/skyrat/defender = 1,
	/mob/living/carbon/alien/humanoid/skyrat/sentinel = 0.5,
	/mob/living/carbon/alien/humanoid/skyrat/spitter = 1,
	)

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
		return FALSE

/datum/action/cooldown/alien/skyrat/devolve
	name = "Devolve"
	desc = "We can gather our energy and shed our current form, reverting back to a simple larva from which we can evolve down a different path."
	button_icon_state = "larba"

/datum/action/cooldown/alien/skyrat/devolve/Activate()
	var/mob/living/carbon/alien/reddit_user = owner
	if(!isalien(reddit_user))
		to_chat(reddit_user, span_danger("Wait a minute... You're not an alien, why would you even think of that?! How did you even get to this point???"))
		return FALSE
	if(tgui_alert(reddit_user, "Do you REALLY want to devolve?", "Message", list("Yes", "No")) != "Yes")
		return FALSE
	var/new_larva = new /mob/living/carbon/alien/larva(reddit_user.loc)
	reddit_user.alien_evolve(new_larva)
	return TRUE
