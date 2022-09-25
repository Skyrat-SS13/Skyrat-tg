#define AROUSED_ALERT "aroused"
#define AROUSED_SMALL "small"
#define AROUSED_MEDIUM "medium"
#define AROUSED_HIGH "high"
#define AROUSED_MAX "max"

/// Sends an icon to the screen that gives an approximate indication of the mob's arousal.
/datum/species/proc/throw_arousal_alert(level, atom/movable/screen/alert/aroused/arousal_alert, mob/living/carbon/human/targeted_human)
	targeted_human.throw_alert(AROUSED_ALERT, /atom/movable/screen/alert/aroused)
	arousal_alert?.icon_state = "arousal_[level]"
	arousal_alert?.update_icon()

/// Sends an icon to the screen that gives an approximate indication of the mob's pain. Looks like spikes/barbed wire.
/datum/species/proc/overlay_pain(level, atom/movable/screen/alert/aroused/arousal_alert)
	arousal_alert?.cut_overlay(arousal_alert.pain_overlay)
	arousal_alert?.pain_level = level
	arousal_alert?.pain_overlay = arousal_alert.update_pain()
	arousal_alert?.add_overlay(arousal_alert.pain_overlay)
	arousal_alert?.update_overlays()

/// Sends an icon to the screen that gives an approximate indication of the mob's pleasure. Looks like a pink-white border on the arousal alert heart.
/datum/species/proc/overlay_pleasure(level, atom/movable/screen/alert/aroused/arousal_alert)
	arousal_alert?.cut_overlay(arousal_alert.pleasure_overlay)
	arousal_alert?.pleasure_level = level
	arousal_alert?.pleasure_overlay = arousal_alert.update_pleasure()
	arousal_alert?.add_overlay(arousal_alert.pleasure_overlay)
	arousal_alert?.update_overlays()

/// Handles throwing the arousal alerts to screen.
/datum/species/proc/handle_arousal(mob/living/carbon/human/target_human, atom/movable/screen/alert/aroused)
	if(!target_human.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		return

	var/atom/movable/screen/alert/aroused/arousal_alert = target_human.alerts[AROUSED_ALERT]

	if(target_human.arousal <= 0)
		var/list/levels = list(AROUSED_SMALL, AROUSED_MEDIUM, AROUSED_HIGH, AROUSED_MAX)
		if(arousal_alert?.pleasure_level in levels)
			arousal_alert.cut_overlay(arousal_alert.pleasure_overlay)
		if(arousal_alert?.pain_level in levels)
			arousal_alert.cut_overlay(arousal_alert.pain_overlay)
		return

	var/alert_state
	switch(target_human.arousal)
		if(-INFINITY to AROUSAL_MINIMUM_DETECTABLE)
			target_human.clear_alert(AROUSED_ALERT, /atom/movable/screen/alert/aroused)
			if(target_human.arousal < AROUSAL_MINIMUM)
				target_human.arousal = AROUSAL_MINIMUM // To prevent massively negative values that break the lewd system for some.
		if(AROUSAL_MINIMUM_DETECTABLE to AROUSAL_LOW)
			alert_state = AROUSED_SMALL
		if(AROUSAL_LOW to AROUSAL_MEDIUM)
			alert_state = AROUSED_MEDIUM
		if(AROUSAL_HIGH to AROUSAL_AUTO_CLIMAX_THRESHOLD)
			alert_state = AROUSED_HIGH
		if(AROUSAL_AUTO_CLIMAX_THRESHOLD to INFINITY) //to prevent that 101 arousal that can make icon disappear or something.
			alert_state = AROUSED_MAX
	if(alert_state)
		throw_arousal_alert(alert_state, arousal_alert, target_human)
		alert_state = null

	if(target_human.arousal > AROUSAL_MINIMUM_DETECTABLE)
		switch(target_human.pain)
			if(-INFINITY to AROUSAL_MINIMUM_DETECTABLE) //to prevent same thing with pain
				arousal_alert?.cut_overlay(arousal_alert.pain_overlay)
				if(target_human.pain < AROUSAL_MINIMUM)
					target_human.pain = AROUSAL_MINIMUM // To prevent massively negative values that break the lewd system for some.
			if(AROUSAL_MINIMUM_DETECTABLE to AROUSAL_LOW)
				alert_state = AROUSED_SMALL
			if(AROUSAL_LOW to AROUSAL_MEDIUM)
				alert_state = AROUSED_MEDIUM
			if(AROUSAL_HIGH to AROUSAL_AUTO_CLIMAX_THRESHOLD)
				alert_state = AROUSED_HIGH
			if(AROUSAL_AUTO_CLIMAX_THRESHOLD to INFINITY)
				alert_state = AROUSED_MAX
	if(alert_state)
		overlay_pain(alert_state, arousal_alert)
		alert_state = null

	switch(target_human.pleasure)
		if(-INFINITY to AROUSAL_MINIMUM_DETECTABLE) //to prevent same thing with pleasure
			arousal_alert?.cut_overlay(arousal_alert.pleasure_overlay)
		if(AROUSAL_MINIMUM_DETECTABLE to AROUSAL_LOW)
			alert_state = AROUSED_SMALL
		if(AROUSAL_LOW to AROUSAL_MEDIUM)
			alert_state = AROUSED_MEDIUM
		if(AROUSAL_HIGH to AROUSAL_AUTO_CLIMAX_THRESHOLD)
			alert_state = AROUSED_HIGH
		if(AROUSAL_AUTO_CLIMAX_THRESHOLD to INFINITY)
			alert_state = AROUSED_MAX
	if(alert_state)
		overlay_pleasure(alert_state, arousal_alert)

#undef AROUSED_ALERT
#undef AROUSED_SMALL
#undef AROUSED_MEDIUM
#undef AROUSED_HIGH
#undef AROUSED_MAX
