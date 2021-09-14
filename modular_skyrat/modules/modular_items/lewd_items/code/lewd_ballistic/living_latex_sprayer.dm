////////////////////////////
///	LIVING LATEX SPRAYER ///
////////////////////////////
// The general principle of operation of the latex sprayer copies the operation of a conventional single-shot grenade launcher.
// One grenade is charged, then a shot is fired, after which you need to remove the sleeve and load a new one.
// A living latex canister is used instead of a grenade.

// Declaring the basic properties and parameters of the Living latex sprayer
/obj/item/gun/ballistic/revolver/latexpulv  //this is only used for underbarrel grenade launchers at the moment, but admins can still spawn it if they feel like being assholes
	// launchers.dm parameters
	desc = "Sprayer for firing special living latex mass" //LAMELLA TODO: Need a description of the Living latex sprayer
	name = "Nanite latex sprayer"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi' // LAMELLA TODO: Living latex sprayer image file needed
	icon_state = "latex_pulv"
	worn_icon = "" // LAMELLA TODO: We need a file with an image of a sprayer in the hands of a character
	inhand_icon_state = "living_latex_gun"
	worn_icon_state = "living_latex_gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi' //LAMELLA TODO: Need a left-handed image file for the sprayer
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi' // LAMELLA TODO: Need a file with a right-handed image for the sprayer
	mag_type = /obj/item/ammo_box/magazine/internal/latexbinreciever // A special type of ammunition reciever. Defined below in code
	fire_sound = 'sound/weapons/gun/general/grenade_launch.ogg' // LAMELLA TODO: Need a living latex sprayer voiceover file
	w_class = WEIGHT_CLASS_NORMAL
	pin = null // Special type of firing_pin for living latex gun.
	bolt_type = BOLT_TYPE_NO_BOLT
	can_misfire = FALSE
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
	magazine_wording = "living latex canister"
	///Phrasing of the cartridge in examine and notification messages; ex: bullet, shell, dart, etc.
	cartridge_wording = "living latex ball"

	/// LAMELLA TODO: You need to set verbs to describe attacks
	attack_verb_continuous = list("strikes", "hits", "bashes")
	attack_verb_simple = list("strike", "hit", "bash")

	/// ERP properties section
	//
	var/list/latexsprayerstates = list("open", "closed", "handed")
	//var/currentlatexsprayerstate = latexsprayerstates[1]
	//
	var/chipslotisclosed = TRUE

/obj/item/gun/ballistic/revolver/latexpulv/Initialize()
	. = ..()
	icon_state = "closed"

// Definition of the firing pin class
/obj/item/firing_pin/latexnanitechip
	name = "latex nanite chip"
	desc = "A small authentication device, to be inserted into a living latex gun slot to allow operation. Contains a nanite management program." // LAMELLA TODO: Need a description of the chip for the living latex sprayer
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi' // LAMELLA TODO: Need a file with the image of the latex nanite chip
	icon_state = "pulv_module"
	worn_icon = "" // LAMELLA TODO: We need a file with the image of the chip in the hands of the character
	inhand_icon_state = "chip"
	worn_icon_state = "chip"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("pokes")
	attack_verb_simple = list("poke")
	fail_message = "<span class='warning'>INVALID USER.</span>"
	selfdestruct = FALSE // Explode when user check is failed.
	force_replace = FALSE // Can forcefully replace other pins.
	pin_removeable = FALSE // Can be replaced by any pin.
	var/list/latexprogram = list(/obj/item/clothing/shoes/ll_socks,
									/obj/item/clothing/gloves/ll_gloves
								) // Default latex program

// Latex Canister Receiver Class definition for Living latex sprayer
/obj/item/ammo_box/magazine/internal/latexbinreciever
	name = "Living latex sprayer internal magazine"
	ammo_type = /obj/item/ammo_casing/latexbin // A special type of ammunition. Defined below in code
	caliber = CALIBER_40MM // GEMINEE TODO: Check the need for a special caliber.
	max_ammo = 1 // Only one canister can be installed in a Living latex sprayer at a time

// Latex Canister Class definition for Latex sprayer. Single Shot Latex sprayer Ammunition
/obj/item/ammo_casing/latexbin
	name = "living latex canister"
	desc = "A canister filled with a mixture of latex and nanites. Used for firing a living latex sprayer. The canister is single-shot and cannot be refilled." // LAMELLA TODO: Need a description of the latex canister
	caliber = CALIBER_40MM // GEMINEE TODO: Check the need for a special caliber.
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi' // LAMELLA TODO: Latex canister image file needed
	icon_state = "latex_bin"
	worn_icon = "" // LAMELA TODO:
	worn_icon_state = "" // LAMELA TODO:
	projectile_type = /obj/projectile/bullet/latexball

// Latex ball class definition
/obj/projectile/bullet/livinglatexball
	name ="living latexball"
	desc = "USE A LIVING LATEX SPRAYER"
	//icon = "" // LAMELLA TODO: Need a file with a picture of a latex ball
	//icon_state= "living_latex_ball"
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
	var/list/latexprogram = list() // List of item types that are recorded in the latex program

//LAMELLA TODO: Need a general special effect setting
//Defines of the special effect of being hit by live latex
/obj/effect/temp_visual/livinglatexhit
	name = "\improper Living latex hit"
	desc = "A black lump of living latex stuck to the target and then quickly enveloped it in its black tentacles, completely covering the entire body in an even layer." // LAMELA TODO: A description of the hit effect is needed.
	//icon = 'icons/effects/beam_splash.dmi' // LAMELA TODO: We need a file with the effects of a ball of latex.
	//icon_state = "living_latex_hit"
	layer = ABOVE_ALL_MOB_LAYER
	pixel_x = 0
	pixel_y = 0
	duration = 10 //Time in deciseconds that the effect will be displayed

// Class definition depicting a ball of live latex
/obj/item/shrapnel/livinglatexball
	name = "livinglatexball"
	//icon = 'icons/obj/guns/ammo.dmi' // LAMELLA TODD: Need a file with a picture of a ball of living latex
	//icon_state = "livinglatexball"
	embedding = null // embedding vars are taken from the projectile itself


// GEMINEE TODO: Overriding the default grenade on-hit behavior for living latex ball
/obj/projectile/bullet/latexball/on_hit(mob/target, blocked = FALSE)
	..() // Standard hit tests.

	if(isliving(target))
		// Let's throw off all the objects from the character before applying the latex.
		// Standard admin drop all cycle
		for(var/obj/item/W in target)
			if(!target.dropItemToGround(W))
				qdel(W)
				target.regenerate_icons()

		// Apply latex garments to the character
		if(ishuman(target))
			livinglatexspread(target)

	return BULLET_ACT_HIT



//////////////////////////////////////////
/// LIVING LATEX SPRAYER LOGIC SECTION ///
//////////////////////////////////////////
// Chip slot open and close handler
/obj/item/gun/ballistic/revolver/latexpulv/AltClick(mob/user)
	if(!ishuman(user))
		return

	if(!chipslotisclosed)
		chipslotisclosed = TRUE
		user.visible_message("You close chip reciever.", "[user.name] close chip reciever.")
		return
	else
		chipslotisclosed = FALSE
		user.visible_message("You open chip reciever. It is [pin ? "has chip" : "empty"]" , "[user.name] open chip reciever. It is [pin ? "has chip" : "empty"]")
		return

// Empty Hand Attack Handler
/obj/item/gun/ballistic/revolver/latexpulv/attack_hand(mob/user)
	if(ishuman(user))
		if(!can_trigger_gun(user))
			return
	else
		return

	// If the chip slot is open, then we take the chip into an empty hand.
	if(!chipslotisclosed && pin)
		user.put_in_hands(pin)
		pin.add_fingerprint(user)
		user.visible_message(span_notice("[user] removes [pin] from [src]."), span_notice("You remove [pin] from [src]."))
		pin = null
		//update_all_visuals()
		return
	// If the panel is closed or there is no chip in the slot, then pull out the canister
	if(!internal_magazine && loc == user && user.is_holding(src) && magazine)
		if(bolt_type == BOLT_TYPE_OPEN)
			chambered = null
		if (magazine.ammo_count())
			playsound(src, load_sound, load_sound_volume, load_sound_vary)
		else
			playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)
		magazine.forceMove(drop_location())
		var/obj/item/ammo_box/magazine/old_mag = magazine

		var/obj/item/ammo_box/magazine/tac_load = null //TODO: check logic
		if (tac_load)
			if (insert_magazine(user, tac_load, FALSE))
				to_chat(user, span_notice("You perform a tactical reload on [src]."))
			else
				to_chat(user, span_warning("You dropped the old [magazine_wording], but the new one doesn't fit. How embarassing."))
				magazine = null
		else
			magazine = null
		user.put_in_hands(old_mag)
		old_mag.update_appearance()
		var/display_message = TRUE //TODO: check logic
		if (display_message)
			to_chat(user, span_notice("You pull the [magazine_wording] out of [src]."))
		update_appearance()
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
		return

// Chip and canister action handler
/obj/item/gun/ballistic/revolver/latexpulv/attackby(obj/item/A, mob/user, params)
	// Blocking the default behavior of the weapon
	//..()

	// Canister click handler is a copy of the standard ammo click handler
	if(istype(A, /obj/item/ammo_casing/latexbin))
		if (bolt_type == BOLT_TYPE_NO_BOLT || internal_magazine)
			if (chambered && !chambered.loaded_projectile)
				chambered.forceMove(drop_location())
				chambered = null
			var/num_loaded = magazine?.attackby(A, user, params, TRUE)
			if (num_loaded)
				to_chat(user, span_notice("You load [num_loaded] [cartridge_wording]\s into [src]."))
				playsound(src, load_sound, load_sound_volume, load_sound_vary)
				if (chambered == null && bolt_type == BOLT_TYPE_NO_BOLT)
					chamber_round()
				A.update_appearance()
				update_appearance()
			return

	// Chip click handler
	if(istype(A, /obj/item/firing_pin/latexnanitechip))
		if(!chipslotisclosed)
			if(pin)
				to_chat(user, span_warning("There is already a chip in [src]!"))
				return
			else
				var/area/a = loc.loc // Gets our locations location, like a dream within a dream
				if(!isarea(a))
					return
				if(!user.transferItemToLoc(A,src))
					//cut_overlay(cell_overlay)
					//cell_overlay.icon_state = "milking_cell_empty"
					//update_all_visuals()
					return

				pin = A
				//cut_overlay(cell_overlay)
				//cell_overlay.icon_state = "milking_cell"
				//add_overlay(cell_overlay)
				user.visible_message(span_notice("[user] inserts a chip into [src]."), span_notice("You insert a chip into [src]."))
				//update_all_visuals()
				return
	else
		to_chat(user, span_warning("[src]'s chip slot isn't opened!"))
		return

	// Space for other handlers, for example emag

	update_appearance()
	A.update_appearance()
	return

/obj/projectile/bullet/latexball/proc/livinglatexspread(mob/target, list/latexprogram)
	to_chat(world, "DBG latex hit - in hit proc executed| target=[target] | program=[latexprogram]")
	var/list/items = list()
	for (var/T, latexprogram)
		// T = new()
		// items.Add(T)



	for(var/obj/item/W in target)

		if(!target.dropItemToGround(W))
			qdel(W)
			target.regenerate_icons()


//The event just before the shot is fired. The moment of recording the program in the projectile
/obj/item/gun/ballistic/revolver/latexpulv/before_firing(atom/target,mob/user)
	//Здесь будет выполняться запись программы в сам выстрел латекса
	// if(.chambered.contents[0])
	// 	.chambered.contents[0].program = .program
	// return

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

// Blocking the action with a wrench
/obj/item/gun/ballistic/wrench_act(mob/living/user, obj/item/I)
	to_chat(user, "You cannot find any way to accept the wrench to [src]. It doesn't fit anywhere.")
	return

// Blocking the action with a screwdriver
/obj/item/gun/screwdriver_act(mob/living/user, obj/item/I)
	to_chat(user, "It seems there is nothing to unscrew. You don't see a single screw.")
	return

//Blocking the action with a welder
/obj/item/gun/welder_act(mob/living/user, obj/item/I)
	to_chat(user, "Nothing to weld here...")
	return

// Blocking the action with a wirecutter
/obj/item/gun/wirecutter_act(mob/living/user, obj/item/I)
	to_chat(user, "You don't see any wires or anything like that.")
	return
