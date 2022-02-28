/obj/item/gun/energy/disabler
	cell_type = /obj/item/stock_parts/cell/super


/obj/item/gun/energy/disabler/upgraded/proc/addammotype(ammo_to_add, name_to_append)
	ammo_type += new ammo_to_add(src)
	name += " of [name_to_append]"
/obj/item/gun/energy/disabler/upgraded
	var/overheat_time = 16
	var/holds_charge = FALSE
	var/unique_frequency = FALSE
	var/overheat = FALSE
	var/mob/holder
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/skyrat/proto) // SKYRAT EDIT: 	ammo_type = list(/obj/item/ammo_casing/energy/disabler)


	var/max_mod_capacity = 100
	var/list/modkits = list()
	var/upgrade_name
	var/amount = 0
	var/maxamount = 3
	var/emission_amount = 1
	var/recharge_timerid
	var/backblast = FALSE
	name = "upgraded disabler"
	Initialize(mapload)
		. = ..()
		var/ammo_to_load = /obj/item/ammo_casing/energy/laser/scatter/disabler/skyrat
		ammo_type += new ammo_to_load(src)
		if(backblast)
			AddElement(/datum/element/backblast, 2, 2, 1)

	shoot_live_shot(mob/living/user, pointblank = 0, atom/pbtarget = null, message = 1)
		. = ..()
		var/obj/item/ammo_casing/energy/shot = ammo_type[select]
		var/reload_speed = rand(shot.lower_reload_speed, shot.upper_reload_speed)
		attempt_reload(reload_speed)

	equipped(mob/user)
		. = ..()
		holder = user
		if(!can_shoot())
			attempt_reload()
	proc/attempt_reload(recharge_time)
		if(!cell)
			return
		if(overheat)
			return
		if(!recharge_time)
			recharge_time = overheat_time
		overheat = TRUE
		emissions(recharge_time, emission_amount)
		var/carried = 0
		if(!unique_frequency)
			for(var/obj/item/gun/energy/disabler/upgraded/K in loc.get_all_contents())
				if(!K.unique_frequency)
					carried++

			carried = max(carried, 1)
		else
			carried = 1

		deltimer(recharge_timerid)
		recharge_timerid = addtimer(CALLBACK(src, .proc/reload), recharge_time * carried, TIMER_STOPPABLE)

	emp_act(severity)
		return
	proc/emissions(recharge_time, emission_amount)
		var/turf/open/T = get_turf(src)
		if(!istype(T) || T.planetary_atmos || T.return_air().return_pressure() > (WARNING_HIGH_PRESSURE - 10))
			return
		var/datum/gas_mixture/emissions = new
		ADD_GAS(/datum/gas/carbon_dioxide, emissions.gases)
		emissions.gases[/datum/gas/carbon_dioxide][MOLES] = emission_amount + (recharge_time / 64)
		emissions.temperature = BODYTEMP_HEAT_WARNING_3 // They get hot!
		T.assume_air(emissions)
		T.air_update_turf(FALSE, FALSE)
		if(prob(33))
			do_sparks(5,TRUE,src)
	proc/reload()
		cell.give(cell.maxcharge)
		if(!suppressed)
			playsound(src.loc, 'sound/arcade/heal.ogg', 60, TRUE)
		else
			to_chat(loc, span_warning("[src] silently charges up."))
		update_appearance()
		SEND_SIGNAL(src, COMSIG_UPDATE_AMMO_HUD)
		overheat = FALSE
	select_fire(mob/living/user)
		..()
