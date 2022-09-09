/obj/machinery/power/apc
	/// Has the APC been protected against arcing?
	var/arc_shielded = FALSE

/obj/machinery/power/apc/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(panel_open && arc_shielded)
		balloon_alert(user, "arc shielding removed")
		arc_shielded = FALSE
		tool.play_tool_sound(src, 50)

/obj/machinery/power/apc/proc/process_arc(excess)
	if(excess >= APC_ARC_LOWERLIMIT && !arc_shielded)
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
