/datum/gun_company
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

// Nakamura engineering sells modsuits and modsuit accessories
/datum/gun_company/nakamura_engineering
	name = "Nakamura Engineering"
	company_flag = CARGO_COMPANY_NAKAMURA
	cost = 6000
	cost_change_lower = -3000
	cost_change_upper = 2000

// Jarnsmiour sells some melee weapons and some forging related items
/datum/gun_company/jarnsmiour
	name = "Jarnsmiour Blacksteel Foundation"
	company_flag = CARGO_COMPANY_BLACKSTEEL
	cost = 3000
	cost_change_lower = -2000
	cost_change_upper = 2000

// Nizhny sells NRI military surplus clothing, gear, and a few firearms
/datum/gun_company/nri_surplus
	name = "Nizhny Company Military Surplus"
	company_flag = CARGO_COMPANY_NRI_SURPLUS
	cost = 5000
	cost_change_lower = -3000
	cost_change_upper = 1000

// DeForest sells medical supplies of most types
/datum/gun_company/deforest_medical
	name = "DeForest Medical Corporation"
	company_flag = CARGO_COMPANY_DEFOREST
	cost = 8000
	cost_change_lower = -5000
	cost_change_upper = 3000
