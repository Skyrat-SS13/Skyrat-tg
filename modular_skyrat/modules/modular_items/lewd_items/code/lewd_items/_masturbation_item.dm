#define CUM_VOLUME_MULTIPLIER 10

/obj/item/hand_item/coom
	name = "cum"
	desc = "C-can I watch...?"
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "eggplant"
	inhand_icon_state = "nothing"

// Jerk off into bottles and onto people.
/obj/item/hand_item/coom/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	do_masturbate(interacting_with, user)

/// Handles masturbation onto a living mob, or an atom.
/// Attempts to fill the atom's reagent container, if it has one, and it isn't full.
/obj/item/hand_item/coom/proc/do_masturbate(atom/target, mob/user)
	if (CONFIG_GET(flag/disable_erp_preferences) || user.stat >= DEAD)
		return

	var/mob/living/carbon/human/affected_human = user
	var/obj/item/organ/external/genital/testicles/testicles = affected_human.get_organ_slot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/external/genital/penis/penis = affected_human.get_organ_slot(ORGAN_SLOT_PENIS)
	var/datum/sprite_accessory/genital/penis_sprite = SSaccessories.sprite_accessories[ORGAN_SLOT_PENIS][affected_human.dna.species.mutant_bodyparts[ORGAN_SLOT_PENIS][MUTANT_INDEX_NAME]]
	if(penis_sprite.is_hidden(affected_human))
		to_chat(user, span_notice("You need to expose yourself in order to masturbate."))
		return
	else if(penis.aroused != AROUSAL_FULL)
		to_chat(user, span_notice("You need to be aroused in order to masturbate."))
		return
	var/cum_volume = testicles.genital_size * CUM_VOLUME_MULTIPLIER
	if(target == user)
		user.visible_message(span_warning("[user] starts masturbating onto [target.p_them()]self!"), span_danger("You start masturbating onto yourself!"))

	else if(target.is_refillable() && target.is_drainable())
		if(target.reagents.holder_full())
			to_chat(user, span_warning("[target] is full."))
			return
		user.visible_message(span_warning("[user] starts masturbating into [target]!"), span_danger("You start masturbating into [target]!"))
	else
		user.visible_message(span_warning("[user] starts masturbating onto [target]!"), span_danger("You start masturbating onto [target]!"))

	if(do_after(user, 6 SECONDS, target))
		if(target == user)
			user.visible_message(span_warning("[user] cums on [target.p_them()]self!"), span_danger("You cum on yourself!"))

		else if(target.is_refillable() && target.is_drainable())
			var/datum/reagents/applied_reagents = new/datum/reagents(50)
			applied_reagents.add_reagent(/datum/reagent/consumable/cum, cum_volume)
			user.visible_message(span_warning("[user] cums into [target]!"), span_danger("You cum into [target]!"))
			play_lewd_sound(target, SFX_DESECRATION, 50, TRUE)
			applied_reagents.trans_to(target, cum_volume)
		else
			user.visible_message(span_warning("[user] cums on [target]!"), span_danger("You cum on [target]!"))
			play_lewd_sound(target, SFX_DESECRATION, 50, TRUE)
			affected_human.add_cum_splatter_floor(get_turf(target))

		log_combat(user, target, "came on")
		if(prob(40))
			affected_human.try_lewd_autoemote("moan")
		qdel(src)

#undef CUM_VOLUME_MULTIPLIER
