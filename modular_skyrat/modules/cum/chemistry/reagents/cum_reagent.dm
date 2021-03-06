/datum/reagent/cum
	name = "Cum"
	description = "A fluid containing sperm that is secretated by the sexual organs of most species."
	color = "#fff9f1"
	taste_description = "musk"
	glass_icon_state = "glass_white"
	glass_name = "glass of cum"
	glass_desc = "O-oh, my...~"
	shot_glass_icon_state = "shotglasswhite"

/datum/reagent/cum/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH|VAPOR))) //might be for the better
		if(exposed_mob.client && (exposed_mob.client.prefs.skyrat_toggles & CUMFACE_PREF))
			var/turf/T = get_turf(exposed_mob)
			new/obj/effect/decal/cleanable/cum(T)
			exposed_mob.adjust_blurriness(1)
			exposed_mob.visible_message("<span class='warning'>[exposed_mob] has been covered in cum!</span>", "<span class='userdanger'>You've been covered in cum!</span>")
			playsound(exposed_mob, "desecration", 50, TRUE)
			if(is_type_in_typecache(exposed_mob, GLOB.creamable))
				if(reac_volume>10)
					exposed_mob.AddComponent(/datum/component/cumfaced/big, src)
				else
					exposed_mob.AddComponent(/datum/component/cumfaced, src)
		qdel(src)
