////////////////////////////
///	LIVING LATEX SPRAYER ///
////////////////////////////
// The general principle of operation of the latex sprayer copies the operation of a conventional single-shot grenade launcher.
// One grenade is charged, then a shot is fired, after which you need to remove the sleeve and load a new one.
// A living latex canister is used instead of a grenade.

// Declaring the basic properties and parameters of the Living latex sprayer
/obj/item/gun/ballistic/revolver/livinglatexsprayer  //this is only used for underbarrel grenade launchers at the moment, but admins can still spawn it if they feel like being assholes
	// launchers.dm parameters
	desc = "Sprayer for firing special living latex mass" //LAMELLA TODO: Need a description of the Living latex sprayer
	name = "Nanite latex sprayer"
	icon = "'modular_skyrat/modules/fixing_missing_icons/ballistic.dmi'" // LAMELLA TODO: Living latex sprayer image file needed
	icon_state = "living_latex_gun"
	worn_icon = "" // LAMELLA TODO: We need a file with an image of a sprayer in the hands of a character
	inhand_icon_state = "living_latex_gun"
	worn_icon_state = "living_latex_gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi' //LAMELLA TODO: Need a left-handed image file for the sprayer
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi' // LAMELLA TODO: Need a file with a right-handed image for the sprayer
	mag_type = /obj/item/ammo_box/magazine/internal/livinglatexcanisterreciever // A special type of ammunition reciever. Defined below in code
	fire_sound = 'sound/weapons/gun/general/grenade_launch.ogg' // LAMELLA TODO: Need a living latex sprayer voiceover file
	w_class = WEIGHT_CLASS_NORMAL
	pin = /obj/item/firing_pin/latexnanitechip // Special type of firing_pin for living latex gun.
	bolt_type = BOLT_TYPE_NO_BOLT
	// LAMELA TODO: Files for the sound operation
	fire_sound = 'sound/weapons/gun/revolver/shot_alt.ogg'
	vary_fire_sound = TRUE
	fire_sound_volume = 50
	dry_fire_sound = 'sound/weapons/gun/revolver/dry_fire.ogg'
	///sound when inserting magazine
	load_sound = 'sound/weapons/gun/revolver/load_bullet.ogg'
	///sound when inserting an empty magazine
	load_empty_sound = 'sound/weapons/gun/general/magazine_insert_empty.ogg'
	///volume of loading sound
	load_sound_volume = 40
	///whether loading sound should vary
	load_sound_vary = TRUE
	///sound of racking
	rack_sound = 'sound/weapons/gun/general/bolt_rack.ogg'
	///volume of racking
	rack_sound_volume = 60
	///whether racking sound should vary
	rack_sound_vary = TRUE
	///sound of when the bolt is locked back manually
	lock_back_sound = 'sound/weapons/gun/general/slide_lock_1.ogg'
	///volume of lock back
	lock_back_sound_volume = 60
	///whether lock back varies
	lock_back_sound_vary = TRUE
	///Sound of ejecting a magazine
	eject_sound = 'sound/weapons/gun/revolver/empty.ogg'
	///sound of ejecting an empty magazine
	eject_empty_sound = 'sound/weapons/gun/general/magazine_remove_empty.ogg'
	///volume of ejecting a magazine
	eject_sound_volume = 40
	///whether eject sound should vary
	eject_sound_vary = TRUE
	///sound of dropping the bolt or releasing a slide
	bolt_drop_sound = 'sound/weapons/gun/general/bolt_drop.ogg'
	///volume of bolt drop/slide release
	bolt_drop_sound_volume = 60
	///empty alarm sound (if enabled)
	empty_alarm_sound = 'sound/weapons/gun/general/empty_alarm.ogg'
	///empty alarm volume sound
	empty_alarm_volume = 70
	///whether empty alarm sound varies
	empty_alarm_vary = TRUE

	// LAMELLA TODO:
	///Phrasing of the magazine in examine and notification messages; ex: magazine, box, etx
	var/magazine_wording = "living latex canister"
	///Phrasing of the cartridge in examine and notification messages; ex: bullet, shell, dart, etc.
	var/cartridge_wording = "living latex ball"

	/// LAMELA TODO: You need to set verbs to describe attacks
	attack_verb_continuous = list("strikes", "hits", "bashes")
	attack_verb_simple = list("strike", "hit", "bash")

// Definition of the firing pin class
/obj/item/firing_pin/latexnanitechip
	name = "latex nanite chip"
	desc = "A small authentication device, to be inserted into a living latex gun slot to allow operation. Contains a nanite management program." // LAMELLA TODO: Need a description of the chip for the living latex sprayer
	icon = 'icons/obj/device.dmi' // LAMELLA TODO: Need a file with the image of the latex nanite chip
	icon_state = "latex_nanite_chip"
	worn_icon = "" // LAMELLA TODO: We need a file with the image of the chip in the hands of the character
	inhand_icon_state = "chip"
	worn_icon_state = "chip"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("pokes")
	attack_verb_simple = list("poke")
	var/fail_message = "<span class='warning'>INVALID USER.</span>"
	var/selfdestruct = FALSE // Explode when user check is failed.
	var/force_replace = FALSE // Can forcefully replace other pins.
	var/pin_removeable = FALSE // Can be replaced by any pin.

// Latex Canister Receiver Class definition for Living latex sprayer
/obj/item/ammo_box/magazine/internal/livinglatexcanisterreciever
	name = "Living latex sprayer internal magazine"
	ammo_type = /obj/item/ammo_casing/livinglatexcanister // // A special type of ammunition. Defined below in code
	caliber = CALIBER_40MM // GEMINEE TODO: Check the need for a special caliber.
	max_ammo = 1 // Only one canister can be installed in a Living latex sprayer at a time

// Latex Canister Class definition for Latex sprayer. Single Shot Latex sprayer Ammunition
/obj/item/ammo_casing/livinglatexcanister
	name = "living latex canister"
	desc = "A canister filled with a mixture of latex and nanites. Used for firing a living latex sprayer. The canister is single-shot and cannot be refilled." // LAMELLA TODO: Need a description of the latex canister
	caliber = CALIBER_40MM // GEMINEE TODO: Check the need for a special caliber.
	icon = "" // LAMELLA TODO: Latex canister image file needed
	icon_state = "living_latex_canister"
	worn_icon = "" // LAMELA TODO:
	worn_icon_state = "" // LAMELA TODO:
	projectile_type = /obj/projectile/bullet/latexball

// Latex ball class definition
/obj/projectile/bullet/livinglatexball
	name ="living latexball"
	desc = "USE A LIVING LATEX SPRAYER"
	icon = "" // LAMELLA TODO: Need a file with a picture of a latex ball
	icon_state= "living_latex_ball"
	damage = 0 // Living latex ball does not damage targets
	nodamage = TRUE // Duplicate the lack of damage with a special parameter
	hitsound = 'sound/weapons/pierce.ogg' // LAMELA TODO: Need a hit sound
	hitsound_wall = "ricochet" // GEMINEE TODO: Find where ricochet sounds are defined
	embedding = null
	shrapnel_type = null
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	shrapnel_type = /obj/item/shrapnel/livinglatexball
	ricochets = 0
	ricochets_max = 0
	ricochet_chance = 0

//LAMELLA TODO: Need a general special effect setting
//Defines of the special effect of being hit by live latex
/obj/effect/temp_visual/livinglatexhit
	name = "\improper Living latex hit"
	desc = "A black lump of living latex stuck to the target and then quickly enveloped it in its black tentacles, completely covering the entire body in an even layer." // LAMELA TODO: A description of the hit effect is needed.
	icon = 'icons/effects/beam_splash.dmi' // LAMELA TODO: We need a file with the effects of a ball of latex.
	icon_state = "living_latex_hit"
	layer = ABOVE_ALL_MOB_LAYER
	pixel_x = 0
	pixel_y = 0
	duration = 10 //Time in deciseconds that the effect will be displayed

// Class definition depicting a ball of live latex
/obj/item/shrapnel/livinglatexball
	name = "livinglatexball"
	icon = 'icons/obj/guns/ammo.dmi' // LAMELLA TODD: Need a file with a picture of a ball of living latex
	icon_state = "livinglatexball"
	embedding = null // embedding vars are taken from the projectile itself


// GEMINEE TODO: Overriding the default grenade on-hit behavior for living latex ball
/obj/projectile/bullet/latexball/on_hit(atom/target, blocked = FALSE)
	..() //GEMINEE TODO: Check the operation of the nodamage parameter. If you need to track checks in a superfunction

	//Disable the standard grenade handling.
	//explosion(target, devastation_range = -1, light_impact_range = 2, flame_range = 3, flash_range = 1, adminlog = FALSE)

	// GEMINEE TODO: Implement your own livning latex ball hit handler

	return BULLET_ACT_HIT








/////////////////////////////////
///	FUNCTION OVERRIDE SECTION ///
/////////////////////////////////

// Redefining the function of installing a magazine in a weapon to replace the sound
/obj/item/ammo_box/attackby(obj/item/A, mob/user, params, silent = FALSE, replace_spent = 0)
	var/num_loaded = 0
	if(!can_load(user))
		return
	if(istype(A, /obj/item/ammo_box))
		var/obj/item/ammo_box/AM = A
		for(var/obj/item/ammo_casing/AC in AM.stored_ammo)
			var/did_load = give_round(AC, replace_spent)
			if(did_load)
				AM.stored_ammo -= AC
				num_loaded++
			if(!did_load || !multiload)
				break
		if(num_loaded)
			AM.update_ammo_count()
	if(istype(A, /obj/item/ammo_casing))
		var/obj/item/ammo_casing/AC = A
		if(give_round(AC, replace_spent))
			user.transferItemToLoc(AC, src, TRUE)
			num_loaded++
			AC.update_appearance()

	if(num_loaded)
		if(!silent)
			to_chat(user, span_notice("You load [num_loaded] shell\s into \the [src]!"))
			playsound(src, 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE) // LAMELLA TODO: Need the sound of inserting the latex canister into the sprayer
		update_ammo_count()

	return num_loaded

// Redefining the function of uninstalling a magazine in a weapon to replace the sound
/obj/item/ammo_box/attack_self(mob/user)
	var/obj/item/ammo_casing/A = get_round()
	if(!A)
		return

	A.forceMove(drop_location())
	if(!user.is_holding(src) || !user.put_in_hands(A)) //incase they're using TK
		A.bounce_away(FALSE, NONE)
	playsound(src, 'sound/weapons/gun/general/mag_bullet_insert.ogg', 60, TRUE) // LAMELLA TODO: Need the sound of taking out the latex canister into the sprayer
	to_chat(user, span_notice("You remove a round from [src]!"))
	update_ammo_count()


