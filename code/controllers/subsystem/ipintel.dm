SUBSYSTEM_DEF(ipintel)
	name = "XKeyScore"
	init_order = INIT_ORDER_XKEYSCORE
<<<<<<< HEAD
	flags = SS_NO_FIRE
	var/enabled = FALSE //disable at round start to avoid checking reconnects
	var/throttle = 0
	var/errors = 0
=======
	flags = SS_OK_TO_FAIL_INIT|SS_NO_FIRE
	/// The threshold for probability to be considered a VPN and/or bad IP
	var/probability_threshold
	/// The email used in conjuction with https://check.getipintel.net/check.php
	var/contact_email
	/// Maximum number of queries per minute
	var/max_queries_per_minute
	/// Maximum number of queries per day
	var/max_queries_per_day
	/// Query base
	var/query_base
	/// The length of time (days) to cache IP intel
	var/ipintel_cache_length
	/// The living playtime (minutes) for players to be exempt from IPIntel checks
	var/exempt_living_playtime
>>>>>>> 24bc322fa6b (Fixed the ipintel subsystem not initializing (#82936))

	var/list/cache = list()

/datum/controller/subsystem/ipintel/Initialize()
	enabled = TRUE
	return SS_INIT_SUCCESS
