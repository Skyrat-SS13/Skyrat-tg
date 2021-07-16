/obj/structure/bodycontainer/crematorium
	var/cremating = FALSE

/obj/structure/bodycontainer/crematorium/proc/start_cremation()
	cremating = TRUE
	locked = TRUE
	update_appearance()
	audible_message(span_hear("You hear a roar as the crematorium activates."))
	playsound(src, 'modular_skyrat/master_files/sound/crematorium.ogg', 100)
	START_PROCESSING(SSobj, src)

/obj/structure/bodycontainer/crematorium/proc/stop_cremating()
	cremating = FALSE
	locked = FALSE
	playsound(src.loc, 'sound/machines/ding.ogg', 50, TRUE) //you horrible people
	STOP_PROCESSING(SSobj, src)

/obj/structure/bodycontainer/crematorium/process(delta_time)
	if(!locked)
		STOP_PROCESSING(SSobj, src)
		return

	var/list/conts = GetAllContents() - src - connected

	if(!conts)
		stop_cremating()
		return

	for(var/obj/O in conts) //conts defined above, ignores crematorium and tray
		qdel(O)
		if(!locate(/obj/effect/decal/cleanable/ash) in get_step(src, dir))//prevent pile-up
			new/obj/effect/decal/cleanable/ash/crematorium(src)
	var/alive_mobs = 0
	for(var/mob/living/M in conts)
		if(M.stat == DEAD)
			continue
		alive_mobs++
		if(ishuman(M))
			var/mob/living/carbon/human/burning_soul = M
			var/list/bodyparts = burning_soul.bodyparts
			shuffle(bodyparts)
			var/obj/item/bodypart/bodypart = pick(bodyparts)
			if(bodypart.brute_dam + bodypart.burn_dam > bodypart.max_damage && !(bodypart.body_zone == BODY_ZONE_HEAD || bodypart.body_zone == BODY_ZONE_CHEST))
				bodypart.dismember()
				to_chat(burning_soul, span_userdanger("Your [bodypart] is turned to carbon as it disintegrates into ash!"))
				M.emote("scream")
				qdel(bodypart)
				return
			bodypart.receive_damage(burn = 30)
			burning_soul.update_body_parts()
			to_chat(burning_soul, span_userdanger("Your body charred by the raging inferno!"))
		else
			M.adjustFireLoss(30)
		M.emote("scream")

	if(!alive_mobs)
		stop_cremating()
		return
