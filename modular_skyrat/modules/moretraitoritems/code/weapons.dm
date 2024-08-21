#define CALIBRE_14MM "14mm"

/obj/item/gun/ballistic/revolver/ocelot
	name = "Colt Peacemaker revolver"
	desc = "A modified Peacemaker revolver that chambers .357 ammo. Less powerful than the regular .357, but ricochets a lot more." // We need tension...conflict. The world today has become too soft. We're living in an age where true feelings are suppressed. So we're going to shake things up a bit. We'll create a world dripping with tension... ...a world filled with greed and suspicion, bravery and cowardice.
	// this could probably be made funnier by reducing its damage multiplier but also making it so that every fired bullet has the wacky ricochets
	// but that's a different plate of cookies for a different glass of milk
	icon_state = "c38_panther"
	accepted_magazine_type = /obj/item/ammo_box/magazine/internal/cylinder

/obj/item/ammo_casing/a357/peacemaker
	name = ".357 Peacemaker bullet casing"
	desc = "A .357 Peacemaker bullet casing."
	caliber = CALIBER_357
	projectile_type = /obj/projectile/bullet/a357/peacemaker

/obj/projectile/bullet/a357/peacemaker
	name = ".357 Peacemaker bullet"
	damage = 25
	wound_bonus = 0
	ricochets_max = 6
	ricochet_chance = 200
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80
	ricochet_decay_chance = 1

/datum/design/a357/peacemaker
	name = "Speed Loader (.357 Peacemaker)"
	id = "a357PM"
	build_type = AUTOLATHE
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
	)
	build_path = /obj/item/ammo_box/a357/peacemaker
	category = list(
		RND_CATEGORY_HACKED,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO,
	)

/obj/item/ammo_box/a357/peacemaker
	name = "speed loader (.357 Peacemaker)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/a357/peacemaker
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION


/obj/item/clothing/head/hats/sus_bowler
	name = "odd bowler"
	desc = "A deep black bowler. Inside the hat, there is a sleek red S, with a smaller X insignia embroidered within. On closer inspection, the brim feels oddly weighted..."
	icon_state = "bowler"
	force = 10
	throwforce = 45
	throw_speed = 5
	throw_range = 9
	w_class = WEIGHT_CLASS_SMALL
	armour_penetration = 30 //5 points less then a double esword!
	sharpness = SHARP_POINTY
	attack_verb_continuous = list("slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")

///obj/item/clothing/head/hats/sus_bowler/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	//var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
	//if(thrownby && !caught)
		//addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, throw_at), thrownby, throw_range+2, throw_speed, null, TRUE), 0.1 SECONDS)
	//else
		//return ..()

///obj/item/clothing/head/hats/sus_bowler/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, gentle = FALSE, quickstart = TRUE)
	//if(ishuman(thrower))
		//var/mob/living/carbon/human/I = thrower
		//I.throw_mode_off(THROW_MODE_TOGGLE) //so they can catch it on the return.
	//return ..()


/*
* Malorian Arms 3516 14MM
* If you have this, you're a badass.
*/

/obj/item/gun/ballistic/automatic/pistol/robohand
	name = "Malorian Arms 3516"
	desc = "The Malorian Arms 3516 is a 14mm heavy pistol, sporting a titanium frame and unique wooden grip. A custom Dyna-porting and \
	direct integral cyber-interlink means only someone with a cyberarm and smartgun link can take full advantage of the pistol's features."
	icon = 'modular_skyrat/modules/moretraitoritems/icons/3516.dmi'
	icon_state = "3516"
	w_class = WEIGHT_CLASS_NORMAL
	accepted_magazine_type = /obj/item/ammo_box/magazine/m14mm
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/moretraitoritems/sound/fire2.ogg'
	load_sound = 'modular_skyrat/modules/moretraitoritems/sound/reload.ogg'
	load_empty_sound = 'modular_skyrat/modules/moretraitoritems/sound/reload.ogg'
	eject_sound = 'modular_skyrat/modules/moretraitoritems/sound/release.ogg'
	eject_empty_sound = 'modular_skyrat/modules/moretraitoritems/sound/release.ogg'
	vary_fire_sound = FALSE
	rack_sound = 'modular_skyrat/modules/moretraitoritems/sound/slide.ogg'
	fire_sound_volume = 100
	bolt_wording = "fuckin' slide"
	reload_time = 0 //FAST AS FUCK BOIS!
	var/unrestricted = FALSE

/obj/item/gun/ballistic/automatic/pistol/robohand/unrestricted
	unrestricted = TRUE

//The gun cannot shoot if you do not have a cyborg arm.
/obj/item/gun/ballistic/automatic/pistol/robohand/afterattack(atom/target, mob/living/user, flag, params)
	//This is where we are checking if the user has a cybernetic arm to USE the gun. ROBOHAND HAS A ROBO HAND
	if(!unrestricted)
		var/mob/living/carbon/human/human_user = user
		var/obj/item/bodypart/selected_hand = human_user.get_active_hand()
		if(IS_ORGANIC_LIMB(selected_hand))
			to_chat(user, span_warning("You can't seem to figure out how to use [src], perhaps you need to check the manual?"))
			return
	. = ..()

/obj/item/gun/ballistic/automatic/pistol/robohand/insert_magazine(mob/user, obj/item/ammo_box/magazine/inserted_mag, display_message)
	if(!istype(inserted_mag, accepted_magazine_type))
		to_chat(user, span_warning("\The [inserted_mag] doesn't seem to fit into \the [src]..."))
		return FALSE
	if(!user.transferItemToLoc(inserted_mag, src))
		to_chat(user, span_warning("You cannot seem to get \the [src] out of your hands!"))
		return FALSE
	magazine = inserted_mag
	if(display_message)
		to_chat(user, span_notice("You load a new [magazine_wording] into \the [src]."))
	playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
	if(bolt_type == BOLT_TYPE_OPEN && !bolt_locked)
		chamber_round(TRUE)
	drop_bolt(user)
	update_appearance()
	animate(src, 0.2 SECONDS, 1, transform = turn(matrix(), 120)) //Le johnny robohand woosh woosh twirl
	animate(time = 0.2 SECONDS, transform = turn(matrix(), 240))
	animate(time = 0.2 SECONDS, transform = null)
	return TRUE

/obj/item/gun/ballistic/automatic/pistol/robohand/eject_magazine(mob/user, display_message, obj/item/ammo_box/magazine/tac_load)
	if(bolt_type == BOLT_TYPE_OPEN)
		chambered = null
	if(magazine.ammo_count())
		playsound(src, eject_sound, eject_sound_volume, eject_sound_volume) //This is why we've copied this proc, it should play the eject sound when ejecting.
	else
		playsound(src, eject_empty_sound, eject_sound_volume, eject_sound_volume)
	magazine.forceMove(drop_location())
	var/obj/item/ammo_box/magazine/old_mag = magazine
	if(tac_load)
		if (insert_magazine(user, tac_load, FALSE))
			to_chat(user, span_notice("You perform an elite tactical reload on \the [src]."))
		else
			to_chat(user, span_warning("You dropped the old [magazine_wording], but the new one doesn't fit. How embarassing."))
			magazine = null
	else
		magazine = null
	user.put_in_hands(old_mag)
	old_mag.update_appearance()
	if(display_message)
		to_chat(user, span_notice("You pull the [magazine_wording] out of \the [src]."))
	update_appearance()
	animate(src, transform = turn(matrix(), 120), time = 0.2 SECONDS, loop = 1) //Le johnny robohand again
	animate(transform = turn(matrix(), 240), time = 0.2 SECONDS)
	animate(transform = null, time = 0.2 SECONDS)

//Magazine stuff
/obj/item/ammo_box/magazine/m14mm
	name = "pistol magazine (14mm)"
	icon = 'modular_skyrat/modules/moretraitoritems/icons/3516_mag.dmi'
	icon_state = "14mm"
	base_icon_state = "14mm"
	ammo_type = /obj/item/ammo_casing/c14mm
	caliber = CALIBRE_14MM
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_casing/c14mm
	name = "14mm bullet casing"
	desc = "A 14mm bullet casing. Badass."
	caliber = CALIBRE_14MM
	projectile_type = /obj/projectile/bullet/c14mm

/obj/projectile/bullet/c14mm
	name = "14mm bullet"
	damage = 60
	embed_type = /datum/embed_data/c14mm
	dismemberment = 50
	pierces = 1
	projectile_piercing = PASSCLOSEDTURF|PASSGRILLE|PASSGLASS

/datum/embed_data/c14mm
	embed_chance = 90
	fall_chance = 3
	jostle_chance = 4
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.4
	pain_mult = 5
	jostle_pain_mult = 9
	rip_time = 10

//nullrod katana
/obj/item/katana/weak/curator //This has the same stats as the curator's claymore
	desc = "An ancient Katana. Forged by... Well, it doesn't really say, but surely it's authentic! And sharp to boot!"
	force = 15
	block_chance = 30
	armour_penetration = 5
