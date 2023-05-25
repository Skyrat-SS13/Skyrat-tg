/**
 * Syndicate
 */
/obj/structure/closet/secure_closet/syndicate
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/secure_closet/syndicate/miner
	name = "mining gear locker"
	icon_state = "mining"
	icon_door = "mining"

/obj/structure/closet/secure_closet/syndicate/roboticist
	name = "roboticist gear locker"
	icon_state = "science"
	icon_door = "science"

/obj/structure/closet/secure_closet/syndicate/scientist
	name = "scientist gear locker"
	icon_state = "science"
	icon_door = "science"

/obj/structure/closet/secure_closet/syndicate/admiral
	name = "station admiral's locker"
	icon_state = "cap"
	icon_door = "cap"

/obj/structure/closet/secure_closet/syndicate/medical
	name = "medical gear locker"
	icon_state = "med_secure"
	icon_door = "med_secure"

/obj/structure/closet/secure_closet/syndicate/engineering
	icon_state = "eng"

/obj/structure/closet/secure_closet/syndicate/engineering/electrical
	name = "electrical supplies locker"
	icon_door = "eng_elec"

/obj/structure/closet/secure_closet/syndicate/engineering/welding
	name = "welding supplies locker"
	icon_door = "eng_weld"

/obj/structure/closet/secure_closet/syndicate/engine_tech
	name = "engine technician gear locker"
	icon_state = "eng_secure"
	icon_door = "eng_secure"

/**
 * Syndicate Leader
 */
/obj/structure/closet/secure_closet/syndicate_leader
	req_access = list(ACCESS_SYNDICATE_LEADER)

/obj/structure/closet/secure_closet/syndicate_leader/armory
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "riot"
	icon_door = "riot"
	anchored = 1

/obj/structure/closet/secure_closet/syndicate_leader/armory/gear
	name = "armory gear locker"

/obj/structure/closet/secure_closet/syndicate_leader/armory/munitions
	name = "armory munitions locker"

/obj/structure/closet/secure_closet/syndicate_leader/brig_officer
	name = "brig officer gear locker"
	icon_state = "sec"
	icon_door = "sec"

/obj/structure/closet/secure_closet/syndicate_leader/corp_liaison
	name = "corporate liaison's locker"
	icon_state = "hop"
	icon_door = "hop"

/obj/structure/closet/secure_closet/syndicate_leader/deck_officer
	name = "deck officer's locker"
	icon_state = "qm"
	icon_door = "qm"

/obj/structure/closet/secure_closet/syndicate_leader/mod
	name = "\improper MODsuit module locker"
	icon_state = "syndicate"
	icon_door = "syndicate"

/obj/structure/closet/secure_closet/syndicate_leader/prisoner
	name = "prisoner item locker"

/obj/structure/closet/secure_closet/syndicate_leader/warden
	name = "master at arms' locker"
	icon_state = "warden"
	icon_door = "warden"


/**
 * Misc
 */
/obj/structure/closet/secure_closet/medical1/syndicate
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/secure_closet/freezer/kitchen/syndicate
	req_access = list(ACCESS_SYNDICATE)

/obj/structure/closet/secure_closet/freezer/meat/syndicate
	req_access = list(ACCESS_SYNDICATE)

