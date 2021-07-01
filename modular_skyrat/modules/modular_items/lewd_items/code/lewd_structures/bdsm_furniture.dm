/obj/structure/bed/bdsm_bed
	name = "bdsm bed"
	desc = "This is a latex bed with D-rings on sides. Looks comfortable."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	icon_state = "bdsm_bed"

/obj/item/bdsm_bed_kit
	name = "bdsm bed construction kit"
	desc = "A wrench is required to construct."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	throwforce = 0
	icon_state = "bdsm_bed_kit"
	var/unwrapped = 0
	w_class = WEIGHT_CLASS_HUGE

/obj/item/bdsm_bed_kit/attackby(obj/item/P, mob/user, params) //constructing a bed here.
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		if (!(item_flags & IN_INVENTORY))
			to_chat(user, "<span class='notice'>You start to fasten the frame to the floor and inflating latex pillows...</span>")
			if(P.use_tool(src, user, 8 SECONDS, volume=50))
				to_chat(user, "<span class='notice'>You construct the bdsm bed!</span>")
				var/obj/structure/bed/bdsm_bed/C = new
				C.loc = loc
				del(src)
			return

/obj/structure/bed/bdsm_bed/attackby(obj/item/P, mob/user, params) //deconstructing a bed. Aww(
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		to_chat(user, "<span class='notice'>You start to unfastening the frame of bed...</span>")
		if(P.use_tool(src, user, 8 SECONDS, volume=50))
			to_chat(user, "<span class='notice'>You take down the bdsm bed!</span>")
			var/obj/item/bdsm_bed_kit/C = new
			C.loc = loc
			del(src)
		return

/obj/structure/bed/bdsm_bed/post_buckle_mob(mob/living/M)
	density = TRUE
	//Push them up from the normal lying position
	M.pixel_y = M.base_pixel_y

/obj/structure/bed/bdsm_bed/post_unbuckle_mob(mob/living/M)
	density = FALSE
	//Set them back down to the normal lying position
	M.pixel_y = M.base_pixel_y + M.body_position_pixel_y_offset

/////////////////////
//X-Stand code here//
/////////////////////

/obj/structure/bed/x_stand
	name = "x stand"
	desc = "Why you even call it X stand? It doesn't even in X form. Anyway you can buckle someone to it"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	icon_state = "xstand"
	max_buckled_mobs = 1
	var/stand_state = "open"
	var/stand_open = FALSE
	var/list/stand_states = list("open" = "close", "close" = "open")
	var/state_thing = "open"
	var/static/mutable_appearance/xstand_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi', "xstand_overlay", LYING_MOB_LAYER)
	buckle_lying = NO_BUCKLE_LYING //We no need mob lying

//to make it have model when we constructing the thingy
/obj/structure/bed/x_stand/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

/obj/structure/bed/x_stand/update_icon_state()
    . = ..()
    icon_state = "[initial(icon_state)]_[stand_state? "open" : "close"]"

//X-Stand LBM interaction handler
/obj/structure/bed/x_stand/attack_hand(mob/living/user)
	var/mob/living/M = locate() in src.loc
	// X-Stand is empty?
	if(!has_buckled_mobs())
		// Is there someone on the X-Stand tile?
		if(M)
			// Can a mob in a X-Stand tile be buckled?
			if(M.can_buckle_to)
				user_buckle_mob(M, user, check_loc = TRUE)
			else
				// The X-Stand is empty, but there is a mob in the X-Stand tile that cannot be buckled
				// A place to report the impossibility to buckle the current mob in X-Stand
		else
			// The stand is empty, there is no one in the tile. We just change the state of the stand.
			toggle_mode(user)
	else
		// The X-Stand is not empty. Get the mob in the X-Stand and try to unbuckle it.
		var/mob/living/buckled_mob = buckled_mobs[1]
		user_unbuckle_mob(buckled_mob, user)


// Handler for attempting to unbukle a mob from a X-Stand
/obj/structure/bed/x_stand/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	// Let's make sure that the X-Stand is in the correct state
	if(stand_state == "open")
		toggle_mode(user)
	var/mob/living/M = buckled_mob
	if(M)
		if(M != user)
			if(!do_after(user, 5 SECONDS, M)) // Timer for unbuckling one mob with another mob
				// Place to describe failed attempt
				return FALSE
			// Description of a successful attempt
			M.visible_message("<span class='notice'>[user] unbuckles [M] from [src].</span>",\
				"<span class='notice'>[user] unbuckles you from [src].</span>",\
				"<span class='hear'>You hear metal clanking.</span>")
			// Description of a successful mob attempt to unbuckle one mob with another mob
		else
			if(!do_after(user, 2 MINUTES, M)) // Timer to unbuckle the mob by itself
				// Place to describe failed attempt
				return FALSE
			// Description of a successful mob attempt to unbuckle itself
			user.visible_message("<span class='notice'>You unbuckle yourself from [src].</span>",\
				"<span class='hear'>You hear metal clanking.</span>")
		add_fingerprint(user)
		if(isliving(M.pulledby))
			var/mob/living/L = M.pulledby
			L.set_pull_offsets(M, L.grab_state)
		unbuckle_mob(buckled_mob)
		toggle_mode(user)
	return M

// Handler for attempting to buckle a mob into a X-Stand
/obj/structure/bed/x_stand/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	// Let's make sure that the X-Stand is in the correct state
	if(stand_state == "close")
		toggle_mode(user)
		//return  // Uncomment if it is necessary to "open" the X-Stand as a separate action before buckling

	// Is buckling even possible? Do a full suite of checks.
	if(!is_user_buckle_possible(M, user, check_loc))
		return FALSE
	add_fingerprint(user)

	// If the mob we're attempting to buckle is not stood on this atom's turf and it isn't the user buckling themselves,
	// we'll try it with a 2 second do_after delay.
	if(M != user)
		// Place to describe an attempt to buckle a mob
		if(!do_after(user, 5 SECONDS, M)) // Timer to buckle one mob by another
			// Place to describe a failed buckling attempt
			return FALSE

		// Sanity check before we attempt to buckle. Is everything still in a kosher state for buckling after the 3 seconds have elapsed?
		// Covers situations where, for example, the chair was moved or there's some other issue.
		if(!is_user_buckle_possible(M, user, check_loc))
			// A place to report the inability to buckle a mob
			return FALSE

		// Description of a successful attempt to buckle a mob by another mob
		M.visible_message("<span class='warning'>[user] starts buckling [M] to [src]!</span>",\
			"<span class='userdanger'>[user] starts buckling you to [src]!</span>",\
			"<span class='hear'>You hear metal clanking.</span>")
		// Place to insert a description of a successful attempt for a user mob
		buckle_mob(M, check_loc = check_loc)
		toggle_mode(user)

	else
		if(!do_after(user, 10 SECONDS, M)) // Timer to buckle the mob itself
			// Place to describe failed attempt
			return FALSE

		// Sanity check before we attempt to buckle. Is everything still in a kosher state for buckling after the 3 seconds have elapsed?
		// Covers situations where, for example, the chair was moved or there's some other issue.
		if(!is_user_buckle_possible(M, user, check_loc))
			// Place to report the inability to buckle
			return FALSE

		user.visible_message("<span class='warning'>You buckles yourself to [src]!</span>",\
			"<span class='hear'>You hear metal clanking.</span>")
		buckle_mob(M, check_loc = check_loc)
		toggle_mode(user)

// X-Stand state switch processing
/obj/structure/bed/x_stand/proc/toggle_mode(mob/user)
	state_thing = stand_states[state_thing]
	switch(state_thing)
		if("open")
			stand_state = "open"
			cut_overlay(xstand_overlay)
		if("close")
			stand_state = "close"
			add_overlay(xstand_overlay)
	add_fingerprint(user)
	update_icon_state()
	update_icon()
	playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)

//Place the mob in the desired position after buckling
/obj/structure/bed/x_stand/post_buckle_mob(mob/living/M)
	M.pixel_y = M.base_pixel_y
	M.pixel_x = M.base_pixel_x
	M.layer = BELOW_MOB_LAYER

//Restore the position of the mob after unbuckling.
/obj/structure/bed/x_stand/post_unbuckle_mob(mob/living/M)
	M.pixel_x = M.base_pixel_x + M.body_position_pixel_x_offset
	M.pixel_y = M.base_pixel_y + M.body_position_pixel_y_offset
	M.layer = initial(M.layer)

///////////////////////////
//xstand construction kit//
///////////////////////////

/obj/item/x_stand_kit
	name = "xstand construction kit"
	desc = "A wrench is required to construct."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/bdsm_furniture.dmi'
	throwforce = 0
	icon_state = "xstand_kit"
	var/unwrapped = 0
	w_class = WEIGHT_CLASS_HUGE

/obj/item/x_stand_kit/attackby(obj/item/P, mob/user, params) //constructing a bed here.
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		if (!(item_flags & IN_INVENTORY))
			to_chat(user, "<span class='notice'>You start to fasten the frame to the floor.</span>")
			if(P.use_tool(src, user, 8 SECONDS, volume=50))
				to_chat(user, "<span class='notice'>You construct the x-stand!</span>")
				var/obj/structure/bed/x_stand/C = new
				C.loc = loc
				del(src)
			return

/obj/structure/bed/x_stand/attackby(obj/item/P, mob/user, params) //deconstructing a bed. Aww(
	add_fingerprint(user)
	if(istype(P, /obj/item/wrench))
		to_chat(user, "<span class='notice'>You start to unfastening the frame of x-stand...</span>")
		if(P.use_tool(src, user, 8 SECONDS, volume=50))
			to_chat(user, "<span class='notice'>You take down the x-stand!</span>")
			var/obj/item/x_stand_kit/C = new
			C.loc = loc
			del(src)
		return
