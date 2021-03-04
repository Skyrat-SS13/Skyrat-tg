/datum/emote/living/cum
	key = "cum"
	key_third_person = "cums"
	cooldown = 3 SECONDS

/datum/emote/living/cum/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return

	var/obj/item/coomer = new /obj/item/coom(user)
	var/mob/living/carbon/human/H = user
	if(user.put_in_hands(coomer) && H.dna.species.mutant_bodyparts["testicles"])
		to_chat(user, "<span class='notice'>You mentally prepare yourself to masturbate.</span>")
	else
		qdel(coomer)
		to_chat(user, "<span class='warning'>You're incapable of cumming.</span>")

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
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/testicles/G = H.getorganslot(ORGAN_SLOT_TESTICLES)
	var/cum_volume = G.genital_size*5+5
	var/datum/reagents/R = new/datum/reagents(50)
	R.add_reagent(/datum/reagent/cum, cum_volume)
	//if(!do_mob(user, M))
	//	return
	if(M==user)
		user.visible_message("<span class='warning'>[user] starts masturbating onto themself![H.dna.species.mutant_bodyparts["testicles"].genital_size]</span>", "<span class='danger'>You start masturbating onto yourself!</span>")
	else
		user.visible_message("<span class='warning'>[user] starts masturbating onto [M]!</span>", "<span class='danger'>You start masturbating onto [M]!</span>")
	if(do_after(user,60))
		if(M==user)
			user.visible_message("<span class='warning'>[user] cums on themself!</span>", "<span class='danger'>You cum on yourself!</span>")
		else
			user.visible_message("<span class='warning'>[user] cums on [M]!</span>", "<span class='danger'>You cum on [M]!</span>")
		R.expose(M, TOUCH)
		if(prob(40))
			user.emote("moan")
		qdel(src)
//jerk off into bottles
/obj/item/coom/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(target.is_refillable() && target.is_drainable())
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/genital/testicles/G = H.getorganslot(ORGAN_SLOT_TESTICLES)
		var/cum_volume = G.genital_size*5+5
		if(target.reagents.holder_full())
			to_chat(user, "<span class='warning'>[target] is full.</span>")
			return
		var/datum/reagents/R = new/datum/reagents(50)
		R.add_reagent(/datum/reagent/cum, cum_volume)
		user.visible_message("<span class='warning'>[user] starts masturbating into the [target]!</span>", "<span class='danger'>You start masturbating into the [target]!</span>")
		if(do_after(user,60))
			user.visible_message("<span class='warning'>[user] cums into the [target]!</span>", "<span class='danger'>You cum into the [target]!</span>")
			playsound(target, "desecration", 50, TRUE)
			R.trans_to(target, cum_volume)
			if(prob(40))
				user.emote("moan")
			qdel(src)
	else
		user.visible_message("<span class='warning'>[user] starts masturbating onto the [target]!</span>", "<span class='danger'>You start masturbating onto the [target]!</span>")
		if(do_after(user,60))
			var/turf/T = get_turf(target)
			user.visible_message("<span class='warning'>[user] cums on the [target]!</span>", "<span class='danger'>You cum on the [target]!</span>")
			playsound(target, "desecration", 50, TRUE)
			new/obj/effect/decal/cleanable/cum(T)
			if(prob(40))
				user.emote("moan")
			qdel(src)