/obj/structure/holosign/barrier/medical
	var/directional_mode = FALSE
	var/direction_locked = null

/obj/structure/holosign/barrier/medical/examine(mob/user)
	. = ..()
	if(directional_mode)
		var/direction_name
		switch(dir)
			if(NORTH)
				direction_name = "North"
			if(EAST)
				direction_name = "East"
			if(SOUTH)
				direction_name = "South"
			if(WEST)
				direction_name = "West"
		. += span_notice("Blocked Direction: [direction_name]")

/obj/structure/holosign/barrier/medical/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(force_allaccess)
		return TRUE
	if(istype(mover, /obj/vehicle/ridden))
		for(var/M in mover.buckled_mobs)
			if(ishuman(M))
				if(!CheckHuman(M, border_dir))
					return FALSE
	if(ishuman(mover))
		return CheckHuman(mover, border_dir)
	return TRUE

/obj/structure/holosign/barrier/medical/Bumped(atom/movable/AM, border_dir)
	. = ..()
	icon_state = "holo_medical"
	if(ishuman(AM) && !CheckHuman(AM, border_dir))
		if(buzzcd < world.time)
			playsound(get_turf(src),'sound/machines/buzz-sigh.ogg',65,TRUE,4)
			buzzcd = (world.time + 60)
		icon_state = "holo_medical-deny"

/obj/structure/holosign/barrier/medical/proc/CheckHuman(mob/living/carbon/human/sickboi, border_dir)
	var/threat = sickboi.check_virus()
	if(get_disease_severity_value(threat) > get_disease_severity_value(DISEASE_SEVERITY_MINOR))
		if(directional_mode && border_dir != direction_locked)
			return TRUE
		return FALSE
	return TRUE
