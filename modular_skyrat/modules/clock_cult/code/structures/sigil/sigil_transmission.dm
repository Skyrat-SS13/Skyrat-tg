/obj/structure/destructible/clockwork/sigil/transmission
	name = "sigil of transmission"
	desc = "A strange sigil, swirling with a yellow light."
	clockwork_desc = "A glorious sigil used to power Rat'varian structures."
	icon_state = "sigiltransmission"
	effect_stand_time = 10
	idle_color = "#f1a746"
	invokation_color = "#f5c529"
	pulse_color = "#f8df8b"
	fail_color = "#f1a746"
	looping = TRUE		//Lopp while in use!
	living_only = FALSE	//This can affect mechs too!
	var/list/linked_structures

/obj/structure/destructible/clockwork/sigil/transmission/Initialize(mapload)
	. = ..()
	linked_structures = list()
	for(var/obj/structure/destructible/clockwork/gear_base/GB in range(src, SIGIL_TRANSMISSION_RANGE))
		GB.link_to_sigil(src)
	START_PROCESSING(SSobj, src)

/obj/structure/destructible/clockwork/sigil/transmission/Destroy()
	STOP_PROCESSING(SSobj, src)
	for(var/obj/structure/destructible/clockwork/gear_base/GB as anything in linked_structures)
		GB.unlink_to_sigil(src)
	return ..()

//We handle updating power, so you don't have to
/obj/structure/destructible/clockwork/sigil/transmission/process()
	for(var/obj/structure/destructible/clockwork/gear_base/GB as anything in linked_structures)
		if(GB.transmission_sigils[1] == src)	//Make sure we are the master sigil
			GB.update_power()

/obj/structure/destructible/clockwork/sigil/transmission/can_affect(atom/movable/AM)
	return (ismecha(AM) || iscyborg(AM) || ishuman(AM))

/obj/structure/destructible/clockwork/sigil/transmission/apply_effects(atom/movable/AM)
	if(ismecha(AM))
		var/obj/vehicle/sealed/mecha/M = AM
		var/is_clockie = FALSE
		for(var/mob/living/living_mob in M.occupants)
			if(!(FACTION_CLOCK in living_mob.faction))
				continue
			is_clockie = TRUE
			break
		var/obj/item/stock_parts/cell/C = M.cell
		if(!C)
			return
		if(is_clockie)
			if(C.charge < C.maxcharge && GLOB.clock_power > 40)
				M.give_power(C.chargerate)
				GLOB.clock_power -= 40
		else
			if(C.charge > 0)
				M.use_power(C.chargerate)
				GLOB.clock_power += 20
	else if(iscyborg(AM))
		var/mob/living/silicon/robot/R = AM
		var/obj/item/stock_parts/cell/C = R.get_cell()
		if(!C)
			return
		if(FACTION_CLOCK in R.faction)
			if(GLOB.clock_power >= 40)
				if(C.charge < C.maxcharge)
					C.give(C.chargerate)
					GLOB.clock_power -= 40
		else
			if(C.charge > C.chargerate)
				C.give(-C.chargerate)
				GLOB.clock_power += 40
	else if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		var/list/L = H.get_contents()
		var/applied_charge = FALSE
		for(var/obj/item in L)
			var/obj/item/stock_parts/cell/C = item.get_cell()
			if(C)
				if(FACTION_CLOCK in H.faction)
					if(GLOB.clock_power >= 40)
						if(C.charge < C.maxcharge)
							C.give(C.chargerate)
							applied_charge = TRUE
				else
					if(C.charge > C.chargerate)
						C.give(-C.chargerate)
						GLOB.clock_power += 40
		if(applied_charge)
			GLOB.clock_power -= 40
