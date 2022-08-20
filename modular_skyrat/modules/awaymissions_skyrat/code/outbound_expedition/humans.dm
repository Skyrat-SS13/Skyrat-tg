#define TRIGGER_RANGE 2

/mob/living/carbon/human/npc
	var/list/text_strings = list()

/mob/living/carbon/human/npc/Initialize()
	. = ..()
	AddComponent(/datum/component/npc, text_strings, TRIGGER_RANGE)

/mob/living/carbon/human/npc/commander
	name = "Commander Stevens"
	real_name = "Commander Stevens"
	move_resist = MOVE_FORCE_EXTREMELY_STRONG //leg day has not been skipped
	text_strings = list(
		"Ah, you're here!",
		"As I'm sure you were briefed upstairs, I'll keep this light.",
		"The shuttle's ready to depart, with enough power and supplies to last you the journey.",
		"Good luck out there, marines. You're doing great work for science.",
	)

/mob/living/carbon/human/npc/commander/Initialize()
	. = ..()
	mind_initialize()
	equipOutfit(/datum/outfit/centcom/naval/commander) //they're not actually CC so change later

#undef TRIGGER_RANGE
