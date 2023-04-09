/obj/spacepod/prebuilt
	icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	icon_state = "pod_civ"
	/// The internal cell type that is used by the spacepod.
	var/cell_type = /obj/item/stock_parts/cell/super
	/// THe armor type we will preload into the spacepod.
	var/spacepod_armor_type = /obj/item/pod_parts/armor
	/// The tank that we will preload into the spacepod.
	var/internal_tank_type = /obj/machinery/portable_atmospherics/canister/air
	/// Equipment that will be preloaded into the spacepod.
	var/equipment_types = list(/obj/item/spacepod_equipment/thruster)
	construction_state = SPACEPOD_ARMOR_WELDED // Make sure it spawns fully setup.

/obj/spacepod/prebuilt/Initialize()
	. = ..()
	add_armor(new spacepod_armor_type(src))
	if(cell_type)
		cell = new cell_type(src)
	if(internal_tank_type)
		internal_tank = new internal_tank_type(src)
	for(var/iterating_equipment_type in equipment_types)
		var/obj/item/spacepod_equipment/spacepod_equipment = new iterating_equipment_type(src)
		attach_equipment(spacepod_equipment)

/obj/spacepod/prebuilt/sec
	name = "security space pod"
	icon_state = "pod_sec"
	locked = TRUE
	spacepod_armor_type = /obj/item/pod_parts/armor/security
	equipment_types = list(
		/obj/item/spacepod_equipment/thruster,
		/obj/item/spacepod_equipment/weaponry/disabler,
		/obj/item/spacepod_equipment/lock/keyed/sec,
		/obj/item/spacepod_equipment/tracker,
		/obj/item/spacepod_equipment/cargo/chair,
		/obj/item/spacepod_equipment/lights/security,
		)

/obj/spacepod/prebuilt/sec/roundstart
	equipment_types = list(
		/obj/item/spacepod_equipment/lock/keyed/sec,
		/obj/item/spacepod_equipment/tracker,
		/obj/item/spacepod_equipment/cargo/chair,
		)

// adminbus spacepod for jousting events
/obj/spacepod/prebuilt/jousting
	name = "jousting space pod"
	icon_state = "pod_mil"
	spacepod_armor_type = /obj/item/pod_parts/armor/security
	cell_type = /obj/item/stock_parts/cell/infinite
	equipment_types = list(
		/obj/item/spacepod_equipment/thruster/upgraded,
		/obj/item/spacepod_equipment/weaponry/laser,
		/obj/item/spacepod_equipment/cargo/chair,
		/obj/item/spacepod_equipment/cargo/chair,
		/obj/item/spacepod_equipment/lights/military,
		)

/obj/spacepod/prebuilt/jousting/red
	icon_state = "pod_synd"
	spacepod_armor_type = /obj/item/pod_parts/armor/security/red


/obj/spacepod/prebuilt/military
	name = "military pod"
	icon_state = "pod_mil"
	spacepod_armor_type = /obj/item/pod_parts/armor/security
	cell_type = /obj/item/stock_parts/cell/hyper
	equipment_types = list(
		/obj/item/spacepod_equipment/thruster/upgraded,
		/obj/item/spacepod_equipment/weaponry/burst_disabler,
		/obj/item/spacepod_equipment/cargo,
		/obj/item/spacepod_equipment/lock/keyed/military,
		/obj/item/spacepod_equipment/cargo/chair,
		/obj/item/spacepod_equipment/teleport,
		/obj/item/spacepod_equipment/lights/military,
		)

/obj/spacepod/random
	icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	icon_state = "pod_civ"
	construction_state = SPACEPOD_ARMOR_WELDED
	var/list/equipment_types = list(
		/obj/item/spacepod_equipment/thruster,
		/obj/item/spacepod_equipment/cargo/chair,
	)
	dirty = TRUE


/obj/spacepod/random/Initialize()
	. = ..()
	var/spacepod_armor_type = pick(
		/obj/item/pod_parts/armor,
		/obj/item/pod_parts/armor/syndicate,
		/obj/item/pod_parts/armor/black,
		/obj/item/pod_parts/armor/gold,
		/obj/item/pod_parts/armor/industrial,
		/obj/item/pod_parts/armor/security,
		)
	add_armor(new spacepod_armor_type(src))
	for(var/iterating_equipment_type in equipment_types)
		var/obj/item/spacepod_equipment/spacepod_equipment = new iterating_equipment_type(src)
		attach_equipment(spacepod_equipment)
	cell = new /obj/item/stock_parts/cell/high/empty(src)
	internal_tank = new /obj/machinery/portable_atmospherics/canister/air(src)
	component_velocity_x = rand(-15, 15)
	component_velocity_y = rand(-15, 15)
	dirt_overlay = pick(list("pod_dirt_1", "pod_dirt_2", "pod_dirt_3"))
	update_integrity(rand(100, max_integrity))
	brakes = FALSE

