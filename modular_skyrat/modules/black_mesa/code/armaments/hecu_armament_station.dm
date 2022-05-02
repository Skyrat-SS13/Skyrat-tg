// VENDOR
/obj/machinery/armament_station/hecu
	required_access = list(ACCESS_AWAY_SEC)

	armament_type = /datum/armament_entry/hecu

// POINTS CARDS

/obj/item/armament_points_card/hecu
	points = 35

// ARMAMENT ENTRIES

/datum/armament_entry/hecu
	var/mags_to_spawn = 5

/datum/armament_entry/hecu/after_equip(turf/safe_drop_location, obj/item/item_to_equip)
	if(istype(item_to_equip, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/spawned_ballistic_gun = item_to_equip
		if(spawned_ballistic_gun.magazine && !istype(spawned_ballistic_gun.magazine, /obj/item/ammo_box/magazine/internal))
			var/obj/item/storage/box/ammo_box/spawned_box = new(safe_drop_location)
			spawned_box.name = "ammo box - [spawned_ballistic_gun.name]"
			for(var/i in 1 to mags_to_spawn)
				new spawned_ballistic_gun.mag_type (spawned_box)
