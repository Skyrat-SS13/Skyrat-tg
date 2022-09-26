/datum/hallucination/shock
	var/image/shock_image
	var/image/electrocution_skeleton_anim

/datum/hallucination/shock/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	shock_image = image(target, target, dir = target.dir)
	shock_image.appearance_flags |= KEEP_APART
	shock_image.color = rgb(0,0,0)
	shock_image.override = TRUE
	electrocution_skeleton_anim = image('icons/mob/human.dmi', target, icon_state = "electrocuted_base", layer=ABOVE_MOB_LAYER)
	electrocution_skeleton_anim.appearance_flags |= RESET_COLOR|KEEP_APART

	to_chat(hallucinator, span_userdanger("You feel a powerful shock course through your body!"))
	hallucinator.visible_message(span_warning("[hallucinator] falls to the ground, shaking!"), ignored_mobs = hallucinator)
	hallucinator.client?.images |= shock_image
	hallucinator.client?.images |= electrocution_skeleton_anim

	hallucinator.playsound_local(get_turf(src), SFX_SPARKS, 100, TRUE)
	hallucinator.adjustStaminaLoss(50)
	hallucinator.Stun(4 SECONDS)
	hallucinator.do_jitter_animation(300) // Maximum jitter
	hallucinator.adjust_jitter(20 SECONDS)

	addtimer(CALLBACK(src, .proc/reset_shock_animation), 4 SECONDS)
	addtimer(CALLBACK(src, .proc/shock_drop), 2 SECONDS)

/datum/hallucination/shock/proc/reset_shock_animation()
	target.client?.images.Remove(shock_image)
	target.client?.images.Remove(electrocution_skeleton_anim)

/datum/hallucination/shock/proc/shock_drop()
	target.Paralyze(6 SECONDS)
