////////////////////////////////////////////////////////////////////////////////////////////////////
//										FURRANIUM
///////////////////////////////////////////////////////////////////////////////////////////////////
//OwO whats this?
//Makes you nya and awoo
//At a certain amount of time in your system it gives you a fluffy tongue, if pure enough, it's permanent.

/datum/reagent/OwO/furranium
	name = "Furranium"
	description = "OwO whats this?"
	color = "#f9b9bc" // rgb: , 0, 255
	taste_description = "dewicious degenyewacy"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	inverse_chem_val 		= 0
	purity = 0.9
	var/obj/item/organ/internal/tongue/nT
	chemical_flags = REAGENT_DONOTSPLIT | REAGENT_CAN_BE_SYNTHESIZED
	ph = 5
	var/obj/item/organ/internal/tongue/T


/datum/reagent/OwO/furranium/expose_mob(mob/living/carbon/human/M, method=INJECT, reac_volume)
	if(method == INJECT)
		M.adjustOxyLoss(reac_volume)
		M.emote("cough")
		if(reac_volume >= 15) // one normal needle's worth
			M.Stun(reac_volume * 0.25)
			var/obj/item/toy/plush/PType = pick(GLOB.valid_plushie_paths)
			var/obj/item/toy/plush/P = new PType(get_turf(M))
			M.visible_message("<span class='warning'>[M] suddenly coughs up a [P.name]!</b></span>",\
							"<span class='warning'>You feel a lump form in your throat, as you suddenly cough up what seems to be a hairball?</b></span>")
			var/T2 = get_random_station_turf()
			P.throw_at(T2, 8, 1)
	..()

/datum/reagent/OwO/furranium/on_mob_life(mob/living/carbon/M)

	switch(current_cycle)
		if(1 to 9)
			if(prob(20))
				to_chat(M, "<span class='notice'>Your tongue feels... fluffy</span>")
		if(10 to 15)
			if(prob(10))
				to_chat(M, "You find yourself unable to supress the desire to meow!")
				M.emote("nya")
			if(prob(10))
				to_chat(M, "You find yourself unable to supress the desire to howl!")
				M.emote("awoo")
			if(prob(20))
				var/list/seen = list()
				for(var/mob/living/carbon/human/victim in oview(7, M))
					if(!isliving(victim))
						continue
					seen += victim
				if(LAZYLEN(seen))
					to_chat(M, "You notice [pick(seen)]'s bulge [pick("OwO!", "uwu!")]")
		if(16)
			T = M.getorganslot(ORGAN_SLOT_TONGUE)
			var/obj/item/organ/internal/tongue/nT = new /obj/item/organ/internal/tongue/fluffy
			T.Remove()
			nT.Insert(M)
			T.moveToNullspace()//To valhalla
			to_chat(M, "<span class='big warning'>Your tongue feels... weally fwuffy!!</span>")
		if(17 to INFINITY)
			if(prob(5))
				to_chat(M, "You find yourself unable to supress the desire to meow!")
				M.emote("nya")
			if(prob(5))
				to_chat(M, "You find yourself unable to supress the desire to howl!")
				M.emote("awoo")
			if(prob(5))
				var/list/seen = list()
				for(var/mob/living/carbon/human/victim in oview(7, M))
					if(!isliving(victim))
						continue
					seen += victim
				if(LAZYLEN(seen))
					to_chat(M, "You notice [pick(seen)]'s bulge [pick("OwO!", "uwu!")]")
	..()

/datum/reagent/OwO/furranium/on_mob_delete(mob/living/carbon/M)
	if(creation_purity < 0.95) // Only permanent if you're a good chemist.
		nT = M.getorganslot(ORGAN_SLOT_TONGUE)
		nT.Remove()
		qdel(nT)
		T.Insert(M)
		to_chat(M, "<span class='notice'>You feel your tongue.... shed...?</span>")
		M.say("Pleh!")
//	else
//		log_reagent("OwOCHEM: [M] ckey: [M.key]'s tongue has been made permanent")
