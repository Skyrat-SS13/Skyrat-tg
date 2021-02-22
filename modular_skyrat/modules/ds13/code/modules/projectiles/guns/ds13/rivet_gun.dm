/*
	The Rivet Gun, patron exclusive.  pistol, high firing rate

	Primary Fire:
		Semi automatic, high firing rate. Very poor damage and range. Repairs instead of damaging non-organic objects.
		Leaves embedded rivets in mobs and surfaces

		The gun only tracks up to five embedded rivets, and only for one minute

	Secondary Fire:
		Detonates all tracked embedded rivets, causing them to create a very weak shrapnel explosion dealing minor aoe damage.
		Easy to hit and reliable, but not powerful
*/

/obj/item/weapon/gun/projectile/rivet
	name = "711-MarkCL Rivet Gun"
	desc = "The 711-MarkCL Rivet Gun is the latest refinement from Timson Tools' long line of friendly tools. Useful for rapid repairs at a distance!"
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "rivetgun"
	magazine_type = /obj/item/ammo_magazine/rivet
	allowed_magazines = /obj/item/ammo_magazine/rivet
	caliber = "rivet"
	accuracy = 0
	fire_delay = 1	//Up to 10 shots per second if you spamclick
	burst_delay = 0
	w_class = ITEM_SIZE_SMALL
	handle_casings = CLEAR_CASINGS
	origin_tech = list(TECH_COMBAT = 2, TECH_MATERIAL = 2)
	load_method = MAGAZINE

	mag_insert_sound = 'sound/weapons/guns/interaction/rivet_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/rivet_magout.ogg'

	//How many we can track
	var/max_rivets = 5
	var/list/rivets = list()


	firemodes = list(
		list(mode_name = "rivet", mode_type = /datum/firemode),
		list(mode_name = "fragmentate", mode_type = /datum/firemode/rivet_frag)
		)

	has_safety = FALSE	//Safety switches are for military/police weapons, not for tools

/obj/item/weapon/gun/projectile/rivet/update_icon()
	..()
	if(ammo_magazine)
		icon_state = "rivetgun"
	else
		icon_state = "rivetgun_e"


//Adds a rivet to our internal tracking list so we can detonate it later
/obj/item/weapon/gun/projectile/rivet/proc/register_rivet(var/obj/item/embedded_rivet/ER)
	//If we have too many, delete them
	if (rivets.len >= max_rivets)

		var/obj/item/embedded_rivet/redundant = rivets[1]
		unregister_rivet(redundant)
		if (!QDELETED(redundant))
			qdel(redundant)

	rivets += ER

//Remove from our list, called when a rivet is deleted. We don't actually delete it here though
/obj/item/weapon/gun/projectile/rivet/proc/unregister_rivet(var/obj/item/embedded_rivet/ER)
	rivets -= ER
	if (ER.rivetgun == src)
		ER.rivetgun = null


/obj/item/weapon/gun/projectile/rivet/Destroy()
	for (var/obj/item/embedded_rivet/r in rivets)
		unregister_rivet(r)
		if (!QDELETED(r))
			qdel(r)
	.=..()


/obj/item/weapon/gun/projectile/rivet/can_fire(atom/target, mob/living/user, clickparams, var/silent = FALSE)
	if (istype(current_firemode, /datum/firemode/rivet_frag))
		//The fragmentation firemode doesnt need ammo
		return TRUE

	.=..()

/*
	Firemode
	Detonates all rivets
*/
/datum/firemode/rivet_frag
	override_fire = TRUE

/datum/firemode/rivet_frag/fire(var/atom/target, var/mob/living/user, var/clickparams, var/pointblank=0, var/reflex=0)
	var/obj/item/weapon/gun/projectile/rivet/R = gun
	if (R.rivets.len)
		var/detonated = 0
		for (var/obj/item/embedded_rivet/ER in R.rivets)
			ER.detonate()
			detonated++
		to_chat(user, SPAN_NOTICE("Detonated [detonated] rivets!"))
	else
		to_chat(user, "There are no active rivets.")

/*
	Ammo Magazine
*/
/obj/item/ammo_magazine/rivet
	name = "rivet bolts"
	icon_state = "rivet"
	mag_type = MAGAZINE
	ammo_type = /obj/item/ammo_casing/rivet
	matter = list(MATERIAL_STEEL = 1000) //metal costs are very roughly based around 1 .45 casing = 75 metal
	caliber = "rivet"
	max_ammo = 16
	multiple_sprites = 0

/obj/item/ammo_magazine/rivet/empty
	ammo_type = null

/obj/item/ammo_magazine/rivet/update_icon()
	if (stored_ammo.len)
		icon_state = "rivet"
	else
		icon_state = "rivet_empty"


/*
	Casing
*/
/obj/item/ammo_casing/rivet
	desc = "rivet"
	caliber = "rivet"
	projectile_type = /obj/item/projectile/bullet/rivet



/*
	Projectile
*/
/obj/item/projectile/bullet/rivet
	damage = 7	//Weaker than a pulse rifle shot, and lacks full auto
	expiry_method = EXPIRY_FADEOUT
	muzzle_type = /obj/effect/projectile/pulse/muzzle/light
	//fire_sound='sound/weapons/guns/fire/divet_fire.ogg'
	structure_damage_factor = 1
	penetration_modifier = 0
	penetrating = FALSE
	var/repair_power = 80
	var/deployed = FALSE

	fire_sound='sound/weapons/guns/fire/rivet_fire.ogg'	//Placeholder


	icon_state = "rivet"

	ricochet_chance = 0



/*
	Special Effect:
	When the rivet gun is fired into non organic objects or turfs, it repairs instead of damaging them
*/
/obj/item/projectile/bullet/rivet/attack_atom(var/atom/A,  var/distance, var/miss_modifier=0)
	var/cached_damage = damage

	//If the atom is inorganic, we briefly set our damage to 0 before hitting it
	if (!A.is_organic())
		damage = 0
	. = ..()	//Parent calls bullet act which will return a flag

	//Continue means that we missed the object
	if (. == PROJECTILE_CONTINUE)
		damage = cached_damage
		return	//We're done here

	else if (!deployed)
		deployed = TRUE
		//Alright, we hit it
		//Lets fix up that thing
		A.repair(repair_power, src, firer)

		//And a sound
		playsound(A, pick(list('sound/weapons/guns/rivet1.ogg','sound/weapons/guns/rivet2.ogg','sound/weapons/guns/rivet3.ogg')), VOLUME_MID, TRUE)

		//And we also embed a rivet
		var/ourturf = get_turf(src)
		var/obj/item/embedded_rivet/ER = new /obj/item/embedded_rivet(ourturf, src)
		ER.pixel_x = src.pixel_x
		ER.pixel_y = src.pixel_y
		if (get_turf(A) != ourturf)
			ER.offset_to(get_turf(A), WORLD_ICON_SIZE)






/*
	Embedded_rivet:
	Object created on hit which can be detonated
*/
/obj/item/embedded_rivet
	icon = 'icons/effects/projectiles.dmi'
	icon_state = "rivet_embed"
	default_scale = 0.6
	name = "rivet"
	mouse_opacity = 0
	var/obj/item/weapon/gun/projectile/rivet/rivetgun
	var/lifetime = 1 MINUTE
	var/detonated = FALSE

	//Draw above other objects
	plane = ABOVE_OBJ_PLANE
	layer = 0

/obj/item/embedded_rivet/New(var/atom/location, var/obj/item/projectile/bullet/rivet/rivet)
	if (istype(rivet.launcher, /obj/item/weapon/gun/projectile/rivet))
		rivetgun = rivet.launcher
		rivetgun.register_rivet(src)
	QDEL_IN(src, lifetime)
	animate(src, transform = src.transform*default_scale, 3)
	.=..()

/obj/item/embedded_rivet/proc/detonate()
	if (!QDELETED(src) && !detonated)
		detonated = TRUE
		fragmentate(T=get_turf(src), fragment_number = 17, spreading_range = 3, fragtypes=list(/obj/item/projectile/bullet/pellet/fragment/rivet))
		qdel(src)

/obj/item/embedded_rivet/Destroy()
	if (rivetgun)
		rivetgun.unregister_rivet(src)

	.=..()



/*
	Fragmentation
*/
/obj/item/projectile/bullet/pellet/fragment/rivet
	damage = 2.2
	range_step = 3 //controls damage falloff with distance. projectiles lose a "pellet" each time they travel this distance. Can be a non-integer.

	base_spread = 0 //causes it to be treated as a shrapnel explosion instead of cone
	spread_step = 20

	silenced = 1
	fire_sound = null
	no_attack_log = 1
	muzzle_type = null
	embed_mult = 0	//Embedding is OP, lets not do that

	kill_count = 16

	//Will probably bounce 2-3 times
	ricochet_chance = 200





