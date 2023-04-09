/**
 * Core items
 */
/datum/design/board/spacepod_main
	name = "Circuit Design (Space Pod Mainboard)"
	desc = "Allows for the construction of a Space Pod mainboard."
	id = "spacepod_main"
	build_path = /obj/item/circuitboard/mecha/pod
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CORE_SYSTEMS
		)

/datum/design/pod_core
	name = "Spacepod Core"
	desc = "Allows for the construction of a spacepod core system."
	id = "podcore"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=5000, /datum/material/uranium=1000, /datum/material/plasma=5000)
	build_path = /obj/item/pod_parts/core
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CORE_SYSTEMS
		)

/**
 * Armor systems
 */
/datum/design/pod_armor_civ
	name = "Spacepod Armor (civilian)"
	desc = "Allows for the construction of spcaepod armor. This is the civilian version."
	id = "podarmor_civ"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=15000,/datum/material/glass=5000,/datum/material/plasma=10000)
	build_path = /obj/item/pod_parts/armor
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_ARMOR_SYSTEMS
		)

/datum/design/pod_armor_black
	name = "Spacepod Armor (dark)"
	desc = "Allows for the construction of spacepod armor. This is the dark civillian version."
	id = "podarmor_dark"
	build_type = PROTOLATHE
	build_path = /obj/item/pod_parts/armor/black
	materials = list(/datum/material/iron=15000,/datum/material/glass=5000,/datum/material/plasma=10000)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_ARMOR_SYSTEMS
		)

/datum/design/pod_armor_industrial
	name = "Spacepod Armor (industrial)"
	desc = "Allows for the construction of spacepod armor. This is the industrial grade version."
	id = "podarmor_industiral"
	build_type = PROTOLATHE
	build_path = /obj/item/pod_parts/armor/industrial
	materials = list(/datum/material/iron=15000,/datum/material/glass=5000,/datum/material/plasma=10000,/datum/material/diamond=5000,/datum/material/silver=7500)
	departmental_flags = DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_ARMOR_SYSTEMS
		)

/datum/design/pod_armor_sec
	name = "Spacepod Armor (security)"
	desc = "Allows for the construction of spacepod armor. This is the security version."
	id = "podarmor_sec"
	build_type = PROTOLATHE
	build_path = /obj/item/pod_parts/armor/security
	materials = list(/datum/material/iron=15000,/datum/material/glass=5000,/datum/material/plasma=10000,/datum/material/diamond=5000,/datum/material/silver=7500)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_ARMOR_SYSTEMS
		)

/datum/design/pod_armor_gold
	name = "Spacepod Armor (golden)"
	desc = "Allows for the construction of spacepod armor. This is the golden version."
	id = "podarmor_gold"
	build_type = PROTOLATHE
	build_path = /obj/item/pod_parts/armor/gold
	materials = list(/datum/material/iron=5000,/datum/material/glass=2500,/datum/material/plasma=7500,/datum/material/gold=10000)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_ARMOR_SYSTEMS
		)


/**
 * Weapon items
 */

/datum/design/pod_gun_disabler
	name = "Spacepod Weapon (Disabler)"
	desc = "Allows for the construction of a spacepod mounted disabler."
	id = "podgun_disabler"
	build_type = PROTOLATHE
	build_path = /obj/item/spacepod_equipment/weaponry/disabler
	materials = list(/datum/material/iron = 15000)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_WEAPON_SYSTEMS
		)


/datum/design/pod_gun_burst_disabler
	name = "Spacepod Weapon (Burst Disabler)"
	desc = "Allows for the construction of a spacepod mounted disabler. This is the burst-fire model."
	id = "podgun_bdisabler"
	build_type = PROTOLATHE
	build_path = /obj/item/spacepod_equipment/weaponry/burst_disabler
	materials = list(/datum/material/iron = 15000,/datum/material/plasma=2000)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_WEAPON_SYSTEMS
		)


/datum/design/pod_gun_laser
	name = "Spacepod Weapon (Laser)"
	desc = "Allows for the construction of a spacepod mounted laser."
	id = "podgun_laser"
	build_type = PROTOLATHE
	build_path = /obj/item/spacepod_equipment/weaponry/laser
	materials = list(/datum/material/iron=10000,/datum/material/glass=5000,/datum/material/gold=1000,/datum/material/silver=2000)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_WEAPON_SYSTEMS
		)

/datum/design/pod_gun_burst_laser
	name = "Spacepod Weapon (Burst Laser)"
	desc = "Allows for the construction of a spacepod mounted burst laser."
	id = "podgun_burst_laser"
	build_type = PROTOLATHE
	build_path = /obj/item/spacepod_equipment/weaponry/laser
	materials = list(/datum/material/iron=10000,/datum/material/glass=10000,/datum/material/gold=5000,/datum/material/silver=8000,/datum/material/diamond=10000)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_WEAPON_SYSTEMS
		)

/datum/design/pod_ka_basic
	name = "Spacepod Weapon (Basic Kinetic Accelerator)"
	desc = "Allows for the construction of a weak spacepod Kinetic Accelerator"
	id = "pod_ka_basic"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 5000, /datum/material/silver = 2000, /datum/material/uranium = 2000)
	build_path = /obj/item/spacepod_equipment/weaponry/basic_pod_ka
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_WEAPON_SYSTEMS
		)

/datum/design/pod_ka
	name = "Spacepod Weapon (Kinetic Accelerator)"
	desc = "Allows for the construction of a spacepod Kinetic Accelerator."
	id = "pod_ka"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 5000, /datum/material/silver = 2000, /datum/material/gold = 2000, /datum/material/diamond = 2000)
	build_path = /obj/item/spacepod_equipment/weaponry/pod_ka
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_WEAPON_SYSTEMS
		)


/datum/design/pod_plasma_cutter
	name = "Spacepod Weapon (Plasma Cutter)"
	desc = "Allows for the construction of a plasma cutter."
	id = "pod_plasma_cutter"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 5000, /datum/material/silver = 2000, /datum/material/gold = 2000, /datum/material/diamond = 2000)
	build_path = /obj/item/spacepod_equipment/weaponry/plasma_cutter
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_WEAPON_SYSTEMS
		)

/datum/design/pod_adv_plasma_cutter
	name = "Spacepod Weapon (Advanced Plasma cutter)"
	desc = "Allows for the construction of an advanced plasma cutter."
	id = "pod_adv_plasma_cutter"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 5000, /datum/material/silver = 4000, /datum/material/gold = 4000, /datum/material/diamond = 4000)
	build_path = /obj/item/spacepod_equipment/weaponry/plasma_cutter/adv
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_WEAPON_SYSTEMS
		)

/**
 * Misc items
 */

/datum/design/pod_misc_tracker
	name = "Spacepod Tracking Module"
	desc = "Allows for the construction of a Space Pod Tracking Module."
	id = "podmisc_tracker"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=5000)
	build_path = /obj/item/spacepod_equipment/tracker
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_MISC_SYSTEMS
		)

/datum/design/spacepod_teleporter
	name = "Spacepod Warp Drive"
	desc = "Allows for the construction of a spacepod warp drive."
	id = "pod_teleporter"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver=10000, /datum/material/gold=10000, /datum/material/uranium=5000, /datum/material/plasma=7000, /datum/material/diamond=20000, /datum/material/bluespace=10000)
	build_path = /obj/item/spacepod_equipment/thruster
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CORE_SYSTEMS
		)

/**
 * Cargo items
 */

/datum/design/pod_cargo_ore
	name = "Spacepod Ore Storage Module"
	desc = "Allows for the construction of a Space Pod Ore Storage Module."
	id = "podcargo_ore"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=20000, /datum/material/glass=2000)
	build_path = /obj/item/spacepod_equipment/cargo/large/ore
	departmental_flags = DEPARTMENT_BITFLAG_CARGO
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CARGO_SYSTEMS
		)

/datum/design/pod_cargo_crate
	name = "Spacepod Crate Storage Module"
	desc = "Allows the construction of a Space Pod Crate Storage Module."
	id = "podcargo_crate"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=25000)
	build_path = /obj/item/spacepod_equipment/cargo/large
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CARGO_SYSTEMS
		)

/datum/design/passenger_seat
	name = "Spacepod Passenger Seat"
	desc = "Allows the construction of a Space Pod Passenger Seat Module."
	id = "podcargo_seat"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=7500, /datum/material/glass=2500)
	build_path = /obj/item/spacepod_equipment/cargo/chair
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CARGO_SYSTEMS
		)

/**
 * Lock items
 */
/datum/design/pod_lock_keyed
	name = "Spacepod Tumbler Lock"
	desc = "Allows for the construction of a tumbler style podlock."
	id = "podlock_keyed"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=4500)
	build_path = /obj/item/spacepod_equipment/lock/keyed
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_LOCKING_SYSTEMS
		)

/datum/design/pod_key
	name = "Spacepod Tumbler Lock Key"
	desc = "Allows for the construction of a blank key for a podlock."
	id = "podkey"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=500)
	build_path = /obj/item/spacepod_key
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_LOCKING_SYSTEMS
		)

/datum/design/lockbuster
	name = "Spacepod Lock Buster"
	desc = "Allows for the construction of a spacepod lockbuster."
	id = "pod_lockbuster"
	build_type = PROTOLATHE
	build_path = /obj/item/device/lock_buster
	materials = list(/datum/material/iron = 15000, /datum/material/diamond=2500) //it IS a drill!
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_LOCKING_SYSTEMS
		)

/**
 * Thrust Systems
 */
/datum/design/spacepod_thruster
	name = "Spacepod Thruster"
	desc = "Allows for the construction of a spacepod thruster system."
	id = "podthruster"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold=5000, /datum/material/uranium=1000, /datum/material/plasma=5000)
	build_path = /obj/item/spacepod_equipment/thruster
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CORE_SYSTEMS
		)

/datum/design/spacepod_thruster_upgraded
	name = "Upgraded Spacepod Thruster"
	desc = "Allows for the construction of a upgraded spacepod thruster system."
	id = "podthruster_upgraded"
	build_type = PROTOLATHE
	materials = list(/datum/material/gold=7000, /datum/material/uranium=5000, /datum/material/plasma=7000, /datum/material/diamond=5000)
	build_path = /obj/item/spacepod_equipment/thruster
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CORE_SYSTEMS
		)

/datum/design/spacepod_thruster_bluespace
	name = "Bluespace Spacepod Thruster"
	desc = "Allows for the construction of a bluespace spacepod thruster system."
	id = "podthruster_bluespace"
	build_type = PROTOLATHE
	materials = list(/datum/material/silver=10000, /datum/material/gold=10000, /datum/material/uranium=5000, /datum/material/plasma=7000, /datum/material/diamond=10000, /datum/material/bluespace=10000)
	build_path = /obj/item/spacepod_equipment/thruster
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_CORE_SYSTEMS
		)

/**
 * Light Systems
 */
/datum/design/spacepod_lights
	name = "Spacepod Light Module"
	desc = "Allows for the construction of a Space Pod Light Module."
	id = "podlights"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=5000)
	build_path = /obj/item/spacepod_equipment/lights
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_MISC_SYSTEMS
		)

/datum/design/spacepod_lights_custom
	name = "Spacepod Custom Light Module"
	desc = "Allows for the construction of a Space Pod Light Module."
	id = "podlights_custom"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron=5000,/datum/material/plasma=2000)
	build_path = /obj/item/spacepod_equipment/lights/custom
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_SECURITY
	category = list(
		RND_CATEGORY_SPACEPOD + RND_SUBCATEGORY_SPACEPOD_MISC_SYSTEMS
		)
