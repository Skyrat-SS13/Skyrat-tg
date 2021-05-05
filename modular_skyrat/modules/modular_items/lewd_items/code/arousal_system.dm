#define AROUS_SYS_LITTLE 30
#define AROUS_SYS_STRONG 70
#define AROUS_SYS_READYTOCUM 90
#define PAIN_SYS_LIMIT 50
#define PLEAS_SYS_EDGE 85

#define CUM_MALE 1
#define CUM_FEMALE 2
#define ITEM_SLOT_PENIS (1<<20)

#define TRAIT_MASOCHISM		"masochism"

///////////-----Decals-----//////////
/obj/effect/decal/cleanable/cum
	name = "cum"
	desc = "Uh... Gross."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'
	icon_state = "cum_1"
	random_icon_states = list("cum_1", "cum_2", "cum_3", "cum_4")
	beauty = -50

/obj/effect/decal/cleanable/femcum
	name = "female cum"
	desc = "Uhh... Someone had fun.."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'
	icon_state = "femcum_1"
	random_icon_states = list("femcum_1", "femcum_2", "femcum_3", "femcum_4")
	beauty = -50

///////////-----Reagents-----///////////
/datum/reagent/consumable/girlcum
	name = "girlcum"
	description = "Uhh... Someone had fun."
	taste_description = "astringent and sweetish"
	color = "#ffffffb0"
	glass_name = "glass of Girlcum"
	glass_desc = "Strange white liquid... Eww!"
	reagent_state = LIQUID
	shot_glass_icon_state = "shotglasswhite"

/datum/reagent/consumable/cum
	name = "cum"
	description = "A fluid containing sperm that is secretated by the sexual organs of most species."
	taste_description = "musky and salty"
	color = "#ffffffff"
	glass_name = "glass of Cum"
	glass_desc = "O-oh, my...~"
	reagent_state = LIQUID
	shot_glass_icon_state = "shotglasswhite"

/datum/reagent/consumable/milk/breast_milk
	name = "breast milk"
	description = "This looks familiar... Wait, it's a milk!"
	taste_description = "warm and creamy"
	color = "#ffffffff"
	glass_name = "glass of Breast milk"
	glass_desc = "Almost like a normal milk."
	reagent_state = LIQUID

/datum/reagent/drug/dopamine
	name = "dopamine"
	description = "Pure happines"
	taste_description = "passion fruit, banana and hint of apple"
	color = "#97ffee"
	glass_name = "dopamine"
	glass_desc = "Delicious flavored reagent. You feel happy even looking at it."
	reagent_state = LIQUID
	overdose_threshold = 10

/datum/reagent/drug/dopamine/on_mob_add(mob/living/M)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_start", /datum/mood_event/orgasm, name)
	..()

/datum/reagent/drug/dopamine/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(2)
	if(prob(7))
		M.emote(pick("shaking","moan"))
	..()

/datum/reagent/drug/dopamine/overdose_start(mob/living/M)
	to_chat(M, "<span class='userdanger'>You start tripping hard!</span>")
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overgasm, name)
	return

/datum/reagent/drug/dopamine/overdose_process(mob/living/M)
	M.adjustArousal(0.5)
	M.adjustPleasure(0.3)
	M.adjustPain(-0.5)
	if(prob(2))
		M.emote(pick("moan","twitch_s"))
	return

///////////-----Initilaze------///////////

/obj/item/organ/genital
	var/datum/reagents/internal_fluids
	var/list/contained_item
	var/obj/item/inserted_item //Used for toys

/obj/item/organ/genital/breasts/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	var/breasts_count = 0
	var/size = 0.5
	if(DNA.features["breasts_size"] > 0)
		size = DNA.features["breasts_size"]

	switch(genital_type)
		if("pair")
			breasts_count = 2
		if("quad")
			breasts_count = 2.5
		if("sextuple")
			breasts_count = 3
	internal_fluids = new /datum/reagents(size * breasts_count * 60)

/obj/item/organ/genital/testicles/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	var/size = 0.5
	if(DNA.features["balls_size"] > 0)
		size = DNA.features["balls_size"]

	internal_fluids = new /datum/reagents(size * 20)

/obj/item/organ/genital/vagina/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	internal_fluids = new /datum/reagents(10)
/*
/obj/item/organ/genital/vagina
	contained_item = list(/obj/item/eggvib)

/obj/item/organ/genital/penis
	contained_item = list(/obj/item/eggvib)

/obj/item/organ/genital/breasts
	contained_item = list(/obj/item/eggvib)
*/

/mob/living
	var/arousal = 0
	var/pleasure = 0
	var/pain = 0

	var/masochism = FALSE
	var/nymphomania = FALSE
	var/neverboner = FALSE

	var/pain_limit = 0
	var/arousal_status = AROUSAL_NONE

//	var/list/contained_item = list(/obj/item/eggvib, /obj/item/buttplug)
//	var/obj/item/inserted_item //Used for vibrators

/mob/living/carbon/human/Initialize()
	. = ..()
	if(!istype(src,/mob/living/carbon/human/species/monkey))
		set_masochism(FALSE)
		set_neverboner(FALSE)
		set_nymphomania(FALSE)
		apply_status_effect(/datum/status_effect/aroused)
		apply_status_effect(/datum/status_effect/body_fluid_regen)

///////////-----Verbs------///////////
/mob/living/carbon/human/verb/arousal_panel()
	set name = "Climax"
	set category = "IC"
	climax(TRUE)
/*
/mob/living/carbon/human/proc/show_arousal_panel()

	var/obj/item/organ/genital/testicles/balls = getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/breasts/breasts = getorganslot(ORGAN_SLOT_BREASTS)
	var/obj/item/organ/genital/vagina/vagina = getorganslot(ORGAN_SLOT_VAGINA)
//	var/obj/item/organ/genital/penis/penis = getorganslot(ORGAN_SLOT_PENIS)

	var/list/dat = list()

	if(usr == src)
		dat += "<div>"
		dat += {"<table style="float: left">"}
		dat += "<tr><td><label>Arousal:</lable></td><td><lable>[round(arousal)]%</label></td></tr>"
		dat += "<tr><td><label>Pleasure:</lable></td><td><lable>[round(pleasure)]%</label></td></tr>"
		dat += "<tr><td><label>Pain:</lable></td><td><lable>[round(pain)]%</label></td></tr>"
		dat += "</table>"

		dat += {"<table style="float: left"; margin-left: 50px;>"}
		if(balls && balls.internal_fluids.holder_full())
			dat += "<tr><td><lable>You balls is full!</label></td></tr>"
		if(breasts && (breasts.internal_fluids.total_volume / breasts.internal_fluids.maximum_volume) > 0.9)
			dat += "<tr><td><lable>You breasts full of milk!</label></td></tr>"
		if(vagina && vagina.internal_fluids.holder_full())
			dat += "<tr><td><lable>You so wet!</label></td></tr>"
		dat += "</table>"
		dat += "</div>"

		dat += "<div>"
		dat += {"<table style="float: left">"}
		dat += "<tr><td><label>Anus:</lable></td><td><A href='?src=[REF(src)];anus=1'>[(inserted_item ? inserted_item.name : "None")]</A></td></tr>"
		if(breasts)
			dat += "<tr><td><label>Nipples:</lable></td><td><A href='?src=[REF(src)];breasts=1'>[(breasts.inserted_item ? breasts.inserted_item.name : "None")]</A></td></tr>"
		if(penis)
			dat += "<tr><td><label>Penis:</lable></td><td><A href='?src=[REF(src)];penis=1'>[(penis.inserted_item ? penis.inserted_item.name : "None")]</A></td></tr>"
		if(vagina)
			dat += "<tr><td><label>Vagina:</lable></td><td><A href='?src=[REF(src)];vagina=1'>[(vagina.inserted_item ? vagina.inserted_item.name : "None")]</A></td></tr>"
		dat += "</table>"
		dat += "</div>"

		dat += "<div>"
		dat += "<A href='?src=[REF(src)];climax=1'>Climax</A>"

	else
		dat += "<div>"
		dat += {"<table style="float: left">"}
		dat += "<tr><td><label>Anus:</lable></td><td><A href='?src=[REF(src)];anus=1'>[(inserted_item ? inserted_item.name : "None")]</A></td></tr>"
		if(breasts)
			dat += "<tr><td><label>Nipples:</lable></td><td><A href='?src=[REF(src)];breasts=1'>[(breasts.inserted_item ? breasts.inserted_item.name : "None")]</A></td></tr>"
		if(penis)
			dat += "<tr><td><label>Penis:</lable></td><td><A href='?src=[REF(src)];penis=1'>[(penis.inserted_item ? penis.inserted_item.name : "None")]</A></td></tr>"
		if(vagina)
			dat += "<tr><td><label>Vagina:</lable></td><td><A href='?src=[REF(src)];vagina=1'>[(vagina.inserted_item ? vagina.inserted_item.name : "None")]</A></td></tr>"
		dat += "</table>"
		dat += "</div>"

		dat += "<div>"

	dat += "<A href='?src=[REF(usr)];mach_close=mob[REF(src)]'>Close</A>"
	dat += "<A href='?src=[REF(src)];refresh=1'>Refresh</A>"
	dat += "</div>"

	var/datum/browser/popup = new(usr, "mob[REF(src)]", "[src]", 440, 510)
	popup.title = "[src] Arousal panel"
	popup.set_content(dat.Join())
	popup.open()

//topic
/mob/living/carbon/human/Topic(href, href_list)
	.=..()
	var/mob/living/carbon/human/user = src

	if(!(usr in view(1)))
		return

	if(href_list["refresh"])
		user.show_arousal_panel()

	if(href_list["climax"])
		climax(TRUE)

///////////-----Procs------///////////
/mob/living/proc/extract_item(user, slotName)
	var/mob/living/carbon/human/U = user
	var/mob/living/carbon/human/O = src
	var/slotText = slotName

	if(slotText == "vagina" || slotText == "nipples" || slotText == "penis")
		var/obj/item/organ/genital/organ = null
		var/list/wList = null
		if(slotText == "vagina")
			organ = O.getorganslot(ORGAN_SLOT_VAGINA)
		else if(slotText == "nipples")
			organ = O.getorganslot(ORGAN_SLOT_BREASTS)
		else if(slotText == "penis")
			organ = O.getorganslot(ORGAN_SLOT_PENIS)
		else
			return FALSE

		wList = organ.contained_item
		if(!isnull(organ.inserted_item))
			U.put_in_hands(organ.inserted_item)
			organ.inserted_item = null
			return TRUE
		else
			var/obj/item/I = U.get_active_held_item()
			if(!I)
				return FALSE
			for(var/T in wList)
				if(istype(I,T))
					//equip_to_slot_if_possible(I, slotText)
					if(!transferItemToLoc(I, organ.inserted_item))
						return FALSE
					organ.inserted_item = I
					return TRUE

	else if(slotText == "anus")
		if(!isnull(O.inserted_item))
			U.put_in_hands(O.inserted_item)
			O.inserted_item = null
			return TRUE
		else
			var/obj/item/I = U.get_active_held_item()
			if(!I)
				return FALSE
			for(var/T in O.contained_item)
				if(istype(I,T))
					if(!transferItemToLoc(I, O.inserted_item))
						return FALSE
					O.inserted_item = I
					return TRUE
	else
		return FALSE
*/

/mob/living/proc/set_masochism(status) //TRUE or FALSE
	if(status == TRUE)
		masochism = status
		pain_limit = 80
	if(status == FALSE)
		masochism = status
		pain_limit = 20

/mob/living/proc/set_nymphomania(status) //TRUE or FALSE
	if(status == TRUE)
		nymphomania = TRUE
	if(status == FALSE)
		nymphomania = FALSE

/mob/living/proc/set_neverboner(status) //TRUE or FALSE
	if(status == TRUE)
		neverboner = TRUE
	if(status == FALSE)
		neverboner = FALSE

////////////
///FLUIDS///
////////////

/datum/status_effect/body_fluid_regen
	id = "body fluid regen"
	tick_interval = 50
	duration = -1
	alert_type = null

/datum/status_effect/body_fluid_regen/tick()
	var/mob/living/carbon/human/H = owner
	if(owner.stat != DEAD && H.client?.prefs.erp_pref == "Yes")
		var/obj/item/organ/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
		var/obj/item/organ/genital/breasts/breasts = owner.getorganslot(ORGAN_SLOT_BREASTS)
		var/obj/item/organ/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)

		var/interval = 5
		if(balls)
			if(owner.arousal >= AROUS_SYS_LITTLE)
				var/regen = (owner.arousal/100) * (balls.internal_fluids.maximum_volume/235) * interval
				balls.internal_fluids.add_reagent(/datum/reagent/consumable/cum, regen)

		if(breasts)
			if(breasts.lactates == TRUE)
				var/regen = ((owner.nutrition / (NUTRITION_LEVEL_WELL_FED/100))/100) * (breasts.internal_fluids.maximum_volume/11000) * interval
				breasts.internal_fluids.add_reagent(/datum/reagent/consumable/milk/breast_milk, regen)
				if(!breasts.internal_fluids.holder_full())
					owner.adjust_nutrition(regen / 2)
				else
					regen = regen

		if(vagina)
			if(owner.arousal >= AROUS_SYS_LITTLE)
				var/regen = (owner.arousal/100) * (vagina.internal_fluids.maximum_volume/250) * interval
				vagina.internal_fluids.add_reagent(/datum/reagent/consumable/girlcum, regen)
				if(vagina.internal_fluids.holder_full() && regen >= 0.15)
					regen = regen
			else
				vagina.internal_fluids.remove_any(0.05)

/////////////
///AROUSAL///
/////////////
/mob/living/proc/get_arousal()
	return arousal

/mob/living/proc/adjustArousal(arous = 0)
	if(stat != DEAD && client?.prefs.erp_pref == "Yes")
		arousal += arous

		var/arousal_flag = AROUSAL_NONE
		if(arousal >= AROUS_SYS_STRONG)
			arousal_flag = AROUSAL_FULL
		else if(arousal >= AROUS_SYS_LITTLE)
			arousal_flag = AROUSAL_PARTIAL

		if(arousal_status != arousal_flag) // Set organ arousal status
			arousal_status = arousal_flag
			if(istype(src,/mob/living/carbon/human))
				var/mob/living/carbon/human/M = src
				for(var/i=1,i<=M.internal_organs.len,i++)
					if(istype(M.internal_organs[i],/obj/item/organ/genital))
						var/obj/item/organ/genital/G = M.internal_organs[i]
						if(!G.aroused == AROUSAL_CANT)
							G.aroused = arousal_status
							G.update_sprite_suffix()
				M.update_body()
	else
		arousal -= abs(arous)

	if(nymphomania == TRUE)
		arousal = min(max(arousal,20),100)
	else
		arousal = min(max(arousal,0),100)

/datum/status_effect/aroused
	id = "aroused"
	tick_interval = 10
	duration = -1
	alert_type = null

/datum/status_effect/aroused/tick()
	var/temp_arousal = -0.1
	var/temp_pleasure = -0.5
	var/temp_pain = -0.5
	if(owner.stat != DEAD)

		var/obj/item/organ/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
		if(balls)
			if(balls.internal_fluids.holder_full())
				temp_arousal += 0.08

		if(owner.masochism)
			temp_pain -= 0.5
		if(owner.nymphomania)
			temp_pleasure += 0.25
			temp_arousal += 0.05
		if(owner.neverboner)
			temp_pleasure -= 50
			temp_arousal -= 50

		if(owner.pain > owner.pain_limit)
			temp_arousal -= 0.1
		if(owner.arousal >= AROUS_SYS_STRONG)
			if(prob(3))
				owner.emote(pick("moan","blush"))
			temp_pleasure += 0.1
			//moan
		if(owner.pleasure >= PLEAS_SYS_EDGE)
			if(prob(3))
				owner.emote(pick("moan","twitch_s"))
			//moan x2

	owner.adjustArousal(temp_arousal)
	owner.adjustPleasure(temp_pleasure)
	owner.adjustPain(temp_pain)

////Pain////
/mob/living/proc/get_pain()
	return pain

/mob/living/proc/adjustPain(pn = 0)
	if(stat != DEAD && client?.prefs.erp_pref == "Yes")
		if(pain > pain_limit || pn > pain_limit / 10) // pain system
			if(masochism == TRUE)
				var/p = pn - (pain_limit / 10)
				if(p > 0)
					adjustArousal(-p)
			else
				if(pn > 0)
					adjustArousal(-pn)
			if(prob(2) && pain > pain_limit && pn > pain_limit / 10)
				emote(pick("scream","shiver")) //SCREAM!!!
		else
			if(pn > 0)
				adjustArousal(pn)
			if(masochism == TRUE)
				var/p = pn / 2
				adjustPleasure(p)
		pain += pn
	else
		pain -= abs(pn)
	pain = min(max(pain,0),100)

////Pleasure////
/mob/living/proc/get_pleasure()
	return pleasure

/mob/living/proc/adjustPleasure(pleas = 0)
	if(stat != DEAD && client?.prefs.erp_pref == "Yes")
		pleasure += pleas
		if(pleasure >= 100) // lets cum
			climax(FALSE)
	else
		pleasure -= abs(pleas)
	pleasure = min(max(pleasure,0),100)

// get damage for pain system
/datum/species/apply_damage(damage, damagetype, def_zone, blocked, mob/living/carbon/human/H, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness)
	. = ..()
	var/hit_percent = (100-(blocked+armor))/100
	hit_percent = (hit_percent * (100-H.physiology.damage_resistance))/100
	switch(damagetype)
		if(BRUTE)
			var/amount = forced ? damage : damage * hit_percent * brutemod * H.physiology.brute_mod
			H.adjustPain(amount)
		if(BURN)
			var/amount = forced ? damage : damage * hit_percent * burnmod * H.physiology.burn_mod
			H.adjustPain(amount)

////////////
///CLIMAX///
////////////

/datum/mood_event/orgasm
	description = "<font color=purple>Woah... This pleasant tiredness... I love it.</font>\n"
	mood_change = 8 //yes, +8. Well fed buff gives same amount. This is Fair (tm).
	timeout = 5 MINUTES

/datum/mood_event/climaxself
	description = "<font color=purple>I just came in my own underwear. Messy.</font>\n"
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/overgasm
	description = "<span class='warning'>Uhh... I don't feel like i want to be horny anymore.</span>\n" //Me too, buddy. Me too.
	mood_change = -6
	timeout = 10 MINUTES

#define HAVING_SEX_MAX_TIME 10 SECONDS

/*
* Checks in last_interaction_time if they did some lewd interaction in the timespan defined by HAVING_SEX_MAX_TIME
* if they didn't do anything (value is null) will return false aswell
*/
/mob/living/proc/is_having_sex()
  var/time_since = last_interaction_time - world.time
  if(HAVING_SEX_MAX_TIME <= time_since)
    return TRUE
  else
    return FALSE

/mob/living/proc/climax(manual = TRUE)
	var/obj/item/organ/genital/penis = getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/genital/vagina = getorganslot(ORGAN_SLOT_VAGINA)
	if(manual == TRUE && !has_status_effect(/datum/status_effect/climax_cooldown) && client?.prefs.erp_pref == "Yes")
		if(neverboner == FALSE && !has_status_effect(/datum/status_effect/climax_cooldown))
			switch(gender)
				if(MALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE)
				if(FEMALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg'), 50, TRUE)
				else
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE)

			if(vagina && penis)
				if(is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					if(!src.is_having_sex())
						visible_message("<font color=purple>[src] is cumming!</font>", "<font color=purple>You are cumming!</font>")
				else
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					if(!src.is_having_sex())
						visible_message("<font color=purple>[src] cums in their underwear!</font>", \
								"<font color=purple>You cum in your underwear! Eww.</font>")
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/climaxself)

			if(vagina)
				if(is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					if(!src.is_having_sex())
						visible_message("<font color=purple>[src] is cumming!</font>", "<font color=purple>You are cumming!</font>")
				else
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					if(!src.is_having_sex())
						visible_message("<font color=purple>[src] cums in their underwear!</font>", \
								"<font color=purple>You cum in your underwear! Eww.</font>")
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/climaxself)

			if(penis)
				if(is_bottomless() || penis.visibility_preference == GENITAL_ALWAYS_SHOW)
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					if(!src.is_having_sex())
						visible_message("<font color=purple>[src] is cumming!</font>", "<font color=purple>You are cumming!</font>")
				else
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					if(!src.is_having_sex())
						visible_message("<font color=purple>[src] cums in their underwear!</font>", \
								"<font color=purple>You cum in your underwear! Eww.</font>")
					SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/climaxself)

			else
				apply_status_effect(/datum/status_effect/climax)
				apply_status_effect(/datum/status_effect/climax_cooldown)
				if(!src.is_having_sex())
					visible_message("<font color=purple>[src] twitches in orgasm!</font>", \
								"<font color=purple>You are cumming! Eww.</font>")

		else
			if(!src.is_having_sex())
				visible_message("<font color=purple>[src] twitches, trying to cum, but with no result.</font>", \
							"<font color=purple>You can't have an orgasm!</font>")
		return TRUE

	else if(manual == FALSE && client?.prefs.erp_pref == "Yes")
		if(neverboner == FALSE && !has_status_effect(/datum/status_effect/climax_cooldown))
			switch(gender)
				if(MALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE)
				if(FEMALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg'), 50, TRUE)
				else
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE)
			if(is_bottomless())
				apply_status_effect(/datum/status_effect/climax)
				apply_status_effect(/datum/status_effect/climax_cooldown)
				if(!src.is_having_sex())
					visible_message("<font color=purple>[src] is cumming!</font>", "<font color=purple>You are cumming!</font>")
			else
				apply_status_effect(/datum/status_effect/climax)
				apply_status_effect(/datum/status_effect/climax_cooldown)
				if(!src.is_having_sex())
					visible_message("<font color=purple>[src] cums in their underwear!</font>", \
								"<font color=purple>You cum in your underwear! Eww.</font>")
				SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "orgasm", /datum/mood_event/climaxself)
		else
			if(!src.is_having_sex())
				visible_message("<font color=purple>[src] twitches, trying to cum, but with no result.</font>", \
							"<font color=purple>You can't have an orgasm!</font>")
		return TRUE

	else
		return FALSE

/datum/status_effect/climax_cooldown
	id = "climax_cooldown"
	tick_interval = 10
	duration = 30 SECONDS
	alert_type = null

/datum/status_effect/climax_cooldown/tick()
	var/obj/item/organ/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/testicles/penis = owner.getorganslot(ORGAN_SLOT_PENIS)

	if(penis)
		penis.aroused = AROUSAL_NONE
	if(vagina)
		vagina.aroused = AROUSAL_NONE
	if(balls)
		balls.aroused = AROUSAL_NONE

/datum/status_effect/masturbation_climax
	id = "climax"
	tick_interval =  10
	duration = 50 //Multiplayer better than singleplayer mode.
	alert_type = null

/datum/status_effect/masturbation_climax/tick() //this one should not leave decals on the floor. Used in case if character cumming on somebody's face or in beaker.
	var/mob/living/carbon/human/H = owner
	if(H.client?.prefs.erp_pref == "Yes")
		var/temp_arousal = -12
		var/temp_pleasure = -12
		var/temp_stamina = 6

		owner.reagents.add_reagent(/datum/reagent/drug/dopamine, 0.3)
		owner.adjustStaminaLoss(temp_stamina)
		owner.adjustArousal(temp_arousal)
		owner.adjustPleasure(temp_pleasure)

/datum/status_effect/climax
	id = "climax"
	tick_interval =  10
	duration = 100
	alert_type = null

/datum/status_effect/climax/tick()
	var/mob/living/carbon/human/H = owner
	if(H.client?.prefs.erp_pref == "Yes")
		var/temp_arousal = -12
		var/temp_pleasure = -12
		var/temp_stamina = 12
		var/temp_paralyze = 11

		owner.reagents.add_reagent(/datum/reagent/drug/dopamine, 0.5)
		owner.adjustStaminaLoss(temp_stamina)
		owner.adjustArousal(temp_arousal)
		owner.adjustPleasure(temp_pleasure)
		owner.Paralyze(temp_paralyze)

/datum/status_effect/climax/on_apply(obj/target)
	var/mob/living/carbon/human/H = owner
	var/obj/item/organ/genital/vagina/vagina = owner.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/testicles/balls = owner.getorganslot(ORGAN_SLOT_TESTICLES)
//	var/obj/item/organ/genital/testicles/penis = owner.getorganslot(ORGAN_SLOT_PENIS)

	if(H.client?.prefs.erp_pref == "Yes")
	/*
	//CONDOMS WORK IN PROGRESS
		if(penis && balls && owner.wear_condom())
			if(prob(40))
				owner.emote("moan")
			balls.reagents.remove_all(balls.reagents.total_volume * 0.6)
			var/obj/item/condom/C = owner.get_item_by_slot(ITEM_SLOT_PENIS)
			C.condom_use()
			if(C.condom_state == "broken")
				var/turf/T = get_turf(owner)
				new /obj/effect/decal/cleanable/cum(T)
	*/
		if(balls && owner.is_bottomless())
			var/turf/T = get_turf(owner)
			new /obj/effect/decal/cleanable/cum(T)
			if(prob(40))
				owner.emote("moan")
			balls.reagents.remove_all(balls.reagents.total_volume * 0.6)

		if(vagina && owner.is_bottomless())
			var/turf/T = get_turf(owner)
			new /obj/effect/decal/cleanable/femcum(T)
			if(prob(40))
				owner.emote("moan")
			vagina.reagents.remove_all()

	return ..()

////////////////////////
///SPANKING PROCEDURE///
////////////////////////

//Hips are red after spanking
/datum/status_effect/spanked
	id = "spanked"
	duration = 300 SECONDS
	alert_type = null

/mob/living/carbon/human/examine(mob/user)
	.=..()
	var/t_his = p_their()
	var/mob/living/U = user

	if(stat != DEAD && !HAS_TRAIT(src, TRAIT_FAKEDEATH) && src != U)
		if(src != user)
			if(has_status_effect(/datum/status_effect/spanked) && is_bottomless())
				. += "<font color=purple>[t_his] thighs turned red.</font>\n"

//Mood boost for masochist
/datum/mood_event/perv_spanked
	description = "<font color=purple>Ah, yes! More! Punish me!</font>\n"
	mood_change = 3
	timeout = 5 MINUTES

/////////////////////
///SUBSPACE EFFECT///
/////////////////////

/datum/status_effect/subspace
	id = "subspace"
	tick_interval = 10
	duration = 5 MINUTES
	alert_type = null

/datum/status_effect/subspace/on_apply()
	. = ..()
	var/mob/living/carbon/human/M = owner
	if(owner.masochism == FALSE)
		owner.set_masochism(TRUE)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "subspace", /datum/mood_event/subspace)

/datum/status_effect/subspace/on_remove()
	. = ..()
	var/mob/living/carbon/human/M = owner
	if(owner.masochism == TRUE && !HAS_TRAIT(owner, TRAIT_MASOCHISM))
		owner.set_masochism(FALSE)
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "subspace", /datum/mood_event/subspace)

/datum/mood_event/subspace
	description = "<font color=purple>Everything so woozy... Pain feels so... Awesome.</font>\n"
	mood_change = 4

///////////////////////
///AROUSAL INDICATOR///
///////////////////////

/obj/item/organ/brain/on_life(delta_time, times_fired) //All your horny is here *points to the head*
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(istype(owner, /mob/living/carbon/human) && H.client?.prefs.erp_pref == "Yes")
		if(!(organ_flags & ORGAN_FAILING))
			H.dna.species.handle_arousal(H, delta_time, times_fired)

//screen alert

/atom/movable/screen/alert/aroused_X
	name = "Aroused"
	desc = "It's a little hot in here"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	icon_state = "arousal_small"
	var/mutable_appearance/pain_overlay
	var/mutable_appearance/pleasure_overlay
	var/pain_level = "small"
	var/pleasure_level = "small"

/atom/movable/screen/alert/aroused_X/Initialize()
	.=..()
	pain_overlay = update_pain()
	pleasure_overlay = update_pleasure()

/atom/movable/screen/alert/aroused_X/proc/update_pain()
	if(pain_level == "small")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pain_small")
	if(pain_level == "medium")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pain_medium")
	if(pain_level == "high")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pain_high")
	if(pain_level == "max")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pain_max")

/atom/movable/screen/alert/aroused_X/proc/update_pleasure()
	if(pleasure_level == "small")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pleasure_small")
	if(pleasure_level == "medium")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pleasure_medium")
	if(pleasure_level == "high")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pleasure_high")
	if(pleasure_level == "max")
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pleasure_max")

/datum/species/proc/handle_arousal(mob/living/carbon/human/H, atom/movable/screen/alert/aroused_X)
	var/atom/movable/screen/alert/aroused_X/I = H.alerts["aroused"]
	if(H.client?.prefs.erp_pref == "Yes")
		switch(H.arousal)
			if(-100 to 10)
				H.clear_alert("aroused", /atom/movable/screen/alert/aroused_X)
			if(10 to 25)
				H.throw_alert("aroused", /atom/movable/screen/alert/aroused_X)
				I?.icon_state = "arousal_small"
				I?.update_icon()
			if(25 to 50)
				H.throw_alert("aroused", /atom/movable/screen/alert/aroused_X)
				I?.icon_state = "arousal_medium"
				I?.update_icon()
			if(50 to 75)
				H.throw_alert("aroused", /atom/movable/screen/alert/aroused_X)
				I?.icon_state = "arousal_high"
				I?.update_icon()
			if(75 to INFINITY) //to prevent that 101 arousal that can make icon disappear or something.
				H.throw_alert("aroused", /atom/movable/screen/alert/aroused_X)
				I?.icon_state = "arousal_max"
				I?.update_icon()

		if(H.arousal > 10)
			switch(H.pain)
				if(-100 to 5) //to prevent same thing with pain
					I?.cut_overlay(I.pain_overlay)
				if(5 to 25)
					I?.cut_overlay(I.pain_overlay)
					I?.pain_level = "small"
					I?.pain_overlay = I.update_pain()
					I?.add_overlay(I.pain_overlay)
					I?.update_overlays()
				if(25 to 50)
					I?.cut_overlay(I.pain_overlay)
					I?.pain_level = "medium"
					I?.pain_overlay = I.update_pain()
					I?.add_overlay(I.pain_overlay)
					I?.update_overlays()
				if(50 to 75)
					I?.cut_overlay(I.pain_overlay)
					I?.pain_level = "high"
					I?.pain_overlay = I.update_pain()
					I?.add_overlay(I.pain_overlay)
					I?.update_overlays()
				if(75 to INFINITY)
					I?.cut_overlay(I.pain_overlay)
					I?.pain_level = "max"
					I?.pain_overlay = I.update_pain()
					I?.add_overlay(I.pain_overlay)
					I?.update_overlays()

		if(H.arousal > 10)
			switch(H.pleasure)
				if(-100 to 5) //to prevent same thing with pleasure
					I?.cut_overlay(I.pleasure_overlay)
				if(5 to 25)
					I?.cut_overlay(I.pleasure_overlay)
					I?.pleasure_level = "small"
					I?.pleasure_overlay = I.update_pleasure()
					I?.add_overlay(I.pleasure_overlay)
					I?.update_overlays()
				if(25 to 60)
					I?.cut_overlay(I.pleasure_overlay)
					I?.pleasure_level = "medium"
					I?.pleasure_overlay = I.update_pleasure()
					I?.add_overlay(I.pleasure_overlay)
					I?.update_overlays()
				if(60 to 85)
					I?.cut_overlay(I.pleasure_overlay)
					I?.pleasure_level = "high"
					I?.pleasure_overlay = I.update_pleasure()
					I?.add_overlay(I.pleasure_overlay)
					I?.update_overlays()
				if(85 to INFINITY)
					I?.cut_overlay(I.pleasure_overlay)
					I?.pleasure_level = "max"
					I?.pleasure_overlay = I.update_pleasure()
					I?.add_overlay(I.pleasure_overlay)
					I?.update_overlays()
		else
			if(I?.pleasure_level in list("small", "medium", "high", "max"))
				I.cut_overlay(I.pleasure_overlay)
			if(I?.pain_level in list("small", "medium", "high", "max"))
				I.cut_overlay(I.pain_overlay)

////////////////////////
///CUM.DM ASSIMILATED///
////////////////////////

//Cumshot on face thing
/datum/reagent/consumable/cum/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume)
	. = ..()
	if(!(methods & (INGEST|INJECT|PATCH|VAPOR))) //might be for the better
		if(exposed_mob.client && (exposed_mob.client.prefs.skyrat_toggles & CUMFACE_PREF))
			var/turf/T = get_turf(exposed_mob)
			new/obj/effect/decal/cleanable/cum(T)
			exposed_mob.adjust_blurriness(1)
			exposed_mob.visible_message("<span class='warning'>[exposed_mob] has been covered in cum!</span>", "<span class='userdanger'>You've been covered in cum!</span>")
			playsound(exposed_mob, "desecration", 50, TRUE)
			if(is_type_in_typecache(exposed_mob, GLOB.creamable))
				if(reac_volume>10)
					exposed_mob.AddComponent(/datum/component/cumfaced/big, src)
				else
					exposed_mob.AddComponent(/datum/component/cumfaced, src)
		qdel(src)

//you got cum on your face bro *licks it off* //What the fuck man
/datum/component/cumfaced
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/mutable_appearance/cumface

/datum/component/cumfaced/Initialize()
	if(!is_type_in_typecache(parent, GLOB.creamable))
		return COMPONENT_INCOMPATIBLE

	SEND_SIGNAL(parent, COMSIG_MOB_CUMFACED)

	cumface = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi')

	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		if(H.dna.species.limbs_id == "lizard")
			cumface.icon_state = "cumface_lizard"
		else if(H.dna.species.limbs_id == "monkey")
			cumface.icon_state = "cumface_monkey"
		else if(H.dna.species.id == "vox")
			cumface.icon_state = "cumface_vox"
		else if(H.dna.species.mutant_bodyparts["snout"])
			cumface.icon_state = "cumface_lizard"
		else
			cumface.icon_state = "cumface_human"
	else if(isAI(parent))
		cumface.icon_state = "cumface_ai"

	var/atom/A = parent
	A.add_overlay(cumface)

/datum/component/cumfaced/Destroy(force, silent)
	var/atom/A = parent
	A.cut_overlay(cumface)
	qdel(cumface)
	return ..()

/datum/component/cumfaced/RegisterWithParent()
	RegisterSignal(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_COMPONENT_CLEAN_FACE_ACT),
		.proc/clean_up)

/datum/component/cumfaced/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_COMPONENT_CLEAN_FACE_ACT))

///Callback to remove pieface
/datum/component/cumfaced/proc/clean_up(datum/source, clean_types)
	SIGNAL_HANDLER

	. = NONE
	if(!(clean_types & CLEAN_TYPE_BLOOD))
		qdel(src)
		return COMPONENT_CLEANED

/datum/component/cumfaced/big
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/mutable_appearance/bigcumface

/datum/component/cumfaced/big/Initialize()
	if(!is_type_in_typecache(parent, GLOB.creamable))
		return COMPONENT_INCOMPATIBLE

	SEND_SIGNAL(parent, COMSIG_MOB_CUMFACED)

	bigcumface = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi')

	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		if(H.dna.species.limbs_id == "lizard")
			bigcumface.icon_state = "bigcumface_lizard"
		else if(H.dna.species.limbs_id == "monkey")
			bigcumface.icon_state = "bigcumface_monkey"
		else if(H.dna.species.id == "vox")
			bigcumface.icon_state = "bigcumface_vox"
		else if(H.dna.species.mutant_bodyparts["snout"])
			bigcumface.icon_state = "bigcumface_lizard"
		else
			bigcumface.icon_state = "bigcumface_human"
	else if(isAI(parent))
		bigcumface.icon_state = "cumface_ai"

	var/atom/A = parent
	A.add_overlay(bigcumface)

/datum/component/cumfaced/big/Destroy(force, silent)
	var/atom/A = parent
	A.cut_overlay(bigcumface)
	qdel(bigcumface)
	return ..()

/datum/emote/living/cum
	key = "cum"
	key_third_person = "cums"
	cooldown = 60 SECONDS

/datum/emote/living/cum/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return

	var/obj/item/coomer = new /obj/item/coom(user)
	var/mob/living/carbon/human/H = user
	var/obj/item/held = user.get_active_held_item()
	var/obj/item/unheld = user.get_inactive_held_item()
	if(user.put_in_hands(coomer) && H.dna.species.mutant_bodyparts["testicles"] && H.dna.species.mutant_bodyparts["penis"])
		if(held || unheld)
			if(!((held.name=="cum" && held.item_flags == DROPDEL | ABSTRACT | HAND_ITEM) || (unheld.name=="cum" && unheld.item_flags == DROPDEL | ABSTRACT | HAND_ITEM)))
				to_chat(user, "<span class='notice'>You mentally prepare yourself to masturbate.</span>")
			else
				qdel(coomer)
		else
			to_chat(user, "<span class='notice'>You mentally prepare yourself to masturbate.</span>")
	else
		qdel(coomer)
		to_chat(user, "<span class='warning'>You're incapable of masturbating.</span>")

/obj/item/coom
	name = "cum"
	desc = "C-can I watch...?"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "eggplant"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

/obj/item/coom/attack(mob/living/M, mob/user, proximity)
	if(!proximity)
		return
	if(!(M.client && (M.client.prefs.skyrat_toggles & CUMFACE_PREF) && ishuman(M)))
		to_chat(user, "<span class='warning'>You can't cum onto [M].</span>")
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/testicles/G = H.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/testicles/P = H.getorganslot(ORGAN_SLOT_PENIS)
	var/datum/sprite_accessory/genital/spriteP = GLOB.sprite_accessories["penis"][H.dna.species.mutant_bodyparts["penis"][MUTANT_INDEX_NAME]]
	if(spriteP.is_hidden(H))
		to_chat(user, "<span class='notice'>You need to expose your penis out in order to masturbate.</span>")
		return
	else if(P.aroused != AROUSAL_FULL)
		to_chat(user, "<span class='notice'>You need to be aroused in order to masturbate.</span>")
		return
	var/cum_volume = G.reagents.total_volume
	var/datum/reagents/R = new/datum/reagents(50)
	R.add_reagent(/datum/reagent/consumable/cum, cum_volume)
	if(M==user)
		user.visible_message("<span class='warning'>[user] starts masturbating onto themself!</span>", "<span class='danger'>You start masturbating onto yourself!</span>")
	else
		user.visible_message("<span class='warning'>[user] starts masturbating onto [M]!</span>", "<span class='danger'>You start masturbating onto [M]!</span>")
	if(do_after(user,M,60))
		if(M==user)
			user.visible_message("<span class='warning'>[user] cums on themself!</span>", "<span class='danger'>You cum on yourself!</span>")
			H.apply_status_effect(/datum/status_effect/masturbation_climax)
		else
			user.visible_message("<span class='warning'>[user] cums on [M]!</span>", "<span class='danger'>You cum on [M]!</span>")
			H.apply_status_effect(/datum/status_effect/masturbation_climax)
		R.expose(M, TOUCH)
		log_combat(user, M, "came on")
		if(prob(40))
			user.emote("moan")
		qdel(src)

//jerk off into bottles
/obj/item/coom/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/testicles/G = H.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/genital/testicles/P = H.getorganslot(ORGAN_SLOT_PENIS)
	var/datum/sprite_accessory/genital/spriteP = GLOB.sprite_accessories["penis"][H.dna.species.mutant_bodyparts["penis"][MUTANT_INDEX_NAME]]
	if(spriteP.is_hidden(H))
		to_chat(user, "<span class='notice'>You need to expose your penis out in order to masturbate.</span>")
		return
	else if(P.aroused != AROUSAL_FULL)
		to_chat(user, "<span class='notice'>You need to be aroused in order to masturbate.</span>")
		return
	if(target.is_refillable() && target.is_drainable())
		var/cum_volume = G.reagents.total_volume
		if(target.reagents.holder_full())
			to_chat(user, "<span class='warning'>[target] is full.</span>")
			return
		var/datum/reagents/R = new/datum/reagents(50)
		R.add_reagent(/datum/reagent/consumable/cum, cum_volume)
		user.visible_message("<span class='warning'>[user] starts masturbating into [target]!</span>", "<span class='danger'>You start masturbating into [target]!</span>")
		if(do_after(user,60))
			user.visible_message("<span class='warning'>[user] cums into [target]!</span>", "<span class='danger'>You cum into [target]!</span>")
			playsound(target, "desecration", 50, TRUE)
			R.trans_to(target, cum_volume)
			H.apply_status_effect(/datum/status_effect/masturbation_climax)
			qdel(src)
	else
		if(ishuman(target))
			return
		user.visible_message("<span class='warning'>[user] starts masturbating onto [target]!</span>", "<span class='danger'>You start masturbating onto [target]!</span>")
		if(do_after(user,60))
			visible_message("<span class='warning'>[user] cums on [target]!</span>", "<span class='danger'>You cum on [target]!</span>")
			playsound(target, "desecration", 50, TRUE)
			H.apply_status_effect(/datum/status_effect/climax)

			if(target.icon_state=="stickyweb1"|target.icon_state=="stickyweb2")
				target.icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'
			qdel(src)
