/obj/machinery/computer/cargo/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/armament/cargo_gun, subtypesof(/datum/armament_entry/cargo_gun), 0)

/// Proc for speaking over radio without needing to reuse a bunch of code
/obj/machinery/computer/cargo/proc/radio_wrapper(atom/movable/speaker, message, channel)
	radio.talk_into(speaker, message, channel)
