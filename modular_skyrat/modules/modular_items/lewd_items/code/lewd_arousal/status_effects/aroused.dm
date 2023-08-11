#define AUTO_EMOTE_CHANCE 3

#define MASOCHISM_PAIN_OFFSET 0.5
#define NEVERBONER_PLEASURE_OFFSET 50

#define BLUEBALL_AROUSAL_MODIFIER 0.08
#define TOO_MUCH_PAIN_MODIFIER 0.1
#define ITS_PRETTY_HOT_IN_HERE_MODIFIER 0.1

#define BASE_AROUSAL_ADJUSTMENT -0.1
#define BASE_PAIN_AND_PLEASURE_ADJUSTMENT -0.5

/datum/status_effect/aroused
	id = "aroused"
	tick_interval = 1 SECONDS
	duration = -1
	alert_type = null

/datum/status_effect/aroused/tick(seconds_between_ticks)
	if(owner.stat >= DEAD || !owner.client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	var/mob/living/carbon/human/affected_mob = owner
	var/temp_arousal = BASE_AROUSAL_ADJUSTMENT
	var/temp_pleasure = BASE_PAIN_AND_PLEASURE_ADJUSTMENT
	var/temp_pain = BASE_PAIN_AND_PLEASURE_ADJUSTMENT

	var/obj/item/organ/external/genital/testicles/balls = affected_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)
	if(balls && balls.internal_fluid_full())
		temp_arousal += BLUEBALL_AROUSAL_MODIFIER

	if(HAS_TRAIT(affected_mob, TRAIT_MASOCHISM))
		temp_pain -= MASOCHISM_PAIN_OFFSET
	if(HAS_TRAIT(affected_mob, TRAIT_NEVERBONER))
		temp_pleasure -= NEVERBONER_PLEASURE_OFFSET
		temp_arousal -= NEVERBONER_PLEASURE_OFFSET

	if(affected_mob.pain > affected_mob.pain_limit)
		temp_arousal -= TOO_MUCH_PAIN_MODIFIER
	if(affected_mob.arousal >= AROUSAL_MEDIUM)
		if(prob(AUTO_EMOTE_CHANCE))
			affected_mob.try_lewd_autoemote(pick("moan", "blush"))
		temp_pleasure += ITS_PRETTY_HOT_IN_HERE_MODIFIER
		//moan
	if(affected_mob.pleasure >= AROUSAL_HIGH && prob(AUTO_EMOTE_CHANCE))
		affected_mob.try_lewd_autoemote(pick("moan", "twitch_s"))
		//moan x2

	affected_mob.adjust_arousal(temp_arousal)
	affected_mob.adjust_pleasure(temp_pleasure)
	affected_mob.adjust_pain(temp_pain)

#undef AUTO_EMOTE_CHANCE

#undef MASOCHISM_PAIN_OFFSET
#undef NEVERBONER_PLEASURE_OFFSET

#undef BLUEBALL_AROUSAL_MODIFIER
#undef TOO_MUCH_PAIN_MODIFIER
#undef ITS_PRETTY_HOT_IN_HERE_MODIFIER

#undef BASE_AROUSAL_ADJUSTMENT
#undef BASE_PAIN_AND_PLEASURE_ADJUSTMENT
