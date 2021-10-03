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
	var/magazine_wording = "living latex canister"
	///Phrasing of the cartridge in examine and notification messages; ex: bullet, shell, dart, etc.
	var/cartridge_wording = "living latex ball"

	/// LAMELLA TODO: You need to set verbs to describe attacks
	attack_verb_continuous = list("strikes", "hits", "bashes")
	attack_verb_simple = list("strike", "hit", "bash")

	/// ERP properties section
	//
	var/list/latexsprayerstates = list("open", "closed", "handed")
	var/curentlatexsprayerstate = latexsprayerstates[1]
	//
	var/chipslotisclosed = TRUE



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
	..() // Standard hit tests.

	if(isliving(target))
		// Let's throw off all the objects from the character before applying the latex.
		// Standard admin drop all cycle
		for(var/obj/item/W in M)
			if(!M.dropItemToGround(W))
				qdel(W)
				M.regenerate_icons()

		// Apply latex garments to the character
		if(ishuman(target))
			livinglatexspread(target,latexprogram)

	return BULLET_ACT_HIT



//////////////////////////////////////////
/// LIVING LATEX SPRAYER LOGIC SECTION ///
//////////////////////////////////////////
// Chip slot open and close handler
/obj/item/gun/ballistic/revolver/livinglatexsprayer/AltClick(mob/user)
	if(ishuman(user))
		if(!can_trigger_gun(user))
			return
	else
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
/obj/item/gun/ballistic/revolver/livinglatexsprayer/attack_hand(mob/user)
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
		cell = null
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
			if (display_message)
				to_chat(user, span_notice("You pull the [magazine_wording] out of [src]."))
			update_appearance()
			SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
		return

// Chip and canister action handler
/obj/item/gun/ballistic/revolver/livinglatexsprayer/attackby(obj/item/A, mob/user, params)
	// Blocking the default behavior of the weapon
	//..()

	// Canister click handler is a copy of the standard ammo click handler
	if(istype(A, /obj/item/ammo_casing/livinglatexcanister))
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
				if(!user.transferItemToLoc(A,src))
					return
				pin = A
				cut_overlay(module_overlay)
				add_overlay(module_overlay)
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
	return

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

//
/obj/item/gun/ballistic/revolver/latexpulv/update_icon_state()
	..()
	icon_state = "[pulv_state]"



//
/obj/item/ammo_casing/latexbin/update_icon_state()
	..()
	if(loaded_projectile)
		icon_state = "[initial(icon_state)]_[latex_bin_states[1]]"
	else
		icon_state = "[initial(icon_state)]_[latex_bin_states[2]]"

//
// /obj/item/ammo_casing/update_desc()
// 	desc = "[initial(desc)][loaded_projectile ? null : " This one is spent."]"
// 	return ..()

/obj/item/gun/ballistic/revolver/latexpulv/attack_self(mob/user, modifiers)

	if(LAZYLEN(user.client?.keys_held) > 0 && user.client?.keys_held[1] == "Z")
		if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[2]]" || pulv_state == "[initial(icon_state)]_[latexsprayerstates[3]]")
			if(SEND_SIGNAL(src, COMSIG_ITEM_ATTACK_SELF, user) & COMPONENT_CANCEL_ATTACK_CHAIN)
				return TRUE
			else
				return FALSE
		else
			user.visible_message("You need to close [src] before take it by two hands.")
			return FALSE

	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[1]]")
		pulv_state = "[initial(icon_state)]_[latexsprayerstates[2]]" // Switch pulv to closed state
		src.update_icon()
		update_glass_latex_overlays()
		return FALSE

	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[2]]")
		pulv_state = "[initial(icon_state)]_[latexsprayerstates[1]]" // Switch pulv to opened state
		src.update_icon()
		update_glass_latex_overlays()
		return FALSE
//
/obj/item/gun/ballistic/revolver/latexpulv/attack_self_secondary(mob/user, modifiers)

	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[2]]") // Pulv closed, need to open
		user.visible_message("You couldn't do anything with [src]... All controls seem to be locked")
		return
	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[3]]") // Pulv handed, need to unwield from twohands
		user.visible_message("You need to free your hand to interact with [src].")
		return

	. = ..()
	if (LAZYACCESS(modifiers, RIGHT_CLICK))
		if(!internal_magazine && magazine)
			if(!magazine.ammo_count())
				eject_magazine(user)
				update_glass_latex_overlays()
				return
		if(bolt_type == BOLT_TYPE_NO_BOLT)
			chambered = null
			var/num_unloaded = 0
			for(var/obj/item/ammo_casing/CB in get_ammo_list(FALSE, TRUE))
				CB.forceMove(drop_location())
				CB.bounce_away(FALSE, NONE)
				num_unloaded++
				var/turf/T = get_turf(drop_location())
				if(T && is_station_level(T.z))
					SSblackbox.record_feedback("tally", "station_mess_created", 1, CB.name)
			if (num_unloaded)
				to_chat(user, span_notice("You unload [num_unloaded] [cartridge_wording]\s from [src]."))
				playsound(user, eject_sound, eject_sound_volume, eject_sound_vary)
				update_appearance()
			else
				to_chat(user, span_warning("[src] is empty!"))
				update_glass_latex_overlays()
			return
		if(bolt_type == BOLT_TYPE_LOCKING && bolt_locked)
			drop_bolt(user)

			return
		if (recent_rack > world.time)
			return
		recent_rack = world.time + rack_delay
		rack(user)
		return


/**
 * Handles registering the procs when the Living Latex Sprayer is wielded
 *
 * Arguments:
 * * source - The source of the on_wield proc call
 * * user - The user which is wielding the Living Latex Sprayer
 */
/obj/item/gun/ballistic/revolver/latexpulv/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	pulv_state = "[initial(icon_state)]_[latexsprayerstates[3]]"
	update_glass_latex_overlays()
	//to_chat(user, span_notice("You brace the [src] against the ground in a firm sweeping stance."))
	//RegisterSignal(user, COMSIG_MOVABLE_PRE_MOVE, .proc/sweep)

/**
 * Handles unregistering the procs when the Living Latex Sprayer is unwielded
 *
 * Arguments:
 * * source - The source of the on_unwield proc call
 * * user - The user which is unwielding the Living Latex Sprayer
 */
/obj/item/gun/ballistic/revolver/latexpulv/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	pulv_state = "[initial(icon_state)]_[latexsprayerstates[2]]"
	update_glass_latex_overlays()
	//UnregisterSignal(user, COMSIG_MOVABLE_PRE_MOVE)

/obj/item/ammo_casing/latexbin/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", atom/fired_from)
	if (!loaded_projectile)
		return
	loaded_projectile.original = target
	loaded_projectile.firer = user
	loaded_projectile.fired_from = fired_from
	loaded_projectile.hit_prone_targets = user.combat_mode
	if (zone_override)
		loaded_projectile.def_zone = zone_override
	else
		loaded_projectile.def_zone = user.zone_selected
	loaded_projectile.suppressed = quiet

	if(isgun(fired_from))
		var/obj/item/gun/G = fired_from
		loaded_projectile.damage *= G.projectile_damage_multiplier
		loaded_projectile.stamina *= G.projectile_damage_multiplier

	if(reagents && loaded_projectile.reagents)
		reagents.trans_to(loaded_projectile, reagents.total_volume, transfered_by = user) //For chemical darts/bullets
		qdel(reagents)

////////////////////////////////////////////////
/// LIVING LATEX SPRAYER USER MANUAL SECTION ///
////////////////////////////////////////////////
//TODO: Это заглушка, нужно оформить мануал как положено
/obj/item/book/manual/latex_pulv_manual
	name = "book"
	icon = 'icons/obj/library.dmi'
	icon_state ="book"
	worn_icon_state = "book"
	desc = "Crack it open, inhale the musk of its pages, and learn something new."
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL  //upped to three because books are, y'know, pretty big. (and you could hide them inside eachother recursively forever)
	attack_verb_continuous = list("bashes", "whacks", "educates")
	attack_verb_simple = list("bash", "whack", "educate")
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/book_drop.ogg'
	pickup_sound =  'sound/items/handling/book_pickup.ogg'
	//dat //Actual page content
	//due_date = 0 //Game time in 1/10th seconds
	//author //Who wrote the thing, can be changed by pen or PC. It is not automatically assigned
	//unique = FALSE //false - Normal book, true - Should not be treated as normal book, unable to be copied, unable to be modified
	//title //The real name of the book.
	//window_size = null // Specific window size for the book, i.e: "1920x1080", Size x Width

/obj/item/book/manual/latex_pulv_manual/Initialize(mapload)
		. = ..()
		dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h3>Growing Humans</h3>

				Why would you want to grow humans? Well, I'm expecting most readers to be in the slave trade, but a few might actually
				want to revive fallen comrades. Growing pod people is actually quite simple:
				<p>
				<ol>
				<li>Find a dead person who is in need of revival. </li>
				<li>Take a blood sample with a syringe (samples of their blood taken BEFORE they died will also work). </li>
				<li>Inject a packet of replica pod seeds (which can be acquired by either mutating cabbages into replica pods (and then harvesting said replica pods) or by purchasing them from certain corporate entities) with the blood sample. </li>
				<li>It is imperative to understand that injecting the replica pod plant with blood AFTER it has been planted WILL NOT WORK; you have to inject the SEED PACKET, NOT the TRAY. </li>
				<li>Plant the seeds. </li>
				<li>Tend to the replica pod's water and nutrition levels until it is time to harvest the podcloned humanoid. </li>
				<li>Note that if the corpse's mind (or spirit, or soul, or whatever the hell your local chaplain calls it) is already in a new body or has left this plane of existence entirely, you will just receive seed packets upon harvesting the replica pod plant, not a podperson. </li>
				</ol>
				<p>
				It really is that easy! Good luck!

				</body>
				</html>
				"}

////////////////////////////////////
/// LIVING LATEX SPRAYER ENCODER ///
////////////////////////////////////
//TODO: это заглушка для программатора. Нужно полностью реализовать предмет
/obj/item/pda/latex_pulv_encoder
	name = "\improper living latex sprayer encoder"
	desc = "Portable Microcomputer Programming Modules for Live Latex Sprayer."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "encoder_off"

/obj/item/pda/latex_pulv_encoder/Initialize(mapload)
	. = ..()

	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "encoder_off"
	base_icon_state = "encoder_off"


//////////////////////////////////////
/// LIVING LATEX DISSOLVER SECTION ///
//////////////////////////////////////
//TODO: это заглушка для растворителя живого латекса. Нужно полностью реализовать предмет
/obj/item/reagent_containers/spray/chemsprayer/living_latex_dissolver
	name = "living latex dissolver"
	desc = "Special solvent for live latex. Safe for skin and mucous membranes."
	icon = 'modular_skyrat/modules/fixing_missing_icons/ballistic.dmi' //skyrat edit
	icon_state = "chemsprayer"
	inhand_icon_state = "chemsprayer"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_NORMAL
	stream_mode = 1
	current_range = 7
	spray_range = 4
	stream_range = 7
	amount_per_transfer_from_this = 10
	volume = 600
