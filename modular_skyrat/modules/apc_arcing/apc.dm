/obj/machinery/power/apc
	/// Has the APC been protected against arcing?
	var/arc_shielded = FALSE

/obj/machinery/power/apc/examine()
	. = ..()
	. += "It [arc_shielded ? "has" : "does not have"] arc shielding installed."
	if(panel_open)
		if(arc_shielded)
			. += "The arc shielding could be removed with a <b>wrench</b>."
		else
			. += "It could be arc shielded with a <b>sheet of bronze</b>."

/obj/machinery/power/apc/process()
	. = ..()
	var/excess = surplus()
	if(!cell || shorted)
		return
	if(!(excess >= APC_ARC_LOWERLIMIT) || arc_shielded)
		return
	var/shock_chance = 5
	if(excess >= APC_ARC_UPPERLIMIT)
		shock_chance = 15
	else if(excess >= APC_ARC_MEDIUMLIMIT)
		shock_chance = 10
	if(prob(shock_chance))
		var/list/shock_mobs = list()
		for(var/creature in view(get_turf(src), 5)) // We only want to shock a single random mob in range, not all.
			if(isliving(creature))
				shock_mobs += creature
		if(shock_mobs.len)
			var/mob/living/living_target = pick(shock_mobs)
			living_target.electrocute_act(rand(5, 25), "electrical arc")
			playsound(get_turf(living_target), 'sound/magic/lightningshock.ogg', 75, TRUE)
			Beam(living_target, icon_state = "lightning[rand(1, 12)]", icon = 'icons/effects/beam.dmi', time = 5)

/obj/machinery/power/apc/attackby(obj/item/attacking_object, mob/living/user, params)
	. = ..()
	if(istype(attacking_object, /obj/item/stack/sheet/bronze) && panel_open)
		if(arc_shielded)
			balloon_alert(user, "already arc shielded!")
			return
		var/obj/item/stack/sheet/bronze/bronze = attacking_object
		bronze.use(1)
		balloon_alert(user, "installed arc shielding")
		arc_shielded = TRUE
		playsound(src, 'sound/items/rped.ogg', 20)
		return

/obj/machinery/power/apc/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(panel_open && arc_shielded)
		balloon_alert(user, "arc shielding removed")
		arc_shielded = FALSE
		tool.play_tool_sound(src, 50)
