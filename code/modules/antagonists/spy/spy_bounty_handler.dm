/**
 * ## Spy bounty handler
 *
 * Singleton datum that handles determining active bounties for spies.
 */
/datum/spy_bounty_handler
	/// Timer between when all bounties are refreshed.
	var/refresh_time = 12 MINUTES
	/// timerID of the active refresh timer.
	var/refresh_timer
	/// Number of times we have refreshed bounties
	var/num_refreshes = 0
	/// Assoc list of items stolen in the past to how many times they have been stolen
	/// Sometimes item typepaths, sometimes REFs, in general just strings that represent stolen items
	var/list/all_claimed_bounty_types = list()
	/// List of all items stolen in the last pool of bounties.
	/// Same as above - strings that represent stolen items.
	var/list/claimed_bounties_from_last_pool = list()
	/// Override for the number of attempts to make a bounty.
	var/num_attempts_override = 0

	/// Assoc list that dictates how much of each bounty difficulty to give out at once.
	/// Modified by the number of times we have refreshed bounties.
	VAR_PRIVATE/list/base_bounties_to_give = list(
		SPY_DIFFICULTY_EASY = 4,
		SPY_DIFFICULTY_MEDIUM = 2,
		SPY_DIFFICULTY_HARD = 2,
	)

	/// Assoc list of all active bounties.
	VAR_PRIVATE/list/list/bounties = list(
		SPY_DIFFICULTY_EASY = list(),
		SPY_DIFFICULTY_MEDIUM = list(),
		SPY_DIFFICULTY_HARD = list(),
	)

	/// Assoc list of all possible bounties for each difficulty, weighted.
	/// This is static, no bounty types are removed from this list.
	VAR_PRIVATE/list/list/bounty_types = list(
		SPY_DIFFICULTY_EASY = list(),
		SPY_DIFFICULTY_MEDIUM = list(),
		SPY_DIFFICULTY_HARD = list(),
	)

	/// Assoc list of all uplink items possible to be given as bounties for each difficulty.
	/// This is not static, as bounties are complete uplink items will be removed from this list.
	var/list/list/possible_uplink_items = list(
		SPY_DIFFICULTY_EASY = list(),
		SPY_DIFFICULTY_MEDIUM = list(),
		SPY_DIFFICULTY_HARD = list(),
	)

/datum/spy_bounty_handler/New()
	for(var/datum/spy_bounty/bounty as anything in subtypesof(/datum/spy_bounty))
		var/weight = initial(bounty.weight)
		var/difficulty = initial(bounty.difficulty)
		if(weight <= 0 || !islist(bounty_types[difficulty]))
			continue
		bounty_types[difficulty][bounty] = weight

	for(var/datum/uplink_item/item as anything in SStraitor.uplink_items)
		if(isnull(item.item) || item.item == ABSTRACT_UPLINK_ITEM)
			continue
		if(!(item.purchasable_from & UPLINK_SPY))
			continue
		// This will have some overlap, and that's intentional -
		// Adds some variety, rare moments where you can get a hard reward for an easier bounty (or visa versa)
		if(item.cost <= SPY_LOWER_COST_THRESHOLD)
			possible_uplink_items[SPY_DIFFICULTY_EASY] += item
		if(item.cost >= SPY_LOWER_COST_THRESHOLD && item.cost <= SPY_UPPER_COST_THRESHOLD)
			possible_uplink_items[SPY_DIFFICULTY_MEDIUM] += item
		if(item.cost >= SPY_UPPER_COST_THRESHOLD)
			possible_uplink_items[SPY_DIFFICULTY_HARD] += item

	refresh_bounty_list()

/// Helper that returns a list of all active bounties in a single list, regardless of difficulty.
/datum/spy_bounty_handler/proc/get_all_bounties() as /list
	var/list/all_bounties = list()
	for(var/difficulty in bounties)
		all_bounties += bounties[difficulty]

	return all_bounties

/// Refreshes all active bounties for each difficulty, no matter if they were complete or not.
/// Then recursively calls itself via a timer.
/datum/spy_bounty_handler/proc/refresh_bounty_list()
	PRIVATE_PROC(TRUE)

	var/list/bounties_to_give = base_bounties_to_give.Copy()

	if(num_refreshes < base_bounties_to_give[SPY_DIFFICULTY_HARD])
		bounties_to_give[SPY_DIFFICULTY_HARD] = num_refreshes
		bounties_to_give[SPY_DIFFICULTY_MEDIUM] += (base_bounties_to_give[SPY_DIFFICULTY_HARD] - num_refreshes)

	for(var/difficulty in bounties)
		QDEL_LIST(bounties[difficulty])

		var/list/pool = bounty_types[difficulty]
		var/amount_to_give = bounties_to_give[difficulty]
		var/failed_attempts = num_attempts_override || clamp(amount_to_give * 4, 10, 25) // more potential bounties = more attempts to make one
		while(amount_to_give > 0 && failed_attempts > 0)
			var/picked_bounty = pick_weight(pool)
			var/datum/spy_bounty/bounty = new picked_bounty(src)
			if(bounty.initalized)
				amount_to_give -= 1
				bounties[difficulty] += bounty

			else
				failed_attempts -= 1
				qdel(bounty)

	claimed_bounties_from_last_pool.Cut()
	num_refreshes += 1
	refresh_timer = addtimer(CALLBACK(src, PROC_REF(refresh_bounty_list)), refresh_time, TIMER_UNIQUE|TIMER_OVERRIDE|TIMER_STOPPABLE)

/// Forces a refresh of the bounty list.
/// Counts towards [num_refreshes].
/datum/spy_bounty_handler/proc/force_refresh()
	if(refresh_timer)
		deltimer(refresh_timer)

	refresh_bounty_list()
