/obj/machinery/posialert
	name = "automated positronic alert console"
	desc = "A console that will ping when a positronic personality is available for download."
	icon = 'modular_skyrat/modules/positronic_alert_console/icons/terminals.dmi'
	icon_state = "posialert"
	var/inuse = FALSE

	/// The encryption key typepath that will be used by the console.
	var/radio_key = /obj/item/encryptionkey/headset_sci
	/// The radio used to send messages over the science channel.
	var/obj/item/radio/radio

/obj/machinery/posialert/Initialize(mapload)
	. = ..()
	radio = new(src)
	radio.keyslot = new radio_key
	radio.listening = FALSE
	radio.recalculateChannels()

/obj/machinery/posialert/Destroy()
	QDEL_NULL(radio)
	. = ..()

/obj/machinery/posialert/attack_ghost(mob/user)
	. = ..()
	if(inuse)
		return
	inuse = TRUE
	flick("posialertflash",src)
	say("There are positronic personalities available.")
	radio.talk_into(src, "There are positronic personalities available.", RADIO_CHANNEL_SCIENCE)
	playsound(loc, 'sound/machines/ping.ogg', 50)
	addtimer(CALLBACK(src, /obj/machinery/posialert.proc/liftcooldown), 30 SECONDS)

/obj/machinery/posialert/proc/liftcooldown()
	inuse = FALSE
