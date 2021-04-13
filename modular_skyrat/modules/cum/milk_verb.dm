/datum/emote/living/milk
	key = "milk"
	key_third_person = "milking"
	cooldown = 30 SECONDS

/datum/emote/living/milk/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	if(!.)
		return


	var/obj/item/coomer = new /obj/item/coom(user)
	var/mob/living/carbon/human/H = user
	var/obj/item/held = user.get_active_held_item()
	var/obj/item/unheld = user.get_inactive_held_item()
	if(user.put_in_hands(coomer) && H.dna.species.mutant_bodyparts["breast"] && H.dna.species.mutant_bodyparts["breast"])
		if(held || unheld)
			if(!((held.name=="milk" && held.item_flags == DROPDEL | ABSTRACT | HAND_ITEM) || (unheld.name=="milk" && unheld.item_flags == DROPDEL | ABSTRACT | HAND_ITEM)))
				to_chat(user, "<span class='notice'>You mentally prepare to milk yourself.</span>")
			else
				qdel(coomer)
		else
			to_chat(user, "<span class='notice'>You mentally prepare to milk yourself.</span>")
	else
		qdel(coomer)
		to_chat(user, "<span class='warning'>You're incapable of milking.</span>")

/obj/item/molk
	name = "milk"
	desc = "C-can I drink...?"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "watermelon"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM

	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/breast/G = H.getorganslot(ORGAN_SLOT_BREASTS)
	var/obj/item/organ/genital/breast/P = H.getorganslot(ORGAN_SLOT_BREASTS)
	var/datum/sprite_accessory/genital/spriteP = GLOB.sprite_accessories["breast"][H.dna.species.mutant_bodyparts["breast"][MUTANT_INDEX_NAME]]
	if(spriteP.is_hidden(H))
		to_chat(user, "<span class='notice'>You need to expose your breast out in order to milk yourself.</span>")
		return
	else if(P.aroused != AROUSAL_FULL)
		to_chat(user, "<span class='notice'>You need to be aroused in order to milk.</span>")
		return
	var/milk_volume = G.genital_size*5+5
	var/datum/reagents/R = new/datum/reagents(50)
	R.add_reagent(/datum/reagent/consumable/milk, cum_volume)

//jerk off into bottles
/obj/item/coom/afterattack(obj/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/genital/testicles/G = H.getorganslot(ORGAN_SLOT_BREASTS)
	var/obj/item/organ/genital/testicles/P = H.getorganslot(ORGAN_SLOT_BREASTS)
	var/datum/sprite_accessory/genital/spriteP = GLOB.sprite_accessories["breast"][H.dna.species.mutant_bodyparts["breast"][MUTANT_INDEX_NAME]]
	if(spriteP.is_hidden(H))
		to_chat(user, "<span class='notice'>You need to expose your breasts out in order to milk into the [target].</span>")
		return
	else if(P.aroused != AROUSAL_FULL)
		to_chat(user, "<span class='notice'>You need to be aroused in order to milk yourself.</span>")
		return
	if(target.is_refillable() && target.is_drainable())
		var/cum_volume = G.genital_size*5+5
		if(target.reagents.holder_full())
			to_chat(user, "<span class='warning'>[target] is full.</span>")
			return
		var/datum/reagents/R = new/datum/reagents(50)
		R.add_reagent(/datum/reagent/consumable/milk, cum_volume)
		user.visible_message("<span class='warning'>[user] starts milking into [target]!</span>", "<span class='danger'>You start milking into [target]!</span>")
		if(do_after(user,60))
			user.visible_message("<span class='warning'>[user] milks into [target]!</span>", "<span class='danger'>You milks into [target]!</span>")
			playsound(target, "desecration", 50, TRUE)
			R.trans_to(target, cum_volume)
			if(prob(40))
				user.emote("moan")
			qdel(src)
