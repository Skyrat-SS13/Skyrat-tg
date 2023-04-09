/datum/techweb_node/spacepod_basic
	id = "spacepod_basic"
	display_name = "Spacepod Construction"
	description = "Basic stuff to construct Spacepods. Don't crash your first spacepod into the station, especially while going more than 10 m/s."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	prereq_ids = list("base")
	design_ids = list("podcore", "podarmor_civ", "podarmor_dark", "spacepod_main", "podthruster")

/**
 * Lock stuffs
 */
/datum/techweb_node/spacepod_lock
	id = "spacepod_lock"
	display_name = "Spacepod Security"
	description = "Keeps greytiders out of your spacepods."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2750)
	prereq_ids = list("spacepod_basic", "engineering")
	design_ids = list("podlock_keyed", "podkey", "podmisc_tracker")


/datum/techweb_node/spacepod_lockbuster
	id = "spacepod_lockbuster"
	display_name = "Spacepod Lock Buster"
	description = "For when someone's being really naughty with a spacepod"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 8500)
	prereq_ids = list("spacepod_lasers", "high_efficiency", "adv_mining")
	design_ids = list("pod_lockbuster")


/**
 * Weapon Designs
 */
/datum/techweb_node/spacepod_disabler
	id = "spacepod_disabler"
	display_name = "Spacepod Weaponry"
	description = "For a bit of pew pew space battles"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3500)
	prereq_ids = list("spacepod_basic", "weaponry")
	design_ids = list("podgun_disabler")

/datum/techweb_node/spacepod_lasers
	id = "spacepod_lasers"
	display_name = "Advanced Spacepod Weaponry"
	description = "For a lot of pew pew space battles. PEW PEW PEW!! Shit, I missed. I need better aim. Whatever."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5250)
	prereq_ids = list("spacepod_disabler", "electronic_weapons")
	design_ids = list("podgun_laser", "podgun_bdisabler")

/datum/techweb_node/spacepod_mining
	id = "spacepod_mining"
	display_name = "Spacepod Mining Tech"
	description = "Cutting up asteroids using your spacepods"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3500)
	prereq_ids = list("basic_mining", "spacepod_disabler")
	design_ids = list("pod_ka_basic")

/datum/techweb_node/spacepod_advmining
	id = "spacepod_advmining"
	display_name = "Advanced Spacepod Mining Tech"
	description = "Cutting up asteroids using your spacepods.... faster!"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3500)
	prereq_ids = list("spacepod_mining", "adv_mining")
	design_ids = list("pod_ka", "pod_plasma_cutter")

/datum/techweb_node/spacepod_advplasmacutter
	id = "spacepod_advplasmacutter"
	display_name = "Advanced Spacepod Plasma Cutter"
	description = "Cutting up asteroids using your spacepods........... FASTERRRRRR!!!!!! Oh shit, that was gibtonite."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4500)
	prereq_ids = list("spacepod_advmining", "adv_plasma")
	design_ids = list("pod_adv_plasma_cutter")

/**
 * Cargo designs
 *
*/
/datum/techweb_node/spacepod_pseat
	id = "spacepod_pseat"
	display_name = "Spacepod Passenger Seat"
	description = "For bringing along victims as you fly off into the far reaches of space"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3750)
	prereq_ids = list("spacepod_basic", "adv_engi")
	design_ids = list("podcargo_seat")

/datum/techweb_node/spacepod_storage
	id = "spacepod_storage"
	display_name = "Spacepod Storage"
	description = "For storing the stuff you find in the far reaches of space"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4500)
	prereq_ids = list("spacepod_pseat", "high_efficiency")
	design_ids = list("podcargo_crate", "podcargo_ore")

/**
 * Armor stuffs
 */
/datum/techweb_node/spacepod_iarmor
	id = "spacepod_iarmor"
	display_name = "Advanced Spacepod Armor"
	description = "Better protection for your precious ride. You'll need it if you plan on engaging in spacepod battles."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2750)
	prereq_ids = list("spacepod_storage", "high_efficiency")
	design_ids = list("podarmor_industiral", "podarmor_sec", "podarmor_gold")

/**
 * Thrusters
 */
/datum/techweb_node/spacepod_advthrusters
	id = "spacepod_advthrusters"
	display_name = "Advanced Spacepod Thrusters"
	description = "More speed is better, right? Right? RIGHT?!"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4500)
	prereq_ids = list("spacepod_basic", "high_efficiency", "adv_power")
	design_ids = list("podthruster_upgraded")

/datum/techweb_node/spacepod_bluespacethrusters
	id = "spacepod_bluespacethrusters"
	display_name = "Bluespace Spacepod Thrusters"
	description = "More speed is better, right? Right? RIGHT?! MAKE ME GO FASTER DAMN IT!!!!"
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
	prereq_ids = list("spacepod_advthrusters", "bluespace_travel")
	design_ids = list("podthruster_bluespace")

/datum/techweb_node/spacepod_teleporter
	id = "spacepod_teleporter"
	display_name = "Spacepod Teleporter"
	description = "For when speed isn't enough, you reduce the distance by breaking the laws of physics."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	prereq_ids = list("spacepod_bluespacethrusters", "bluespace_travel", "micro_bluespace")
	design_ids = list("pod_teleporter")

/**
 * Misc stuffs
 */
/datum/techweb_node/spacepod_lights
	id = "spacepod_lights"
	display_name = "Spacepod Lights"
	description = "Helps you see in the dark."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000)
	prereq_ids = list("spacepod_basic", "engineering")
	design_ids = list("podlights", "podlights_custom")
