/obj/item/grenade/heater
	name = "Deployable space heater"
	desc = "An adorable grenade shaped like a miniature space heater.  It has a pin to pull on the side."
	icon = 'modular_skyrat/modules/deployable_hvac/icons/deployable_hvac.dmi'
	icon_state = "heatbang"
	inhand_icon_state = "flashbang"


//Clusterbomb version
/obj/item/grenade/clusterbuster/heater
	name = "Global Warming"
	payload = /obj/item/grenade/heater
	min_spawned = 4
	max_spawned = 5
	segment_chance = 35
	custom_price = PAYCHECK_COMMAND * 10 //Same as black market armament holochip
	custom_premium_price = PAYCHECK_COMMAND * 10 // I don't want it bought every single round


/obj/item/grenade/heater/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return
	playsound(src, 'sound/machines/hiss.ogg', 75, 1)
	do_smoke(1, 1, null, get_turf(src))
	if(locate(/obj/machinery/space_heater/deployable) in get_turf(src))  //Explode if there's another one here
		new /obj/effect/decal/cleanable/robot_debris(get_turf(src.loc))  //Close enough
	else
		new /obj/machinery/space_heater/deployable(get_turf(src.loc))
	qdel(src)



/obj/machinery/space_heater/deployable
	anchored = TRUE
	density = TRUE
	interaction_flags_machine = INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN
	icon = 'modular_skyrat/modules/deployable_hvac/icons/deployable_hvac.dmi'
	icon_state = "sheater-off"
	base_icon_state = "sheater"
	name = "deployable space heater"
	desc = "A deployed compressed space heater.  The Space Amish would be disappointed in its build quality."
	max_integrity = 50 //It's weak and not very good for combat use agaist guns.
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 10)
	circuit = /obj/item/circuitboard/machine/space_heater
	on = TRUE // Starts on
	heating_power = 40000 // Default
	efficiency = 20000 // Default

//Deconstruction shouldn't yield a frame
/obj/machinery/space_heater/deployable/deconstruct(disassembled = TRUE)
	if(flags_1 & NODECONSTRUCT_1)
		return ..() //Just delete us, no need to call anything else.

	on_deconstruction()
	if(!LAZYLEN(component_parts))
		return ..() //we don't have any parts.
	//spawn_frame(disassembled)
	new /obj/item/stack/sheet/cardboard(get_turf(src.loc))
	for(var/obj/item/part in component_parts)
		part.forceMove(loc)
	LAZYCLEARLIST(component_parts)
	return ..()

// Box for the engi-vend and cargo
/obj/item/storage/box/heatergrenades
	name = "box of deployable space heaters"
	desc = "A box containing adorable grenades shaped like miniature space heaters.  No need to add water, just pull the pin and throw."

/obj/item/storage/box/heatergrenades/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/grenade/heater(src)
