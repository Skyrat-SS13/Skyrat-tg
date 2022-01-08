/**
Divet pistol typedef & logic
*/
#define DIVET_DAMAGE	17.5
#define DIVET_DELAY	1
/obj/item/weapon/gun/projectile/divet
	name = "divet pistol"
	desc = "A Winchester Arms NK-series pistol capable of fully automatic fire."
	icon_state = "divet"
	item_state = "divet"
	magazine_type = /obj/item/ammo_magazine/divet
	allowed_magazines = /obj/item/ammo_magazine/divet
	caliber = "slug"
	accuracy = 10
	fire_delay = 5.5
	burst_delay = 1
	w_class = ITEM_SIZE_SMALL
	handle_casings = CLEAR_CASINGS
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	load_method = MAGAZINE

	mag_insert_sound = 'sound/weapons/guns/interaction/divet_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/divet_magout.ogg'


	firemodes = list(
		FULL_AUTO_300,
		list(mode_name="3-round bursts", burst=3, fire_delay=3, move_delay=4, one_hand_penalty=0, burst_accuracy=list(0,-2,-4), dispersion=list(0.0, 0.6, 1.0)),

		)

/obj/item/weapon/gun/projectile/divet/update_icon()
	..()
	if(ammo_magazine && ammo_magazine.stored_ammo.len)
		icon_state = "divet"
	else
		icon_state = "divet_e"

/obj/item/weapon/gun/projectile/divet/empty
	magazine_type = null

/obj/item/weapon/gun/projectile/divet/silenced
	name = "special ops divet pistol"
	desc = "A modified version of the Winchester Arms NK-series pistol. An integrated suppressor lowers the audio profile, although this has a detrimental effect on power."
	icon_state = "divet_spec"
	item_state = "divet_spec"
	silenced = TRUE
	damage_factor = 0.85	//Silencers reduce bullet speed, and hence damage output

/obj/item/weapon/gun/projectile/divet/silenced/update_icon()
	..()
	if(ammo_magazine && ammo_magazine.stored_ammo.len)
		icon_state = "divet_spec"
	else
		icon_state = "divet_spec_e"


/**
Magazine type definitions
*/

/obj/item/ammo_magazine/divet
	name = "magazine (pistol slug)"
	icon_state = "45ds"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/ls_slug
	matter = list(MATERIAL_STEEL = 525) //metal costs are very roughly based around 1 .45 casing = 75 metal
	caliber = "slug"
	max_ammo = 10
	multiple_sprites = 1

/obj/item/ammo_magazine/divet/hollow_point
	name = "divet magazine (hollow point)"
	icon_state = "hpds"
	ammo_type = /obj/item/ammo_casing/ls_slug/hollow_point

/obj/item/ammo_magazine/divet/ap
	name = "divet magazine (AP)"
	icon_state = "apds"
	ammo_type = /obj/item/ammo_casing/ls_slug/ap

/obj/item/ammo_magazine/divet/incendiary
	name = "divet magazine (incendiary)"
	icon_state = "icds"
	ammo_type = /obj/item/ammo_casing/ls_slug/incendiary


/**
Ammo casings for the mags
*/

/obj/item/ammo_casing/ls_slug
	desc = "A .45 bullet casing."
	caliber = "slug"
	projectile_type = /obj/item/projectile/bullet/ls_slug

/obj/item/ammo_casing/ls_slug/hollow_point
	projectile_type = /obj/item/projectile/bullet/ls_slug/hollow_point

/obj/item/ammo_casing/ls_slug/ap
	projectile_type = /obj/item/projectile/bullet/ls_slug/ap

/obj/item/ammo_casing/ls_slug/incendiary
	projectile_type = /obj/item/projectile/bullet/ls_slug/incendiary

/**
Projectile logic
*/

/obj/item/projectile/bullet/ls_slug
	damage = DIVET_DAMAGE
	expiry_method = EXPIRY_FADEOUT
	muzzle_type = /obj/effect/projectile/pulse/muzzle/light
	fire_sound='sound/weapons/guns/fire/divet_fire.ogg'
	armor_penetration = 7.5
	structure_damage_factor = 1.5
	penetration_modifier = 1.1
	icon_state = "divet"

//More damage and shrapnel, less AP, structure damage and penetration
/obj/item/projectile/bullet/ls_slug/hollow_point
	damage = DIVET_DAMAGE *	1.15
	step_delay = DIVET_DELAY * 1.25
	structure_damage_factor = 0.5
	penetration_modifier = 0
	embed = TRUE
	armor_penetration = 0
	icon_state = "divet_hp"

//Opposite of hollowpoint
/obj/item/projectile/bullet/ls_slug/ap
	damage = DIVET_DAMAGE *	0.85
	step_delay = DIVET_DELAY * 0.75
	structure_damage_factor = 1.75
	penetration_modifier = 1.5
	armor_penetration = 15
	icon_state = "divet_ap"

//Mostly normal rounds with a little extra armor pen, but they also set you on fire
/obj/item/projectile/bullet/ls_slug/incendiary
	icon_state = "divet_incend"
	armor_penetration = 9


/obj/item/projectile/bullet/ls_slug/incendiary/on_impact(var/mob/living/L)
	if (istype(L))
		L.fire_stacks += 5
		L.IgniteMob()