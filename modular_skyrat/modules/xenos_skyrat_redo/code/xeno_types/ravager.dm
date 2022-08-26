/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/humanoid/skyrat/ravager
	name = "alien ravager"
	caste = "ravager"
	maxHealth = 350
	health = 350
	icon_state = "alienravager"
	var/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager/triple_charge
	var/datum/action/cooldown/spell/aoe/repulse/xeno/slicing/tailsweep_slice
	var/datum/action/cooldown/alien/skyrat/literally_too_angry_to_die/you_cant_hurt_me_jack
	melee_damage_lower = 30
	melee_damage_upper = 35

/mob/living/carbon/alien/humanoid/skyrat/ravager/Initialize(mapload)
	. = ..()
	triple_charge = new /datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager()
	triple_charge.Grant(src)

	tailsweep_slice = new /datum/action/cooldown/spell/aoe/repulse/xeno/slicing()
	tailsweep_slice.Grant(src)

	you_cant_hurt_me_jack = new /datum/action/cooldown/alien/skyrat/literally_too_angry_to_die
	you_cant_hurt_me_jack.Grant(src)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/carbon/alien/humanoid/skyrat/ravager/Destroy()
	QDEL_NULL(triple_charge)
	QDEL_NULL(tailsweep_slice)
	QDEL_NULL(you_cant_hurt_me_jack)
	return ..()

/mob/living/carbon/alien/humanoid/skyrat/ravager/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel
	..()

/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager
	name = "Triple Charge Attack"
	desc = "Allows you to charge thrice at a location, trampling any in your path."
	cooldown_time = 30 SECONDS
	charge_delay = 0.3 SECONDS
	charge_distance = 7
	charge_past = 3
	destroy_objects = FALSE
	charge_damage = 50
	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "ravager_charge"
	unset_after_click = TRUE

/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager/do_charge_indicator(atom/charger, atom/charge_target)
	playsound(charger, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_roar2.ogg', 100, TRUE, 8, 0.9)

/datum/action/cooldown/mob_cooldown/charge/triple_charge/ravager/Activate(atom/target_atom)
	. = ..()
	return TRUE

/datum/action/cooldown/spell/aoe/repulse/xeno/slicing
	name = "Slicing Tail Sweep"
	desc = "Throw back attackers with a swipe of your tail, slicing them with it's sharpened tip."

	cooldown_time = 60 SECONDS

	aoe_radius = 2

	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "slice_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/ravager

	sound = 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_tail_swipe.ogg' //The defender's tail sound isn't changed because its big and heavy, this isn't

/datum/action/cooldown/spell/aoe/repulse/xeno/slicing/cast_on_thing_in_aoe(atom/movable/victim, atom/caster)
	if(isalien(victim))
		return
	var/turf/throwtarget = get_edge_target_turf(caster, get_dir(caster, get_step_away(victim, caster)))
	var/dist_from_caster = get_dist(victim, caster)

	if(dist_from_caster == 0)
		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(10 SECONDS)
			victim_living.apply_damage(40,BRUTE,BODY_ZONE_CHEST,wound_bonus=20,sharpness=SHARP_EDGED)
			shake_camera(victim, 4, 3)
			playsound(victim, 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg', 100, TRUE, 8, 0.9)
			to_chat(victim, span_userdanger("You're slammed into the floor by [caster]'s tail!"))
	else
		if(sparkle_path)
			new sparkle_path(get_turf(victim), get_dir(caster, victim))

		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(4 SECONDS)
			victim_living.apply_damage(40,BRUTE,BODY_ZONE_CHEST,wound_bonus=20,sharpness=SHARP_EDGED)
			shake_camera(victim, 4, 3)
			playsound(victim, 'modular_skyrat/master_files/sound/weapons/bloodyslice.ogg', 100, TRUE, 8, 0.9)
			to_chat(victim, span_userdanger("[caster]'s tail slashes you, throwing you back!"))

		victim.safe_throw_at(throwtarget, ((clamp((max_throw - (clamp(dist_from_caster - 2, 0, dist_from_caster))), 3, max_throw))), 1, caster, force = repulse_force)

/obj/effect/temp_visual/dir_setting/tailsweep/ravager
	icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	icon_state = "slice_tail_anim"

/datum/action/cooldown/alien/skyrat/literally_too_angry_to_die
	name = "Endure"
	desc = "Imbue your body with unimaginable amounts of rage (and plasma) to allow yourself to ignore all pain for a short time."
	button_icon_state = "literally_too_angry"
	plasma_cost = 250 //This requires full plasma to do, so there can be some time between armstrong moments
	var/endure_active = FALSE
	var/endure_duration = 20 SECONDS

/datum/action/cooldown/alien/skyrat/literally_too_angry_to_die/Activate()
	. = ..()
	if(endure_active)
		owner.balloon_alert(owner, "already enduring")
		return FALSE
	owner.balloon_alert(owner, "endure began")
	playsound(owner, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_roar1.ogg', 100, TRUE, 8, 0.9)
	to_chat(owner, span_danger("We numb our ability to feel pain, allowing us to fight until the very last for the next [endure_duration/10] seconds."))
	addtimer(CALLBACK(src, .proc/endure_deactivate), endure_duration)
	owner.add_filter("ravager_endure_outline", 4, outline_filter(1, COLOR_RED_LIGHT))
	ADD_TRAIT(owner, TRAIT_STUNIMMUNE, TRAIT_XENO_ABILITY_GIVEN)
	ADD_TRAIT(owner, TRAIT_NOSOFTCRIT, TRAIT_XENO_ABILITY_GIVEN)
	ADD_TRAIT(owner, TRAIT_NOHARDCRIT, TRAIT_XENO_ABILITY_GIVEN)
	endure_active = TRUE
	return TRUE

/datum/action/cooldown/alien/skyrat/literally_too_angry_to_die/proc/endure_deactivate()
	endure_active = FALSE
	owner.balloon_alert(owner, "endure ended")
	owner.remove_filter("ravager_endure_outline")
	REMOVE_TRAIT(owner, TRAIT_STUNIMMUNE, TRAIT_XENO_ABILITY_GIVEN)
	REMOVE_TRAIT(owner, TRAIT_NOSOFTCRIT, TRAIT_XENO_ABILITY_GIVEN)
	REMOVE_TRAIT(owner, TRAIT_NOHARDCRIT, TRAIT_XENO_ABILITY_GIVEN)
