#define CALIBRE_14MM "14mm"

/*
* Malorian Arms 3516 14MM
* If you have this, you're a badass.
*/

/obj/item/gun/ballistic/automatic/pistol/robohand
	name = "Malorian Arms 3516"
	desc = "The Malorian Arms 3516 is a 14mm heavy pistol, sporting a titanium frame and unique wooden grip. A custom Dyna-porting and \
	direct integral cyber-interlink means only someone with a cyberarm and smartgun link can take full advantage of the pistol's features."
	special_desc = "Anyone wielding one of these is bound for a glorious early death. The letter 'V' is stamped on the bottom of the grip."
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc_affiliation = "memories of Johnny Robohand"
	icon = 'modular_skyrat/modules/robohand/icons/3516.dmi'
	icon_state = "3516"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m14mm
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/robohand/sound/fire2.ogg'
	load_sound = 'modular_skyrat/modules/robohand/sound/reload.ogg'
	load_empty_sound = 'modular_skyrat/modules/robohand/sound/reload.ogg'
	eject_sound = 'modular_skyrat/modules/robohand/sound/release.ogg'
	eject_empty_sound = 'modular_skyrat/modules/robohand/sound/release.ogg'
	vary_fire_sound = FALSE
	rack_sound = 'modular_skyrat/modules/robohand/sound/slide.ogg'
	fire_sound_volume = 100
	bolt_wording = "fuckin' slide"
	reload_time = 0 //ROLL THE BONES I'M CHIPPIN' IN
	company_flag = COMPANY_MALORIAN
	var/unrestricted = FALSE

/obj/item/gun/ballistic/automatic/pistol/robohand/unrestricted
	unrestricted = TRUE

//Gun actions

//The gun cannot shoot if you do not have a cyborg arm.
/obj/item/gun/ballistic/automatic/pistol/robohand/afterattack(atom/target, mob/living/user, flag, params)
	//This is where we are checking if the user has a cybernetic arm to USE the gun. ROBOHAND HAS A ROBO HAND
	if(ishuman(user))
		return ..()
	if(!unrestricted)
		var/mob/living/carbon/human/human_user = user
		var/obj/item/bodypart/selected_hand = human_user.get_active_hand()
		if(IS_ORGANIC_LIMB(selected_hand))
			to_chat(user, span_warning("You can't seem to figure out how to use [src], perhaps you need to check the manual?"))
			return
	. = ..()

/obj/item/gun/ballistic/automatic/pistol/robohand/insert_magazine(mob/user, obj/item/ammo_box/magazine/inserted_mag, display_message)
	if(!istype(inserted_mag, mag_type))
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
	animate(src, transform = turn(matrix(), 120), time = 2, loop = 1) //flippin'
	animate(transform = turn(matrix(), 240), time = 2)
	animate(transform = null, time = 2)

//Magazine stuff

/obj/item/ammo_box/magazine/m14mm
	name = "pistol magazine (14mm)"
	desc = "A ten-round magazine holding proprietary 14mm rounds, capable of piercing cover and enemy combatants."
	icon = 'modular_skyrat/modules/robohand/icons/3516_mag.dmi'
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

/obj/projectile/bullet/c14mm //vanilla .357 but pierces everything except mobs. groovy
	name = "14mm bullet"
	damage = 50
	wound_bonus = -30
	pierces = 1
	projectile_piercing = ~(PASSMOB)
	range = 20 //this thing penetrates all walls, and thus without the range being neutered it will destroy 3 windows and kill someone in dorms if you miss
