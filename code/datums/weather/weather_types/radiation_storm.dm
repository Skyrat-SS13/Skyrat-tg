//Radiation storms occur when the station passes through an irradiated area, and irradiate anyone not standing in protected areas (maintenance, emergency storage, etc.)
/datum/weather/rad_storm
	name = "radiation storm"
	desc = "A cloud of intense radiation passes through the area dealing rad damage to those who are unprotected."

	telegraph_duration = 400
	telegraph_message = "<span class='danger'>The air begins to grow warm.</span>"

	weather_message = "<span class='userdanger'><i>You feel waves of heat wash over you! Find shelter!</i></span>"
	weather_overlay = "ash_storm"
	weather_duration_lower = 600
	weather_duration_upper = 1500
	weather_color = "green"
	weather_sound = 'sound/misc/bloblarm.ogg'

	end_duration = 100
	end_message = "<span class='notice'>The air seems to be cooling off again.</span>"

	area_type = /area
	protected_areas = list(/area/station/maintenance, /area/station/ai_monitored/turret_protected/ai_upload, /area/station/ai_monitored/turret_protected/ai_upload_foyer,
							/area/station/ai_monitored/turret_protected/aisat/maint, /area/station/ai_monitored/command/storage/satellite,
							/area/station/ai_monitored/turret_protected/ai, /area/station/commons/storage/emergency/starboard, /area/station/commons/storage/emergency/port,
							/area/shuttle, /area/station/security/prison/safe, /area/station/security/prison/toilet, /area/icemoon/underground, /area/ruin/comms_agent/maint)
	target_trait = ZTRAIT_STATION

	immunity_type = TRAIT_RADSTORM_IMMUNE
	/// Chance we get a negative mutation, if we fail we get a positive one
	var/negative_mutation_chance = 90
	/// Chance we mutate
	var/mutate_chance = 40

/datum/weather/rad_storm/telegraph()
	..()
	status_alarm(TRUE)


/datum/weather/rad_storm/weather_act(mob/living/L)
	if(!prob(mutate_chance))
		return

	if(!ishuman(L))
		return

	var/mob/living/carbon/human/H = L
	if(!H.can_mutate() || H.status_flags & GODMODE)
		return

	if(HAS_TRAIT(H, TRAIT_RADIMMUNE))
		return

	if (SSradiation.wearing_rad_protected_clothing(H))
		return

	H.random_mutate_unique_identity()
	H.random_mutate_unique_features()

	if(prob(50))
		do_mutate(L)

/datum/weather/rad_storm/end()
	if(..())
		return
	priority_announce("The radiation threat has passed. Please return to your workplaces.", "Anomaly Alert", ANNOUNCER_RADIATIONPASSED) //SKYRAT EDIT CHANGE
	status_alarm(FALSE)

/datum/weather/rad_storm/proc/do_mutate(mob/living/carbon/human/mutant)
	if(prob(negative_mutation_chance))
		mutant.easy_random_mutate(NEGATIVE+MINOR_NEGATIVE)
	else
		mutant.easy_random_mutate(POSITIVE)
	mutant.domutcheck()

/datum/weather/rad_storm/proc/status_alarm(active) //Makes the status displays show the radiation warning for those who missed the announcement.
	var/datum/radio_frequency/frequency = SSradio.return_frequency(FREQ_STATUS_DISPLAYS)
	if(!frequency)
		return

	var/datum/signal/signal = new
	if (active)
		signal.data["command"] = "alert"
		signal.data["picture_state"] = "radiation"
	else
		signal.data["command"] = "shuttle"

	var/atom/movable/virtualspeaker/virtual_speaker = new(null)
	frequency.post_signal(virtual_speaker, signal)

/// Used by the radioactive nebula when the station doesnt have enough shielding
/datum/weather/rad_storm/nebula
	protected_areas = list(/area/shuttle, /area/station/maintenance/radshelter)

	weather_overlay = "nebula_radstorm"
	weather_duration_lower = 100 HOURS
	weather_duration_upper = 100 HOURS

	end_message = null

	mutate_chance = 0.1

	///Chance we pulse a living during the storm
	var/radiation_chance = 5

/datum/weather/rad_storm/nebula/weather_act(mob/living/living)
	..()

	if(!prob(radiation_chance))
		return

	if(!SSradiation.can_irradiate_basic(living) || SSradiation.wearing_rad_protected_clothing(living))
		return

	radiation_pulse(
		source = living,
		max_range = 0,
		threshold = RAD_LIGHT_INSULATION,
		chance = URANIUM_IRRADIATION_CHANCE,
	)

/datum/weather/rad_storm/nebula/status_alarm(active)
	if(!active) //we stay on
		return
	..()
