////////////////////////////
///	LIVING LATEX SPRAYER ///
////////////////////////////
// The general principle of operation of the latex sprayer copies the operation of a conventional single-shot grenade launcher.
// One grenade is charged, then a shot is fired, after which you need to remove the sleeve and load a new one.
// A living latex canister is used instead of a grenade.

// Declaring the basic properties and parameters of the Living latex sprayer
/obj/item/gun/ballistic/revolver/latexpulv  //this is only used for underbarrel grenade launchers at the moment, but admins can still spawn it if they feel like being assholes
	// launchers.dm parameters
	desc = "Sprayer for firing projectiles of nanites simulating latex"
	name = "Nanite latex sprayer"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "latex_pulv"
	inhand_icon_state = "latex_pulv"
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
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

	///Phrasing of the magazine in examine and notification messages; ex: magazine, box, etx
	magazine_wording = "living latex canister"
	///Phrasing of the cartridge in examine and notification messages; ex: bullet, shell, dart, etc.
	cartridge_wording = "living latex canister"

	/// Verbs to describe attacks, using only "splashes on" because there probably won't be more than one shot. [[Big shot]].
	attack_verb_continuous = list("splashes on")
	attack_verb_simple = list("splashes on")

	/// ERP properties section
	var/list/latexsprayerstates = list("opened", "closed", "handed")
	var/pulv_state = null
	var/chipslotisclosed = TRUE
	var/glass_states = list("trans", "solid", "nocan")

	/////////////////////
	// Overlay Objects //
	/////////////////////
	var/mutable_appearance/module_overlay
	var/mutable_appearance/modulerack_overlay
	var/mutable_appearance/glass_overlay
	var/mutable_appearance/hydraulics_overlay
	var/mutable_appearance/latex_overlay

// Initialize
/obj/item/gun/ballistic/revolver/latexpulv/Initialize(mapload)
	. = ..()
	pulv_state = "[initial(icon_state)]_[latexsprayerstates[1]]"
	icon_state = pulv_state

	chambered = null // Pulv mustbe empty at spawn


	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

	module_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "module", BELOW_MOB_LAYER)
	module_overlay.name = "module_overlay"
	modulerack_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "module_rack", BELOW_MOB_LAYER)
	modulerack_overlay.name = "modulerack_overlay"
	glass_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "glass_opened_nocan", BELOW_MOB_LAYER)
	glass_overlay.name = "glass_overlay"
	hydraulics_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "hydraulics", BELOW_MOB_LAYER)
	hydraulics_overlay.name = "hydraulics_overlay"
	latex_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi', "latex_opened_black", BELOW_MOB_LAYER)
	latex_overlay.name = "latex_overlay"

	add_overlay(glass_overlay)
	add_overlay(hydraulics_overlay)
	update_overlays()
	update_glass_latex_overlays()

// Initialize a twohanded wielding component
/obj/item/gun/ballistic/revolver/latexpulv/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=12, icon_wielded="[initial(icon_state)]_[latexsprayerstates[3]]")

// Code for handle an equip proc
/obj/item/gun/ballistic/revolver/latexpulv/equipped(mob/living/user, slot)
	. = ..()

// Code for hanlde a drop proc
/obj/item/gun/ballistic/revolver/latexpulv/dropped(mob/user)
	. = ..()

// Definition of the firing pin class
/obj/item/firing_pin/latexpulvmodule
	name = "latex nanite chip"
	desc = "A small authentication device, to be inserted into a nanite latex gun slot to allow operation. Contains a nanite management program."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "pulv_module"
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
	var/ghost_ai_player = null // Varialble to store a ghost player who can take a role of AI on the living latex items

// Latex Canister Receiver Class definition for Living latex sprayer
/obj/item/ammo_box/magazine/internal/latexbinreciever
	name = "Living latex sprayer internal magazine"
	ammo_type = /obj/item/ammo_casing/latexbin // A special type of ammunition. Defined below in code
	caliber = CALIBER_40MM // Look's like we don't need to set up our caliber for this gun
	max_ammo = 1 // Only one canister can be installed in a Living latex sprayer at a time

/obj/item/ammo_box/magazine/internal/latexbinreciever/Initialize(mapload)
	. = ..()
	stored_ammo = list()

// Latex Canister Class definition for Latex sprayer. Single Shot Latex sprayer Ammunition
/obj/item/ammo_casing/latexbin
	name = "living latex canister"
	desc = "A canister filled with a nanites. Used for firing a nanite latex sprayer. The canister is single-shot and cannot be refilled."
	caliber = CALIBER_40MM // Look's like we don't need to set up our caliber for this gun
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "latexbin"
	projectile_type = /obj/projectile/bullet/livinglatexball
	var/list/latex_color_list = list("black", "pink", "teal", "yellow", "red", "green")
	var/latexcolors = null //List for color for color change menu
	var/latex_color = "black"
	var/list/latexbin_states = list("full","empty")
	var/latexbin_state = null
	var/color_changed = TRUE

//Latex bin init
/obj/item/ammo_casing/latexbin/Initialize()
	. = ..()
	populate_latex_colors()

	//random color variation on start. Because why not?
	latex_color = pick(latex_color_list)
	update_icon_state()
	update_icon()

	var/obj/item/ammo_casing/latexbin/B = src
	var/obj/projectile/bullet/livinglatexball/P = B.loaded_projectile
	P.latex_ball_color = latex_color
	latexbin_state = "[initial(icon_state)]_[latex_color]_[latexbin_states[1]]"
	icon_state = "[latexbin_state]"

//Latex bin examine
/obj/item/ammo_casing/latexbin/examine(mob/user)
	.=..()
	if(color_changed == FALSE)
		. += "<span class='notice'>Alt-Click \the [src.name] to customize it.</span>"

// Latex ball class definition
/obj/projectile/bullet/livinglatexball
	name ="living latexball"
	desc = "USE A LIVING LATEX SPRAYER"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state= "latex_projectile"
	damage = 0 // Living latex ball does not damage targets
	nodamage = TRUE // Duplicate the lack of damage with a special parameter
	hitsound = 'sound/weapons/pierce.ogg' // LAMELLA TODO: Need a hit sound
	hitsound_wall = "ricochet" // LAMELLA TODO: Need a hit wall sound
	embedding = null
	shrapnel_type = null
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	shrapnel_type = /obj/item/shrapnel/livinglatexball
	ricochets = 0
	ricochets_max = 0
	ricochet_chance = 0
	var/list/latexprogram = list() // List of item types that are recorded in the latex program
	var/latex_ball_color = "black" // Default latex color
	range = 4 // max range befor latex ball drops down

// Latex balloon initialization. Set color
/obj/projectile/bullet/livinglatexball/Initialize(mapload)
	. = ..()
	icon_state = "[initial(icon_state)]_[latex_ball_color]"
	update_icon_state()

// Icon state update handler
/obj/projectile/bullet/livinglatexball/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[latex_ball_color]"

// Handler for the event when the shot has reached the maximum distance. Drop decal on the floor
/obj/projectile/bullet/livinglatexball/on_range()
	if(isopenturf(src.loc))
		new /obj/effect/decal/cleanable/latexdecal(loc, latex_ball_color)
	. = ..()


// LAMELLA TODO: Need a general special effect setting
// Defines of the special effect of being hit by live latex
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

// Hit handler
/obj/projectile/bullet/livinglatexball/on_hit(mob/target, blocked = FALSE)
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
	else if(isopenturf(target.loc))
		new /obj/effect/decal/cleanable/latexdecal(loc, latex_ball_color)


	return BULLET_ACT_HIT



//////////////////////////////////////////
/// LIVING LATEX SPRAYER LOGIC SECTION ///
//////////////////////////////////////////
// Overlay state handler
/obj/item/gun/ballistic/revolver/latexpulv/proc/update_glass_latex_overlays()

	var/latex_new_icon_state = "latex"
	var/glass_new_icon_state = "glass"
	var/glass_postfix = null
	var/color = "black"
	var/obj/item/ammo_casing/latexbin/A
	var/obj/projectile/bullet/livinglatexball/P

	if(chambered)
		A = chambered
		if(A.loaded_projectile != null)
			P = A.loaded_projectile
			if(P != null)
				A.latex_color = P.latex_ball_color
				color = A.latex_color
				glass_postfix = "trans"
		else
			glass_postfix = "solid"
	else
		glass_postfix = "nocan"

	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[1]]") // Pulv opened
		if(P)
			latex_new_icon_state = "[latex_new_icon_state]_[latexsprayerstates[1]]_[color]"
		else
			latex_new_icon_state = "no latex in canister - no icon"
		glass_new_icon_state = "[glass_new_icon_state]_[latexsprayerstates[1]]_[glass_postfix]"
		if(chambered)
			cut_overlay(hydraulics_overlay)
		else
			add_overlay(hydraulics_overlay)
	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[2]]") // Pulv closed
		if(P)
			latex_new_icon_state = "[latex_new_icon_state]_[latexsprayerstates[2]]_[color]"
		else
			latex_new_icon_state = "no latex in canister - no icon"
		glass_new_icon_state = "[glass_new_icon_state]_[latexsprayerstates[2]]_[glass_postfix]"
		cut_overlay(hydraulics_overlay)
	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[3]]") // Pulv handed
		if(P)
			latex_new_icon_state = "[latex_new_icon_state]_[latexsprayerstates[3]]_[color]"
		else
			latex_new_icon_state = "no latex in canister - no icon"
		glass_new_icon_state = "[glass_new_icon_state]_[latexsprayerstates[3]]_[glass_postfix]"
		cut_overlay(hydraulics_overlay)


	if(latex_overlay.icon_state != latex_new_icon_state)
		cut_overlay(latex_overlay)
		latex_overlay.icon_state = "[latex_new_icon_state]"
		add_overlay(latex_overlay)
	if(glass_overlay.icon_state != glass_new_icon_state)
		cut_overlay(glass_overlay)
		glass_overlay.icon_state = "[glass_new_icon_state]"
		add_overlay(glass_overlay)
	icon_state = pulv_state
	update_overlays()

// Chip slot open and close handler
/obj/item/gun/ballistic/revolver/latexpulv/AltClick(mob/user)
	if(!ishuman(user))
		return
	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[2]]") // Pulv closed, need to open
		user.visible_message("You couldn't do anything with [src]... All controls seem to be locked")
		return
	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[3]]") // Pulv handed, need to unwield from twohands
		user.visible_message("You need to free your hand to interact with [src].")
		return
	if(!chipslotisclosed)
		chipslotisclosed = TRUE
		cut_overlay(modulerack_overlay)
		cut_overlay(module_overlay)
		update_overlays()
		user.visible_message("You close chip reciever.", "[user.name] close chip reciever.")
		return
	else
		chipslotisclosed = FALSE
		add_overlay(modulerack_overlay)
		if(pin)
			add_overlay(module_overlay)
		update_overlays()
		user.visible_message("You open chip reciever. It is [pin ? "has chip" : "empty"]" , "[user.name] open chip reciever. It is [pin ? "has chip" : "empty"]")
		return

// Empty Hand Attack Handler
/obj/item/gun/ballistic/revolver/latexpulv/attack_hand(mob/user)
	if(!ishuman(user))
		return

	if(src.loc == user)
		if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[2]]") // Pulv closed, need to open
			visible_message("You couldn't do anything with [src]... All controls seem to be locked", TRUE)
			return
		if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[3]]") // Pulv handed, need to unwield from twohands
			visible_message("You need to free your hand to interact with [src].", TRUE)
			return

		// If the chip slot is open, then we take the chip into an empty hand.
		if(!chipslotisclosed && pin)
			user.put_in_hands(pin)
			pin.add_fingerprint(user)
			user.visible_message(span_notice("[user] removes [pin] from [src]."), span_notice("You remove [pin] from [src]."))
			cut_overlay(module_overlay)
			update_overlays()
			pin = null
			update_glass_latex_overlays()
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

			add_overlay(hydraulics_overlay)
			update_glass_latex_overlays()
			update_overlays()
			update_appearance()
			SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
			return
	else
		..()

// Chip and canister action handler
/obj/item/gun/ballistic/revolver/latexpulv/attackby(obj/item/A, mob/user, params)
	// Blocking the default behavior of the weapon
	//..()

	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[2]]") // Pulv closed, need to open
		user.visible_message("You couldn't do anything with [src]... All controls seem to be locked")
		return
	if(pulv_state == "[initial(icon_state)]_[latexsprayerstates[3]]") // Pulv handed, need to unwield from twohands
		user.visible_message("You need to free your hand to interact with [src].")
		return

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
				cut_overlay(hydraulics_overlay)
				cut_overlay(glass_overlay)
				if(!chambered.loaded_projectile)
					glass_overlay.icon_state = "glass_opened_trans"
				else
					glass_overlay.icon_state = "glass_opened_solid"
				update_glass_latex_overlays()
				update_overlays()
				update_appearance()
			return

	// Chip click handler
	if(istype(A, /obj/item/firing_pin/latexpulvmodule))
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
				update_overlays()
				update_glass_latex_overlays()
				return
	else
		to_chat(user, span_warning("[src]'s chip slot isn't opened!"))
		return

	// Space for other handlers, for example emag
	update_glass_latex_overlays()
	update_appearance()
	A.update_appearance()
	return

// Handler for spreading live latex to target.
/obj/projectile/bullet/livinglatexball/proc/livinglatexspread(mob/target)
	var/mob/living/carbon/human/H = target

	//Turn target mob to south direction
	H.setDir(SOUTH)

	// //Immobilize target for latex animation duration
	//H.Immobilize(10000, TRUE)

	//Paralyze target for latex animation duration
	H.Paralyze(10000, TRUE)


	//H.livniglatexspread (10000, TRUE)

	var/list/items = list()
	for (var/T in src.latexprogram)

		var/obj/item/I = T
		I = new I
		items.Add(I)

	for(var/obj/item/I in items)
		var/slot = I.slot_flags
		var/obj/item/E = target.get_item_by_slot(slot)
		if(E != null)
			target.dropItemToGround(E, TRUE, TRUE)
			qdel(E)
		target.equip_to_slot(I, slot)
	target.regenerate_icons()

//The event just before the shot is fired. The moment of recording the program in the projectile
/obj/item/gun/ballistic/revolver/latexpulv/before_firing(atom/target, mob/user)
	//Здесь будет выполняться запись программы в сам выстрел латекса
	if(src.chambered)
		var/obj/item/ammo_casing/latexbin/L = src.chambered
		if(L.loaded_projectile)
			var/obj/projectile/bullet/livinglatexball/B = L.loaded_projectile
			if(!src.pin) // Для безопасности, проверим, что чип установлен
				return
			var/obj/item/firing_pin/latexpulvmodule/F = src.pin
			B.latexprogram = F.latexprogram
	return

// The handler for the chamber. Returning an empty canister to the chamber
/obj/item/gun/ballistic/revolver/latexpulv/handle_chamber(empty_chamber, from_firing, chamber_next_round)
	. = ..()
	src.chambered = src.magazine.stored_ammo
	update_glass_latex_overlays()

/// Latex color changing
// Create colors for color change menu items
/obj/item/ammo_casing/latexbin/proc/populate_latex_colors()
	latexcolors = list(
		"black" = image(icon = src.icon, icon_state = "latexbin_black_full"),
		"pink" = image(icon = src.icon, icon_state = "latexbin_pink_full"),
		"teal" = image(icon = src.icon, icon_state = "latexbin_teal_full"),
		"green" = image(icon = src.icon, icon_state = "latexbin_green_full"),
		"yellow" = image(icon = src.icon, icon_state = "latexbin_yellow_full"),
		"red" = image(icon = src.icon, icon_state = "latexbin_red_full"))

// Checking if we can use the menu
/obj/item/ammo_casing/latexbin/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

// Radial menu handler for color selection by using altclick
/obj/item/ammo_casing/latexbin/AltClick(mob/user, obj/item/I)
	. = ..()
	if(.)
		return FALSE

	var/choice = show_radial_menu(user,src, latexcolors, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
	if(!choice)
		return TRUE
	latex_color = choice
	update_icon()

	var/obj/item/ammo_casing/latexbin/B = src
	var/obj/projectile/bullet/livinglatexball/P = B.loaded_projectile
	if(P)
		P.latex_ball_color = latex_color
		P.update_icon_state()
	color_changed = TRUE
	to_chat(user, span_notice("You change the color of the latex in the bin."))
	return TRUE

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

// Extension for the icon state update handler
/obj/item/gun/ballistic/revolver/latexpulv/update_icon_state()
	..()
	icon_state = "[pulv_state]"



// Extension for the icon state update handler
/obj/item/ammo_casing/latexbin/update_icon_state()
	..()
	if(loaded_projectile)
		icon_state = "[initial(icon_state)]_[latex_color]_[latexbin_states[1]]"
	else
		icon_state = "[initial(icon_state)]_[latex_color]_[latexbin_states[2]]"

// Latex Sprayer Use Handler
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

// Latex Sprayer Use Handler by right click
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

// Local version of the projectile readiness processor
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
/obj/item/book/manual/latex_pulv_manual
	name = "latex kit instructions"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state ="paper"
	worn_icon_state = "paper"
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

// Manulal initialization handler. Fill in the content of the manual
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

//////////////////////////////////////
/// LIVING LATEX DISSOLVER SECTION ///
//////////////////////////////////////
/obj/item/reagent_containers/spray/livinglatexdissolver
	name = "Nanite latex dissolver"
	desc = "The special solvent that dissolves nanites, that used for the imitation of living latex. Safe for skin and mucous membranes."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "latex_dissolver"
	inhand_icon_state = "latex_dissolver"
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	volume = 10
	stream_range = 2
	amount_per_transfer_from_this = 5
	list_reagents = list(/datum/reagent/consumable/livinlatexdissolver = 10)


/// Reagent for Removing Live Latex Items
/datum/reagent/consumable/livinlatexdissolver
	name = "Nanite latex solvent"
	description = "A chemical agent used for dissolve a nanite latex materials."
	color = "#549681" // rgb: 84, 150, 129
	taste_description = "spicy and sour"
	penetrates_skin = NONE
	ph = 7.4
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

// Handler applying dissolver to mob
/datum/reagent/consumable/livinlatexdissolver/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!ishuman(exposed_mob))
		return

	var/mob/living/carbon/victim = exposed_mob

	if(methods & (TOUCH|VAPOR))
		for(var/obj/item/W in victim)
			if(LAZYLEN(W.custom_materials) > 0)
				for(var/datum/material/M in W.custom_materials)
					if(istype(M, /datum/material/livinglatex))
						qdel(W)
		victim.regenerate_icons()

// Living latex material
/datum/material/livinglatex
	name = "living latex"
	desc = "living latex"
	color = "#242424"
	greyscale_colors = "#242424"
	strength_modifier = 0.85
	sheet_type = /obj/item/stack/sheet/plastic // LAMELLA TODO: вероятно нам потребуется специальная визуализация для материала
	categories = list(MAT_CATEGORY_ITEM_MATERIAL=TRUE)
	value_per_unit = 0.0125
	beauty_modifier = -0.01
	armor_modifiers = list(MELEE = 1.5, BULLET = 1.1, LASER = 0.3, ENERGY = 0.5, BOMB = 1, BIO = 1, RAD = 1, FIRE = 1.1, ACID = 1)

// Handler for accidental material consumption
/datum/material/livinglatex/on_accidental_mat_consumption(mob/living/carbon/eater, obj/item/food)
	//LAMELLA TODO: Нужно прикинуть что будет если схавать живой латекс.
	eater.reagents.add_reagent(/datum/reagent/livinglatex, rand(6, 8))
	food?.reagents?.add_reagent(/datum/reagent/livinglatex, food.reagents.total_volume*(2/5))
	return TRUE

// Living latex reagent
/datum/reagent/livinglatex
	name = "living latex"
	description = "the latex based components mixed with nanites."
	color = "#242424"
	taste_description = "latex"
	ph = 6
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

//////////////////////////
/// LIVING LATEX DECAL ///
//////////////////////////
// General description of the class of latex decal
/obj/effect/decal/cleanable/latexdecal
	name = "living latex"
	desc = "It's greasy. Looks like Beepsky made another mess."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/latex_pulv.dmi'
	icon_state = "latex_decal"
	//random_icon_states = list("floor1", "floor2", "floor3", "floor4", "floor5", "floor6", "floor7")
	blood_state = BLOOD_STATE_OIL
	bloodiness = BLOOD_AMOUNT_PER_DECAL
	beauty = -100
	clean_type = CLEAN_TYPE_BLOOD

// Latex initialization, add latex reagent to the decal
/obj/effect/decal/cleanable/latexdecal/Initialize(mapload, var/color = "black")
	. = ..()
	reagents.add_reagent(/datum/reagent/livinglatex, 30)
	icon_state = "[initial(icon_state)]_[color]"

// Handler for affecting something on the decall
/obj/effect/decal/cleanable/latexdecal/attackby(obj/item/I, mob/living/user)

	// If it's hot, then we set fire to the latex
	var/attacked_by_hot_thing = I.get_temperature()
	if(attacked_by_hot_thing)
		visible_message(span_warning("[user] tries to ignite [src] with [I]!"), span_warning("You try to ignite [src] with [I]."))
		log_combat(user, src, (attacked_by_hot_thing < 480) ? "tried to ignite" : "ignited", I)
		fire_act(attacked_by_hot_thing)
		return
	return ..() // Otherwise the default actions

// Handler for the decal's ability to ignite
/obj/effect/decal/cleanable/latexdecal/fire_act(exposed_temperature, exposed_volume)
	if(exposed_temperature < 480)
		return
	visible_message(span_danger("[src] catches fire!"))
	var/turf/T = get_turf(src)
	qdel(src)
	new /obj/effect/hotspot(T)

// Adding a slip effect when driving on a decal without anti-slip protection
/obj/effect/decal/cleanable/latexdecal/slippery/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, 80, (NO_SLIP_WHEN_WALKING | SLIDE))
