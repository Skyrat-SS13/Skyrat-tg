// Dogborg Sleeper units

/obj/item/dogborg/sleeper
	name = "hound sleeper"
	desc = "nothing should see this."
	icon = 'icons/mob/robot_items.dmi'
	icon_state = "sleeper"
	w_class = WEIGHT_CLASS_TINY
	var/mob/living/carbon/patient
	var/inject_amount = 10
	var/min_health = -100
	var/cleaning = FALSE
	var/cleaning_cycles = 10
	var/patient_laststat = null
	var/list/injection_chems = list(/datum/reagent/medicine/antitoxin, /datum/reagent/medicine/epinephrine,
								/datum/reagent/medicine/salbutamol, /datum/reagent/medicine/bicaridine, /datum/reagent/medicine/kelotane)
	var/eject_port = "ingestion"
	var/escape_in_progress = FALSE
	var/message_cooldown
	var/breakout_time = 150
	var/tmp/last_hearcheck = 0
	var/tmp/list/hearing_mobs
	var/list/items_preserved = list()
	var/static/list/important_items = typecacheof(list(
		/obj/item/hand_tele,
		/obj/item/card/id,
		/obj/item/aicard,
		/obj/item/gun,
		/obj/item/pinpointer,
		/obj/item/clothing/shoes/magboots,
		/obj/item/clothing/head/helmet/space,
		/obj/item/clothing/suit/space,
		/obj/item/reagent_containers/hypospray/CMO,
		/obj/item/tank/jetpack/oxygen/captain,
		/obj/item/clothing/accessory/medal/gold/captain,
		/obj/item/clothing/suit/armor,
		/obj/item/documents,
		/obj/item/nuke_core,
		/obj/item/nuke_core_container,
		/obj/item/areaeditor/blueprints,
		/obj/item/documents/syndicate,
		/obj/item/disk/nuclear,
		/obj/item/bombcore,
		/obj/item/grenade,
		/obj/item/storage
		))

// Bags are prohibited from this due to the potential explotation of objects, same with brought

/obj/item/dogborg/sleeper/Initialize()
	. = ..()
	update_icon()
	item_flags |= NOBLUDGEON //No more attack messages
	START_PROCESSING(SSobj, src)

/obj/item/dogborg/sleeper/Destroy()
	STOP_PROCESSING(SSobj, src)
	go_out() //just... sanity I guess, edge case shit
	return ..()

/obj/item/dogborg/sleeper/Exit(atom/movable/O)
	return 0

/obj/item/dogborg/sleeper/proc/get_host()
	if(!loc)
		return
	if(iscyborg(loc))
		return loc
	else if(iscyborg(loc.loc))
		return loc.loc //cursed cyborg code

/obj/item/dogborg/sleeper/afterattack(mob/living/carbon/target, mob/living/silicon/user, proximity)
	var/mob/living/silicon/robot/hound = get_host()
	if(!hound)
		return
	if(!proximity)
		return
	if(!iscarbon(target))
		return
	var/voracious = TRUE
	if(!target.client || !(target.client.prefs.cit_toggles & MEDIHOUND_SLEEPER) || !hound.client || !(hound.client.prefs.cit_toggles & MEDIHOUND_SLEEPER))
		voracious = FALSE
	if(target.buckled)
		to_chat(user, "<span class='warning'>The user is buckled and can not be put into your [src].</span>")
		return
	if(patient)
		to_chat(user, "<span class='warning'>Your [src] is already occupied.</span>")
		return
	user.visible_message("<span class='warning'>[hound.name] is carefully inserting [target.name] into their [src].</span>", "<span class='notice'>You start placing [target] into your [src]...</span>")
	if(!patient && iscarbon(target) && !target.buckled && do_after (user, 100, target = target))

		if(!in_range(src, target)) //Proximity is probably old news by now, do a new check.
			return //If they moved away, you can't eat them.

		if(patient)
			return //If you try to eat two people at once, you can only eat one.

		else //If you don't have someone in you, proceed.
			if(!isjellyperson(target) && ("toxin" in injection_chems))
				injection_chems -= "toxin"
				injection_chems += "antitoxin"
			if(isjellyperson(target) && !("toxin" in injection_chems))
				injection_chems -= "antitoxin"
				injection_chems += "toxin"
			target.forceMove(src)
			target.reset_perspective(src)
			target.ExtinguishMob() //The tongue already puts out fire stacks but being put into the sleeper shouldn't allow you to keep burning.
			update_gut(hound)
			user.visible_message("<span class='warning'>[voracious ? "[hound]'s [src.name] lights up and expands as [target] slips inside into their [src.name]." : "[hound]'s sleeper indicator lights up as [target] is scooped up into [hound.p_their()] [src]."]</span>", \
				"<span class='notice'>Your [voracious ? "[src.name] lights up as [target] slips into" : "sleeper indicator light shines brightly as [target] is scooped inside"] your [src]. Life support functions engaged.</span>")
			message_admins("[key_name(hound)] has sleeper'd [key_name(patient)] as a dogborg. [ADMIN_JMP(src)]")
			playsound(hound, 'sound/effects/bin_close.ogg', 100, 1)

/obj/item/dogborg/sleeper/container_resist(mob/living/user)
	var/mob/living/silicon/robot/hound = get_host()
	if(!hound)
		go_out(user)
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	if(user.a_intent == INTENT_HELP)
		return
	var/voracious = TRUE
	if(!user.client || !(user.client.prefs.cit_toggles & MEDIHOUND_SLEEPER) || !hound.client || !(hound.client.prefs.cit_toggles & MEDIHOUND_SLEEPER))
		voracious = FALSE
	user.visible_message("<span class='notice'>You see [voracious ? "[user] struggling against the expanded material of [hound]'s gut!" : "and hear [user] pounding against something inside of [hound]'s [src.name]!"]</span>", \
		"<span class='notice'>[voracious ? "You start struggling inside of [src]'s tight, flexible confines," : "You start pounding against the metallic walls of [src],"] trying to trigger the release... (this will take about [DisplayTimeText(breakout_time)].)</span>", \
		"<span class='italics'>You hear a [voracious ? "couple of thumps" : "loud banging noise"] coming from within [hound].</span>")
	if(do_after(user, breakout_time, target = src))
		user.visible_message("<span class='warning'>[user] successfully broke out of [hound.name]!</span>", \
			"<span class='notice'>You successfully break out of [hound.name]!</span>")
		go_out(user, hound)

/obj/item/dogborg/sleeper/proc/go_out(atom/movable/target, mob/living/silicon/robot/hound)
	var/voracious = hound ? TRUE : FALSE
	var/list/targets = target && hound ? list(target) : contents
	if(hound)
		if(!hound.client || !(hound.client.prefs.cit_toggles & MEDIHOUND_SLEEPER))
			voracious = FALSE
		else
			for(var/mob/M in targets)
				if(!M.client || !(M.client.prefs.cit_toggles & MEDIHOUND_SLEEPER))
					voracious = FALSE
	if(length(targets))
		if(hound)
			hound.visible_message("<span class='warning'>[voracious ? "[hound] empties out [hound.p_their()] contents via [hound.p_their()] release port." : "[hound]'s underside slides open with an audible clunk before [hound.p_their()] [src] flips over, carelessly dumping its contents onto the ground below [hound.p_them()] before closing right back up again."]</span>", \
				"<span class='notice'>[voracious ? "You empty your contents via your release port." : "You open your sleeper hatch, quickly releasing all of the contents within before closing it again."]</span>")
		for(var/a in contents)
			var/atom/movable/AM = a
			AM.forceMove(get_turf(src))
			if(ismob(AM))
				var/mob/M = AM
				M.reset_perspective()
		playsound(loc, voracious ? 'sound/effects/splat.ogg' : 'sound/effects/bin_close.ogg', 50, 1)
	items_preserved.Cut()
	cleaning = FALSE
	patient = null
	if(hound)
		update_gut(hound)


/obj/item/dogborg/sleeper/attack_self(mob/user)
	. = ..()
	if(. || !iscyborg(user))
		return
	ui_interact(user)

/obj/item/dogborg/sleeper/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
									datum/tgui/master_ui = null, datum/ui_state/state = GLOB.notcontained_state)

	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "dogborg_sleeper", name, 375, 550, master_ui, state)
		ui.open()

/obj/item/dogborg/sleeper/ui_data()
	var/list/data = list()
	data["occupied"] = patient ? 1 : 0

	if(cleaning && length(contents - items_preserved))
		data["items"] = "Self-cleaning mode active: [length(contents - items_preserved)] object(s) remaining."
	data["cleaning"] = cleaning
	if(injection_chems != null)
		data["chem"] = list()
		for(var/chem in injection_chems)
			var/datum/reagent/R = GLOB.chemical_reagents_list[chem]
			data["chem"] += list(list("name" = R.name, "id" = R.type))

	data["occupant"] = list()
	var/mob/living/mob_occupant = patient
	if(mob_occupant)
		data["occupant"]["name"] = mob_occupant.name
		switch(mob_occupant.stat)
			if(CONSCIOUS)
				data["occupant"]["stat"] = "Conscious"
				data["occupant"]["statstate"] = "good"
			if(SOFT_CRIT)
				data["occupant"]["stat"] = "Conscious"
				data["occupant"]["statstate"] = "average"
			if(UNCONSCIOUS)
				data["occupant"]["stat"] = "Unconscious"
				data["occupant"]["statstate"] = "average"
			if(DEAD)
				data["occupant"]["stat"] = "Dead"
				data["occupant"]["statstate"] = "bad"
		data["occupant"]["health"] = mob_occupant.health
		data["occupant"]["maxHealth"] = mob_occupant.maxHealth
		data["occupant"]["minHealth"] = HEALTH_THRESHOLD_DEAD
		data["occupant"]["bruteLoss"] = mob_occupant.getBruteLoss()
		data["occupant"]["oxyLoss"] = mob_occupant.getOxyLoss()
		data["occupant"]["toxLoss"] = mob_occupant.getToxLoss()
		data["occupant"]["fireLoss"] = mob_occupant.getFireLoss()
		data["occupant"]["cloneLoss"] = mob_occupant.getCloneLoss()
		data["occupant"]["brainLoss"] = mob_occupant.getOrganLoss(ORGAN_SLOT_BRAIN)
		data["occupant"]["reagents"] = list()
		if(mob_occupant.reagents.reagent_list.len)
			for(var/datum/reagent/R in mob_occupant.reagents.reagent_list)
				data["occupant"]["reagents"] += list(list("name" = R.name, "volume" = R.volume))
	return data

/obj/item/dogborg/sleeper/ui_act(action, params)
	. = ..()
	if(. || !iscyborg(usr))
		return

	switch(action)
		if("eject")
			go_out(null, usr)
			. = TRUE
		if("inject")
			var/chem = text2path(params["chem"])
			if(!patient || !chem)
				return
			inject_chem(chem, usr)
			. = TRUE
		if("cleaning")
			if(!contents)
				to_chat(src, "Your [src] is already cleaned.")
				return
			if(patient)
				to_chat(patient, "<span class='danger'>[usr.name]'s [src] fills with caustic enzymes around you!</span>")
			to_chat(src, "<span class='danger'>Cleaning process enabled.</span>")
			clean_cycle(usr)
			. = TRUE

/obj/item/dogborg/sleeper/proc/update_gut(mob/living/silicon/robot/hound)
	//Well, we HAD one, what happened to them?
	var/prociconupdate = FALSE
	var/currentenvy = hound.sleeper_nv
	hound.sleeper_nv = FALSE
	if(patient in contents)
		if(patient_laststat != patient.stat)
			if(patient.stat & DEAD)
				hound.sleeper_r = 1
				hound.sleeper_g = 0
				patient_laststat = patient.stat
			else
				hound.sleeper_r = 0
				hound.sleeper_g = 1
				patient_laststat = patient.stat
			prociconupdate = TRUE

		if(!patient.client || !(patient.client.prefs.cit_toggles & MEDIHOUND_SLEEPER) || !hound.client || !(hound.client.prefs.cit_toggles & MEDIHOUND_SLEEPER))
			hound.sleeper_nv = TRUE
		else
			hound.sleeper_nv = FALSE
		if(hound.sleeper_nv != currentenvy)
			prociconupdate = TRUE

		//Update icon
		if(prociconupdate)
			hound.update_icons()
		//Return original patient
		return(patient)
	//Check for a new patient
	else
		for(var/mob/living/carbon/human/C in contents)
			patient = C
			if(patient.stat & DEAD)
				hound.sleeper_r = 1
				hound.sleeper_g = 0
				patient_laststat = patient.stat
			else
				hound.sleeper_r = 0
				hound.sleeper_g = 1
				patient_laststat = patient.stat

			if(!patient.client || !(patient.client.prefs.cit_toggles & MEDIHOUND_SLEEPER) || !hound.client || !(hound.client.prefs.cit_toggles & MEDIHOUND_SLEEPER))
				hound.sleeper_nv = TRUE
			else
				hound.sleeper_nv = FALSE

			//Update icon and return new patient
			hound.update_icons()
			return

	//Cleaning looks better with red on, even with nobody in it
	if(cleaning && !patient)
		hound.sleeper_r = 1
		hound.sleeper_g = 0
	//Couldn't find anyone, and not cleaning
	else if(!cleaning && !patient)
		hound.sleeper_r = 0
		hound.sleeper_g = 0

	patient_laststat = null
	patient = null
	hound.update_icons()

//Gurgleborg process
/obj/item/dogborg/sleeper/proc/clean_cycle(mob/living/silicon/robot/hound)
	//Sanity
	if(!hound)
		return
	for(var/I in items_preserved)
		if(!(I in contents))
			items_preserved -= I
	var/list/touchable_items = contents - items_preserved
	var/sound/prey_digest = sound(get_sfx("digest_prey"))
	var/sound/prey_death = sound(get_sfx("death_prey"))
	var/sound/pred_digest = sound(get_sfx("digest_pred"))
	var/sound/pred_death = sound(get_sfx("death_pred"))
	if(cleaning_cycles)
		cleaning_cycles--
		cleaning = TRUE
		for(var/mob/living/carbon/C in (touchable_items))
			if((C.status_flags & GODMODE) || !CHECK_BITFIELD(C.vore_flags, DIGESTABLE))
				items_preserved += C
			else
				C.adjustBruteLoss(2)
				C.adjustFireLoss(3)
		if(contents)
			var/atom/target = pick(touchable_items)
			if(iscarbon(target)) //Handle the target being a mob
				var/mob/living/carbon/T = target
				if(T.stat == DEAD && CHECK_BITFIELD(T.vore_flags, DIGESTABLE))	//Mob is now dead
					message_admins("[key_name(hound)] has digested [key_name(T)] as a dogborg. ([hound ? "<a href='?_src_=holder;adminplayerobservecoodjump=1;X=[hound.x];Y=[hound.y];Z=[hound.z]'>JMP</a>" : "null"])")
					to_chat(hound,"<span class='notice'>You feel your belly slowly churn around [T], breaking them down into a soft slurry to be used as power for your systems.</span>")
					to_chat(T,"<span class='notice'>You feel [hound]'s belly slowly churn around your form, breaking you down into a soft slurry to be used as power for [hound]'s systems.</span>")
					hound.cell.give(30000) //Fueeeeellll
					if((world.time - NORMIE_HEARCHECK) > last_hearcheck)
						var/turf/source = get_turf(hound)
						LAZYCLEARLIST(hearing_mobs)
						for(var/mob/H in get_hearers_in_view(3, source))
							if(!H.client || !(H.client.prefs.cit_toggles & DIGESTION_NOISES))
								continue
							LAZYADD(hearing_mobs, H)
						last_hearcheck = world.time
						for(var/mob/H in hearing_mobs)
							if(!istype(H.loc, /obj/item/dogborg/sleeper))
								H.playsound_local(source, null, 45, falloff = 0, S = pred_death)
							else if(H in contents)
								H.playsound_local(source, null, 65, falloff = 0, S = prey_death)
					for(var/belly in T.vore_organs)
						var/obj/belly/B = belly
						for(var/atom/movable/thing in B)
							thing.forceMove(src)
							if(ismob(thing))
								to_chat(thing, "As [T] melts away around you, you find yourself in [hound]'s [name]")
					for(var/obj/item/W in T)
						if(!T.dropItemToGround(W))
							qdel(W)
					qdel(T)
		//Handle the target being anything but a mob
			else if(isobj(target))
				var/obj/T = target
				if(T.type in important_items) //If the object is in the items_preserved global list
					items_preserved += T
				//If the object is not one to preserve
				else
					qdel(T)
					update_gut()
					hound.cell.give(10)
	else
		cleaning_cycles = initial(cleaning_cycles)
		cleaning = FALSE
		to_chat(hound, "<span class='notice'>Your [src] chimes it ends its self-cleaning cycle.</span>")//Belly is entirely empty

	if(!length(contents))
		to_chat(hound, "<span class='notice'>Your [src] is now clean. Ending self-cleaning cycle.</span>")
		cleaning = FALSE

//sound effects
	if(prob(50))
		if((world.time - NORMIE_HEARCHECK) > last_hearcheck)
			var/turf/source = get_turf(hound)
			LAZYCLEARLIST(hearing_mobs)
			for(var/mob/H in get_hearers_in_view(3, source))
				if(!H.client || !(H.client.prefs.cit_toggles & DIGESTION_NOISES))
					continue
				LAZYADD(hearing_mobs, H)
			last_hearcheck = world.time
			for(var/mob/H in hearing_mobs)
				if(!istype(H.loc, /obj/item/dogborg/sleeper))
					H.playsound_local(source, null, 45, falloff = 0, S = pred_digest)
				else if(H in contents)
					H.playsound_local(source, null, 65, falloff = 0, S = prey_digest)

	update_gut(hound)

	if(cleaning)
		addtimer(CALLBACK(src, .proc/clean_cycle, hound), 50)

/obj/item/dogborg/sleeper/proc/CheckAccepted(obj/item/I)
	return is_type_in_typecache(I, important_items)

/obj/item/dogborg/sleeper/proc/inject_chem(chem, mob/living/silicon/robot/hound)
	if(!hound)
		return
	if(hound.cell.charge <= 800) //This is so borgs don't kill themselves with it. Remember, 750 charge used every injection.
		to_chat(hound, "<span class='notice'>You don't have enough power to synthesize fluids.</span>")
		return
	if(patient.reagents.get_reagent_amount(chem) + 10 >= 20) //Preventing people from accidentally killing themselves by trying to inject too many chemicals!
		to_chat(hound, "<span class='notice'>Your stomach is currently too full of fluids to secrete more fluids of this kind.</span>")
		return
	patient.reagents.add_reagent(chem, 10)
	hound.cell.use(750) //-750 charge per injection
	var/units = round(patient.reagents.get_reagent_amount(chem))
	to_chat(hound, "<span class='notice'>Injecting [units] unit\s of [chem] into occupant.</span>") //If they were immersed, the reagents wouldn't leave with them.

/obj/item/dogborg/sleeper/K9 //The K9 portabrig
	name = "Mobile Brig"
	desc = "Equipment for a K9 unit. A mounted portable-brig that holds criminals."
	icon_state = "sleeperb"
	inject_amount = 0
	min_health = -100
	injection_chems = null //So they don't have all the same chems as the medihound!
	breakout_time = 300

/obj/item/dogborg/sleeper/K9/afterattack(mob/living/carbon/target, mob/living/silicon/user, proximity)
	var/mob/living/silicon/robot/hound = get_host()
	if(!hound || !istype(target) || !proximity || target.anchored)
		return
	if (!CHECK_BITFIELD(target.vore_flags,DEVOURABLE))
		to_chat(user, "The target registers an error code. Unable to insert into [src].")
		return
	if(patient)
		to_chat(user,"<span class='warning'>Your [src] is already occupied.</span>")
		return
	if(target.buckled)
		to_chat(user,"<span class='warning'>[target] is buckled and can not be put into your [src].</span>")
		return
	user.visible_message("<span class='warning'>[hound.name] is ingesting [target] into their [src].</span>", "<span class='notice'>You start ingesting [target] into your [src.name]...</span>")
	if(do_after(user, 30, target = target) && !patient && !target.buckled)
		target.forceMove(src)
		target.reset_perspective(src)
		update_gut(hound)
		user.visible_message("<span class='warning'>[hound.name]'s mobile brig clunks in series as [target] slips inside.</span>", "<span class='notice'>Your mobile brig groans lightly as [target] slips inside.</span>")
		playsound(hound, 'sound/effects/bin_close.ogg', 80, 1) // Really don't need ERP sound effects for robots

/obj/item/dogborg/sleeper/K9/flavour
	name = "Recreational Sleeper"
	desc = "A mounted, underslung sleeper, intended for holding willing occupants for leisurely purposes."
