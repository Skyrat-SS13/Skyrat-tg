/// A simple one-use beacon to activate a two-way portal to the anchored receiver it's linked to.
/obj/item/permanent_portal_creator
	name = "two-way bluespace entanglement device"
	desc = "A device with a very complex name, that is only used to confirm the second location that's tied to a stationary entanglement anchor."
	icon = 'icons/obj/device.dmi'
	icon_state = "hand_tele"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 30, BIO = 0, FIRE = 100, ACID = 100)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	/// The weakref to the linked entanglement anchor.
	var/datum/weakref/linked_anchor = null
	/// The name of the portal created at the position of the device.
	var/beacon_portal_name = "portal to somewhere"
	/// The name of the portal created at the position of the anchor.
	var/anchor_portal_name = "exit from somewhere"


/obj/item/permanent_portal_creator/attack_self(mob/user, modifiers)
	if(!linked_anchor)
		balloon_alert(user, "not linked!")
		return

	if(!isweakref(linked_anchor))
		balloon_alert(user, "invalid destination!")
		return

	var/obj/item/permanent_portal_anchor/portal_anchor = linked_anchor.resolve()

	if(!istype(portal_anchor) || !get_turf(portal_anchor))
		balloon_alert(user, "invalid destination!")
		return

	if(tgui_alert(user, "Are you sure that this is the place you want to have the portal located at? This action is permanent and cannot be undone.", "Are you sure?", list("Yes", "No")) != "Yes")
		return

	balloon_alert(user, "begining entanglement process...")

	if(!do_after(user, 5 SECONDS))
		balloon_alert(user, "entanglement cancelled!")
		return

	var/list/obj/effect/portal/created_portals = create_portal_pair(get_turf(src), get_turf(portal_anchor), _lifespan = NONE)
	created_portals[1].name = beacon_portal_name
	created_portals[2].name = anchor_portal_name

	created_portals[1].balloon_alert(user, "entanglement successful!")

	qdel(portal_anchor)
	qdel(src)


/obj/item/permanent_portal_creator/space_hotel
	name = "\improper Twin Nexus two-way bluespace entanglement device"
	beacon_portal_name = "portal to the Twin Nexus"
	anchor_portal_name = "exit of the Twin Nexus"


/obj/item/permanent_portal_creator/space_hotel/examine(mob/user)
	. = ..()
	. += "\nThis one seems to have the Twin Nexus hotel's logo engraved on its back."


/obj/item/permanent_portal_anchor
	name = "two-way bluespace entanglement anchor"
	desc = "A device with a very complex name, that serves as the stationary target of a linked two-way bluespace entanglement device."
	icon = 'icons/obj/device.dmi'
	icon_state = "beacon"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	anchored = FALSE
	density = FALSE
	layer = BELOW_MOB_LAYER
	/// Does it automatically deploy when initialized?
	var/deploy_on_init = FALSE


/obj/item/permanent_portal_anchor/Initialize(mapload)
	. = ..()
	if(deploy_on_init)
		deploy()


/obj/item/permanent_portal_anchor/attack_self(mob/user, modifiers)
	if(!ishuman(user))
		return

	balloon_alert(user, "deploying...")

	if(!do_after(user, 5 SECONDS))
		balloon_alert(user, "deployment failed!")

	deploy(user)

	playsound(src, 'modular_skyrat/modules/aesthetics/airlock/sound/bolts_down.ogg', 50, FALSE)

	balloon_alert(user, "deployment successful!")


/// Simple helper proc to deploy the anchor, with mob/user as an optional argument to make them drop it if they're holding it.
/obj/item/permanent_portal_anchor/proc/deploy(mob/user = null)
	if(user)
		user.dropItemToGround(src, force = TRUE, silent = TRUE)

	set_anchored(TRUE)

	// Just to make it look a little nicer.
	pixel_x = 0
	pixel_y = -10


/obj/item/permanent_portal_anchor/attackby(obj/item/attacking_item, mob/user, params)
	if(!istype(attacking_item, /obj/item/permanent_portal_creator))
		return ..()

	if(!anchored)
		balloon_alert(user, "needs to be deployed!")
		return

	var/obj/item/permanent_portal_creator/portal_maker = attacking_item
	portal_maker.linked_anchor = WEAKREF(src)

	balloon_alert(user, "linking successful!")


/obj/item/permanent_portal_anchor/space_hotel
	name = "\improper Twin Nexus two-way bluespace entanglement anchor"
	desc = "A device with a very complex name, that serves as the stationary target of a linked two-way bluespace entanglement device.\n\nIn your case, it serves to let your guests out."


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
	color = "#2CAF2C"
	room_number = 4

/obj/machinery/door/airlock/keyed/hotel_room/four
	greyscale_accent_color = "#2CAF2C"
	room_number = 4


/obj/item/key_card/hotel_room/five
	color = "#E55C01"
	room_number = 5

/obj/machinery/door/airlock/keyed/hotel_room/five
	greyscale_accent_color = "#E55C01"
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
