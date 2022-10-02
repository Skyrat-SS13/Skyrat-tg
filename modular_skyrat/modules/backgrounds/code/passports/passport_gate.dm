// Time to make people very angry.
// Intentionally does not use scanner gate code, because yikes.

#define SCANGATE_NONE "none"
#define SCANGATE_PASSPORT "passport"
#define SCANGATE_CITIZENSHIP "citizenship"
#define SCANGATE_WEALTH "wealth"
#define SCANGATE_SPACEBORNE "spaceborne"

/obj/item/circuitboard/machine/passport_gate
	name = "Passport Gate"
	greyscale_colors = CIRCUIT_COLOR_COMMAND
	build_path = /obj/machinery/scanner_gate/passport_gate
	// Scanners to scan RFID/whatever, laser to read paper passports, and glass to protect the laser.
	req_components = list(
		/obj/item/stock_parts/scanning_module = 2,
		/obj/item/stock_parts/micro_laser = 1,
		/obj/item/stack/sheet/glass = 1,
	)


/obj/machinery/scanner_gate/passport_gate
	name = "passport gate"
	desc = "A gate able to scan the passports of anyone who walks through it."
	icon_state = "scangate_black"
	circuit = /obj/item/circuitboard/machine/passport_gate

	/// Used by the passport gate for more advanced functions that can be set by the user.
	var/list/scangate_filter
	/// Radio for the machine to speak into if sec alerts are enabled.
	var/obj/item/radio/radio = /obj/item/radio/headset/headset_sec

/obj/machinery/scanner_gate/passport_gate/Initialize(mapload)
	. = ..()
	radio = new radio()

/obj/machinery/scanner_gate/passport_gate/perform_scan(mob/living/living)
	if(obj_flags & EMAGGED)
		playsound(src, 'modular_skyrat/modules/backgrounds/sounds/passportscanbroke.ogg', 75)
		return

	playsound(src, 'modular_skyrat/modules/backgrounds/sounds/passportscan.ogg', 75)
	var/obj/item/passport/passport = living.get_passport()

	if(!passport)
		if(scangate_mode == SCANGATE_PASSPORT)
			radio.talk_into(src, "[living] has tripped the passport gate at [get_area(src)] for having no passport!!", RADIO_CHANNEL_SECURITY)
			alarm_beep()
		return

	var/beep = FALSE

	switch(scangate_mode)
		if(SCANGATE_CITIZENSHIP)
			if(passport.get_data()["empire"] in scangate_filter)
				beep = TRUE
		if(SCANGATE_WEALTH)
			if(passport.get_data()["current_wages"] > scangate_filter["max"] || passport.get_data()["current_wages"] < scangate_filter["min"])
				beep = TRUE
		if(SCANGATE_SPACEBORNE)
			if(passport.get_data()["space_faring"])
				beep = TRUE
	if(reverse)
		beep = !beep

	if(beep)
		alarm_beep()
		SEND_SIGNAL(src, COMSIG_SCANGATE_PASS_TRIGGER, living)
		if(!ignore_signals)
			color = wires.get_color_of_wire(WIRE_ACCEPT)
			var/obj/item/assembly/assembly = wires.get_attached(color)
			assembly?.activate()
	else
		SEND_SIGNAL(src, COMSIG_SCANGATE_PASS_NO_TRIGGER, living)
		if(!ignore_signals)
			color = wires.get_color_of_wire(WIRE_DENY)
			var/obj/item/assembly/assembly = wires.get_attached(color)
			assembly?.activate()
		set_scanline("scanning", 10)
		say("Welcome, [passport.get_data()["name"]], enjoy your shift, and have a nice day.")

/obj/machinery/scanner_gate/passport_gate/attackby(obj/item/attacking_item, mob/user, params)
	var/obj/item/card/id/card = attacking_item.GetID()
	if(card)
		if(locked)
			if(allowed(user))
				locked = FALSE
				to_chat(user, span_notice("You unlock [src]."))
		else if(!(obj_flags & EMAGGED))
			to_chat(user, span_notice("You lock [src] with [attacking_item]."))
			locked = TRUE
		else
			to_chat(user, span_warning("You try to lock [src] with [attacking_item], but nothing happens."))
	return ..()

/obj/machinery/scanner_gate/passport_gate/emag_act(mob/user)
	req_one_access = list()
	return ..()

/obj/machinery/scanner_gate/passport_gate/Destroy()
	qdel(radio)
	return ..()

#undef SCANGATE_NONE
#undef SCANGATE_PASSPORT
#undef SCANGATE_CITIZENSHIP
#undef SCANGATE_WEALTH
#undef SCANGATE_SPACEBORNE
