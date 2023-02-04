/datum/nifsoft/apc_recharge
	name = "APC Connector"
	desc = "A small attachment that allows synthmorphs to recharge themselves from APCs."
	list_pos = NIF_APCCHARGE
	cost = 625
	wear = 2
	applies_to = NIF_SYNTHETIC
	tick_flags = NIF_ACTIVETICK
	var/obj/machinery/power/apc/apc
	other_flags = (NIF_O_APCCHARGE)

/datum/nifsoft/apc_recharge/activate()
	if((. = ..()))
		var/mob/living/carbon/human/H = nif.human
		apc = locate(/obj/machinery/power/apc) in get_step(H,H.dir)
		if(!apc)
			apc = locate(/obj/machinery/power/apc) in get_step(H,0)
		if(!apc)
			nif.notify("You must be facing an APC to connect to.",TRUE)
			spawn(0)
				deactivate()
			return FALSE

		H.visible_message("<span class='warning'>Thin snakelike tendrils grow from [H] and connect to \the [apc].</span>","<span class='notice'>Thin snakelike tendrils grow from you and connect to \the [apc].</span>")

/datum/nifsoft/apc_recharge/deactivate(var/force = FALSE)
	if((. = ..()))
		apc = null

/datum/nifsoft/apc_recharge/life()
	if((. = ..()))
		var/mob/living/carbon/human/H = nif.human
		if(apc && (get_dist(H,apc) <= 1) && H.nutrition < 440) // 440 vs 450, life() happens before we get here so it'll never be EXACTLY 450
			H.nutrition = min(H.nutrition+10, 450)
			apc.drain_power(7000/450*10) //This is from the large rechargers. No idea what the math is.
			return TRUE
		else
			nif.notify("APC charging has ended.")
			H.visible_message("<span class='warning'>[H]'s snakelike tendrils whip back into their body from \the [apc].</span>","<span class='notice'>The APC connector tendrils return to your body.</span>")
			deactivate()
			return FALSE

/datum/nifsoft/pressure
	name = "Pressure Seals"
	desc = "Creates pressure seals around important synthetic components to protect them from vacuum. Almost impossible on organics."
	list_pos = NIF_PRESSURE
	cost = 875
	a_drain = 0.5
	wear = 3
	applies_to = NIF_SYNTHETIC
	other_flags = (NIF_O_PRESSURESEAL)

/datum/nifsoft/heatsinks
	name = "Heat Sinks"
	desc = "Advanced heat sinks for internal heat storage of heat on a synth until able to vent it in atmosphere."
	list_pos = NIF_HEATSINK
	cost = 725
	a_drain = 0.25
	wear = 3
	var/used = 0
	tick_flags = NIF_ALWAYSTICK
	applies_to = NIF_SYNTHETIC
	other_flags = (NIF_O_HEATSINKS)

/datum/nifsoft/heatsinks/activate()
	if((. = ..()))
		if(used >= 1500)
			nif.notify("Heat sinks not safe to operate again yet! Max 75% on activation.",TRUE)
			spawn(0)
				deactivate()
			return FALSE

/datum/nifsoft/heatsinks/stat_text()
	return "[active ? "Active" : "Disabled"] (Stored Heat: [FLOOR((used/20), 1)]%)"

/datum/nifsoft/heatsinks/life()
	if((. = ..()))
		//Not being used, all clean.
		if(!active && !used)
			return TRUE

		//Being used, and running out.
		else if(active && ++used == 2000)
			nif.notify("Heat sinks overloaded! Shutting down!",TRUE)
			deactivate()

		//Being cleaned, and finishing empty.
		else if(!active && --used == 0)
			nif.notify("Heat sinks re-chilled.")

/datum/nifsoft/compliance
	name = "Compliance Module"
	desc = "A system that allows one to apply 'laws' to sapient life. Extremely illegal, of course."
	list_pos = NIF_COMPLIANCE
	cost = 8200
	wear = 4
	illegal = TRUE
	vended = FALSE
	access = 999 //Prevents anyone from buying it without an emag.
	var/laws = "Be nice to people!"

/datum/nifsoft/compliance/New(var/newloc,var/newlaws)
	laws = newlaws //Sanitize before this (the disk does)
	..(newloc)

/datum/nifsoft/compliance/activate()
	if((. = ..()))
		to_chat(nif.human,"<span class='danger'>You are compelled to follow these rules: </span>\n<span class='notify'>[laws]</span>")

/datum/nifsoft/compliance/install()
	if((. = ..()))
		to_chat(nif.human,"<span class='danger'>You feel suddenly compelled to follow these rules: </span>\n<span class='notify'>[laws]</span>")

/datum/nifsoft/compliance/uninstall()
	nif.notify("ERROR! Unable to comply!",TRUE)
	return FALSE //NOPE.

/datum/nifsoft/compliance/stat_text()
	return "Show Laws"

/datum/nifsoft/sizechange
	name = "Mass Alteration"
	desc = "A system that allows one to change their size, through drastic mass rearrangement. Causes significant wear when installed."
	list_pos = NIF_SIZECHANGE
	cost = 375
	wear = 6

/datum/nifsoft/sizechange/activate()
	if((. = ..()))
		var/new_size = tgui_input_number(usr, "Put the desired size (25-200%), or (1-600%) in dormitory areas.", "Set Size", 200, 600, 1)

		if (!nif.human.size_range_check(new_size))
			if(new_size)
				to_chat(nif.human,"<span class='notice'>The safety features of the NIF Program prevent you from choosing this size.</span>")
			return
		else
			if(nif.human.resize(new_size/100, uncapped=nif.human.has_large_resize_bounds(), ignore_prefs = TRUE))
				to_chat(nif.human,"<span class='notice'>You set the size to [new_size]%</span>")
				nif.human.visible_message("<span class='warning'>Swirling grey mist envelops [nif.human] as they change size!</span>","<span class='notice'>Swirling streams of nanites wrap around you as you change size!</span>")
		spawn(0)
			deactivate()

/datum/nifsoft/sizechange/deactivate(var/force = FALSE)
	if((. = ..()))
		return TRUE

/datum/nifsoft/sizechange/stat_text()
	return "Change Size"

/datum/nifsoft/worldbend
	name = "World Bender"
	desc = "Alters your perception of various objects in the world. Only has one setting for now: displaying all your crewmates as farm animals."
	list_pos = NIF_WORLDBEND
	cost = 100
	a_drain = 0.01

/datum/nifsoft/worldbend/activate()
	if((. = ..()))
		var/list/justme = list(nif.human)
		for(var/human in human_mob_list)
			if(human == nif.human)
				continue
			var/mob/living/carbon/human/H = human
			H.display_alt_appearance("animals", justme)
			alt_farmanimals += nif.human

/datum/nifsoft/worldbend/deactivate(var/force = FALSE)
	if((. = ..()))
		var/list/justme = list(nif.human)
		for(var/human in human_mob_list)
			if(human == nif.human)
				continue
			var/mob/living/carbon/human/H = human
			H.hide_alt_appearance("animals", justme)
			alt_farmanimals -= nif.human

/datum/nifsoft/malware
	name = "Cool Kidz Toolbar"
	desc = "Best toolbar in business since 2098."
	list_pos = NIF_MALWARE
	cost = 1987
	wear = 0
	illegal = TRUE
	vended = FALSE
	tick_flags = NIF_ALWAYSTICK
	var/last_ads
	can_uninstall = FALSE

/datum/nifsoft/malware/activate()
	if((. = ..()))
		to_chat(nif.human,"<span class='danger'>Runtime error in 15_misc.dm, line 191.</span>")

/datum/nifsoft/malware/install()
	if((. = ..()))
		last_ads = world.time

/datum/nifsoft/malware/life()
	if((. = ..()))
		if(nif.human.client && world.time - last_ads > rand(10 MINUTES, 15 MINUTES) && prob(1))
			last_ads = world.time
			nif.human.client.create_fake_ad_popup_multiple(/obj/screen/popup/default, 5)