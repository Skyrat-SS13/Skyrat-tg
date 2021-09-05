/obj/item/metal_density_scanner
	name = "metal density scanner"
	desc = "A handheld device used for detecting and measuring density of nearby metals."
	icon = 'icons/obj/metal_scanner.dmi'
	icon_state = "mds"
	inhand_icon_state = "multitool"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	var/turned_on = FALSE
	var/last_scan = METAL_DENSITY_NONE
	//Variables for the advanced kinds
	var/has_readout = FALSE
	var/is_reading_out = FALSE
	var/next_readout_scan = 0
	var/readout_progress = 0

/obj/item/metal_density_scanner/update_icon_state()
	. = ..()
	if(!turned_on)
		icon_state = initial(icon_state)
	else
		if(is_reading_out)
			icon_state = "[initial(icon_state)]_on[last_scan]read"
		else
			icon_state = "[initial(icon_state)]_on[last_scan]"

/obj/item/metal_density_scanner/Destroy()
	if(turned_on)
		turn_off()
	return ..()

/obj/item/metal_density_scanner/proc/turn_on()
	turned_on = TRUE
	do_scan()
	update_icon()
	START_PROCESSING(SSobj, src)

/obj/item/metal_density_scanner/proc/turn_off()
	turned_on = FALSE
	update_icon()
	STOP_PROCESSING(SSobj, src)

/obj/item/metal_density_scanner/proc/do_scan()
	var/turf/my_turf = get_turf(src)
	var/datum/ore_node/ON = GetOreNodeInScanRange(my_turf)
	if(ON)
		last_scan = ON.GetScannerDensity(my_turf)
	else
		last_scan = METAL_DENSITY_NONE
	update_icon()

/obj/item/metal_density_scanner/process()
	do_scan()
	if(is_reading_out)
		readout_progress += 20
		if(readout_progress>=100)
			readout_progress = 0
			next_readout_scan = world.time + 1 MINUTES
			is_reading_out = FALSE
			print_readout()
			update_icon()

/obj/item/metal_density_scanner/proc/print_readout()
	var/turf/my_turf = get_turf(src)
	var/datum/ore_node/ON = GetOreNodeInScanRange(my_turf)
	if(!ON)
		return
	playsound(my_turf, 'sound/items/poster_being_created.ogg', 100, 1)
	var/obj/item/paper/P = new /obj/item/paper(my_turf)
	P.name = "metal density readout"
	P.info = "<CENTER><B>METAL DENSITY READOUT</B></CENTER><BR>"
	P.info += "<B>GPS coordinates: x:[my_turf.x], y:[my_turf.y], z:[my_turf.z]</B><BR>"
	if(ON)
		P.info += ON.GetScannerReadout(my_turf)
	else
		P.info += "No ores detected at the coordinates"
	P.update_icon()
	//We're inside a storage? Put the printout in the storage
	if(SEND_SIGNAL(loc, COMSIG_CONTAINS_STORAGE))
		P.forceMove(loc)
	//We're held by a human? Try and put it in his hand
	else if(ishuman(loc))
		var/mob/living/carbon/human/H = loc
		H.put_in_hands(P)

/obj/item/metal_density_scanner/examine(mob/user)
	. = ..()
	if(has_readout)
		. += "<span class='notice'>Alt-click to use the readout function.</span>"
	if(turned_on)
		switch(last_scan)
			if(METAL_DENSITY_NONE)
				. += "<span class='notice'>Not recieving any feedback.</span>"
			if(METAL_DENSITY_LOW)
				. += "<span class='notice'>Metal density levels are low.</span>"
			if(METAL_DENSITY_MEDIUM)
				. += "<span class='notice'>Metal density levels are medium.</span>"
			if(METAL_DENSITY_HIGH)
				. += "<span class='boldnotice'>Metal density levels are high.</span>"

/obj/item/metal_density_scanner/attack_self(mob/user)
	if(is_reading_out)
		return
	if(turned_on)
		turn_off()
	else
		turn_on()
	playsound(user, turned_on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 20, TRUE)
	update_icon()
	to_chat(user, "<span class='notice'>[icon2html(src, user)] You switch [turned_on ? "on" : "off"] [src].</span>")

/obj/item/metal_density_scanner/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(!has_readout || is_reading_out)
		return
	if(!turned_on)
		to_chat(user, "<span class='warning'>[src] must be on turned on to make a readout!</span>")
		return TRUE
	if(next_readout_scan > world.time)
		to_chat(user, "<span class='warning'>[src] readout function is still recharging!</span>")
		return TRUE
	playsound(user, 'sound/machines/terminal_processing.ogg', 50, TRUE)
	to_chat(user, "<span class='notice'>You turn on [src]'s readout function.</span>")
	is_reading_out = TRUE
	update_icon()
	return TRUE

/obj/item/metal_density_scanner/adv
	name = "advanced metal density scanner"
	desc = "A handheld device used for detecting and measuring density of nearby metals. This one had a built-in readout function."
	icon_state = "mds_adv"
	has_readout = TRUE
