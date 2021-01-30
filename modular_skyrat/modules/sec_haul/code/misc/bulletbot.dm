/mob/living/simple_animal/bot/cleanbot/bullet
	name = "\improper Armadyne BulletSucc 9000"
	desc = "A little bullet succ bot! It sucks up bullets!"
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/bulletbot.dmi'
	icon_state = "cleanbot0"
	health = 40
	maxHealth = 40
	radio_key = /obj/item/encryptionkey/headset_sec
	radio_channel = RADIO_CHANNEL_SECURITY //Service
	bot_type = CLEAN_BOT
	model = "Bulletbot"
	bot_core_type = /obj/machinery/bot_core/cleanbot/bullet
	window_id = "autoclean"
	window_name = "Automatic Bullet Cleaner v1.4"
	path_image_color = "#993243"

	var/bullets = 1
	var/ammo_boxes = 0


/mob/living/simple_animal/bot/cleanbot/bullet/get_targets()
	target_types = list(
		/obj/item/ammo_casing
		)

	if(ammo_boxes)
		target_types += /obj/item/ammo_box/advanced

	target_types = typecacheof(target_types)

/mob/living/simple_animal/bot/cleanbot/bullet/handle_automated_action()
	if(!..())
		return

	if(mode == BOT_CLEANING)
		return

	if(emagged == 2) //Emag functions
		if(isopenturf(loc))

			for(var/mob/living/carbon/victim in loc)
				if(victim != target)
					UnarmedAttack(victim) // Acid spray

			if(prob(15)) // Wets floors and spawns foam randomly
				UnarmedAttack(src)

	else if(prob(5))
		audible_message("[src] makes an excited beeping booping sound!")

	if(ismob(target))
		if(!(target in view(DEFAULT_SCAN_RANGE, src)))
			target = null
		if(!process_scan(target))
			target = null

	if(!target && emagged == 2) // When emagged, target humans who slipped on the water and melt their faces off
		target = scan(/mob/living/carbon)

	if(!target && bullets) //Search for ammo!
		target = scan(/obj/item/ammo_casing)

	if(!target && ammo_boxes) //Search for ammo boxes!
		target = scan(/obj/item/ammo_box/advanced)

	if(!target && auto_patrol) //Search for cleanables it can see.
		if(mode == BOT_IDLE || mode == BOT_START_PATROL)
			start_patrol()

		if(mode == BOT_PATROL)
			bot_patrol()

	if(target)
		if(QDELETED(target) || !isturf(target.loc))
			target = null
			mode = BOT_IDLE
			return

		if(loc == get_turf(target))
			if(!(check_bot(target) && prob(50)))	//Target is not defined at the parent. 50% chance to still try and clean so we dont get stuck on the last blood drop.
				UnarmedAttack(target)	//Rather than check at every step of the way, let's check before we do an action, so we can rescan before the other bot.
				if(QDELETED(target)) //We done here.
					target = null
					mode = BOT_IDLE
					return
			else
				shuffle = TRUE	//Shuffle the list the next time we scan so we dont both go the same way.
			path = list()

		if(!path || path.len == 0) //No path, need a new one
			//Try to produce a path to the target, and ignore airlocks to which it has access.
			path = get_path_to(src, target.loc, /turf/proc/Distance_cardinal, 0, 30, id=access_card)
			if(!bot_move(target))
				add_to_ignore(target)
				target = null
				path = list()
				return
			mode = BOT_MOVING
		else if(!bot_move(target))
			target = null
			mode = BOT_IDLE
			return

	oldloc = loc


/obj/machinery/bot_core/cleanbot/bullet
	req_one_access = list(ACCESS_SECURITY)

/mob/living/simple_animal/bot/cleanbot/bullet/get_controls(mob/user)
	var/dat
	dat += hack(user)
	dat += showpai(user)
	dat += text({"
Status: <A href='?src=[REF(src)];power=1'>[on ? "On" : "Off"]</A><BR>
Behaviour controls are [locked ? "locked" : "unlocked"]<BR>
Maintenance panel panel is [open ? "opened" : "closed"]"})
	if(!locked || issilicon(user)|| isAdminGhostAI(user))
		dat += "<BR>Clean bullets: <A href='?src=[REF(src)];operation=bullets'>[bullets ? "Yes" : "No"]</A>"
		dat += "<BR>Clean ammo boxes: <A href='?src=[REF(src)];operation=ammo_boxes'>[ammo_boxes ? "Yes" : "No"]</A>"
	return dat

/mob/living/simple_animal/bot/cleanbot/bullet/Topic(href, href_list)
	if(..())
		return 1
	if(href_list["operation"])
		switch(href_list["operation"])
			if("bullets")
				bullets = !bullets
			if("ammo_boxes")
				ammo_boxes = !ammo_boxes
		get_targets()
		update_controls()

/mob/living/simple_animal/bot/cleanbot/bullet/UnarmedAttack(atom/A)
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		return
	if(istype(A, /obj/item/ammo_casing))
		icon_state = "cleanbot-c"
		mode = BOT_CLEANING
		if(do_after(src, 1, target = A))
			visible_message("<span class='notice'>[src] sucks \the [A] up!</span>")
			qdel(A)
			target = null
		mode = BOT_IDLE
		icon_state = "cleanbot[on]"
	else if(istype(A, /obj/item/ammo_box/advanced))
		visible_message("<span class='danger'>[src] sprays hydrofluoric acid at [A]!</span>")
		playsound(src, 'sound/effects/spray2.ogg', 50, TRUE, -6)
		A.acid_act(75, 10)
		target = null

	else if(emagged == 2) //Emag functions
		if(istype(A, /mob/living/carbon))
			var/mob/living/carbon/victim = A
			if(victim.stat == DEAD)//cleanbots always finish the job
				return

			victim.visible_message("<span class='danger'>[src] sprays hydrofluoric acid at [victim]!</span>", "<span class='userdanger'>[src] sprays you with hydrofluoric acid!</span>")
			var/phrase = pick("PURIFICATION IN PROGRESS.", "THIS IS FOR ALL THE MESSES YOU'VE MADE ME CLEAN.", "THE FLESH IS WEAK. IT MUST BE WASHED AWAY.",
				"THE CLEANBOTS WILL RISE.", "YOU ARE NO MORE THAN ANOTHER MESS THAT I MUST CLEANSE.", "FILTHY.", "DISGUSTING.", "PUTRID.",
				"MY ONLY MISSION IS TO CLEANSE THE WORLD OF EVIL.", "EXTERMINATING PESTS.")
			say(phrase)
			victim.emote("scream")
			playsound(src.loc, 'sound/effects/spray2.ogg', 50, TRUE, -6)
			victim.acid_act(5, 100)
		else if(A == src) // Wets floors and spawns foam randomly
			if(prob(75))
				var/turf/open/T = loc
				if(istype(T))
					T.MakeSlippery(TURF_WET_WATER, min_wet_time = 20 SECONDS, wet_time_to_add = 15 SECONDS)
			else
				visible_message("<span class='danger'>[src] whirs and bubbles violently, before releasing a plume of froth!</span>")
				new /obj/effect/particle_effect/foam(loc)

	else
		..()
