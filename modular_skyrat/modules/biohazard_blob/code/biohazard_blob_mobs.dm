/mob/living/simple_animal/hostile/biohazard_blob
	gold_core_spawnable = HOSTILE_SPAWN
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	see_in_dark = 4
	mob_biotypes = MOB_ORGANIC
	gold_core_spawnable = NO_SPAWN
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_mobs.dmi'
	vision_range = 5
	aggro_vision_range = 8
	move_to_delay = 6


/mob/living/simple_animal/hostile/biohazard_blob/oil_shambler
	name = "oil shambler"
	desc = "Humanoid figure covered in oil, or maybe they're just oil? They seem to be perpetually on fire."
	icon_state = "oil_shambler"
	icon_living = "oil_shambler"
	icon_dead = "oil_shambler"
	speak_emote = list("blorbles")
	emote_hear = list("blorbles")
	speak_chance = 5
	turns_per_move = 4
	maxHealth = 150
	health = 150
	obj_damage = 40
	melee_damage_lower = 10
	melee_damage_upper = 15
	faction = list(MOLD_FACTION)
	attack_sound = 'sound/effects/attackblob.ogg'
	melee_damage_type = BURN
	del_on_death = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_FIRE
	damage_coeff = list(BRUTE = 1, BURN = 0, TOX = 0, CLONE = 1, STAMINA = 0, OXY = 0)
	maxbodytemp = INFINITY
	gender = MALE

/mob/living/simple_animal/hostile/biohazard_blob/oil_shambler/Initialize()
	. = ..()
	update_overlays()

/mob/living/simple_animal/hostile/biohazard_blob/oil_shambler/Destroy()
	visible_message("<span class='warning'>The [src] ruptures!</span>")
	var/datum/reagents/R = new/datum/reagents(300)
	R.my_atom = src
	R.add_reagent(/datum/reagent/napalm, 50)
	chem_splash(loc, 5, list(R))
	playsound(src, 'sound/effects/splat.ogg', 50, TRUE)
	return ..()

/mob/living/simple_animal/hostile/biohazard_blob/oil_shambler/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, icon, "oil_shambler_overlay", layer, plane, dir, alpha)
	SSvis_overlays.add_vis_overlay(src, icon, "oil_shambler_overlay", 0, EMISSIVE_PLANE, dir, alpha)

/mob/living/simple_animal/hostile/biohazard_blob/oil_shambler/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		if(prob(20))
			L.fire_stacks += 2
		if(L.fire_stacks)
			L.IgniteMob()

/mob/living/simple_animal/hostile/biohazard_blob/diseased_rat
	name = "diseased rat"
	desc = "An incredibly large, rabid looking rat. There's shrooms growing out of it"
	icon_state = "diseased_rat"
	icon_living = "diseased_rat"
	icon_dead = "diseased_rat_dead"
	speak_emote = list("chitters")
	emote_hear = list("chitters")
	speak_chance = 5
	turns_per_move = 4
	maxHealth = 70
	health = 70
	obj_damage = 30
	melee_damage_lower = 7
	melee_damage_upper = 13
	faction = list(MOLD_FACTION)
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	pass_flags = PASSTABLE
	butcher_results = list(/obj/item/food/meat/slab = 1)
	attack_sound = 'sound/weapons/bite.ogg'
	melee_damage_type = BRUTE

/mob/living/simple_animal/hostile/biohazard_blob/electric_mosquito
	name = "electric mosquito"
	desc = "An ovesized mosquito, with what it seems like electricity inside its body."
	icon_state = "electric_mosquito"
	icon_living = "electric_mosquito"
	icon_dead = "electric_mosquito_dead"
	speak_emote = list("buzzes")
	emote_hear = list("buzzes")
	speak_chance = 5
	turns_per_move = 4
	maxHealth = 70
	health = 70
	obj_damage = 20
	melee_damage_lower = 5
	melee_damage_upper = 6
	faction = list(MOLD_FACTION)
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	attack_sound = 'sound/effects/attackblob.ogg'
	melee_damage_type = BRUTE
	pass_flags = PASSTABLE

/mob/living/simple_animal/hostile/biohazard_blob/electric_mosquito/AttackingTarget()
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		C.reagents.add_reagent(/datum/reagent/teslium, 2)
