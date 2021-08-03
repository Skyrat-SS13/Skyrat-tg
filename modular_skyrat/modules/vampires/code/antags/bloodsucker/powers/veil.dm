/* This was a poor ability, and a keyfactor of why bloodsuckers are no longer going to get it as a balance reason.
/datum/action/bloodsucker/veil
	name = "Veil of Many Faces"
	desc = "Disguise yourself in the illusion of another identity."
	button_icon_state = "power_veil"
	bloodcost = 15
	cooldown = 100
	amToggle = TRUE
	bloodsucker_can_buy = TRUE
	warn_constant_cost = TRUE

	// Outfit Vars
	var/list/original_items = list()

	// Identity Vars
	var/prev_gender
	var/prev_skin_tone
	var/prev_hair_style
	var/prev_facial_hair_style
	var/prev_hair_color
	var/prev_facial_hair_color
	var/prev_underwear
	var/prev_undie_color
	var/prev_undershirt
	var/prev_shirt_color
	var/prev_socks
	var/prev_socks_color
	var/prev_disfigured
	var/list/prev_features	// For lizards and such


/datum/action/bloodsucker/veil/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return

	return TRUE


/datum/action/bloodsucker/veil/ActivatePower()

	cast_effect() // POOF

	//if (blahblahblah)
	//	Disguise_Outfit()

	Disguise_FaceName()


/datum/action/bloodsucker/veil/proc/Disguise_Outfit()

	// Step One: Back up original items




/datum/action/bloodsucker/veil/proc/Disguise_FaceName()

	// Change Name/Voice
	var/mob/living/carbon/human/H = owner
	H.name_override = H.dna.species.random_name(H.gender)
	H.name = H.name_override
	H.SetSpecialVoice(H.name_override)
	to_chat(owner, "<span class='warning'>You mystify the air around your person. Your identity is now altered.</span>")

	// Store Prev Appearance
	prev_gender = H.gender
	prev_skin_tone = H.skin_tone
	prev_hair_style = H.hairstyle
	prev_facial_hair_style = H.facial_hairstyle
	prev_hair_color = H.hair_color
	prev_facial_hair_color = H.facial_hair_color
	prev_underwear = H.underwear
	prev_undie_color = H.underwear_color
	prev_undershirt = H.undershirt
	prev_socks = H.socks
	prev_socks_color = H.socks_color
	//prev_eye_color
	prev_disfigured = HAS_TRAIT(H, TRAIT_DISFIGURED) // I was disfigured! //prev_disabilities = H.disabilities
	prev_features = H.dna.features

	// Change Appearance, not randomizing clothes colour, itll just be janky
	H.gender = pick(MALE, FEMALE)
	H.skin_tone_override = null
	H.skin_tone = random_skin_tone()
	H.hair_style = random_hairstyle(H.gender)
	H.facial_hair_style = pick(random_facial_hairstyle(H.gender),"Shaved")
	H.hair_color = random_short_color()
	H.facial_hair_color = H.hair_color
	H.underwear = random_underwear(H.gender)
	H.undershirt = random_undershirt(H.gender)
	H.socks = random_socks(H.gender)
	//H.eye_color = random_eye_color()
	REMOVE_TRAIT(H, TRAIT_DISFIGURED, null) //
	H.dna.features = random_features(H.dna.species?.id, H.gender)

	// Apply Appearance
	H.update_body(TRUE) // Outfit and underwear, also body and privates.
	//H.update_mutant_bodyparts() // Lizard tails etc
	H.update_hair()
	H.update_body_parts()

	// Wait here until we deactivate power or go unconscious
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
	while (ContinueActive(owner) && istype(bloodsuckerdatum))//active && owner && owner.stat == CONSCIOUS)
		bloodsuckerdatum.AddBloodVolume(-0.2)
		sleep(10)

	// Wait for a moment if you fell unconscious...
	if (owner && owner.stat > CONSCIOUS)
		sleep(50)


/datum/action/bloodsucker/veil/DeactivatePower(mob/living/user = owner, mob/living/target)
	..()
	if (ishuman(user))
		var/mob/living/carbon/human/H = user

		// Revert Identity
		H.UnsetSpecialVoice()
		H.name_override = null
		H.name = H.real_name

		// Revert Appearance
		H.gender = prev_gender
		H.skin_tone = prev_skin_tone
		if(!GLOB.skin_tones[H.skin_tone])
			H.dna.skin_tone_override = H.skin_tone
		H.hair_style = prev_hair_style
		H.facial_hair_style = prev_facial_hair_style
		H.hair_color = prev_hair_color
		H.facial_hair_color = prev_facial_hair_color
		H.underwear = prev_underwear
		H.undie_color = prev_undie_color
		H.undershirt = prev_undershirt
		H.shirt_color = prev_shirt_color
		H.socks = prev_socks
		H.socks_color = prev_socks_color

		//H.disabilities = prev_disabilities // Restore HUSK, CLUMSY, etc.
		if (prev_disfigured)
			ADD_TRAIT(H, TRAIT_DISFIGURED, "husk") // NOTE: We are ASSUMING husk. // H.status_flags |= DISFIGURED	// Restore "Unknown" disfigurement
		H.dna.features = prev_features
		// Apply Appearance
		H.update_body(TRUE) // Outfit and underwear, also body and privates.
		H.update_hair()
		H.update_body_parts()	// Body itself, maybe skin color?
		cast_effect() // POOF

	// CAST EFFECT //	// General effect (poof, splat, etc) when you cast. Doesn't happen automatically!
/datum/action/bloodsucker/veil/proc/cast_effect()
	// Effect
	playsound(get_turf(owner), 'sound/magic/smoke.ogg', 20, 1)
	var/datum/effect_system/steam_spread/puff = new /datum/effect_system/steam_spread/()
	puff.effect_type = /obj/effect/particle_effect/smoke/vampsmoke
	puff.set_up(3, 0, get_turf(owner))
	puff.attach(owner) // OPTIONAL
	puff.start()
	owner.spin(8, 1) // Spin around like a loon.

/obj/effect/particle_effect/smoke/vampsmoke
	opaque = FALSE
	lifetime = 0
/obj/effect/particle_effect/smoke/vampsmoke/fade_out(frames = 6)
	..(frames)
*/


