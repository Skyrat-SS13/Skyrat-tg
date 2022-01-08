/obj/item/bodypart/head/necromorph
	name = BODY_ZONE_HEAD
	desc = "Didn't make sense not to live for fun, your brain gets smart but your head gets dumb."
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	icon_state = "slasher_head_m"
	max_damage = 250 //SKYRAT EDIT CHANGE: max_damage = 200
	body_zone = BODY_ZONE_HEAD
	body_part = HEAD
	w_class = WEIGHT_CLASS_BULKY //Quite a hefty load
	slowdown = 1 //Balancing measure
	throw_range = 2 //No head bowling
	px_x = 0
	px_y = -8
	stam_damage_coeff = 1
	max_stamina_damage = 100
	wound_resistance = 5
	disabled_wound_penalty = 25
	scars_covered_by_clothes = FALSE
	grind_results = null


/obj/item/bodypart/head/necromorph/ubermorph
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_head"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 500
	animal_origin = ALIEN_BODYPART


