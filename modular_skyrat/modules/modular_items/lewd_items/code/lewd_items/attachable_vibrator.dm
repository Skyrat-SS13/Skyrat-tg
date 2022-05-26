/*
/*
*	VIBRATING EGG
*/

/obj/item/clothing/sextoy/eggvib
	name = "vibrating egg"
	desc = "A simple, vibrating sex toy."
	icon_state = "eggvib"
	inhand_icon_state = "eggvib"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	slot_flags = ITEM_SLOT_PENIS | ITEM_SLOT_VAGINA | ITEM_SLOT_NIPPLES | ITEM_SLOT_ANUS
	moth_edible = FALSE
	/// Is the toy currently on
	var/toy_on = FALSE
	/// The current color of the toy, affects sprite
	var/current_color = "pink"
	/// Bool of if the color's been changed or not before
	var/color_changed = FALSE
	/// The current mode of the toy, affects sprite
	var/vibration_mode = "off"
	/// Assoc list of modes, used to transfer between them
	var/list/modes = list("low" = "medium", "medium" = "high", "high" = "off", "off" = "low")
	/// A looping sound called on process()
	var/datum/looping_sound/vibrator/low/soundloop1
	/// A looping sound called on process()
	var/datum/looping_sound/vibrator/medium/soundloop2
	/// A looping sound called on process()
	var/datum/looping_sound/vibrator/high/soundloop3
	/// The sprites used in the radial menu when selecting a toy color
	var/static/list/vib_designs
	w_class = WEIGHT_CLASS_TINY

/// Creates the designs for the color choice radial menu
/obj/item/clothing/sextoy/eggvib/proc/populate_vib_designs()
	vib_designs = list(
		"pink" = image(icon = src.icon, icon_state = "[initial(icon_state)]_pink_low[(istype(src, /obj/item/clothing/sextoy/eggvib/signalvib)) ? "_on" : ""]"),
		"teal" = image(icon = src.icon, icon_state = "[initial(icon_state)]_teal_low[(istype(src, /obj/item/clothing/sextoy/eggvib/signalvib)) ? "_on" : ""]"))

/obj/item/clothing/sextoy/eggvib/AltClick(mob/user)
	if(!color_changed)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user, src, vib_designs, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	else
		toggle_mode()
		switch(vibration_mode)
			if("low")
				to_chat(user, span_notice("You set the vibration mode to low. Bzzz..."))
			if("medium")
				to_chat(user, span_notice("You set the vibration mode to medium. Bzzzz!"))
			if("high")
				to_chat(user, span_notice("You set the vibration mode to high. Careful with that thing."))
			if("off")
				to_chat(user, span_notice("You turn off the vibrating egg. Fun time's over."))
		update_icon()
		update_icon_state()

/obj/item/clothing/sextoy/eggvib/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(vib_designs))
		populate_vib_designs()
	//soundloop
	soundloop1 = new(src, FALSE)
	soundloop2 = new(src, FALSE)
	soundloop3 = new(src, FALSE)

/obj/item/clothing/sextoy/eggvib/Destroy()
	QDEL_NULL(soundloop1)
	QDEL_NULL(soundloop2)
	QDEL_NULL(soundloop3)
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/sextoy/eggvib/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[vibration_mode][(istype(src, /obj/item/clothing/sextoy/eggvib/signalvib)) ? (toy_on ? "_on" : "_off") : ""]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/// Toggles between vibration modes seuentially
/obj/item/clothing/sextoy/eggvib/proc/toggle_mode()
	vibration_mode = modes[vibration_mode]
	soundloop1.stop()
	soundloop2.stop()
	soundloop3.stop()
	switch(vibration_mode)
		if("low")
			toy_on = TRUE
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE, ignore_walls = FALSE)
			soundloop1.start()
		if("medium")
			toy_on = TRUE
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE, ignore_walls = FALSE)
			soundloop2.start()
		if("high")
			toy_on = TRUE
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE, ignore_walls = FALSE)
			soundloop3.start()
		if("off")
			toy_on = FALSE
			playsound(loc, 'sound/weapons/magout.ogg', 20, TRUE, ignore_walls = FALSE)

/obj/item/clothing/sextoy/eggvib/equipped(mob/living/carbon/human/user, slot, initial)
	. = ..()
	if(!istype(user))
		return
	if(is_in_genital(user))
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/eggvib/dropped(mob/user, silent)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/eggvib/process(delta_time)
	if(!toy_on)
		return
	var/mob/living/carbon/human/target = loc
	if(!istype(target))
		return
	if(vibration_mode == "low")
		target.adjustArousal(0.5 * delta_time)
		target.adjustPleasure(0.5 * delta_time)
	if(vibration_mode == "medium")
		target.adjustArousal(0.6 * delta_time)
		target.adjustPleasure(0.6 * delta_time)
	if(vibration_mode == "high")
		target.adjustArousal(0.7 * delta_time)
		target.adjustPleasure(0.7 * delta_time)

/*
*	SIGNALLER CONTROLLED EGG
*/

/obj/item/clothing/sextoy/eggvib/signalvib
	name = "signal vibrating egg"
	desc = "A vibrating sex toy with remote control capability. Use a signaller to turn it on."
	icon_state = "signalvib"
	inhand_icon_state = "signalvib"
	modes = list("low" = "medium", "medium" = "high", "high" = "low")
	vibration_mode = "low"
	/// If TRUE, the code and frequency will be random on initialize()
	var/random = TRUE
	/// If TRUE, the set code and frequency will be appended to the toy's name
	var/freq_in_name = TRUE
	/// The default signaller code of the toy
	var/code = 2
	/// The default frequency of the toy
	var/frequency = FREQ_ELECTROPACK

/obj/item/clothing/sextoy/eggvib/signalvib/Initialize()
	if(random)
		code = rand(1, 100)
		frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
	if(freq_in_name)
		name = initial(name) + " - freq: [frequency/10] code: [code]"
	set_frequency(frequency)
	. = ..()

/obj/item/clothing/sextoy/eggvib/signalvib/Destroy()
	SSradio.remove_object(src, frequency)
	. = ..()

// A moment for the `attackby()` proc that used to lie here, letting you turn a vibrator into an electric chair.

/obj/item/clothing/sextoy/eggvib/signalvib/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[vibration_mode == "off" ? "low_off" : (toy_on ? "[vibration_mode]_on" : "[vibration_mode]_off")]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/sextoy/eggvib/signalvib/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	SSradio.add_object(src, frequency, RADIO_SIGNALER)

/obj/item/clothing/sextoy/eggvib/signalvib/ui_state(mob/user)
	return GLOB.hands_state

//arousal stuff

/obj/item/clothing/sextoy/eggvib/signalvib/AltClick(mob/user)
	if(!color_changed)
		var/choice = show_radial_menu(user, src, vib_designs, custom_check = CALLBACK(src, /obj/item/clothing/sextoy/proc/check_menu, user), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	else
		if(!toy_on)
			to_chat(usr, span_notice("You can't switch modes while the vibrating egg is turned off!"))
			return
		toggle_mode()
		soundloop1.stop()
		soundloop2.stop()
		soundloop3.stop()
		switch(vibration_mode)
			if("low")
				to_chat(user, span_notice("You set the vibration mode to low. Bzzz..."))
				soundloop1.start()
			if("medium")
				to_chat(user, span_notice("You set the vibration mode to medium. Bzzzz!"))
				soundloop2.start()
			if("high")
				to_chat(user, span_notice("You set the vibration mode to high. Careful with that thing!"))
				soundloop3.start()
		update_icon()
		update_icon_state()

/obj/item/clothing/sextoy/eggvib/signalvib/receive_signal(datum/signal/signal)
	if(!signal || signal.data["code"] != code)
		return

	toy_on = !toy_on
	update_icon_state()
	update_icon()

	if(toy_on)
		soundloop1.stop()
		soundloop2.stop()
		soundloop3.stop()
		if(vibration_mode == "low")
			soundloop1.start()
		if(vibration_mode == "medium")
			soundloop2.start()
		if(vibration_mode == "high")
			soundloop3.start()
	else
		soundloop1.stop()
		soundloop2.stop()
		soundloop3.stop()

	//adding messages to chat if vibrator enabled while
	var/mob/living/carbon/human/vibrated = loc
	if(!istype(vibrated))
		return
	if(toy_on)
		if(src == vibrated.penis || src == vibrated.vagina || src == vibrated.anus)
			to_chat(vibrated, span_purple("You feel pleasant vibrations deep below..."))
		else if(src == vibrated.nipples)
			to_chat(vibrated, span_purple("You feel pleasant stimulation in your nipples."))
	else if(!toy_on && is_in_genital(vibrated))
		to_chat(vibrated, span_purple("The vibrating toy no longer drives you mad."))

	if(!master)
		return
	if(isassembly(master))
		var/obj/item/assembly/master_as_assembly = master
		master_as_assembly.pulsed()
	master.receive_signal()

/obj/item/clothing/sextoy/eggvib/signalvib/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Signalvib", name)
		ui.open()

/obj/item/clothing/sextoy/eggvib/signalvib/ui_data(mob/user)
	var/list/data = list()
	data["toystate"] = toy_on
	data["frequency"] = frequency
	data["code"] = code
	data["minFrequency"] = MIN_FREE_FREQ
	data["maxFrequency"] = MAX_FREE_FREQ
	return data

/obj/item/clothing/sextoy/eggvib/signalvib/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toystate")
			toy_on = !toy_on
			update_icon_state()
			update_icon()
			soundloop1.stop()
			soundloop2.stop()
			soundloop3.stop()
			if(toy_on)
				if(vibration_mode == "low")
					soundloop1.start()
				if(vibration_mode == "medium")
					soundloop2.start()
				if(vibration_mode == "high")
					soundloop3.start()

			if(!toy_on)
				soundloop1.stop()
				soundloop2.stop()
				soundloop3.stop()
			. = TRUE
		if("freq")
			var/value = unformat_frequency(params["freq"])
			if(value)
				frequency = sanitize_frequency(value, TRUE)
				set_frequency(frequency)
				. = TRUE
		if("code")
			var/value = text2num(params["code"])
			if(value)
				value = round(value)
				code = clamp(value, 1, 100)
				. = TRUE
		if("reset")
			if(params["reset"] == "freq")
				frequency = initial(frequency)
				. = TRUE
			else if(params["reset"] == "code")
				code = initial(code)
				. = TRUE

/obj/item/clothing/sextoy/eggvib/signalvib/toggle_mode()
	vibration_mode = modes[vibration_mode]
	switch(vibration_mode)
		if("low")
			vibration_mode = "low"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE, ignore_walls = FALSE)
		if("medium")
			vibration_mode = "medium"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE, ignore_walls = FALSE)
		if("high")
			vibration_mode = "high"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE, ignore_walls = FALSE)
*/
