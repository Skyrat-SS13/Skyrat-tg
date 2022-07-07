/obj/machinery/computer/security/telescreen/entertainment
	name = "TV monitor"
	desc = "Humans call it a zombie screen. Sometimes they show Japanese cartoons on it"
	icon = 'modular_skyrat/modules/television/icons/obj/screen.dmi'
	icon_state = "entertainment"
	network = list("tv","thunder")
	var/obj/item/radio/internal_radio
	var/radio_key = /obj/item/encryptionkey/tv
	var/sound = TRUE

/obj/machinery/computer/security/telescreen/entertainment/Initialize(mapload)
	. = ..()
	internal_radio = new /obj/item/radio(src)
	internal_radio.keyslot = new radio_key
	internal_radio.set_frequency(FREQ_TV)

/obj/machinery/computer/security/telescreen/entertainment/examine()
	. = ..()
	. += "Ctrl + click toggles the sound. Sound indicator lights [sound ? "green" : "red"]"

/obj/machinery/computer/security/telescreen/entertainment/CtrlClick(mob/user)
	. = ..()
	sound = !sound
	internal_radio.set_on(sound)
	internal_radio.set_frequency(FREQ_TV)
	to_chat(user, "You have turned [sound ? "on" : "off"] the sound")

/obj/machinery/computer/security/telescreen/entertainment/proc/announcement(var/message)
	say(message)
	icon_state = "entertainment_on"
	addtimer(VARSET_CALLBACK(src, icon_state, "entertainment"), 15 SECONDS)

/obj/machinery/computer/security/telescreen/entertainment/Destroy()
	. = ..()
	QDEL_NULL(internal_radio)
