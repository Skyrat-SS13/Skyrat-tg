//////////////////////////
///Normal vibrating egg///
//////////////////////////

/obj/item/clothing/sextoy/eggvib
	name = "vibrating egg"
	desc = "Simple sex toy."
	icon_state = "eggvib"
	inhand_icon_state = "eggvib"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	slot_flags = ITEM_SLOT_PENIS|ITEM_SLOT_VAGINA|ITEM_SLOT_NIPPLES|ITEM_SLOT_ANUS
	var/toy_on = FALSE
	var/current_color = "pink"
	var/color_changed = FALSE
	var/vibration_mode = "low"
	var/list/modes = list("low" = "medium", "medium" = "hard", "hard" = "low")
	var/mode = "low"
	var/static/list/eggvib_designs
	w_class = WEIGHT_CLASS_TINY

//create radial menu
/obj/item/clothing/sextoy/eggvib/proc/populate_eggvib_designs()
	eggvib_designs = list(
		"pink" = image(icon = src.icon, icon_state = "eggvib_pink_low_on"),
		"teal" = image(icon = src.icon, icon_state = "eggvib_teal_low_on"))

/obj/item/clothing/sextoy/eggvib/AltClick(mob/user, obj/item/I)
	var/mob/living/carbon/human/H = user
	if(color_changed == TRUE)
		toy_on = !toy_on
		to_chat(user, "<span class='notice'>You switched remote controller [toy_on? "on. Brrrr..." : "off."]</span>")
		playsound(user, toy_on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
		update_icon_state()
		update_icon()
		if(src == H.vagina || src == H.penis || src == H.anus || src == H.nipples)
			START_PROCESSING(SSobj, src)

	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, eggvib_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	else
		return

//to check if we can change egg's model
/obj/item/clothing/sextoy/eggvib/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/sextoy/eggvib/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(eggvib_designs))
		populate_eggvib_designs()

/obj/item/clothing/sextoy/eggvib/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[vibration_mode]_[toy_on? "on" : "off"]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/sextoy/eggvib/attack_self(mob/user, obj/item/I)
	if(toy_on == TRUE)
		toggle_mode()
		if(vibration_mode == "low")
			to_chat(user, "<span class='notice'>Vibration mode now is low. Bzzz...</span>")
		if(vibration_mode == "medium")
			to_chat(user, "<span class='notice'>Vibration mode now is medium. Bzzzz!</span>")
		if(vibration_mode == "hard")
			to_chat(user, "<span class='notice'>Vibration mode now is hard. Careful with that thing.</span>")
		update_icon()
		update_icon_state()
	else
		to_chat(usr, "<span class ='notice'> You cannot switch modes while the vibrating egg is... Not vibrating!</span>")
		return

/obj/item/clothing/sextoy/eggvib/proc/toggle_mode()
	mode = modes[mode]
	switch(mode)
		if("low")
			vibration_mode = "low"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
		if("medium")
			vibration_mode = "medium"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
		if("hard")
			vibration_mode = "hard"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)

/obj/item/clothing/sextoy/eggvib/equipped(mob/user, slot, initial)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(src == H.vagina || src == H.penis || src == H.anus || src == H.nipples)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/eggvib/dropped(mob/user, silent)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/eggvib/process(delta_time)
	var/mob/living/U = loc
	if(toy_on == TRUE)
		if(vibration_mode == "low")
			U.adjustArousal(0.5 * delta_time)
			U.adjustPleasure(0.5 * delta_time)
		if(vibration_mode == "medium")
			U.adjustArousal(0.6 * delta_time)
			U.adjustPleasure(0.6 * delta_time)
		if(vibration_mode == "hard")
			U.adjustArousal(0.7 * delta_time)
			U.adjustPleasure(0.7 * delta_time)

//////////////////////////
///Signal vibrating egg///
//////////////////////////
/obj/item/clothing/sextoy/signalvib
	name = "signal vibrating egg"
	desc = "Sex toy with remote control capability. Use signaller to turn it on."
	icon_state = "signalvib"
	inhand_icon_state = "signalvib"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	slot_flags = ITEM_SLOT_PENIS|ITEM_SLOT_VAGINA|ITEM_SLOT_NIPPLES|ITEM_SLOT_ANUS
	var/toy_on = FALSE
	var/current_color = "pink"
	var/color_changed = FALSE
	var/vibration_mode = "low"
	var/list/modes = list("low" = "medium", "medium" = "hard", "hard" = "low")
	var/mode = "low"
	var/static/list/signalvib_designs
	w_class = WEIGHT_CLASS_TINY

	var/random = TRUE
	var/freq_in_name = TRUE

	var/on = TRUE
	var/code = 2
	var/frequency = FREQ_ELECTROPACK
	var/shock_cooldown = FALSE

//signalling stuff

/obj/item/clothing/sextoy/signalvib/Destroy()
	SSradio.remove_object(src, frequency)
	return ..()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/clothing/sextoy/signalvib/attack_hand(mob/user, list/modifiers)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.back)
			to_chat(user, "<span class='warning'>You need help taking this off!</span>")
			return
	return ..()

/obj/item/clothing/sextoy/signalvib/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/clothing/head/helmet))
		var/obj/item/assembly/shock_kit/A = new /obj/item/assembly/shock_kit(user)
		A.icon = 'icons/obj/assemblies.dmi'

		if(!user.transferItemToLoc(W, A))
			to_chat(user, "<span class='warning'>[W] is stuck to your hand, you cannot attach it to [src]!</span>")
			return
		W.master = A
		A.helmet_part = W

		user.transferItemToLoc(src, A, TRUE)
		master = A
		A.electropack_part = src

		user.put_in_hands(A)
		A.add_fingerprint(user)
	else
		return ..()

/obj/item/clothing/sextoy/signalvib/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	SSradio.add_object(src, frequency, RADIO_SIGNALER)

/obj/item/clothing/sextoy/signalvib/ui_state(mob/user)
	return GLOB.hands_state

//arousal stuff

/obj/item/clothing/sextoy/signalvib/receive_signal(datum/signal/signal)
	if(!signal || signal.data["code"] != code)
		return

	toy_on = !toy_on
	update_icon_state()
	update_icon()

	if(master)
		if(isassembly(master))
			var/obj/item/assembly/master_as_assembly = master
			master_as_assembly.pulsed()
		master.receive_signal()

//create radial menu
/obj/item/clothing/sextoy/signalvib/proc/populate_signalvib_designs()
	signalvib_designs = list(
		"pink" = image(icon = src.icon, icon_state = "signalvib_pink_low_on"),
		"teal" = image(icon = src.icon, icon_state = "signalvib_teal_low_on"))

/obj/item/clothing/sextoy/signalvib/AltClick(mob/user, obj/item/I)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, signalvib_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	if(color_changed == TRUE)
		if(toy_on == TRUE)
			toggle_mode()
			if(vibration_mode == "low")
				to_chat(user, "<span class='notice'>Vibration mode now is low. Bzzz...</span>")
			if(vibration_mode == "medium")
				to_chat(user, "<span class='notice'>Vibration mode now is medium. Bzzzz!</span>")
			if(vibration_mode == "hard")
				to_chat(user, "<span class='notice'>Vibration mode now is hard. Careful with that thing.</span>")
			update_icon()
			update_icon_state()
		else
			to_chat(usr, "<span class ='notice'> You cannot switch modes while the vibrating egg is... Not vibrating!</span>")
			return
	else
		return

//to check if we can change egg's model
/obj/item/clothing/sextoy/signalvib/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/clothing/sextoy/signalvib/Initialize()
	set_frequency(frequency)
	update_icon_state()
	update_icon()
	if(!length(signalvib_designs))
		populate_signalvib_designs()

	if(random)
		code = rand(1,100)
		frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
	if(freq_in_name)
		name = initial(name) + " - freq: [frequency/10] code: [code]"
	.=..()

/obj/item/clothing/sextoy/signalvib/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/clothing/sextoy/signalvib/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Signalvib", name)
		ui.open()

/obj/item/clothing/sextoy/signalvib/ui_data(mob/user)
	var/list/data = list()
	data["toystate"] = toy_on
	data["frequency"] = frequency
	data["code"] = code
	data["minFrequency"] = MIN_FREE_FREQ
	data["maxFrequency"] = MAX_FREE_FREQ
	return data

/obj/item/clothing/sextoy/signalvib/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toystate")
			toy_on = !toy_on
			update_icon_state()
			update_icon()
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

/obj/item/clothing/sextoy/signalvib/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[vibration_mode]_[toy_on? "on" : "off"]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/sextoy/signalvib/proc/toggle_mode()
	mode = modes[mode]
	switch(mode)
		if("low")
			vibration_mode = "low"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
		if("medium")
			vibration_mode = "medium"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)
		if("hard")
			vibration_mode = "hard"
			playsound(loc, 'sound/weapons/magin.ogg', 20, TRUE)

//Processing
/obj/item/clothing/sextoy/signalvib/equipped(mob/user, slot, initial)
	. = ..()
	var/mob/living/carbon/human/U = src.loc
	if(src == U.penis || src == U.vagina || src == U.nipples || src == U.anus)
		START_PROCESSING(SSobj, src)
		to_chat(world, "vibrating ON")

/obj/item/clothing/sextoy/signalvib/dropped(mob/user, silent)
	. = ..()
	STOP_PROCESSING(SSobj, src)
	to_chat(world, "vibrating OFF")

/obj/item/clothing/sextoy/signalvib/process(delta_time)
	var/mob/living/U = loc
	if(toy_on == TRUE)
		if(vibration_mode == "low")
			U.adjustArousal(0.5 * delta_time)
			U.adjustPleasure(0.5 * delta_time)
		if(vibration_mode == "medium")
			U.adjustArousal(0.6 * delta_time)
			U.adjustPleasure(0.6 * delta_time)
		if(vibration_mode == "hard")
			U.adjustArousal(0.7 * delta_time)
			U.adjustPleasure(0.7 * delta_time)
