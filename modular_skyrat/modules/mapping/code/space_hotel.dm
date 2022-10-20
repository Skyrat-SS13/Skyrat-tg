//Space Hotel Keycards and Room Doors
/obj/item/key_card/hotel_room
	name = "\improper Twin Nexus keycard"
	desc = "A keycard, to open a keycard-locked hotel room."
	access_id = "guest_room_"
	/// The number of the room, so that it gets automatically handled by the code everywhere
	/// it's relevant.
	var/room_number = null


/obj/item/key_card/hotel_room/Initialize(mapload)
	. = ..()

	if(!room_number)
		return

	access_id += "[room_number]"


/obj/item/key_card/hotel_room/examine(mob/user)
	. = ..()

	if(!room_number)
		return

	. += "It has an engraving on it that reads: \"Guest Room [room_number]\""


/obj/item/key_card/hotel_room/master
	name = "\improper Twin Nexus master keycard"
	desc = "A master keycard, to open all the keycard-locked hotel rooms.\nIt has an engraving on it that reads: \"Master Access\""
	access_id = null
	master_access = TRUE


/obj/machinery/door/airlock/keyed/hotel_room
	name = "Guest Room"
	access_id = "guest_room_"
	autoclose = TRUE
	greyscale_accent_color = null
	/// The number of the room, so that it gets automatically handled by the code everywhere
	/// it's relevant.
	var/room_number = null
	var/alternate = FALSE


/obj/machinery/door/airlock/keyed/hotel_room/Initialize(mapload)
	. = ..()

	if(!room_number)
		return

	name += " [room_number]"
	access_id += "[room_number]"
	fill_state_suffix = "_[room_number]"

	update_appearance()


/obj/item/key_card/hotel_room/one
	color = "#E0E000"
	room_number = 1

/obj/machinery/door/airlock/keyed/hotel_room/one
	greyscale_accent_color = "#E0E000"
	room_number = 1


/obj/item/key_card/hotel_room/two
	color = "#C4004E"
	room_number = 2

/obj/machinery/door/airlock/keyed/hotel_room/two
	greyscale_accent_color = "#C4004E"
	room_number = 2


/obj/item/key_card/hotel_room/three
	color = "#00C074"
	room_number = 3

/obj/machinery/door/airlock/keyed/hotel_room/three
	greyscale_accent_color = "#00C074"
	room_number = 3


/obj/item/key_card/hotel_room/four
	color = "#E55C01"
	room_number = 4

/obj/machinery/door/airlock/keyed/hotel_room/four
	greyscale_accent_color = "#E55C01"
	room_number = 4


/obj/item/key_card/hotel_room/five
	color = "#2CAF2C"
	room_number = 5

/obj/machinery/door/airlock/keyed/hotel_room/five
	greyscale_accent_color = "#2CAF2C"
	room_number = 5


/obj/item/key_card/hotel_room/six
	color = "#AC00AC"
	room_number = 6

/obj/machinery/door/airlock/keyed/hotel_room/six
	greyscale_accent_color = "#AC00AC"
	room_number = 6


/obj/item/key_card/hotel_room/seven
	color = "#0AA7E9"
	room_number = 7

/obj/machinery/door/airlock/keyed/hotel_room/seven
	greyscale_accent_color = "#0AA7E9"
	room_number = 7
