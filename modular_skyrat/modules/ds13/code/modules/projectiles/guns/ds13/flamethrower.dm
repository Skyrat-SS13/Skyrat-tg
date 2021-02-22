/obj/item/weapon/gun/spray/hydrazine_torch
	name = "PFM-100 Industrial Torch"
	desc = "A heavy duty liquid-fuel flamethrower, designed to run on hydrazine and operate in a vacuum. It can also run on ordinary gasoline, at reduced effectiveness."
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "hydetorch"
	item_state = "hydetorch"

	mag_insert_sound = 'sound/weapons/guns/interaction/torch_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/torch_magout.ogg'

	//This gun has no safety switch
	safety_state = FALSE

	var/obj/item/weapon/reagent_containers/glass/fuel_tank/tank

	var/fuel_per_second = 20
	var/consume_excess_fuel = TRUE	//When trying to consume more fuel than we have:
	//If true, consume all the fuel that remains, and then call it a failure
	//If false, don't consume anything and fail

	firemodes = list(
		list(mode_name="flamethrower",mode_type = /datum/firemode/sustained/spray/flame, consume_excess_fuel = TRUE),
		list(mode_name="incendiary blast", mode_type = /datum/firemode/incendiary, ammo_cost = 4, windup_time = 0.5 SECONDS, windup_sound = 'sound/weapons/guns/fire/pulse_grenade_windup.ogg', projectile_type = /obj/item/projectile/bullet/impact_grenade/incendiary, fire_delay=20, consume_excess_fuel = FALSE))

	matter = list(MATERIAL_STEEL = 5000, MATERIAL_GLASS = 1750, MATERIAL_SILVER = 500)

	//These vars are read by firemode and set in update_fuel
	spray_type = /datum/extension/spray/flame	//Extension and particle defines are located in abilities/spray/fire.dm
	var/radial_spray_type = /datum/extension/spray/flame/radial
	var/temperature = T0C + 2600

	//Used for the alt fire
	var/blast_projectile = /obj/item/projectile/bullet/impact_grenade/incendiary

	var/pilot_light_fuelcost = 0.1
	var/pilot_light = FALSE

	//While firing, we periodically play a fire sound
	var/sound_interval = 0.6 SECOND



	fire_sound = list('sound/weapons/guns/fire/flmthrowr_01.ogg',
	'sound/weapons/guns/fire/flmthrowr_02.ogg',
	'sound/weapons/guns/fire/flmthrowr_03.ogg',
	'sound/weapons/guns/fire/flmthrowr_04.ogg',
	'sound/weapons/guns/fire/flmthrowr_05.ogg')



//Preloaded subtypes

//Default starts with an empty tank
/obj/item/weapon/gun/spray/hydrazine_torch/Initialize()
	.=..()

	tank = new /obj/item/weapon/reagent_containers/glass/fuel_tank(src)
	update_fuel()
	update_firemode()

/obj/item/weapon/gun/spray/hydrazine_torch/fuel/Initialize()
	.=..()
	QDEL_NULL(tank)
	tank = new /obj/item/weapon/reagent_containers/glass/fuel_tank/fuel(src)
	update_fuel()
	update_firemode()

/obj/item/weapon/gun/spray/hydrazine_torch/hydrazine/Initialize()
	.=..()
	QDEL_NULL(tank)
	tank = new /obj/item/weapon/reagent_containers/glass/fuel_tank/hydrazine(src)
	update_fuel()
	update_firemode()


/obj/item/weapon/gun/spray/hydrazine_torch/examine(var/mob/user)
	.=..()
	if (!tank)
		to_chat(user, SPAN_WARNING("No fuel tank is installed."))
	else
		var/fuelname = "hydrazine"
		if (tank.fueltype == /datum/reagent/fuel)
			fuelname = "gasoline"

		to_chat(user, SPAN_NOTICE("It is currently running on [fuelname]"))

		var/fullness = tank.reagents.total_volume / tank.reagents.maximum_volume
		var/spanclass = "notice"
		if (fullness < 0.6)
			if (fullness < 0.2)
				spanclass = "danger"
			else
				spanclass = "warning"
		to_chat(user, span(spanclass, "The fuel gauge reads [round(fullness, 0.01)*100]%"))

		if (tank.contamination > 0)
			to_chat(user, span("danger", "The fuel contamination warning light is blinking!"))


/obj/item/weapon/gun/spray/hydrazine_torch/can_fire(atom/target, mob/living/user, clickparams, var/silent = FALSE)
	.=..()

	if (.)
		if (!tank)
			return FALSE

		if(!tank.vacuum_burn)
			var/turf/T = get_turf(src)
			if (!T)
				return FALSE //Something is wrong, where are we??
			var/datum/gas_mixture/G = T.return_air()
			if (!G || !G.can_support_fire())
				return FALSE

		//If we're not eating excess, then we need to safety check this first
		if (!consume_excess_fuel)
			var/required_fuel = ammo_cost * fuel_per_second
			if (tank.get_remaining_fuel() < required_fuel)
				return FALSE


//If the pilot light isn't on when we fire, it will be turned on, at the cost of a significant time delay
/obj/item/weapon/gun/spray/hydrazine_torch/pre_fire(var/atom/target, var/mob/living/user, var/clickparams, var/pointblank=0, var/reflex=0)
	//Specific check here, we're gonna set it to an interim value
	if (pilot_light != TRUE)
		toggle_pilot_light()

		//One more check, incase turning it on failed. Maybe fuel is empty
		if (pilot_light != TRUE)
			return FALSE

		//We will have a brief delay to let the pilot light's sound play, before fire starts
		sleep(5)

		//Now this is a little hacky: We're going to see if the user is still holding down the mouse button, by asking the click handler
		return user.left_mouse_down()
	.=..()

/obj/item/weapon/gun/spray/hydrazine_torch/update_icon()
	var/former_itemstate = item_state

	icon_state = "hydetorch"
	item_state = "hydetorch"


	if (!tank)
		icon_state = "hydetorch_e"

	//Specifically check true to exclude the -1 in progress state
	else if (pilot_light == TRUE)
		icon_state = "hydetorch_lit"
		item_state = "hydetorch_lit"
	else
		icon_state = "hydetorch"

	if (former_itemstate != item_state)
		update_wear_icon()

/obj/item/weapon/gun/spray/hydrazine_torch/Process()
	.=..()
	if (firing)
		sound_interval -= 2 //2 deciseconds is the delay of fast process
		if (sound_interval <= 0)
			sound_interval += initial(sound_interval)
			playsound(src, pick(fire_sound), VOLUME_MID, TRUE)

	if (pilot_light)
		var/required_fuel = pilot_light_fuelcost * 0.2
		consume_fuel(required_fuel) //This will call the necessary procs if it runs out of fuel


//This proc creates particles and applies effects
/obj/item/weapon/gun/spray/hydrazine_torch/started_firing()
	.=..()
	if (tank && tank.contamination && prob(tank.contamination))
		//Tank goes boom
		QDEL_NULL(tank)
		explosion(4, 1)
		update_icon()
	playsound(src, pick(fire_sound), VOLUME_MID, TRUE)


/obj/item/weapon/gun/spray/hydrazine_torch/verb/toggle_pilot_light()
	set name = "Toggle pilot light"
	set src in usr
	set category = null

	if (pilot_light == -1) //-1 indicates "currently being lit"
		return //Prevents spamclicks breaking things

	if (get_remaining_ammo() < pilot_light_fuelcost)
		playsound(src, 'sound/items/welderactivate.ogg', VOLUME_MID, 1)
		pilot_light = -1
		to_chat(usr, SPAN_DANGER("The [src] does not have enough fuel to ignite the pilot light"))

		//Spam prevention
		spawn(10)
			pilot_light = FALSE
		return

	var/target_state = !pilot_light


	//Takes time to turn on, but goes out instantly
	if (target_state == TRUE)
		pilot_light = -1
		var/oldloc = loc
		if (!do_after(usr, 1.5 SECONDS, src) || loc != oldloc)
			pilot_light = FALSE
			return FALSE

	set_pilot_light(target_state)
	if (usr)
		usr.visible_message(SPAN_NOTICE("[usr] [pilot_light ? "ignites" : "extinguishes"] the pilot light on \the [src]"))
	return pilot_light


/obj/item/weapon/gun/spray/hydrazine_torch/proc/set_pilot_light(var/state, var/update = TRUE)
	if (pilot_light == state)
		return

	if (state == TRUE && !consume_fuel(pilot_light_fuelcost))
		return
	pilot_light = state


	var/soundfile = 'sound/items/welderactivate.ogg'
	if (!pilot_light)
		soundfile = 'sound/items/welderdeactivate.ogg'

	playsound(src, soundfile, VOLUME_MID, 1)

	if (update)
		update_icon()

	if (!is_processing)
		START_PROCESSING(SSfastprocess, src)


//The torch has no safety switch, that's routed to the pilot light instead
/obj/item/weapon/gun/spray/hydrazine_torch/toggle_safety(var/mob/user)
	safety_state = FALSE
	toggle_pilot_light()








/obj/item/weapon/gun/spray/hydrazine_torch/can_stop_processing()
	if (pilot_light)
		return FALSE

	.=..()


/obj/item/weapon/gun/spray/hydrazine_torch/load_ammo(A, var/mob/user)
	if (istype(A, /obj/item/weapon/reagent_containers/glass/fuel_tank))
		if (tank && tank.loc == src)
			to_chat(user, SPAN_WARNING("The [src] already has a tank installed, remove it first!"))
			return
		if(!user.unEquip(A, src))
			return

		tank = A
		user.visible_message("[user] inserts \a [A] into [src].", "<span class='notice'>You insert \a [A] into [src].</span>")
		playsound(loc, mag_insert_sound, 50, 1)


		update_fuel()
		update_firemode()
		update_icon()

	.=..()

/obj/item/weapon/gun/spray/hydrazine_torch/unload_ammo(var/mob/user, allow_dump=0)
	if(tank)
		user.put_in_hands(tank)
		user.visible_message("[user] removes [tank] from [src].", "<span class='notice'>You remove [tank] from [src].</span>")
		playsound(loc, mag_remove_sound, 50, 1)
		tank.update_icon()
		tank = null

		update_icon()




/obj/item/weapon/gun/spray/hydrazine_torch/consume_projectiles(var/number = 1)
	if (!tank)
		return FALSE



	var/required_fuel = fuel_per_second * number


	//If we're not eating excess, then we need to safety check this first
	if (!consume_excess_fuel)
		if (tank.get_remaining_fuel() < required_fuel)
			return FALSE

	if (consume_fuel(required_fuel))
		return .=..()

	return FALSE

/obj/item/weapon/gun/spray/hydrazine_torch/get_remaining_ammo()
	if (!tank)
		return 0

	return tank.get_remaining_fuel()



/obj/item/weapon/gun/spray/hydrazine_torch/proc/consume_fuel(var/required_fuel)
	if (!tank)
		fuel_depleted()
		return FALSE

	var/fuel_removed = tank.reagents.remove_reagent(tank.fueltype, required_fuel, TRUE)	//Passing true to safety prevents reactions and optimises a tiny bit

	if (fuel_removed < required_fuel)
		fuel_depleted()
		return FALSE

	return TRUE


/obj/item/weapon/gun/spray/hydrazine_torch/proc/update_fuel()
	if (!tank || tank.fueltype == /datum/reagent/fuel)
		spray_type = /datum/extension/spray/flame
		radial_spray_type = /datum/extension/spray/flame/radial
		range =	4
		temperature = T0C + 2600
		blast_projectile = /obj/item/projectile/bullet/impact_grenade/incendiary
	else if (tank.fueltype == /datum/reagent/hydrazine)
		spray_type = /datum/extension/spray/flame/blue
		radial_spray_type = /datum/extension/spray/flame/blue/radial
		range =	5
		temperature = T0C + 4000
		blast_projectile = /obj/item/projectile/bullet/impact_grenade/incendiary/blue


//If fuel runs out, everything stops
/obj/item/weapon/gun/spray/hydrazine_torch/proc/fuel_depleted()
	set_pilot_light(FALSE, FALSE) //Second var tells it not to update, we will do that seperately
	stop_firing() //This will stop the processing
	update_icon()










/*
	Fuel Tank
*/
/obj/item/weapon/reagent_containers/glass/fuel_tank
	name = "liquid fuel tank"
	desc = "A tank designed to fit the PFM-100 Industrial Torch. A warning plate on the side instructs the user not to mix multiple types of fuel, and not to allow any non-fuel contaminants into the tank."
	volume = 400	//four litres

	icon = 'icons/obj/ammo.dmi'
	icon_state = "hydecanister_e"
	//TODO: Update icon on reagent change and show the non empty version if we contain reagents

	//If nonzero, there is a small chance of a horrible explosion
	//The tank is considered contaminated if it contains anything other than pure fuel of one type. Normal or Hydrazine
	//It will be considered contaminated if you mix both, or if any nonfuel reagents get in
	var/contamination = 0

	var/fueltype = /datum/reagent/fuel

	var/vacuum_burn = FALSE

	can_be_placed_into = list(
		/obj/machinery/chem_master/,
		/obj/machinery/chemical_dispenser,
		/obj/structure/table,
		/obj/structure/closet,
		/obj/structure/sink,
		/obj/item/weapon/grenade/chem_grenade,
		/obj/item/weapon/storage/secure/safe,
		/obj/machinery/disposal,
		/obj/machinery/smartfridge/,
		/obj/item/weapon/gun/spray/hydrazine_torch
	)


/obj/item/weapon/reagent_containers/glass/fuel_tank/examine(var/mob/user)
	.=..()
	var/fuelname = "hydrazine"
	if (fueltype == /datum/reagent/fuel)
		fuelname = "gasoline"

	to_chat(user, SPAN_NOTICE("It is currently running on [fuelname]"))

	var/fullness = reagents.total_volume / reagents.maximum_volume
	var/spanclass = "notice"
	if (fullness < 0.6)
		if (fullness < 0.2)
			spanclass = "danger"
		else
			spanclass = "warning"
	to_chat(user, span(spanclass, "The fuel gauge reads [round(fullness, 0.01)*100]%"))

	if (contamination > 0)
		to_chat(user, span("danger", "The fuel contamination warning light is blinking!"))


//To save processing, lets not recheck the fuel unless something other than our designated fuel went in or out
/obj/item/weapon/reagent_containers/glass/fuel_tank/on_reagent_change(var/reagent_type, var/delta)
	if (reagent_type != fueltype)
		check_fuel_type_and_contamination()

/*
	Two purposes for this proc:
	1. Determines whether we are using normal or hydrazine fuel

	2. Determines how contaminated the tank is
*/
/obj/item/weapon/reagent_containers/glass/fuel_tank/proc/check_fuel_type_and_contamination()
	fueltype = /datum/reagent/fuel
	vacuum_burn = FALSE

	var/contaminants = reagents.total_volume

	var/quantity_fuel = reagents.get_reagent_amount(/datum/reagent/fuel)
	var/quantity_hydrazine = reagents.get_reagent_amount(/datum/reagent/hydrazine)

	if (quantity_hydrazine > quantity_fuel)
		fueltype = /datum/reagent/hydrazine
		vacuum_burn = TRUE
		contaminants -= quantity_hydrazine
	else
		contaminants -= quantity_fuel

	contamination = 0
	//Alright, we've determined what should be here, lets see what shouldn't
	if (contaminants > 0)
		contamination = (contaminants / reagents.maximum_volume) * 100

/obj/item/weapon/reagent_containers/glass/fuel_tank/proc/get_remaining_fuel()
	return reagents.get_reagent_amount(fueltype)



/*
	Prefilled subtypes
*/
/obj/item/weapon/reagent_containers/glass/fuel_tank/fuel
	name = "fuel tank (gasoline)"
/obj/item/weapon/reagent_containers/glass/fuel_tank/fuel/Initialize()
	.=..()
	reagents.add_reagent(/datum/reagent/fuel, 400)		//Intentionally low since it is so strong. Still enough to knock someone out.



/obj/item/weapon/reagent_containers/glass/fuel_tank/hydrazine
	name = "fuel tank (hydrazine)"

/obj/item/weapon/reagent_containers/glass/fuel_tank/hydrazine
	fueltype = /datum/reagent/hydrazine

/obj/item/weapon/reagent_containers/glass/fuel_tank/hydrazine/Initialize()
	.=..()
	reagents.add_reagent(/datum/reagent/hydrazine, 400)		//Intentionally low since it is so strong. Still enough to knock someone out.












/*
	Spray guns

	The spray subtype is used for guns that project a constant cone of fire, acid, cold, lightning, etc
*/
/obj/item/weapon/gun/spray
	var/spray_type = /datum/extension/spray

	var/range =	4
	var/angle = 30

//How long it will take to windup before
/obj/item/weapon/gun/spray/proc/get_windup()
	return 0

/obj/item/weapon/gun/spray/can_stop_processing()
	if (firing)
		return FALSE

	.=..()


/obj/item/weapon/gun/spray/Process()
	if (firing)
		if (!consume_projectiles(0.2)) //0.2 is the delta of the fastprocess subsystem
			stop_firing()


//This proc creates particles and applies effects
/obj/item/weapon/gun/spray/started_firing()
	firing = TRUE
	if (!is_processing)
		START_PROCESSING(SSfastprocess, src)


/obj/item/weapon/gun/spray/stop_firing()
	firing = FALSE
	.=..()
	if (can_stop_processing())
		STOP_PROCESSING(SSfastprocess, src)

	//Just to be sure
	stop_spraying()




/*
	Firemode
*/
/datum/firemode/sustained/spray/flame
	spray_type = /datum/extension/spray/flame
	angle = 30
	range = 5


/datum/firemode/sustained/spray/update(var/forced_state)
	var/obj/item/weapon/gun/spray/HT = gun
	range = HT.range
	angle = HT.angle
	.=..()

/datum/firemode/sustained/spray/flame/update(var/forced_state)
	var/obj/item/weapon/gun/spray/hydrazine_torch/HT = gun
	extra_data = list("temperature" = HT.temperature)
	.=..()






/*
	Acquisition
*/
/decl/hierarchy/supply_pack/mining/torch_fuel
	name = "Torch Fuel Canisters"
	contains = list(/obj/item/weapon/reagent_containers/glass/fuel_tank/fuel = 4)
	cost = 80
	containertype = /obj/structure/closet/crate
	containername = "\improper Torch Fuel Canisters crate"


//Crazy expensive for just ONE tank of hydrazine. Cargo is not a convenient source for it
/decl/hierarchy/supply_pack/mining/torch_hydrazine
	name = "Torch Hydrazine Canister"
	contains = list(/obj/item/weapon/reagent_containers/glass/fuel_tank/hydrazine = 1)
	cost = 200
	containertype = /obj/structure/closet/crate
	containername = "\improper Torch Fuel Canisters crate"


/decl/hierarchy/supply_pack/mining/hydrazine_torch
	name = "Mining Tool - Hydrazine Torch"
	contains = list(/obj/item/weapon/gun/spray/hydrazine_torch = 1,
	/obj/item/weapon/reagent_containers/glass/fuel_tank/fuel = 2)
	cost = 80
	containertype = /obj/structure/closet/crate
	containername = "\improper Hydrazine Torch crate"










/*
	Alternate Fire
	incendiary blast:
	Fires an impact grenade which, on detonation, creates a radial fire spray for a few seconds, rather than an explosion
*/
/datum/firemode/incendiary/update()
	var/obj/item/weapon/gun/spray/hydrazine_torch/HT = gun
	if (istype(HT))
		gun.projectile_type = HT.blast_projectile

	.=..()

/obj/item/projectile/bullet/impact_grenade/incendiary
	name = "fireball"
	icon_state = "fireblast"
	icon = 'icons/obj/projectiles.dmi'

	fire_sound = list('sound/weapons/guns/fire/torch_altfire_1.ogg',
	'sound/weapons/guns/fire/torch_altfire_2.ogg',
	'sound/weapons/guns/fire/torch_altfire_3.ogg')


/obj/item/projectile/bullet/impact_grenade/incendiary/blue
	icon_state = "fireblast_blue"

/obj/item/projectile/bullet/impact_grenade/incendiary/detonate()
	if (!exploded)
		exploded = TRUE
		var/obj/item/weapon/gun/spray/hydrazine_torch/HT = launcher

		var/spraytype = /datum/extension/spray/flame/radial
		var/temperature = T0C + 2600

		//Have this check here so that in future we can easily support incendiary grenades fired from different weapons
		if (istype(HT))
			spraytype = HT.radial_spray_type
			temperature = HT.temperature
		var/turf/T = get_turf(src)

		//We trigger the spray on the turf, because this object is about to be deleted
		T.spray_ability(subtype = spraytype,  target = null, angle = 360, length = 3, duration = 3 SECONDS, extra_data = list("temperature" = temperature))
		expire()