/obj/item/organ/internal/vocal_cords //organs that are activated through speech with the :x/MODE_KEY_VOCALCORDS channel
	name = "vocal cords"
	icon_state = "appendix"
	visual = FALSE
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_VOICE
	gender = PLURAL
	decay_factor = 0 //we don't want decaying vocal cords to somehow matter or appear on scanners since they don't do anything damaged
	healing_factor = 0
	var/list/spans = null

/obj/item/organ/internal/vocal_cords/proc/can_speak_with() //if there is any limitation to speaking with these cords
	return TRUE

/obj/item/organ/internal/vocal_cords/proc/speak_with(message) //do what the organ does
	return

/obj/item/organ/internal/vocal_cords/proc/handle_speech(message) //actually say the message
	owner.say(message, spans = spans, sanitize = FALSE)

//Colossus drop, forces the listeners to obey certain commands
/obj/item/organ/internal/vocal_cords/colossus
	name = "divine vocal cords"
	desc = "They carry the voice of an ancient god."
	icon_state = "voice_of_god"
	actions_types = list(/datum/action/item_action/organ_action/colossus)
	var/next_command = 0
	var/cooldown_mod = 1
	var/base_multiplier = 1
	spans = list("colossus","yell")

/datum/action/item_action/organ_action/colossus
	name = "Voice of God"
	var/obj/item/organ/internal/vocal_cords/colossus/cords = null

/datum/action/item_action/organ_action/colossus/New()
	..()
	cords = target

/datum/action/item_action/organ_action/colossus/IsAvailable(feedback = FALSE)
	if(!owner)
		return FALSE
	if(world.time < cords.next_command)
		if (feedback)
			owner.balloon_alert(owner, "wait [DisplayTimeText(cords.next_command - world.time)]!")
		return FALSE
	if(isliving(owner))
		var/mob/living/living = owner
		if(!living.can_speak())
			if (feedback)
				owner.balloon_alert(owner, "can't speak!")
			return FALSE
	if(check_flags & AB_CHECK_CONSCIOUS)
		if(owner.stat)
			if (feedback)
				owner.balloon_alert(owner, "unconscious!")
			return FALSE
	return TRUE

/datum/action/item_action/organ_action/colossus/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return
	var/command = tgui_input_text(owner, "Speak with the Voice of God", "Command")
	if(!command)
		return
	if(QDELETED(src) || QDELETED(owner))
		return
	owner.say(".x[command]")

/obj/item/organ/internal/vocal_cords/colossus/can_speak_with()
	if(!owner)
		return FALSE

	if(world.time < next_command)
		to_chat(owner, span_notice("You must wait [DisplayTimeText(next_command - world.time)] before Speaking again."))
		return FALSE

	return owner.can_speak()

/obj/item/organ/internal/vocal_cords/colossus/handle_speech(message)
	playsound(get_turf(owner), 'sound/magic/clockwork/invoke_general.ogg', 300, TRUE, 5)
	return //voice of god speaks for us

/obj/item/organ/internal/vocal_cords/colossus/speak_with(message)
	var/cooldown = voice_of_god(uppertext(message), owner, spans, base_multiplier)
	next_command = world.time + (cooldown * cooldown_mod)

/obj/item/organ/internal/adamantine_resonator
	visual = FALSE
	name = "adamantine resonator"
	desc = "Fragments of adamantine exist in all golems, stemming from their origins as purely magical constructs. These are used to \"hear\" messages from their leaders."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_ADAMANTINE_RESONATOR
	icon_state = "adamantine_resonator"

/obj/item/organ/internal/vocal_cords/adamantine
	name = "adamantine vocal cords"
	desc = "When adamantine resonates, it causes all nearby pieces of adamantine to resonate as well. Golems containing these formations use this to broadcast messages to nearby golems."
	actions_types = list(/datum/action/item_action/organ_action/use/adamantine_vocal_cords)
	icon_state = "adamantine_cords"

/datum/action/item_action/organ_action/use/adamantine_vocal_cords/Trigger(trigger_flags)
	if(!IsAvailable(feedback = TRUE))
		return
	var/message = tgui_input_text(owner, "Resonate a message to all nearby golems", "Resonate")
	if(!message)
		return
	if(QDELETED(src) || QDELETED(owner))
		return
	owner.say(".x[message]")

/obj/item/organ/internal/vocal_cords/adamantine/handle_speech(message)
	var/msg = span_resonate("[span_name("[owner.real_name]")] resonates, \"[message]\"")
	for(var/player in GLOB.player_list)
		if(iscarbon(player))
			var/mob/living/carbon/speaker = player
			if(speaker.get_organ_slot(ORGAN_SLOT_ADAMANTINE_RESONATOR))
				to_chat(speaker, msg)
		if(isobserver(player))
			var/link = FOLLOW_LINK(player, owner)
			to_chat(player, "[link] [msg]")
