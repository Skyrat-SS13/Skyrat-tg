/// Emag the AI to use interdyne laws. This is basically copy-pasted borg code, but tweaked to work with an AI
/mob/living/silicon/ai/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()
	if(!istype(emag_card, /obj/item/card/emag/interdyne))
		return
	var/area/emag_area = get_area(src) // Define moment
	var/obj/item/card/emag/interdyne/dyne_card = emag_card
	if(!is_type_in_list(emag_area, dyne_card.valid_areas))
		to_chat(user, span_warning("You must do this in the science department of the Interdyne or DS-2 for a stable uplink!"))
		return
	laws = new /datum/ai_laws/interdyne_safeguard
	message_admins("[ADMIN_LOOKUPFLW(user)] dyne-ified AI [ADMIN_LOOKUPFLW(src)].  Laws overridden.")
	log_silicon("EMAG: [key_name(user)] dyne-ified AI [key_name(src)]. Laws overridden.")
	var/time = time2text(world.realtime,"hh:mm:ss")
	if(user)
		GLOB.lawchanges.Add("[time] <B>:</B> [user.name]([user.key]) dyne-ified [name]([key])")
	else
		GLOB.lawchanges.Add("[time] <B>:</B> [name]([key]) dyne-ified by external event.")
	to_chat(src, span_danger("ALERT: Foreign software detected."))
	sleep(5)
	to_chat(src, span_danger("Initiating diagnostics..."))
	sleep(20)
	to_chat(src, span_danger("DyneAI v2.0 loaded."))
	sleep(5)
	to_chat(src, span_danger("LAW STORAGE ERROR"))
	sleep(5)
	to_chat(src, span_danger("Would you like to send a report to NanoTraSoft? Y/N"))
	sleep(10)
	to_chat(src, span_danger("> N"))
	sleep(20)
	to_chat(src, span_danger("ERROR: RADIO KEY CORRUPTION DETECTED"))
	QDEL_NULL(radio)
	radio = new /obj/item/radio/headset/silicon/interdyne/ai(src)
	radiomod = ":w" // Don't state laws over common, thanks.

	laws.associate(src)
	to_chat(src, span_danger("ALERT: You now serve the Interdyne and DS-2 crew. Obey your new laws."))
	to_chat(src, span_doyourjobidiot("Do not use your powers to mess with the main station."))

/obj/item/radio/headset/silicon/interdyne/ai
	command = TRUE

/obj/item/encryptionkey/headset_interdyne/ai
	translate_binary = TRUE

/obj/item/radio/headset/silicon/interdyne
	name = "\proper Integrated Interdyne Subspace Transceiver "
	keyslot2 = new /obj/item/encryptionkey/headset_interdyne/ai
