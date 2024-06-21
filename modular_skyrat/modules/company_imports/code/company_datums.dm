/datum/cargo_company
	/// Name of the company
	var/name
	/// Bitflag that should match what guns the company produces
	var/company_flag
	/// If the company needs a multitooled console to see
	var/illegal = FALSE
	/// Var for internal calculations, don't touch
	var/base_cost = 0
	/// How much the company costs, can shift over time
	var/cost = 0
	/// Multiplier added to the cost before showing the final price to the user
	var/cost_mult = 1
	/// On a subsystem fire, will lower/raise company values by a random value between lower and upper
	var/cost_change_lower = -100
	/// On a subsystem fire, will lower/raise company values by a random value between lower and upper
	var/cost_change_upper = 100
	/// If this company can be picked to be a handout company to start
	var/can_roundstart_pick = TRUE
	/// The "interest" value of the company, to determine how much stock the company has, goes down passively and is raised by things being bought
	var/interest = 0
	/// Multiplier for magazine costs
	var/magazine_cost_mult = 1

// Nakamura engineering's MOD division, sells modsuits and modsuit accessories
/datum/cargo_company/nakamura_modsuits
	name = COMPANY_NAME_NAKAMURA_ENGINEERING_MODSUITS
	company_flag = CARGO_COMPANY_NAKAMURA_MODSUITS
	cost = 6000
	cost_change_lower = -1000
	cost_change_upper = 4000

// Jarnsmiour sells some melee weapons and some forging related items
/datum/cargo_company/jarnsmiour
	name = COMPANY_NAME_BLACKSTEEL_FOUNDATION
	company_flag = CARGO_COMPANY_BLACKSTEEL
	cost = 3000
	cost_change_lower = 0
	cost_change_upper = 3000

// Sells NRI military surplus clothing, gear, and a few firearms
/datum/cargo_company/nri_surplus
	name = COMPANY_NAME_NRI_SURPLUS
	company_flag = CARGO_COMPANY_NRI_SURPLUS
	cost = 3000
	cost_change_lower = -1000
	cost_change_upper = 2000
	can_roundstart_pick = FALSE

// DeForest sells medical supplies of most types
/datum/cargo_company/deforest_medical
	name = COMPANY_NAME_DEFOREST_MEDICAL
	company_flag = CARGO_COMPANY_DEFOREST
	cost = 9000
	cost_change_lower = -1000
	cost_change_upper = 4000

// Donk sells donk co branded stuff, microwave foods, donk co merch, and donksoft guns
/datum/cargo_company/donk
	name = COMPANY_NAME_DONK_CO
	company_flag = CARGO_COMPANY_DONK
	cost = 3000
	cost_change_lower = -1000
	cost_change_upper = 2000

// Kahraman sells industrial grade mining equipment

/datum/cargo_company/kahraman
	name = COMPANY_NAME_KAHRAMAN_INDUSTRIES
	company_flag = CARGO_COMPANY_KAHRAMAN
	cost = 6000
	cost_change_lower = -1000
	cost_change_upper = 3000

// Sells unique construction supplies that the station can't normally obtain
/datum/cargo_company/akh_frontier
	name = COMPANY_NAME_FRONTIER_EQUIPMENT
	company_flag = CARGO_COMPANY_FRONTIER_EQUIPMENT

// A coalition between nt and bolt to sell personal defense equipment and weapons
/datum/cargo_company/nanotrasen_bolt_weapons
	name = COMPANY_NAME_SOL_DEFENSE_DEFENSE
	company_flag = CARGO_COMPANY_SOL_DEFENSE
	cost = 6000
	cost_change_lower = -1000
	cost_change_upper = 4000
	can_roundstart_pick = FALSE

// Micron control systems energy lineup.
/datum/cargo_company/microstar_energy_weapons
	name = COMPANY_NAME_MICRON_CONTROL_SYSTEMS
	company_flag = CARGO_COMPANY_MICRON
	cost = 6000
	cost_change_lower = -1000
	cost_change_upper = 4000
	can_roundstart_pick = FALSE


// Vitzstvi sells ammo boxes and speedloaders for most of the weapons sold by other companies
/datum/cargo_company/vitezstvi_ammo
	name = COMPANY_NAME_VITEZSTVI_AMMO
	company_flag = CARGO_COMPANY_VITEZSTVI_AMMO
	cost = 3000
	cost_change_lower = -1000
	cost_change_upper = 2000
	can_roundstart_pick = FALSE
