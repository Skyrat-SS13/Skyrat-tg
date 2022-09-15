/obj/item/hand_item/coom
	name = "cum"
	desc = "C-can I watch...?"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "eggplant"
	inhand_icon_state = "nothing"

/obj/item/hand_item/coom/attack(mob/living/target, mob/user, proximity)
	. = ..()
	do_masturbate(target, user, proximity)

// Jerk off into bottles
/obj/item/hand_item/coom/afterattack(obj/target, mob/user, proximity)
	. = ..()
	do_masturbate(target, user, proximity)

/obj/item/hand_item/coom/proc/do_masturbate(obj/target, mob/user, proximity)
	if (CONFIG_GET(flag/disable_erp_preferences))
		return
	if(!proximity)
		return
	if(user.stat == DEAD)
		return
	var/mob/living/carbon/human/affected_human = user
	var/obj/item/organ/external/genital/testicles/testicles = affected_human.getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/external/genital/penis/penis = affected_human.getorganslot(ORGAN_SLOT_PENIS)
	var/datum/sprite_accessory/genital/spriteP = GLOB.sprite_accessories[ORGAN_SLOT_PENIS][affected_human.dna.species.mutant_bodyparts[ORGAN_SLOT_PENIS][MUTANT_INDEX_NAME]]
	if(spriteP.is_hidden(affected_human))
		to_chat(user, span_notice("You need to expose yourself in order to masturbate."))
		return
	else if(penis.aroused != AROUSAL_FULL)
		to_chat(user, span_notice("You need to be aroused in order to masturbate."))
		return
	var/cum_volume = testicles.genital_size*5+5
	var/datum/reagents/applied_reagents = new/datum/reagents(50)
	applied_reagents.add_reagent(/datum/reagent/consumable/cum, cum_volume)
	if(target == user)
		user.visible_message(span_warning("[user] starts masturbating onto [target.p_them()]self!"), span_danger("You start masturbating onto yourself!"))

	else if(target.is_refillable() && target.is_drainable())
		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target] is full."))
			return
		user.visible_message(span_warning("[user] starts masturbating into [target]!"), span_danger("You start masturbating into [target]!"))
	else
		user.visible_message(span_warning("[user] starts masturbating onto [target]!"), span_danger("You start masturbating onto [target]!"))

	if(do_after(user, 60, target))
		if(target == user)
			user.visible_message(span_warning("[user] cums on [target.p_them()]self!"), span_danger("You cum on yourself!"))

		else if(target.is_refillable() && target.is_drainable())
			user.visible_message(span_warning("[user] cums into [target]!"), span_danger("You cum into [target]!"))
			playsound(target, SFX_DESECRATION, 50, TRUE, ignore_walls = FALSE)
			applied_reagents.trans_to(target, cum_volume)
		else
			user.visible_message(span_warning("[user] cums on [target]!"), span_danger("You cum on [target]!"))
			playsound(target, SFX_DESECRATION, 50, TRUE, ignore_walls = FALSE)
			affected_human.add_cum_splatter_floor(get_turf(target))

			if(target.icon_state=="stickyweb1"|target.icon_state=="stickyweb2")
				target.icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'

		applied_reagents.expose(target, TOUCH)
		log_combat(user, target, "came on")
		if(prob(40))
			affected_human.try_lewd_autoemote("moan")
		qdel(src)
