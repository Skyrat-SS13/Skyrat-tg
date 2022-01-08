//Simple ability that makes a loud screaming noise, causes screenshake in everyone nearby.
/mob/proc/shout()
	set name = "Shout"
	set category = "Abilities"

	if (incapacitated(INCAPACITATION_KNOCKOUT))
		return

	do_shout(SOUND_SHOUT)


//Simple ability that makes a louder screaming noise, causes more screenshake in everyone nearby.
/mob/proc/shout_long()
	set name = "Scream"
	set category = "Abilities"

	if (incapacitated(INCAPACITATION_KNOCKOUT))
		return

	do_shout(SOUND_SHOUT_LONG)



/mob/proc/do_shout(var/sound_type, var/do_stun = TRUE)
	if (check_audio_cooldown(sound_type))
		if (play_species_audio(src, sound_type, VOLUME_HIGH, 1, 2))
			if (do_stun)
				src.Stun(1)
			src.shake_animation(40)
			set_audio_cooldown(sound_type, 8 SECONDS)
			new /obj/effect/effect/expanding_circle(loc, 2, 3 SECOND)	//Visual effect
			for (var/mob/M in range(8, src))
				var/distance = get_dist(src, M)
				var/intensity = 5 - (distance * 0.3)
				var/duration = (7 - (distance * 0.5)) SECONDS
				shake_camera(M, duration, intensity)
				//TODO in future: Add psychosis damage here for non-necros who hear the scream