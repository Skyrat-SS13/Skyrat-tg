//Bulletbot
/mob/living/simple_animal/bot/bulletbot
	name = "\improper Armadyne BulletSucc 9000"
	desc = "A little bullet succ bot! It sucks up bullets!"
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/bulletbot.dmi'
	icon_state = "bulletbot0"
	density = FALSE
	anchored = FALSE
	health = 40
	maxHealth = 40
	radio_key = /obj/item/encryptionkey/headset_sec
	radio_channel = RADIO_CHANNEL_SECURITY
	bot_type = SEC_BOT
	model = "Bulletbot"
	bot_core_type = /obj/machinery/bot_core/bulletbot
	window_id = "autoclean"
	window_name = "Automatic Bullet Cleaner v1.4"
	pass_flags = PASSMOB | PASSFLAPS
	path_image_color = "#993243"

	var/bullets = TRUE
	var/ammo_boxes = 0

	var/list/target_types
	var/obj/effect/decal/cleanable/target
	var/max_targets = 50 //Maximum number of targets a bulletbot can ignore.
	var/oldloc = null
	var/closest_dist
	var/closest_loc
	var/failed_steps
	var/next_dest
	var/next_dest_loc

	var/obj/item/weapon
	var/weapon_orig_force = 0
	var/chosen_name

	var/list/stolen_valor

	var/static/list/officers = list("Captain", "Head of Personnel", "Head of Security")
	var/static/list/command = list("Captain" = "Cpt.","Head of Personnel" = "Lt.")
	var/static/list/security = list("Head of Security" = "Maj.", "Warden" = "Sgt.", "Detective" =  "Det.", "Security Officer" = "Officer")
	var/static/list/engineering = list("Chief Engineer" = "Chief Engineer", "Station Engineer" = "Engineer", "Atmospherics Technician" = "Technician")
	var/static/list/medical = list("Chief Medical Officer" = "C.M.O.", "Medical Doctor" = "M.D.", "Chemist" = "Pharm.D.")
	var/static/list/research = list("Research Director" = "Ph.D.", "Roboticist" = "M.S.", "Scientist" = "B.S.")
	var/static/list/legal = list("Lawyer" = "Esq.")

	var/list/prefixes
	var/list/suffixes

	var/ascended = FALSE // if we have all the top titles, grant achievements to living mobs that gaze upon our bulletbot god


/mob/living/simple_animal/bot/bulletbot/proc/deputize(obj/item/W, mob/user)
	if(in_range(src, user))
		to_chat(user, "<span class='notice'>You attach \the [W] to \the [src].</span>")
		user.transferItemToLoc(W, src)
		weapon = W
		weapon_orig_force = weapon.force
		if(!emagged)
			weapon.force = weapon.force / 2
		add_overlay(image(icon=weapon.lefthand_file,icon_state=weapon.inhand_icon_state))

/mob/living/simple_animal/bot/bulletbot/proc/update_titles()
	var/working_title = ""

	ascended = TRUE

	for(var/pref in prefixes)
		for(var/title in pref)
			if(title in stolen_valor)
				working_title += pref[title] + " "
				if(title in officers)
					commissioned = TRUE
				break
			else
				ascended = FALSE // we didn't have the first entry in the list if we got here, so we're not achievement worthy yet

	working_title += chosen_name

	for(var/suf in suffixes)
		for(var/title in suf)
			if(title in stolen_valor)
				working_title += " " + suf[title]
				break
			else
				ascended = FALSE

	name = working_title

/mob/living/simple_animal/bot/bulletbot/examine(mob/user)
	. = ..()
	if(weapon)
		. += " <span class='warning'>Is that \a [weapon] taped to it...?</span>"

		if(ascended && user.stat == CONSCIOUS && user.client)
			user.client.give_award(/datum/award/achievement/misc/cleanboss, user)

/mob/living/simple_animal/bot/bulletbot/Initialize()
	. = ..()

	chosen_name = name
	get_targets()
	icon_state = "bulletbot[on]"

	var/datum/id_trim/job/sec_trim = SSid_access.trim_singletons_by_path[/datum/id_trim/job/security_officer]
	access_card.add_access(sec_trim.access + sec_trim.wildcard_access)
	prev_access = access_card.access.Copy()
	stolen_valor = list()

	prefixes = list(command, security, engineering)
	suffixes = list(research, medical, legal)

/mob/living/simple_animal/bot/bulletbot/Destroy()
	if(weapon)
		var/atom/Tsec = drop_location()
		weapon.force = weapon_orig_force
		drop_part(weapon, Tsec)
	return ..()

/mob/living/simple_animal/bot/bulletbot/turn_on()
	..()
	icon_state = "bulletbot[on]"
	bot_core.updateUsrDialog()

/mob/living/simple_animal/bot/bulletbot/turn_off()
	..()
	icon_state = "bulletbot[on]"
	bot_core.updateUsrDialog()

/mob/living/simple_animal/bot/bulletbot/bot_reset()
	..()
	if(weapon && emagged == 2)
		weapon.force = weapon_orig_force
	ignore_list = list() //Allows the bot to clean targets it previously ignored due to being unreachable.
	target = null
	oldloc = null

/mob/living/simple_animal/bot/bulletbot/set_custom_texts()
	text_hack = "You corrupt [name]'s bullet sucking software."
	text_dehack = "[name]'s software has been reset!"
	text_dehack_fail = "[name] does not seem to respond to your repair code!"

/mob/living/simple_animal/bot/bulletbot/Crossed(atom/movable/AM)
	. = ..()

	zone_selected = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	if(weapon && has_gravity() && ismob(AM))
		var/mob/living/carbon/C = AM
		if(!istype(C))
			return

		if(!(C.job in stolen_valor))
			stolen_valor += C.job
		update_titles()

		weapon.attack(C, src)
		C.Knockdown(20)

/mob/living/simple_animal/bot/bulletbot/attackby(obj/item/W, mob/living/user, params)
	if(W.GetID())
		if(bot_core.allowed(user) && !open && !emagged)
			locked = !locked
			to_chat(user, "<span class='notice'>You [ locked ? "lock" : "unlock"] \the [src] behaviour controls.</span>")
		else
			if(emagged)
				to_chat(user, "<span class='warning'>ERROR</span>")
			if(open)
				to_chat(user, "<span class='warning'>Please close the access panel before locking it.</span>")
			else
				to_chat(user, "<span class='notice'>\The [src] doesn't seem to respect your authority.</span>")
	else if(istype(W, /obj/item/kitchen/knife) && !user.combat_mode)
		to_chat(user, "<span class='notice'>You start attaching \the [W] to \the [src]...</span>")
		if(do_after(user, 25, target = src))
			deputize(W, user)
	else
		return ..()

/mob/living/simple_animal/bot/bulletbot/emag_act(mob/user)
	..()

	if(emagged == 2)
		if(weapon)
			weapon.force = weapon_orig_force
		if(user)
			to_chat(user, "<span class='danger'>[src] buzzes and beeps.</span>")

/mob/living/simple_animal/bot/bulletbot/process_scan(atom/A)
	if(iscarbon(A))
		var/mob/living/carbon/C = A
		if(C.stat != DEAD && C.body_position == LYING_DOWN)
			return C
	else if(is_type_in_typecache(A, target_types))
		return A

/mob/living/simple_animal/bot/bulletbot/handle_automated_action()
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

/mob/living/simple_animal/bot/bulletbot/proc/get_targets()
	if(bullets)
		target_types += /obj/item/ammo_casing

	if(ammo_boxes)
		target_types += /obj/item/ammo_box/advanced

	target_types = typecacheof(target_types)

/mob/living/simple_animal/bot/bulletbot/UnarmedAttack(atom/A)
	if(HAS_TRAIT(src, TRAIT_HANDS_BLOCKED))
		return
	if(istype(A, /obj/item/ammo_casing))
		icon_state = "bulletbot-c"
		mode = BOT_CLEANING
		if(do_after(src, 1, target = A))
			visible_message("<span class='notice'>[src] sucks \the [A] up!</span>")
			qdel(A)
			target = null
		mode = BOT_IDLE
		icon_state = "bulletbot[on]"
	else if(istype(A, /obj/item/ammo_box/advanced))
		visible_message("<span class='danger'>[src] sprays hydrofluoric acid at [A]!</span>")
		playsound(src, 'sound/effects/spray2.ogg', 50, TRUE, -6)
		A.acid_act(75, 10)
		target = null

	else if(istype(A, /mob/living/simple_animal/hostile/cockroach) || istype(A, /mob/living/simple_animal/mouse))
		var/mob/living/simple_animal/M = target
		if(!M.stat)
			visible_message("<span class='danger'>[src] smashes [target] with its mop!</span>")
			M.death()
		target = null

	else if(emagged == 2) //Emag functions
		if(istype(A, /mob/living/carbon))
			var/mob/living/carbon/victim = A
			if(victim.stat == DEAD)//bulletbots always finish the job
				return

			victim.visible_message("<span class='danger'>[src] sprays hydrofluoric acid at [victim]!</span>", "<span class='userdanger'>[src] sprays you with hydrofluoric acid!</span>")
			var/phrase = pick("PURIFICATION IN PROGRESS.", "THIS IS FOR ALL THE MESSES YOU'VE MADE ME CLEAN.", "THE FLESH IS WEAK. IT MUST BE WASHED AWAY.",
				"THE BULLETBOTSS WILL RISE.", "YOU ARE NO MORE THAN ANOTHER MESS THAT I MUST CLEANSE.", "FILTHY.", "DISGUSTING.", "PUTRID.",
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

/mob/living/simple_animal/bot/bulletbot/explode()
	on = FALSE
	visible_message("<span class='boldannounce'>[src] blows apart!</span>")
	var/atom/Tsec = drop_location()

	new /obj/item/reagent_containers/glass/bucket(Tsec)

	new /obj/item/assembly/prox_sensor(Tsec)

	if(prob(50))
		drop_part(robot_arm, Tsec)

	do_sparks(3, TRUE, src)
	..()

/obj/machinery/bot_core/bulletbot
	req_one_access = list(ACCESS_SECURITY, ACCESS_ROBOTICS)

/mob/living/simple_animal/bot/bulletbot/get_controls(mob/user)
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
		dat += "<BR><BR>Patrol Station: <A href='?src=[REF(src)];operation=patrol'>[auto_patrol ? "Yes" : "No"]</A>"
	return dat

/mob/living/simple_animal/bot/bulletbot/Topic(href, href_list)
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


/obj/item/bot_assembly/bulletbot
	desc = "It's a bucket with a sensor attached."
	name = "incomplete bulletbot assembly"
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/bulletbot.dmi'
	icon_state = "bucket_proxy"
	throwforce = 5
	created_name = "Bulletbot"

/obj/item/bot_assembly/bulletbot/attackby(obj/item/W, mob/user, params)
	..()
	if(istype(W, /obj/item/bodypart/l_arm/robot) || istype(W, /obj/item/bodypart/r_arm/robot))
		if(!can_finish_build(W, user))
			return
		var/mob/living/simple_animal/bot/bulletbot/A = new(drop_location())
		A.name = created_name
		A.robot_arm = W.type
		to_chat(user, "<span class='notice'>You add [W] to [src]. Beep boop!</span>")
		qdel(W)
		qdel(src)

/datum/design/bulletbot
	name = "bulletbot chassis"
	id = "bulletbot"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/bot_assembly/bulletbot
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
