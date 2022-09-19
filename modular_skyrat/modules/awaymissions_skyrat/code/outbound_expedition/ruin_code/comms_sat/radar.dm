/obj/machinery/outbound_expedition/comms_dish
	name = "radar dish"
	desc = "That's a radar dish, alright."
	icon = 'icons/mob/hivebot.dmi'
	icon_state = "def_radar"

/obj/machinery/outbound_expedition/comms_dish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "Pinging Signal")

/obj/machinery/outbound_expedition/comms_dish/examine(mob/user)
	. = ..()
	. += span_notice("It seems there is a <b>disk slot</b> on one side of it at the base.")

/obj/machinery/outbound_expedition/comms_dish/attackby(obj/item/weapon, mob/user, params)
	if(!istype(weapon, /obj/item/computer_hardware/hard_drive/portable))
		return ..()
	balloon_alert(user, "downloading...")
	if(!do_after(user, 10 SECONDS, src))
		balloon_alert(user, "downloading stopped")
		return
	var/obj/item/computer_hardware/hard_drive/portable/our_disk = weapon
	if(!our_disk.store_file(new /datum/computer_file/data/outbound_radar_data))
		balloon_alert(user, "more space needed")
		playsound(src, 'sound/machines/buzz-sigh.ogg', 75)
		return
	playsound(src, 'sound/machines/ping.ogg', 75)
	balloon_alert(user, "downloaded")

/datum/computer_file/data/outbound_radar_data
	filename = "radardata"
	do_not_edit = TRUE
	size = 6
