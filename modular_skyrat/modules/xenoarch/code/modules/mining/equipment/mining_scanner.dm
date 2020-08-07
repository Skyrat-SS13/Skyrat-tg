/obj/item/t_scanner/adv_mining_scanner/xenoarch
	name = "advanced automatic xenoarch mining scanner"
	icon = 'modular_skyrat/modules/xenoarch/icons/obj/tools.dmi'

/obj/item/t_scanner/adv_mining_scanner/xenoarch/scan()
	if(current_cooldown <= world.time)
		current_cooldown = world.time + cooldown
		var/turf/t = get_turf(src)
		mineral_scan_pulse_xenoarch(t, range)

/proc/mineral_scan_pulse_xenoarch(turf/T, range = world.view)
	var/list/minerals = list()
	for(var/turf/closed/mineral/strange/M in range(range, T))
		if(M.scan_state)
			minerals += M
	if(LAZYLEN(minerals))
		for(var/turf/closed/mineral/strange/M in minerals)
			var/obj/effect/temp_visual/mining_overlay/xenoarch/oldC = locate(/obj/effect/temp_visual/mining_overlay/xenoarch) in M
			if(oldC)
				qdel(oldC)
			var/obj/effect/temp_visual/mining_overlay/xenoarch/C = new /obj/effect/temp_visual/mining_overlay/xenoarch(M)
			C.icon_state = M.scan_state

/obj/effect/temp_visual/mining_overlay/xenoarch
	icon = 'modular_skyrat/modules/xenoarch/icons/effects/ore_visuals.dmi'

/obj/effect/temp_visual/mining_overlay/xenoarch/Initialize()
	. = ..()
	animate(src, alpha = 0, time = duration, easing = EASE_IN)
