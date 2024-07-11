/mob/living/basic/mining/stillcap
	name = "stillcap"
	desc = "A strange, elusive creature that always seems to come out of nowhere."
	icon = 'modular_skyrat/modules/serenitystation/icons/newfauna_wide.dmi'
	icon_state = "stillcap_red"
	icon_living = "stillcap_red"
	base_icon_state = "stillcap_red"
	icon_dead = "stillcap_red_dead"
	pixel_x = -12
	base_pixel_x = -12
	mob_biotypes = MOB_ORGANIC|MOB_BEAST

	maxHealth = 180
	health = 180
	speed = 5
	obj_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_vis_effect = ATTACK_EFFECT_BITE
	melee_attack_cooldown = 1.2 SECONDS

	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	death_message = "collapses in a muted thud."
	pass_flags_self = PASSMOB

	attack_sound = 'sound/weapons/bite.ogg'
	move_force = MOVE_FORCE_WEAK
	move_resist = MOVE_FORCE_WEAK
	pull_force = MOVE_FORCE_WEAK
	ai_controller = /datum/ai_controller/basic_controller/stillcap


/mob/living/basic/mining/stillcap/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/can_hide/basic, list(/turf/open/misc/asteroid/forest/mushroom))
	AddElement(/datum/element/ai_flee_while_injured)
	AddElement(/datum/element/ai_retaliate)
	AddComponent(/datum/component/basic_mob_ability_telegraph)
	AddComponent(/datum/component/basic_mob_attack_telegraph, telegraph_duration = 0.6 SECONDS)


/mob/living/basic/mining/stillcap/red
	name = "red stillcap"
	desc = parent_type::desc + " This one appears to be red."
	icon_state = "stillcap_red"
	icon_living = "stillcap_red"
	base_icon_state = "stillcap_red"
	icon_dead = "stillcap_red_dead"


/mob/living/basic/mining/stillcap/blue
	name = "blue stillcap"
	desc = parent_type::desc + " This one appears to be blue."
	icon_state = "stillcap_blue"
	icon_living = "stillcap_blue"
	base_icon_state = "stillcap_blue"
	icon_dead = "stillcap_blue_dead"


/mob/living/basic/mining/stillcap/green
	name = "green stillcap"
	desc = parent_type::desc + " This one appears to be green."
	icon_state = "stillcap_green"
	icon_living = "stillcap_green"
	base_icon_state = "stillcap_green"
	icon_dead = "stillcap_green_dead"
