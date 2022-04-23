/**
 * Rewarding Ashwalkers for lasting long enough in the round
 * 30 minutes: speed
 * 60 minutes: armor
 * 90 minutes: fire breath
 */

/datum/movespeed_modifier/elder_speed
	multiplicative_slowdown = -0.2

/datum/component/elder_ash
	///the parent of the component must be a human
	var/mob/living/carbon/human/human_parent

/datum/component/elder_ash/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	human_parent = parent
	addtimer(CALLBACK(src, .proc/elder_speed), 30 MINUTES)
	addtimer(CALLBACK(src, .proc/elder_armor), 60 MINUTES)
	addtimer(CALLBACK(src, .proc/elder_breath), 90 MINUTES)

/datum/component/elder_ash/proc/elder_speed()
	human_parent.add_movespeed_modifier(/datum/movespeed_modifier/elder_speed)
	to_chat(human_parent, span_warning("As time passes, you feel that your legs have become stronger-- your walking is more efficient."))

/datum/component/elder_ash/proc/elder_armor()
	human_parent.dna.species.armor = 30
	to_chat(human_parent, span_warning("As time passes, you feel that your scales have hardened-- you can take hits better."))

/datum/component/elder_ash/proc/elder_breath()
	var/datum/action/cooldown/mob_cooldown/fire_breath/granted_action
	granted_action = new()
	granted_action.Grant(human_parent)
	to_chat(human_parent, span_warning("As time passes, an ancient power within you has awakened-- the power of fire is yours!"))
