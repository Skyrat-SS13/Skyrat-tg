//Bubbalegion
/mob/living/simple_animal/hostile/asteroid/hivelord/legion/ocean
	name = "bubbalegion"
	desc = "The strange disruptions of the water form the vague form of a humanoid, shambling about."
	icon = 'modular_skyrat/modules/liquids/icons/mob/ocean/ocean_monsters.dmi'
	icon_state = "bubbalegion"
	icon_living = "bubbalegion"
	icon_aggro = "bubbalegion"
	icon_dead = "bubbalegion"
	crusher_loot = /obj/item/crusher_trophy/legion_skull
	loot = list(/obj/item/organ/regenerative_core/legion)
	brood_type = /mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/ocean

/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/ocean/make_legion(mob/living/carbon/human/H)
	return new /mob/living/simple_animal/hostile/asteroid/hivelord/legion/ocean(H.loc)

// BubbaLegion skull
/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/ocean
	name = "bubbalegion"
	desc = "One of many."
	icon = 'modular_skyrat/modules/liquids/icons/mob/ocean/ocean_monsters.dmi'
	icon_state = "bubbalegion_head"
	icon_living = "bubbalegion_head"
	icon_aggro = "bubbalegion_head"
	icon_dead = "bubbalegion_head"
