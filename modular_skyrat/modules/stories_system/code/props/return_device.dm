/obj/item/beamout_tool
	name = "beam-out tool" // TODO, find a way to make this into drop pods cuz that's cooler visually
	desc = "Use this to begin the lengthy beam-out  process to return to Sol Federation space. It will bring anyone you are pulling with you."
	icon = 'modular_skyrat/modules/goofsec/icons/reporter.dmi'
	icon_state = "beam_me_up_scotty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/beamout_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert))
		to_chat(user, span_warning("You don't understand how to use this device."))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beam-out using their beam-out tool.")
	to_chat(user, "You have begun the beam-out process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beam-out")
	if(do_after(user, 30 SECONDS))
		to_chat(user, "You have completed the beam-out process and are returning to the Sol Federation.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has beamed themselves out.")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				if(ishuman(living_user.pulling))
					var/mob/living/carbon/human/beamed_human = living_user.pulling
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [ADMIN_LOOKUPFLW(beamed_human)] alongside them.")
				else
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [living_user.pulling] alongside them.")
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, pulling_turf)
				sparks.attach(pulling_turf)
				sparks.start()
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/magic/Repulse.ogg', 100, 1)
			var/datum/effect_system/spark_spread/quantum/sparks = new
			sparks.set_up(10, 1, user_turf)
			sparks.attach(user_turf)
			sparks.start()
			qdel(user)
	else
		user.balloon_alert(user, "beam-out cancelled")
