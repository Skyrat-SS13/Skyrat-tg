/datum/quirk/narcolepsy
	name = "Narcolepsy"
	desc = "You may fall asleep at any moment and feel tired often."
	icon = FA_ICON_CLOUD_MOON_RAIN
	value = -9
	hardcore_value = 9
	medical_record_text = "Patient may involuntarily fall asleep during normal activities."
	mail_goodies = list(
		/obj/item/reagent_containers/cup/glass/coffee,
	)

/datum/quirk/narcolepsy/post_add()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user.gain_trauma(/datum/brain_trauma/severe/narcolepsy/permanent, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/narcolepsy/remove()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user?.cure_trauma_type(/datum/brain_trauma/severe/narcolepsy/permanent, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/brain_trauma/severe/narcolepsy/permanent
	scan_desc = "narcolepsy"

//similar to parent but slower
/datum/brain_trauma/severe/narcolepsy/permanent/on_life(seconds_per_tick, times_fired)
	if(owner.IsSleeping())
		return

	var/sleep_chance = 0.333 //3
	var/drowsy = !!owner.has_status_effect(/datum/status_effect/drowsiness)
	if(drowsy)
		sleep_chance = 1

	if(!drowsy && SPT_PROB(sleep_chance, seconds_per_tick))
		to_chat(owner, span_warning("You feel tired..."))
		owner.adjust_drowsiness(rand(30 SECONDS, 60 SECONDS))

	else if(drowsy && SPT_PROB(sleep_chance, seconds_per_tick))
		to_chat(owner, span_warning("You fall asleep."))
		owner.Sleeping(rand(20 SECONDS, 30 SECONDS))
