//Anomalous crystal effects
#define ANOM_CRYSTAL_FIRE 1
#define ANOM_CRYSTAL_EMP 2
#define ANOM_CRYSTAL_GRAVITATIONAL 3
#define ANOM_CRYSTAL_EXPLOSIVE 4
#define ANOM_CRYSTAL_RESIN_FOAM 5
#define ANOM_CRYSTAL_NITROUS_OXIDE 6
#define ANOM_CRYSTAL_RADIATION 7
#define ANOM_CRYSTAL_MEDICAL_FOAM 8
#define ANOM_CRYSTAL_TOXIN_FOAM 9
#define ANOM_CRYSTAL_ELECTRIC 10
#define ANOM_CRYSTAL_FROST_VAPOUR 11
//MAKE SURE TO UPDATE THIS!!
#define ANOM_CRYSTAL_EFFECTS_IN_TOTAL 11

/obj/item/anomalous_sliver
	name = "anomalous sliver"
	icon = 'icons/excavation/crystal.dmi'
	icon_state = "sliver"
	w_class = WEIGHT_CLASS_TINY
	var/anom_type
	var/power = 20

/obj/item/anomalous_sliver/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if it wasn't caught
		visible_message("<span class='warning'>[src] flashes and shatters!</span>",
		"<span class='hear'>You hear something shatter!</span>")
		var/turf/our_T = get_turf(src)
		var/obj/ash = new /obj/effect/decal/cleanable/ash(our_T)
		ash.color = color
		playsound(src, "shatter", 50, TRUE)
		anomaly_crystal_effect(our_T, anom_type, power)
		do_sparks(1, TRUE, src)
		qdel(src)

/obj/item/anomalous_sliver/sliver/Initialize()
	. = ..()
	icon_state = "sliver[rand(1,4)]"

/obj/item/anomalous_sliver/crystal
	name = "anomalous crystal"
	icon_state = "crystal"
	w_class = WEIGHT_CLASS_SMALL
	power = 100
	var/slivers_remaining = 5

/obj/item/anomalous_sliver/crystal/Initialize()
	. = ..()
	anom_type = rand(1,ANOM_CRYSTAL_EFFECTS_IN_TOTAL)
	color = "#[random_color()]"

/obj/item/anomalous_sliver/crystal/attackby(obj/item/I, mob/user, params)
	if(I.get_sharpness() && user.Adjacent(src))
		to_chat(user, "<span class='notice'>You carefully slice a piece off of [src]...</span>")
		if(do_mob(user, src, 4 SECONDS))
			if(prob(50 + (I.force*2)))
				to_chat(user, "<span class='notice'>You succeed, slicing a sliver off of [src].</span>")
				splinter_off()
			else
				to_chat(user, "<span class='warning'>You mess up and the crystal flashes briefly!</span>")
				do_sparks(1, TRUE, src)
				splinter_off(FALSE)
				anomaly_crystal_effect(get_turf(src), anom_type, 20)
		return TRUE
	else
		return ..()

/obj/item/anomalous_sliver/crystal/proc/splinter_off(drop = TRUE)
	if(drop)
		var/obj/item/anomalous_sliver/sliver/ACS = new(get_turf(src))
		ACS.color = color
		ACS.anom_type = anom_type
		. = ACS
	slivers_remaining--
	power -= 20
	if(slivers_remaining <= 0)
		visible_message("<span class='warning'>[src] splinters off the last bit!</span>")
		qdel(src)

/obj/item/anomalous_sliver/proc/anomaly_crystal_effect(turf/T, anom_type, anom_pow)
	message_admins("Anomalous crystal effect was activated, with a power of [anom_pow]! [ADMIN_JMP(T)]")
	switch(anom_type)
		if(ANOM_CRYSTAL_FIRE)
			var/gas_power = anom_pow/5
			T.atmos_spawn_air("o2=[gas_power];plasma=[gas_power];TEMP=600")
		if(ANOM_CRYSTAL_EMP)
			var/heavy = round((anom_pow-20)/40)
			var/light = round(anom_pow+20/20)
			empulse(T, light, heavy)
		if(ANOM_CRYSTAL_ELECTRIC)
			var/power = anom_pow*70
			do_sparks(3, TRUE, T)
			tesla_zap(T, 4, power, ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE | ZAP_MOB_STUN)
		if(ANOM_CRYSTAL_RADIATION)
			playsound(T, 'sound/effects/empulse.ogg', 50, TRUE)
			radiation_pulse(T, anom_pow)
		if(ANOM_CRYSTAL_EXPLOSIVE)
			var/power = anom_pow/8
			var/datum/effect_system/reagents_explosion/e = new()
			e.set_up(power, T, 0, 0)
			e.start()
		if(ANOM_CRYSTAL_GRAVITATIONAL)
			var/boing = FALSE
			if(anom_pow > 40)
				boing = TRUE
			for(var/obj/O in orange(4, T))
				if(!O.anchored)
					step_towards(O,T)
			for(var/mob/living/M in range(0, T))
				if(boing && !M.stat)
					M.Paralyze(40)
					var/atom/target = get_edge_target_turf(M, get_dir(T, get_step_away(M, T)))
					M.throw_at(target, 5, 1)
			for(var/mob/living/M in orange(4, T))
				if(!M.mob_negates_gravity())
					step_towards(M,T)
			for(var/obj/O in range(0,T))
				if(!O.anchored)
					if(T.intact && HAS_TRAIT(O, TRAIT_T_RAY_VISIBLE))
						continue
					var/mob/living/target = locate() in view(4,T)
					if(target && !target.stat)
						O.throw_at(target, 5, 10)
		if(ANOM_CRYSTAL_RESIN_FOAM)
			var/obj/effect/resin_container/RC = new(T)
			RC.Smoke()
		if(ANOM_CRYSTAL_NITROUS_OXIDE)
			var/gas_power = anom_pow/2
			T.atmos_spawn_air("n2o=[gas_power];TEMP=290")
		if(ANOM_CRYSTAL_MEDICAL_FOAM)
			var/foam_range = anom_pow/5
			var/reagents_amount = anom_pow/5
			var/datum/reagents/R = new/datum/reagents(300)
			R.add_reagent(/datum/reagent/medicine/regen_jelly, reagents_amount)
			var/datum/effect_system/foam_spread/foam = new
			foam.set_up(foam_range, T, R)
			foam.start()
		if(ANOM_CRYSTAL_TOXIN_FOAM)
			var/foam_range = anom_pow/5
			var/reagents_amount = anom_pow/5
			var/datum/reagents/R = new/datum/reagents(300)
			R.add_reagent(/datum/reagent/toxin, reagents_amount)
			var/datum/effect_system/foam_spread/foam = new
			foam.set_up(foam_range, T, R)
			foam.start()
		if(ANOM_CRYSTAL_FROST_VAPOUR)
			var/gas_power = anom_pow*1.5
			T.atmos_spawn_air("water_vapor=[gas_power];TEMP=3")

#undef ANOM_CRYSTAL_FIRE
#undef ANOM_CRYSTAL_EMP
#undef ANOM_CRYSTAL_GRAVITATIONAL
#undef ANOM_CRYSTAL_EXPLOSIVE
#undef ANOM_CRYSTAL_RESIN_FOAM
#undef ANOM_CRYSTAL_NITROUS_OXIDE
#undef ANOM_CRYSTAL_RADIATION
#undef ANOM_CRYSTAL_MEDICAL_FOAM
#undef ANOM_CRYSTAL_TOXIN_FOAM
#undef ANOM_CRYSTAL_ELECTRIC
#undef ANOM_CRYSTAL_FROST_VAPOUR
#undef ANOM_CRYSTAL_EFFECTS_IN_TOTAL
