// Parent type since most of the lockers required syndicate access
/obj/structure/closet/secure_closet/interdynefob
	req_access = list("syndicate")

// Generic lockers/subtypes
/obj/structure/closet/secure_closet/interdynefob/mod_locker
	icon_door = "syndicate"
	icon_state = "syndicate"
	name = "MODsuit module locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/mod_locker/PopulateContents()
	..()

	new /obj/item/mod/module/stealth(src)
	new /obj/item/mod/module/projectile_dampener(src)
	new /obj/item/mod/module/pepper_shoulders(src)
	new /obj/item/mod/module/criminalcapture(src)
	new /obj/item/mod/module/visor/night(src)
	new /obj/item/screwdriver/nuke(src)
