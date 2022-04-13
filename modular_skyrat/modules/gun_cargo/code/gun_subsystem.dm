#define MAX_HANDOUT_CHOICES 3
#define FAILED_INTEREST 1
#define PASSED_INTEREST 2
#define HIGH_INTEREST 3
#define INTEREST_HIGH_MULT 25

SUBSYSTEM_DEF(gun_companies)
	name = "Gun Companies"
	wait = 120 SECONDS
	runlevels = RUNLEVEL_GAME
	/// Assoc list of companies that the subsystem has initialized, `"NAME" = datum_reference`
	var/list/companies = list()
	/// Assoc list of unpurchased companies
	var/list/unpurchased_companies = list()
	/// Assoc list of purchased companies
	var/list/purchased_companies = list()
	/// List of chosen handout company datums, for the user to pick 1
	var/list/chosen_handouts = list()
	/// Picked a free company yet?
	var/handout_picked = FALSE

/datum/controller/subsystem/gun_companies/Initialize(start_timeofday)
	for(var/datum/gun_company/company as anything in subtypesof(/datum/gun_company))
		var/datum/gun_company/new_company = new company
		companies[new_company.name] = new_company
		unpurchased_companies[new_company.name] = new_company

	var/list/potential_handouts = list()
	for(var/company_name in unpurchased_companies)
		var/datum/gun_company/picked_company = unpurchased_companies[company_name]
		if(!picked_company.can_roundstart_pick)
			continue
		potential_handouts += picked_company
	for(var/i in 1 to MAX_HANDOUT_CHOICES)
		chosen_handouts += pick_n_take(potential_handouts)
	fire() //Gotta get the prices randomized to start
	return ..()

/datum/controller/subsystem/gun_companies/Destroy()
	for(var/company in companies)
		QDEL_NULL(company)
	for(var/company_unbought in unpurchased_companies)
		QDEL_NULL(unpurchased_companies)
	for(var/company_bought in purchased_companies)
		QDEL_NULL(purchased_companies)
	. = ..()

/datum/controller/subsystem/gun_companies/Recover()
	companies = SSgun_companies.companies
	unpurchased_companies = SSgun_companies.unpurchased_companies
	purchased_companies = SSgun_companies.purchased_companies

/datum/controller/subsystem/gun_companies/fire(resumed)
	var/list/passed_interest_tier = list()

	for(var/company in companies)
		var/datum/gun_company/company_datum = companies[company]

		company_datum.base_cost += max(rand(company_datum.cost_change_lower, company_datum.cost_change_upper), 0)
		company_datum.base_cost = company_datum.base_cost <= 1000 ? 1000 : company_datum.base_cost
		company_datum.cost = round(company_datum.base_cost * company_datum.cost_mult) + CARGO_CRATE_VALUE

		var/interest_threshold = rand(1, 2)
		var/interest_knockdown = 0.5 * interest_threshold

		if(company_datum in unpurchased_companies)
			interest_knockdown *= 0.1

		company_datum.interest -= interest_knockdown

		if(company_datum.interest < interest_threshold)
			passed_interest_tier[company_datum] = FAILED_INTEREST

		else
			var/non_zero_threshold = interest_threshold ? interest_threshold : 1

			if(company_datum.interest < (non_zero_threshold * INTEREST_HIGH_MULT))
				passed_interest_tier[company_datum] = PASSED_INTEREST

			else
				passed_interest_tier[company_datum] = HIGH_INTEREST


	var/list/products = subtypesof(/datum/armament_entry/cargo_gun)

	for(var/armament_category as anything in GLOB.armament_entries)
		for(var/subcategory as anything in GLOB.armament_entries[armament_category][CATEGORY_ENTRY])
			for(var/datum/armament_entry/armament_entry as anything in GLOB.armament_entries[armament_category][CATEGORY_ENTRY][subcategory])
				if(products && !(armament_entry.type in products))
					continue

				var/datum/armament_entry/cargo_gun/entry_typecast = armament_entry

				for(var/company_gun in companies)
					var/datum/gun_company/the_datum = companies[company_gun]

					if(the_datum.company_flag != entry_typecast.company_bitflag)
						continue

					switch(passed_interest_tier[the_datum])

						if(FAILED_INTEREST)
							var/stock_failed = rand(0, 2)
							entry_typecast.stock = max((round((stock_failed * entry_typecast.stock_mult) - 1)), 0)
							var/gun_cost_failed = rand(entry_typecast.lower_cost, entry_typecast.upper_cost)
							var/compound_cost = round(entry_typecast.cost * 0.1)
							entry_typecast.cost = max((round((gun_cost_failed + compound_cost) - (0.25 * entry_typecast.lower_cost))), 0)
							entry_typecast.magazine_cost = round((entry_typecast.cost * 0.1) * the_datum.magazine_cost_mult)

						if(PASSED_INTEREST)
							var/stock_passed = rand(0, 4)
							entry_typecast.stock = max((round(stock_passed * entry_typecast.stock_mult)), 0)
							var/gun_cost_passed = rand(entry_typecast.lower_cost, entry_typecast.upper_cost)
							var/compound_cost = round(entry_typecast.cost * 0.1)
							entry_typecast.cost = max((round(gun_cost_passed + compound_cost)), 0)
							entry_typecast.magazine_cost = round((entry_typecast.cost * 0.11) * the_datum.magazine_cost_mult)

						if(HIGH_INTEREST)
							var/stock_interested = rand(0, 6)
							entry_typecast.stock = max((round(stock_interested * entry_typecast.stock_mult) + 1), 0)
							var/gun_cost_high = rand(entry_typecast.lower_cost, entry_typecast.upper_cost)
							var/compound_cost = round(entry_typecast.cost * 0.1)
							entry_typecast.cost = max(round(gun_cost_high + compound_cost), 0)
							entry_typecast.magazine_cost = round((entry_typecast.cost * 0.125) * the_datum.magazine_cost_mult)

#undef MAX_HANDOUT_CHOICES
#undef INTEREST_HIGH_MULT
