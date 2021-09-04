/datum/overmap_object/ore_rock
	name = "ore asteroid"
	visual_type = /obj/effect/abstract/overmap/ore_rock
	overmap_flags = OV_SHOWS_ON_SENSORS|OV_CAN_BE_TARGETED|OV_CAN_BE_SCANNED|OV_CAN_BE_ATTACKED
	var/integrity_left = 25

/datum/overmap_object/ore_rock/New()
	. = ..()
	partial_y = rand(-13,13)
	partial_x = rand(-13,13)
	UpdateVisualOffsets()

/datum/overmap_object/ore_rock/proc/SpawnLoot()
	var/datum/overmap_object/loot_thing = new /datum/overmap_object/transportable/ore_loot(current_system, x, y)
	loot_thing.partial_y = partial_y
	loot_thing.partial_x = partial_x
	loot_thing.UpdateVisualOffsets()

/datum/overmap_object/ore_rock/DealtDamage(damage_type, damage_amount)
	if(damage_type != OV_DAMTYPE_MINING)
		damage_amount *= 0.1 //10 times less damage if it's not a mining weapon
	integrity_left -= damage_amount
	if(integrity_left <= 0)
		SpawnLoot()
		qdel(src)

/obj/effect/abstract/overmap/ore_rock
	icon_state = "smallcircle"
	layer = OVERMAP_LAYER_LOOT
	color = LIGHT_COLOR_PURPLE

/datum/overmap_object/transportable/ore_loot
	name = "ore chunks"
	visual_type = /obj/effect/abstract/overmap/ore_loot
	transports_remaining_low = 1
	transports_remaining_high = 1
	items_per_transport_low = 1
	items_per_transport_high = 2

/datum/overmap_object/transportable/ore_loot/GetLootTable()
	return list(/obj/effect/spawner/lootdrop/ore_scarce = 10,
				/obj/effect/spawner/lootdrop/ore = 50,
				/obj/effect/spawner/lootdrop/ore_rich = 50)

/obj/effect/abstract/overmap/ore_loot
	icon_state = "smallobject"
	layer = OVERMAP_LAYER_LOOT
	color = LIGHT_COLOR_PURPLE
