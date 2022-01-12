//Fired from the ripper, a sawblade deals constant damage to things it touches





//These are defined here to prevent duplication
#define SAWBLADE_HEALTH 350
#define DIAMONDBLADE_HEALTH 1050




//Applied when a non-remotecontrolled blade hits a wall or other solid object
#define IMPACT_DAMAGE 60

/*-----------------------------------
	Remote Control Sawblade
------------------------------------*/
/obj/item/projectile/remote/sawblade
	name = "sawblade"
	desc = "Oh god, run, RUN!"
	damage_type = BRUTE

	//How much Damage Per Second is dealt to targets the blade hits in remote control mode. This is broken up into many small hits based on tick interval
	dps	=	27
	alpha = 255
	check_armour = "melee" //Its a cutting blade, melee armor helps most
	dispersion = 0
	icon = 'icons/effects/projectiles.dmi'
	icon_state = "sawblade_projectile"
	mouse_opacity = 1
	sharp = 1
	edge = 1

	sound_active = 'sound/weapons/sawblade_normal.ogg'
	sound_grind = 'sound/weapons/sawblade_grind.ogg'


	max_health = SAWBLADE_HEALTH


//The advanced version. A bit more damage, a LOT more durability
/obj/item/projectile/remote/sawblade/diamond
	damage = 50
	dps = 36
	max_health = DIAMONDBLADE_HEALTH
	name = "diamond blade"
	desc = "Glittering death approaches."
	icon_state = "diamond_projectile"
	ammo_type = /obj/item/ammo_casing/sawblade/diamond
	trash_type = /obj/item/trash/broken_sawblade/diamond



//Handle some effects on hitting mobs
/obj/item/projectile/remote/sawblade/attack_mob(var/mob/living/target_mob, var/distance, var/miss_modifier=0)
	//Update our hit location to wherever user is currently aiming
	var/mob/living/user = firemode.get_user()
	if (user)
		def_zone = get_zone_sel(user)

	.=..()
	playsound(target_mob, 'sound/weapons/bladeslice.ogg', 60, 1, 1)
	if (!remote_controlled)

		global_pixel_loc = get_global_pixel_loc() //Cache this so we know where to drop a remnant, for non remote blades










//Ammo version for picking up and loading
/obj/item/ammo_casing/sawblade
	name = "sawblade"
	desc = "A steel toothed blade with hardened plasteel tips, designed as ammunition for the RC-DS Remote Control Disc Ripper."
	icon_state = "sawblade"
	caliber = "saw"
	projectile_type = /obj/item/projectile/remote/sawblade
	max_health = SAWBLADE_HEALTH //The ammo versions have a health value which is carried over from the projectile if an unbroken blade is dropped
	matter = list(MATERIAL_STEEL = 1000, MATERIAL_PLASTEEL = 125)

	//An uninserted sawblade is also a modestly good weapon to swing around
	w_class = ITEM_SIZE_NORMAL
	force = 12
	throwforce = 20
	sharp = TRUE
	edge = TRUE

/obj/item/ammo_casing/sawblade/examine(var/mob/user)
	.=..()
	//Show damage on inspection
	if (health < initial(health))
		var/hp = health / initial(health)
		switch (hp)
			if (0.8 to 1.0)
				to_chat(user, "It has a few minor scuffs and scratches")
				to_chat(user, SPAN_WARNING("It is worn and shows significant stress fractures"))
			if (0.3 to 0.5)
				to_chat(user, SPAN_WARNING("It is blunted and chipped, has clearly seen heavy use"))
			else
				to_chat(user, SPAN_DANGER("It is cracked and bent, likely to shatter if used again"))

//Damaged blades are worth less to recyle. Every 1% health lost reduces matter by 0.5%
/obj/item/ammo_casing/sawblade/get_matter()
	var/hp = health / initial(health)
	var/matmult = (0.5 * hp) + 0.5 //This will give a value in the range 0.5..1.0
	var/list/returnmat = list()
	for (var/m in matter)
		returnmat[m] = matter[m] * matmult

	return returnmat

/obj/item/ammo_casing/sawblade/diamond
	name = "sawblade"
	desc = "A glittering blade with a diamond-coated plasteel edge. Extremely durable and designed for grinding through the toughest materials."
	icon_state = "diamondblade"
	projectile_type = /obj/item/projectile/remote/sawblade/diamond
	max_health = DIAMONDBLADE_HEALTH
	matter = list(MATERIAL_STEEL = 1000, MATERIAL_PLASTEEL = 250, MATERIAL_DIAMOND = 125)


//Dropped when a blade breaks. These are trash subtype for easy categorising and pickup
/obj/item/trash/broken_sawblade
	name = "fragmented sawblade"
	layer = BELOW_TABLE_LAYER //Trash falls under objects
	//icon = 'icons/obj/trash.dmi' //Just putting this here for reference, no need to duplicate it
	icon_state = "sawblade"
	desc = "This was once a precisely machined cutting tool. Now it is just scrap metal for recycling."
	matter = list(MATERIAL_STEEL = 300, MATERIAL_PLASTEEL = 40) //The broken versions contain roughly a third of the original matter when recycled


/obj/item/trash/broken_sawblade/diamond
	name = "shattered diamond blade"
	icon_state = "diamondblade"
	desc = "This glittering blade was once a durable cutting edge, it must have seen heavy use to end up like this. May still contain some valueable materials to recycle."
	matter = list(MATERIAL_STEEL = 300, MATERIAL_PLASTEEL = 80, MATERIAL_DIAMOND = 40) //The broken versions contain roughly a third of the original matter when recycled

/*-----------------------------------
	Speed Loader
------------------------------------*/
/obj/item/ammo_magazine/sawblades
	name = "ripper blades"
	desc = "A pack of replacement sawblades."
	icon_state = "ripper_blades"
	caliber = "saw"
	ammo_type = /obj/item/ammo_casing/sawblade
	matter = list(MATERIAL_STEEL = 1260)
	max_ammo = 4
	multiple_sprites = 0
	mag_type = SPEEDLOADER
	delete_when_empty = TRUE

/obj/item/ammo_magazine/sawblades/diamond
	name = "diamond blades"
	icon_state = "diamond_blades"
	desc = "A pack of high precision diamond-edged replacement sawblades."
	ammo_type = /obj/item/ammo_casing/sawblade/diamond


/*-----------------------------------
	Normal Fire Sawblade
------------------------------------*/
/obj/item/projectile/sawblade
	name = "sawblade"
	desc = "Oh god, run, RUN!"
	damage_type = BRUTE
	//The compile time damage var is only used for blade launch mode. It will be replaced with a calculated value in remote control mode
	damage = 35
	sharp = 1
	edge = 1
	icon = 'icons/effects/projectiles.dmi'
	icon_state = "sawblade_projectile"
	health = SAWBLADE_HEALTH
	penetrating = INFINITY	//Can slice through mobs, but it loses health when it does so
	var/vector2/global_pixel_loc

	var/dropped = FALSE

	//The ammo item to drop when we are released but not quite broken
	var/ammo_type = /obj/item/ammo_casing/sawblade

	//The broken sawblade item to drop when we run out of health
	var/trash_type = /obj/item/trash/broken_sawblade


	var/drop_sound = 'sound/effects/weightdrop.ogg'

	var/break_sound = "shatter"

	var/drop_damage = 25

/obj/item/projectile/sawblade/diamond
	damage = 50
	health = DIAMONDBLADE_HEALTH
	name = "diamond blade"
	desc = "glittering death approaches"
	icon_state = "diamond_projectile"


//Only called for blades in saw launcher mode, and only if they fail to penetrate through an object under normal rules.
//This proc basically asks if we want to override a failed result.
/obj/item/projectile/sawblade/check_penetrate(var/atom/A)
	//Blades will always slice through mobs
	//Possible TODO: Check that the mob is organic
	if (istype(A, /mob/living))
		return TRUE
	else
		//We don't pass through walls and hard objects
		return FALSE

/obj/item/projectile/sawblade/attack_mob(var/mob/living/target_mob, var/distance, var/miss_modifier=0)
	var/cached_damage = damage	//The parent may modify our damage var, this is to undo any modification
	.=..()

	playsound(target_mob, 'sound/weapons/bladeslice.ogg', 60, 1, 1)
	release_vector(global_pixel_loc)
	global_pixel_loc = get_global_pixel_loc() //Cache this so we know where to drop a remnant, for non remote blades
	damage = cached_damage
	take_damage(damage)







/obj/item/projectile/sawblade/on_impact(var/atom/A)
	global_pixel_loc = get_global_pixel_loc() //Cache this so we know where to drop a remnant, for non remote blades
	A.ex_act(3) //Some hefty damage is dealt, though its still less effective than remote control mode
	take_damage(IMPACT_DAMAGE) //Don't bother updating, it will drop momentarily anyway

	drop()


/obj/item/projectile/sawblade/proc/drop()
	if (dropped)
		return


	dropped = TRUE



	if (health < drop_damage)
		if (break_sound)
			playsound(src, break_sound, 70, 1)

		if (trash_type)
			var/obj/item/broken = new trash_type(loc)
			broken.set_global_pixel_loc(QDELETED(src) ? global_pixel_loc : get_global_pixel_loc())//Make sure it appears exactly below this disk

			//And lets give it a random rotation to make it look like it just fell there
			var/matrix/M = matrix()
			M.Turn(rand(0,360))
			broken.transform = M

	else
		if (drop_sound)
			playsound(get_turf(src),drop_sound, 70, 1, 1) //Clunk!
		//If health remains, the sawblade drops on the floor
		if (ammo_type)
			take_damage(drop_damage) //Take some damage from the dropping
			var/obj/item/ammo_casing/sawblade/ammo = new ammo_type(loc)
			ammo.set_global_pixel_loc(QDELETED(src) ? global_pixel_loc : get_global_pixel_loc())//Make sure it appears exactly below this disk
			ammo.health = health //Set its health to ours
			//And lets give it a random rotation to make it look like it just fell there
			var/matrix/M = matrix()
			M.Turn(rand(0,360))
			ammo.transform = M

	//Once we've placed either a blade or a broken remnant, delete this projectile
	//We spawn it off to prevent recursion issues, make sure the launcher does its cleanup first

	spawn()
		if (!QDELETED(src))
			qdel(src)


#undef IMPACT_DAMAGE
#undef SAWBLADE_HEALTH
#undef DIAMONDBLADE_HEALTH
