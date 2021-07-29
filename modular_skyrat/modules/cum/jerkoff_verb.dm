/datum/emote/living/cum
	key = "cum"
	key_third_person = "cums"
	cooldown = 30 SECONDS

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
	var/cum_volume = G.genital_size*5+5
	var/datum/reagents/R = new/datum/reagents(50)
	R.add_reagent(/datum/reagent/cum, cum_volume)
	if(M==user)
		user.visible_message("<span class='warning'>[user] starts masturbating onto themself!</span>", "<span class='danger'>You start masturbating onto yourself!</span>")
	else
		user.visible_message("<span class='warning'>[user] starts masturbating onto [M]!</span>", "<span class='danger'>You start masturbating onto [M]!</span>")
	if(do_after(user,M,60))
		if(M==user)
			user.visible_message("<span class='warning'>[user] cums on themself!</span>", "<span class='danger'>You cum on yourself!</span>")
		else
			user.visible_message("<span class='warning'>[user] cums on [M]!</span>", "<span class='danger'>You cum on [M]!</span>")
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
		var/cum_volume = G.genital_size*5+5
		if(target.reagents.holder_full())
			to_chat(user, "<span class='warning'>[target] is full.</span>")
			return
		var/datum/reagents/R = new/datum/reagents(50)
		R.add_reagent(/datum/reagent/cum, cum_volume)
		user.visible_message("<span class='warning'>[user] starts masturbating into [target]!</span>", "<span class='danger'>You start masturbating into [target]!</span>")
		if(do_after(user,60))
			user.visible_message("<span class='warning'>[user] cums into [target]!</span>", "<span class='danger'>You cum into [target]!</span>")
			playsound(target, "desecration", 50, TRUE)
			R.trans_to(target, cum_volume)
			if(prob(40))
				user.emote("moan")
			qdel(src)
	else
		if(ishuman(target))
			return
		user.visible_message("<span class='warning'>[user] starts masturbating onto [target]!</span>", "<span class='danger'>You start masturbating onto [target]!</span>")
		if(do_after(user,60))
			var/turf/T = get_turf(target)
			user.visible_message("<span class='warning'>[user] cums on [target]!</span>", "<span class='danger'>You cum on [target]!</span>")
			playsound(target, "desecration", 50, TRUE)
			new/obj/effect/decal/cleanable/cum(T)
			if(prob(40))
				user.emote("moan")

			if(target.icon_state=="stickyweb1"|target.icon_state=="stickyweb2")
				target.icon = 'modular_skyrat/modules/cum/cum.dmi'
			qdel(src)
