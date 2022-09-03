/obj/effect/portal/cryo
	name = "Portal to Cryo"
	desc = "Looks like it's time for someone to sleep."
	var/target = null

/obj/effect/portal/cryo/Initialize(mapload)
	playsound(src.loc, 'sound/magic/Repulse.ogg', 100, 1)
	var/datum/effect_system/spark_spread/quantum/sparks = new
	sparks.set_up(10, 1, src.loc)
	sparks.attach(src.loc)
	sparks.start()
	QDEL_IN(src, 5 SECONDS)

/obj/effect/portal/cryo/Destroy() // get info from proc, and try to put player in cryo. if player destroyed, just delete portal
	if(target)
		var/mob/living/carbon/human/user = target
		user.move_resist -= 1000
		for(var/obj/machinery/cryopod/cryo in GLOB.station_cryopods)
			if(!cryo.occupant)
				cryo.close_machine(user)
				break

	playsound(src.loc, 'sound/magic/Repulse.ogg', 100, 1)
	var/datum/effect_system/spark_spread/quantum/sparks = new //I don't like having to duplicate this
	sparks.set_up(10, 1, src.loc)
	sparks.attach(src.loc)
	sparks.start()
	return ..()

// give protection from move to player, and give info to portal
/mob/living/carbon/human/proc/send_to_cryo() 
	src.move_resist += 1000
	src.Stun(6 SECONDS, TRUE)
	var/obj/effect/portal/cryo/portal = new /obj/effect/portal/cryo(get_turf(src))
	portal.target = src
			

