/obj/effect/anomaly/ectoplasm/detonate()
	. = ..()

	if(effect_power < 10) //Under 10% participation, we do nothing more than a small visual *poof*.
		new /obj/effect/temp_visual/revenant/cracks(get_turf(src))
		return

	if(effect_power >= 10) //Performs something akin to a revenant defile spell.
		var/effect_range = ghosts_orbiting + 3
		var/effect_area = range(effect_range, src)

		for(var/impacted_thing in effect_area)
			if(isfloorturf(impacted_thing))
				if(prob(5))
					new /obj/effect/decal/cleanable/blood(get_turf(impacted_thing))
				else if(prob(10))
					new /obj/effect/decal/cleanable/greenglow/ecto(get_turf(impacted_thing))
				else if(prob(10))
					new /obj/effect/decal/cleanable/dirt/dust(get_turf(impacted_thing))

				if(!isplatingturf(impacted_thing))
					var/turf/open/floor/floor_to_break = impacted_thing
					if(floor_to_break.overfloor_placed && floor_to_break.floor_tile && prob(20))
						new floor_to_break.floor_tile(floor_to_break)
						floor_to_break.make_plating(TRUE)
						floor_to_break.broken = TRUE
						floor_to_break.burnt = TRUE

			if(ishuman(impacted_thing))
				var/mob/living/carbon/human/mob_to_infect = impacted_thing
				mob_to_infect.ForceContractDisease(new /datum/disease/revblight(), FALSE, TRUE)
				new /obj/effect/temp_visual/revenant(get_turf(mob_to_infect))
				to_chat(mob_to_infect, span_revenminor("A cacophony of ghostly wailing floods your ears for a moment. The noise subsides, but a distant whispering continues echoing inside of your head..."))

			if(istype(impacted_thing, /obj/structure/window))
				var/obj/structure/window/window_to_damage = impacted_thing
				window_to_damage.take_damage(rand(60, 90))
				if(window_to_damage?.fulltile)
					new /obj/effect/temp_visual/revenant/cracks(get_turf(window_to_damage))

	if(effect_power >= 35)
		var/effect_range = ghosts_orbiting + 3
		haunt_outburst(epicenter = get_turf(src), range = effect_range, haunt_chance = 45, duration = (effect_power * 4 SECONDS))
		priority_announce("Anomaly has reached critical mass. Ectoplasmic outburst detected.", "Anomaly Alert")
