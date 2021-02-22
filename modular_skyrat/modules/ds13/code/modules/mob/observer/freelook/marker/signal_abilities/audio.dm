/datum/signal_ability/audio
	name = "False Sound"
	id = "sound_premarker"
	desc = "Plays a fake sound of a chosen type, from a necromorph species of your choice. This spell becomes a lot cheaper once the marker is active"
	target_string = "any turf to play the sound from"
	energy_cost = 150
	cooldown = 3 MINUTES
	require_corruption = FALSE
	require_necrovision = TRUE
	target_types = list(/turf)

	targeting_method	=	TARGET_CLICK

	var/datum/species/selected_species
	var/selected_soundtype
	marker_active_required = -1

/datum/signal_ability/audio/marker
	name = "Deceptive Sound"
	id = "sound_postmarker"
	desc = "Plays a fake sound of a chosen type, from a necromorph species of your choice."

	energy_cost = 50
	cooldown = 10 SECONDS
	marker_active_required = TRUE


/datum/signal_ability/audio/pre_cast(var/mob/user)
	var/choice1 = input(user,"Select which necromorph type to impersonate. Try to pick something plausible for the current round time.","Species Selection") as null|anything in GLOB.all_necromorph_species
	if (!choice1)
		return FALSE

	var/choice2 = input(user,"Which kind of sound would you like to play?","Sound Selection") as null|anything in list(SOUND_ATTACK, SOUND_DEATH, SOUND_PAIN, SOUND_SHOUT, SOUND_SHOUT_LONG, SOUND_SPEECH)
	if (!choice2)
		return FALSE

	selected_species = GLOB.all_necromorph_species[choice1]
	selected_soundtype = choice2
	return TRUE

/datum/signal_ability/audio/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/volume = VOLUME_MID
	if (selected_soundtype == SOUND_SHOUT || selected_soundtype == SOUND_SHOUT_LONG || selected_soundtype == SOUND_DEATH)
		volume = VOLUME_LOUD
	selected_species.play_species_audio(target, selected_soundtype, volume, 1, 2)

