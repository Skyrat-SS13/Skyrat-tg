GLOBAL_LIST_EMPTY(handheld_transceivers)

/obj/item/handheld_transceiver
	name = "handheld transceiver"
	desc = "A two-way secure communication device used by people to communicate with each other."
	icon = 'modular_skyrat\modules\black_mesa\icons\walkietalkie.dmi'
	icon_state = "radio_off"
	throwforce = 10
	var/faction = "USMC"
	var/activated = FALSE

/obj/item/handheld_transceiver/Initialize(mapload)
	. = ..()
	GLOB.handheld_transceivers += src
	become_hearing_sensitive()

/obj/item/handheld_transceiver/Destroy()
	GLOB.handheld_transceivers -= src
	. = ..()

/obj/item/handheld_transceiver/attack_self(mob/user, modifiers)
	. = ..()
	if(!activated)
		to_chat(user, "You turn on [src].")
		icon_state = "radio_on"
		activated = TRUE
	else
		to_chat(user, "You turn off [src].")
		icon_state = "radio_off"
		activated = FALSE

/obj/item/handheld_transceiver/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, list/message_mods)
	. = ..()
	if(!activated)
		return
	if(get_turf(speaker) != get_turf(src))
		return
	broadcast_message(raw_message, speaker)

/obj/item/handheld_transceiver/proc/broadcast_message(message, atom/movable/speaker)
	for(var/obj/item/handheld_transceiver/talk in GLOB.handheld_transceivers)
		if(talk.faction == faction)
			talk.say_message(message, speaker)
	for(var/mob/dead/observer/player_mob in GLOB.player_list)
		if(!istype(player_mob, /mob/dead/observer))
			continue
		if(QDELETED(player_mob)) //Some times nulls and deleteds stay in this list. This is a workaround to prevent ic chat breaking for everyone when they do.
			continue //Remove if underlying cause (likely byond issue) is fixed. See TG PR #49004.
		if(player_mob.stat != DEAD) //not dead, not important
			continue
		if(get_dist(player_mob, src) > 7 || player_mob.z != z) //they're out of range of normal hearing
			if(!(player_mob.client.prefs.chat_toggles & CHAT_GHOSTEARS)) //they're talking normally and we have hearing at any range off
				continue
		var/link = FOLLOW_LINK(player_mob, src)
		to_chat(player_mob, span_blue("[link] <b>[speaker.name]</b> \[RADIO: [faction]\] says, \"[message]\""))

/obj/item/handheld_transceiver/proc/say_message(message, atom/movable/speaker)
	for(var/mob/living/carbon/human/transceiver_hearer in get_turf(src))
		if(HAS_TRAIT(transceiver_hearer, TRAIT_DEAF))
			continue
		to_chat(transceiver_hearer, span_blue("<b>[speaker.name]</b> \[RADIO: [faction]\] says, \"[message]\""))
