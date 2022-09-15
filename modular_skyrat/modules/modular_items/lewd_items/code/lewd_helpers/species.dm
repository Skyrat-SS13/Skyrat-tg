/datum/species/proc/throw_arousalalert(level, atom/movable/screen/alert/aroused_x/arousal_alert, mob/living/carbon/human/targeted_human)
	targeted_human.throw_alert("aroused", /atom/movable/screen/alert/aroused_x)
	arousal_alert?.icon_state = level
	arousal_alert?.update_icon()

/datum/species/proc/overlay_pain(level, atom/movable/screen/alert/aroused_x/arousal_alert)
	arousal_alert?.cut_overlay(arousal_alert.pain_overlay)
	arousal_alert?.pain_level = level
	arousal_alert?.pain_overlay = arousal_alert.update_pain()
	arousal_alert?.add_overlay(arousal_alert.pain_overlay)
	arousal_alert?.update_overlays()

/datum/species/proc/overlay_pleasure(level, atom/movable/screen/alert/aroused_x/arousal_alert)
	arousal_alert?.cut_overlay(arousal_alert.pleasure_overlay)
	arousal_alert?.pleasure_level = level
	arousal_alert?.pleasure_overlay = arousal_alert.update_pleasure()
	arousal_alert?.add_overlay(arousal_alert.pleasure_overlay)
	arousal_alert?.update_overlays()

/datum/species/proc/handle_arousal(mob/living/carbon/human/target_human, atom/movable/screen/alert/aroused_x)
	var/atom/movable/screen/alert/aroused_x/arousal_alert = target_human.alerts["aroused"]
	if(target_human.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		switch(target_human.arousal)
			if(-100 to 1)
				target_human.clear_alert("aroused", /atom/movable/screen/alert/aroused_x)
			if(1 to 25)
				throw_arousalalert("arousal_small", arousal_alert, target_human)
			if(25 to 50)
				throw_arousalalert("arousal_medium", arousal_alert, target_human)
			if(50 to 75)
				throw_arousalalert("arousal_high", arousal_alert, target_human)
			if(75 to INFINITY) //to prevent that 101 arousal that can make icon disappear or something.
				throw_arousalalert("arousal_max", arousal_alert, target_human)

		if(target_human.arousal > 1)
			switch(target_human.pain)
				if(-100 to 1) //to prevent same thing with pain
					arousal_alert?.cut_overlay(arousal_alert.pain_overlay)
				if(1 to 25)
					overlay_pain("small", arousal_alert)
				if(25 to 50)
					overlay_pain("medium", arousal_alert)
				if(50 to 75)
					overlay_pain("high", arousal_alert)
				if(75 to INFINITY)
					overlay_pain("max", arousal_alert)

		if(target_human.arousal > 1)
			switch(target_human.pleasure)
				if(-100 to 1) //to prevent same thing with pleasure
					arousal_alert?.cut_overlay(arousal_alert.pleasure_overlay)
				if(1 to 25)
					overlay_pleasure("small", arousal_alert)
				if(25 to 60)
					overlay_pleasure("medium", arousal_alert)
				if(60 to 85)
					overlay_pleasure("high", arousal_alert)
				if(85 to INFINITY)
					overlay_pleasure("max", arousal_alert)
		else
			if(arousal_alert?.pleasure_level in list("small", "medium", "high", "max"))
				arousal_alert.cut_overlay(arousal_alert.pleasure_overlay)
			if(arousal_alert?.pain_level in list("small", "medium", "high", "max"))
				arousal_alert.cut_overlay(arousal_alert.pain_overlay)
