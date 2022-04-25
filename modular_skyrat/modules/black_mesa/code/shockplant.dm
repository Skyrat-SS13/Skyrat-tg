
/obj/structure/shockplant
	name = "electrical plant"
	desc = "It glows with a warm buzz."
	icon = 'modular_skyrat/modules/black_mesa/icons/plants.dmi'
	icon_state = "electric_plant"
	density = TRUE
	anchored = TRUE
	max_integrity = 200
	light_range = 15
	light_power = 0.5
	light_color = "#53fafa"
	/// Our faction
	var/faction = FACTION_XEN
	/// Our range to shock folks in.
	var/shock_range = 6
	/// Our cooldown on the shocking.
	var/shock_cooldown = 3 SECONDS
	/// The zap power
	var/shock_power = 10000

	COOLDOWN_DECLARE(shock_cooldown_timer)

/obj/structure/shockplant/Initialize(mapload)
	. = ..()
	for(var/turf/open/iterating_turf as anything in circle_view_turfs(src, shock_range))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, .proc/trigger)

/obj/structure/shockplant/proc/trigger(datum/source, atom/movable/entered_atom)
	SIGNAL_HANDLER

	if(!COOLDOWN_FINISHED(src, shock_cooldown_timer))
		return

	if(isliving(entered_atom))
		var/mob/living/entering_mob = entered_atom
		if(faction in entering_mob.faction)
			return
		tesla_zap(src, shock_range, shock_power, shocked_targets = list(entering_mob))
		playsound(src, 'sound/magic/lightningbolt.ogg', 100, TRUE)
		COOLDOWN_START(src, shock_cooldown_timer, shock_cooldown)
