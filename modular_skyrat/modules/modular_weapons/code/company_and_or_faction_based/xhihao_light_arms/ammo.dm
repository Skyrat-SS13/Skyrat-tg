/*
*	.310 Strilka
*/

/obj/item/ammo_casing/strilka310/rubber
	name = ".310 Strilka rubber bullet casing"
	desc = "A .310 rubber bullet casing. Casing is a bit of a fib, there isn't one.\
	<br><br>\
	<i>RUBBER: Less than lethal ammo. Deals both stamina damage and regular damage.</i>"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/ammo.dmi'
	icon_state = "310-casing-rubber"

	projectile_type = /obj/projectile/bullet/strilka310/rubber
	harmful = FALSE

/obj/projectile/bullet/strilka310/rubber
	name = ".310 rubber bullet"
	damage = 15
	stamina = 55
	ricochets_max = 5
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.7
	shrapnel_type = null
	sharpness = NONE
	embed_data = null

/obj/item/ammo_casing/strilka310/ap
	name = ".310 Strilka armor-piercing bullet casing"
	desc = "A .310 armor-piercing bullet casing. Note, does not actually contain a casing.\
	<br><br>\
	<i>ARMOR-PIERCING: Improved armor-piercing capabilities, in return for less outright damage.</i>"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/ammo.dmi'
	icon_state = "310-casing-ap"

	projectile_type = /obj/projectile/bullet/strilka310/ap
	custom_materials = AMMO_MATS_AP
	advanced_print_req = TRUE

/obj/projectile/bullet/strilka310/ap
	name = ".310 armor-piercing bullet"
	damage = 50
	armour_penetration = 60
