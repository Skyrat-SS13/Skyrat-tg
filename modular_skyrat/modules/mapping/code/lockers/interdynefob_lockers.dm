// Lockers used in interdynefob.dmm

// Parent type since most of the lockers required syndicate access
/obj/structure/closet/secure_closet/interdynefob
	req_access = list("syndicate")

// Generic lockers/subtypes
/obj/structure/closet/secure_closet/personal
	icon_door = "cabinet"
	icon_state = "cabinet"

// Job-specific lockers
/obj/structure/closet/secure_closet/interdynefob/science_gear
	icon_state = "science"
	name = "scientist gear locker"

/obj/structure/closet/secure_closet/interdynefob/robotics
	icon_state = "science"
	name = "roboticist gear locker"

/obj/structure/closet/secure_closet/interdynefob/medical
	icon_state = "med_secure"
	name = "medical gear locker"

/obj/structure/closet/secure_closet/interdynefob/welding_supplies
	icon_door = "eng_weld"
	icon_state = "eng"
	name = "welding supplies locker"

/obj/structure/closet/secure_closet/interdynefob/electrical_supplies
	icon_door = "eng_elec"
	icon_state = "eng"
	name = "electrical supplies locker"

/obj/structure/closet/secure_closet/interdynefob/engie_locker
	icon_door = "eng_secure"
	icon_state = "eng_secure"
	name = "engine technician gear locker"

/obj/structure/closet/secure_closet/interdynefob/mining_locker
	icon_door = "mining"
	icon_state = "mining"
	name = "mining gear locker"

/obj/structure/closet/secure_closet/interdynefob/sa_locker
	icon_door = "cap"
	icon_state = "cap"
	name = "\proper station admiral's locker"

/obj/structure/closet/secure_closet/interdynefob/munitions_locker
	anchored = 1;
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_door = "riot"
	icon_state = "riot"
	name = "armory munitions locker"

// Heads lockers
/obj/structure/closet/secure_closet/interdynefob/maa_locker
	icon_door = "warden"
	icon_state = "warden"
	name = "master at arms' locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/armory_gear_locker
	anchored = 1
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_door = "riot"
	icon_state = "riot"
	name = "armory gear locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/prisoner_locker
	name = "prisoner item locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/mod_locker
	icon_door = "syndicate"
	icon_state = "syndicate"
	name = "MODsuit module locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/brig_officer_locker
	icon_door = "sec"
	icon_state = "sec"
	name = "brig officer gear locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/cl_locker
	icon_door = "hop"
	icon_state = "hop"
	name = "\proper corporate liaison's locker"
	req_access = list("syndicate_leader")
