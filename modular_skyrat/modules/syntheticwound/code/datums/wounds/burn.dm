
/*
	Burn wounds
*/

// TODO: well, a lot really, but specifically I want to add potential fusing of clothing/equipment on the affected area, and limb infections, though those may go in body part code
/datum/wound/synthetic/burn
	name = "Burn Wound"
	a_or_from = "from"
	wound_type = WOUND_BURN
	processes = TRUE
	sound_effect = 'sound/effects/wounds/sizzle1.ogg'
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE)

	treatable_by = list(/obj/item/stack/medical/ointment, /obj/item/stack/medical/mesh) // sterilizer and alcohol will require reagent treatments, coming soon

		// Flesh damage vars
	/// How much damage to our flesh we currently have. Once both this and infestation reach 0, the wound is considered healed
	var/flesh_damage = 5
	/// Our current counter for how much flesh regeneration we have stacked from regenerative mesh/synthflesh/whatever, decrements each tick and lowers flesh_damage
	var/flesh_healing = 0

		// Infestation vars (only for severe and critical)
	/// How quickly infection breeds on this burn if we don't have disinfectant
	var/infestation_rate = 0
	/// Our current level of infection
	var/infestation = 0
	/// Our current level of sanitization/anti-infection, from disinfectants/alcohol/UV lights. While positive, totally pauses and slowly reverses infestation effects each tick
	var/sanitization = 0

	/// Once we reach infestation beyond WOUND_INFESTATION_SEPSIS, we get this many warnings before the limb is completely paralyzed (you'd have to ignore a really bad burn for a really long time for this to happen)
	var/strikes_to_lose_limb = 3


/datum/wound/synthetic/burn/handle_process()
	. = ..()
	if(strikes_to_lose_limb == 0) // we've already hit sepsis, nothing more to do
		if(prob(1))
			victim.adjustStaminaLoss(10)
			victim.visible_message("<span class='danger'>The heat damage on the remnants of [victim]'s melted [limb.name] arc violently and creak dangerously!</span>", "<span class='warning'>You feel a sudden drain from your [limb.name]; causing a heavy sense of exhaustion to rush through your circuitry.</span>", vision_distance = COMBAT_MESSAGE_RANGE)
		return

	// here's the check to see if we're cleared up
	if(flesh_damage <= 0)
		to_chat(victim, "<span class='green'>The burns on your [limb.name] have cleared up!</span>")
		qdel(src)
		return

	infestation += infestation_rate //Infestation rate is indicative of burns getting worse due to short circuits

	switch(infestation)
		if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
			if(prob(30))
				victim.adjustStaminaLoss(2)
				if(prob(6))
					to_chat(victim, "<span class='warning'>The melted circuitry on your [limb.name] spark and zap weakly...</span>")
		if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
			if(!disabling && prob(2))
				to_chat(victim, "<span class='warning'><b>Your [limb.name] completely locks up, as you struggle to regain control over your circuitry!</b></span>")
				set_disabling(TRUE)
			else if(disabling && prob(8))
				to_chat(victim, "<span class='notice'>You regain sensation in your [limb.name], but it's still in terrible shape!</span>")
				set_disabling(FALSE)
			else if(prob(20))
				victim.adjustStaminaLoss(3)
		if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
			if(!disabling && prob(3))
				to_chat(victim, "<span class='warning'><b>You suddenly lose all sensation in your [limb.name]; the wiring far too damaged to sustain operation!</b></span>")
				set_disabling(TRUE)
			else if(disabling && prob(3))
				to_chat(victim, "<span class='notice'>You can barely feel your [limb.name] again, and you have to strain your processing core to retain motor control!</span>")
				set_disabling(FALSE)
			else if(prob(1))
				to_chat(victim, "<span class='warning'>You attempt diagnostics on your [limb.name]; and all it reports are dull errors...</span>")
				victim.adjustStaminaLoss(5)
			else if(prob(4))
				victim.adjustStaminaLoss(4)
		if(WOUND_INFECTION_SEPTIC to INFINITY)
			if(prob(infestation))
				switch(strikes_to_lose_limb)
					if(3 to INFINITY)
						to_chat(victim, "<span class='deadsay'>The metal and plastic sheathing on your [limb.name] is literally boiling off; you're in terrible shape!</span>")
					if(2)
						to_chat(victim, "<span class='deadsay'><b>The arcing in your [limb.name] is audibly buzzing, you feel as if the malfunctions are ever so slightly getting worse.</b></span>")
					if(1)
						to_chat(victim, "<span class='deadsay'><b>Your limb is all but unresponsive; [limb.name] is almost completely useless!</b></span>")
					if(0)
						to_chat(victim, "<span class='deadsay'><b>The last of the control circuits in your [limb.name] wither away beneath the heat, as the arcing and fire finally subsides; having destroyed all connection to the main housing.</b></span>")
						threshold_penalty = 120 // piss easy to destroy
						var/datum/brain_trauma/severe/paralysis/sepsis = new (limb.body_zone)
						victim.gain_trauma(sepsis)
				strikes_to_lose_limb--

/datum/wound/synthetic/burn/get_examine_description(mob/user)
	if(strikes_to_lose_limb <= 0)
		return "<span class='deadsay'><B>[victim.p_their(TRUE)] [limb.name] has locked up completely and is non-functional.</B></span>"

	var/list/condition = list("[victim.p_their(TRUE)] [limb.name] [examine_desc]")
	if(limb.current_gauze)
		var/bandage_condition
		switch(limb.current_gauze.absorption_capacity)
			if(0 to 1.25)
				bandage_condition = "nearly ruined"
			if(1.25 to 2.75)
				bandage_condition = "badly worn"
			if(2.75 to 4)
				bandage_condition = "slightly burnt"
			if(4 to INFINITY)
				bandage_condition = "clean"

		condition += " underneath a dressing of [bandage_condition] [limb.current_gauze.name]"
	else
		switch(infestation)
			if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
				//condition += ", <span class='deadsay'>with early signs of infection.</span>"
				condition += ", <span class='deadsay'>with small spots of flaked metal along the nearby support structure!</span>"
			if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
				//condition += ", <span class='deadsay'>with growing clouds of infection.</span>"
				condition += ", <span class='deadsay'>with growing lines of destroyed wiring.</span>"
			if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
				condition += ", <span class='deadsay'>with violent arcs of electricity!</span>"
			if(WOUND_INFECTION_SEPTIC to INFINITY)
				return "<span class='deadsay'><B>[victim.p_their(TRUE)] [limb.name] is a mess of charred metal and slagged plastic!</B></span>"
			else
				condition += "!"

	return "<B>[condition.Join()]</B>"

/datum/wound/synthetic/burn/get_scanner_description(mob/user)
	if(strikes_to_lose_limb == 0)
		var/oopsie = "Type: [name]\nSeverity: [severity_text()]"
		oopsie += "<div class='ml-3'>Infection Level: <span class='deadsay'>The bodypart has suffered complete degredation and must be replaced. Amputate or augment limb immediately.</span></div>"
		return oopsie

	. = ..()
	. += "<div class='ml-3'>"

	if(infestation <= sanitization && flesh_damage <= flesh_healing)
		. += "No further treatment required: Burns will automatically repair shortly."
	else
		switch(infestation)
			if(WOUND_INFECTION_MODERATE to WOUND_INFECTION_SEVERE)
				. += "Infection Level: Moderate\n"
			if(WOUND_INFECTION_SEVERE to WOUND_INFECTION_CRITICAL)
				. += "Infection Level: Severe\n"
			if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
				. += "Infection Level: <span class='deadsay'>CRITICAL</span>\n"
			if(WOUND_INFECTION_SEPTIC to INFINITY)
				. += "Infection Level: <span class='deadsay'>LOSS IMMINENT</span>\n"
		if(infestation > sanitization)
			. += "\tCable coils, Tape, or otherwise complete replacement of the limb will be effective.\n"

		if(flesh_damage > 0)
			. += "Limb damage detected: Application of Cable Coil and Tape will encourage automated repair systems to handle further damage.\n"
	. += "</div>"

/*
	new burn common procs
*/

/// if someone is using ointment or mesh on our burns
/datum/wound/synthetic/burn/proc/cablecoil(obj/item/stack/medical/I, mob/user)
	user.visible_message("<span class='notice'>[user] begins applying [I] to [victim]'s [limb.name]...</span>", "<span class='notice'>You begin applying [I] to [user == victim ? "your" : "[victim]'s"] [limb.name]...</span>")
	if(!do_after(user, (user == victim ? I.self_delay : I.other_delay), extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	limb.heal_damage(I.heal_brute, I.heal_burn)
	user.visible_message("<span class='green'>[user] applies [I] to [victim].</span>", "<span class='green'>You apply [I] to [user == victim ? "your" : "[victim]'s"] [limb.name].</span>")
	I.use(1)
	sanitization += I.sanitization
	flesh_healing += I.flesh_regeneration

	if((infestation <= 0 || sanitization >= infestation) && (flesh_damage <= 0 || flesh_healing > flesh_damage))
		to_chat(user, "<span class='notice'>You've done all you can with [I], now you must wait for the flesh on [victim]'s [limb.name] to recover.</span>")
	else
		try_treating(I, user)

/datum/wound/synthetic/burn/treat(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/cable_coil))
		cablecoil(I, user)
	else if(istype(I, /obj/item/stack/sticky_tape/surgical))
		var/obj/item/stack/sticky_tape/surgical = I
		cablecoil(mesh_check, user)

// people complained about burns not healing on stasis beds, so in addition to checking if it's cured, they also get the special ability to very slowly heal on stasis beds if they have the healing effects stored
/datum/wound/synthetic/burn/on_stasis()
	. = ..()
	if(flesh_healing > 0)
		flesh_damage = max(0, flesh_damage - 0.2)
	if((flesh_damage <= 0) && (infestation <= WOUND_INFECTION_MODERATE))
		to_chat(victim, "<span class='green'>The burns on your [limb.name] have cleared up!</span>")
		qdel(src)
		return
	if(sanitization > 0)
		infestation = max(0, infestation - WOUND_BURN_SANITIZATION_RATE * 0.2)

/datum/wound/synthetic/burn/on_synthflesh(amount)
	flesh_healing += amount * 0.5 // 20u patch will heal 10 flesh standard

// we don't even care about first degree burns, straight to second
/datum/wound/synthetic/burn/moderate
	name = "Minor Heatwarping"
	desc = "Synthetic is suffering minor damage to the outer-shell of their limb, usually caused by high-intensity heating."
	treat_text = "Recommended application of cable coil or tape to affected region."
	examine_desc = "is somewhat charred; sparking beneath its covering"
	occur_text = "sparks and smokes violently, small arcs coming from the surface"
	severity = WOUND_SEVERITY_MODERATE
	damage_mulitplier_penalty = 1.1
	threshold_minimum = 40
	threshold_penalty = 30 // burns cause significant decrease in limb integrity compared to other wounds
	status_effect_type = /datum/status_effect/wound/burn/moderate
	flesh_damage = 5
	scar_keyword = "burnmoderate"

/datum/wound/synthetic/burn/severe
	name = "Major Heatwarping"
	desc = "Synthetic is suffering major damage caused by heat exposure to the limb, Repairs are essential for continued operation."
	treat_text = "Recommended immediate repair and replacement of damaged cables, followed by taping."
	examine_desc = "appears seriously charred, many areas melted beyond recognition"
	occur_text = "chars rapidly; several high-voltage arcs sparking from their limbs."
	severity = WOUND_SEVERITY_SEVERE
	damage_mulitplier_penalty = 1.2
	threshold_minimum = 80
	threshold_penalty = 40
	status_effect_type = /datum/status_effect/wound/burn/severe
	treatable_by = list(/obj/item/stack/cable_coil, /obj/item/stack/sticky_tape/surgical)
	infestation_rate = 0.05 // appx 13 minutes to reach sepsis without any treatment
	flesh_damage = 12.5
	scar_keyword = "burnsevere"

/datum/wound/synthetic/burn/critical
	name = "Catastrophic Heatwarping"
	desc = "Synthetic has had their limb charred to the point of near-destruction, very little remains of the original design."
	treat_text = "Immediate intervention, usually by entirely replacing the burnt segments of their limb; followed by intense monitoring to ensure further damage does not occur"
	examine_desc = "is a horrifying mess of metal and plastic; along with cabling melted together"
	occur_text = "vaporizes as metal, plastic and cabling melts into one amorphous mass"
	severity = WOUND_SEVERITY_CRITICAL
	damage_mulitplier_penalty = 1.3
	sound_effect = 'sound/effects/wounds/sizzle2.ogg'
	threshold_minimum = 140
	threshold_penalty = 80
	status_effect_type = /datum/status_effect/wound/burn/critical
	treatable_by = list(/obj/item/stack/cable_coil, /obj/item/stack/sticky_tape/surgical)
	infestation_rate = 0.15 // appx 4.33 minutes to reach sepsis without any treatment
	flesh_damage = 20
	scar_keyword = "burncritical"
