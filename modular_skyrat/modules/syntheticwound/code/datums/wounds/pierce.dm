
/*
	Piercing wounds
*/

/datum/wound/synthetic/pierce
	name = "Piercing Wound"
	sound_effect = 'sound/weapons/slice.ogg'
	processes = TRUE
	wound_type = WOUND_PIERCE
	treatable_by = list(/obj/item/stack/sticky_tape/surgical)
	treatable_tool = TOOL_CAUTERY
	base_treat_time = 3 SECONDS
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE)

	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// If gauzed, what percent of the internal bleeding actually clots of the total absorption rate
	var/gauzed_clot_rate

	/// When hit on this bodypart, we have this chance of losing some blood + the incoming damage
	var/internal_bleeding_chance
	/// If we let off blood when hit, the max blood lost is this * the incoming damage
	var/internal_bleeding_coefficient

/datum/wound/synthetic/slash/show_wound_topic(mob/user)
	return (user == victim && blood_flow)

/datum/wound/synthetic/slash/Topic(href, href_list)
	. = ..()
	if(href_list["wound_topic"])
		if(!usr == victim)
			return
		victim.self_grasp_bleeding_limb(limb)

/datum/wound/synthetic/pierce/wound_injury(datum/wound/old_wound)
	blood_flow = initial_flow

/datum/wound/synthetic/pierce/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(victim.stat == DEAD || wounding_dmg < 5)
		return
	if(victim.blood_volume && prob(internal_bleeding_chance + wounding_dmg))
		if(limb.current_splint && limb.current_splint.splint_factor)
			wounding_dmg *= (1 - limb.current_splint.splint_factor)
		var/blood_bled = rand(1, wounding_dmg * internal_bleeding_coefficient) // 12 brute toolbox can cause up to 15/18/21 bloodloss on mod/sev/crit
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
				victim.visible_message("<span class='smalldanger'>Oil droplets fly from the hole in [victim]'s [limb.name].</span>", "<span class='danger'>You eject some of your oil; the blow to your [limb.name] jarring your systems!.</span>", vision_distance=COMBAT_MESSAGE_RANGE)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message("<span class='smalldanger'>A small stream of oil spurts from the hole in [victim]'s [limb.name]!</span>", "<span class='danger'>You eject out a string of oil from the blow to your [limb.name]!</span>", vision_distance=COMBAT_MESSAGE_RANGE)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message("<span class='danger'>A spray of oil streams from the gash in [victim]'s [limb.name]!</span>", "<span class='danger'><b>You gush out a spray of oil from the blow to your [limb.name]!</b></span>", vision_distance=COMBAT_MESSAGE_RANGE)
				victim.bleed(blood_bled)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/synthetic/pierce/get_bleed_rate_of_change()
	if(HAS_TRAIT(victim, TRAIT_BLOODY_MESS))
		return BLOOD_FLOW_INCREASING
	if(limb.current_gauze)
		return BLOOD_FLOW_DECREASING
	return BLOOD_FLOW_STEADY

/datum/wound/synthetic/pierce/handle_process()
	blood_flow = min(blood_flow, WOUND_SLASH_MAX_BLOODFLOW)

	if(victim.bodytemperature < (BODYTEMP_NORMAL -  10))
		blood_flow -= 0.2
		if(prob(5))
			to_chat(victim, "<span class='notice'>You feel the [lowertext(name)] in your [limb.name] firming up from the cold!</span>")

	if(HAS_TRAIT(victim, TRAIT_BLOODY_MESS))
		blood_flow += 0.5 // old heparin used to just add +2 bleed stacks per tick, this adds 0.5 bleed flow to all open cuts which is probably even stronger as long as you can cut them first

	if(limb.current_gauze && limb.current_gauze.seep_gauze(limb.current_gauze.absorption_rate, GAUZE_STAIN_BLOOD))
		blood_flow -= limb.current_gauze.absorption_rate * gauzed_clot_rate

	if(blood_flow <= 0)
		qdel(src)

/datum/wound/synthetic/pierce/on_stasis()
	. = ..()
	if(blood_flow <= 0)
		qdel(src)

/datum/wound/synthetic/pierce/check_grab_treatments(obj/item/I, mob/user)
	if(I.get_temperature()) // if we're using something hot but not a cautery, we need to be aggro grabbing them first, so we don't try treating someone we're eswording
		return TRUE

/datum/wound/synthetic/pierce/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/sticky_tape/surgical))
		tapepierce(I, user)
	else if(I.tool_behaviour == TOOL_CAUTERY || I.get_temperature())
		tool_cauterize(I, user)

/datum/wound/synthetic/pierce/on_xadone(power)
	. = ..()
	blood_flow -= 0.03 * power // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/datum/wound/synthetic/pierce/on_synthflesh(power)
	. = ..()
	blood_flow -= 0.05 * power // 20u * 0.05 = -1 blood flow, less than with slashes but still good considering smaller bleed rates

/// If someone is using a suture to close this puncture
/datum/wound/synthetic/pierce/proc/tapepierce(/obj/item/stack/sticky_tape/surgical/A, mob/user)
	var/self_penalty_mult = (user == victim ? 1.4 : 1)
	user.visible_message("<span class='notice'>[user] begins taping over [victim]'s [limb.name] with [A]...</span>", "<span class='notice'>You begin taping over [user == victim ? "your" : "[victim]'s"] [limb.name] with [A]...</span>")
	if(!do_after(user, base_treat_time * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	user.visible_message("<span class='green'>[user] tapes up over some of the leaking on [victim].</span>", "<span class='green'>You tape up some of the leaking on [user == victim ? "yourself" : "[victim]"].</span>")
	var/blood_sutured = A.stop_bleeding / self_penalty_mult
	blood_flow -= blood_sutured
	var/obj/item/stack/used_stack = A
	used_stack.use(1)
	if(blood_flow > 0)
		try_treating(A, user)
	else
		to_chat(user, "<span class='green'>You successfully close the hole in [user == victim ? "your" : "[victim]'s"] [limb.name].</span>")

/// If someone is using either a cautery tool or something with heat to cauterize this pierce
/datum/wound/synthetic/pierce/proc/tool_cauterize(obj/item/I, mob/user)
	var/improv_penalty_mult = (I.tool_behaviour == TOOL_CAUTERY ? 1 : 1.25) // 25% longer and less effective if you don't use a real cautery
	var/self_penalty_mult = (user == victim ? 1.5 : 1) // 50% longer and less effective if you do it to yourself

	user.visible_message("<span class='danger'>[user] begins welding shut [victim]'s [limb.name] with [I]...</span>", "<span class='warning'>You begin welding shut [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]...</span>")
	if(!do_after(user, base_treat_time * self_penalty_mult * improv_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	user.visible_message("<span class='green'>[user] welds shut some of the leaking on [victim].</span>", "<span class='green'>You weld shut some of the leaking on [victim].</span>")
	limb.receive_damage(burn = 2 + severity, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / (self_penalty_mult * improv_penalty_mult))
	blood_flow -= blood_cauterized

	if(blood_flow > 0)
		try_treating(I, user)

/datum/wound/synthetic/pierce/moderate
	name = "Minor Puncture"
	desc = "Patient's hydraulic lines have been punctured, causing leaking."
	treat_text = "Treat affected site with bandaging to help stem the flow, along with welding and taping." // space is cold in ss13, so it's like an ice pack!
	examine_desc = "has a small, circular hole; peircing a vital line, slowly leaking"
	occur_text = "spurts out a thin stream of oil"
	sound_effect = 'sound/effects/wounds/pierce1.ogg'
	severity = WOUND_SEVERITY_MODERATE
	initial_flow = 1.5
	gauzed_clot_rate = 0.8
	internal_bleeding_chance = 30
	internal_bleeding_coefficient = 1.25
	threshold_minimum = 30
	threshold_penalty = 20
	status_effect_type = /datum/status_effect/wound/pierce/moderate
	scar_keyword = "piercemoderate"

/datum/wound/synthetic/pierce/severe
	name = "Open Puncture"
	desc = "Patient's internal mechanics are heavily perforated, causing sizeable internal leaking and reduced limb stability."
	treat_text = "Repair punctures in hydraulic lines by suitable welding source, or extreme cold may also work."
	examine_desc = "is pierced clear through, with bits of mangled bits of metal obscuring the open hole"
	occur_text = "looses a violent spray of oil, revealing a clear hole"
	sound_effect = 'sound/effects/wounds/pierce2.ogg'
	severity = WOUND_SEVERITY_SEVERE
	initial_flow = 2.25
	gauzed_clot_rate = 0.6
	internal_bleeding_chance = 60
	internal_bleeding_coefficient = 1.5
	threshold_minimum = 50
	threshold_penalty = 35
	status_effect_type = /datum/status_effect/wound/pierce/severe
	scar_keyword = "piercesevere"

/datum/wound/synthetic/pierce/critical
	name = "Internal Cavity"
	desc = "Patients internal structure has been heavily compromised, causing massive hydraulic fluid loss."
	treat_text = "Heavy welding, and potential mechanical intervention required to ensure limb operability"
	examine_desc = "is torn through; almost in twain as it leaks oil and hsudders violently"
	occur_text = "blasts apart, sending chunks of shrapnel flying in all directions"
	sound_effect = 'sound/effects/wounds/pierce3.ogg'
	severity = WOUND_SEVERITY_CRITICAL
	initial_flow = 3
	gauzed_clot_rate = 0.4
	internal_bleeding_chance = 80
	internal_bleeding_coefficient = 1.75
	threshold_minimum = 100
	threshold_penalty = 50
	status_effect_type = /datum/status_effect/wound/pierce/critical
	scar_keyword = "piercecritical"
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE | MANGLES_FLESH)
