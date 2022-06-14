/datum/antagonist
	/// Should this antagonist be allowed to view exploitable information?
	var/view_exploitables = FALSE

/datum/antagonist/heretic
	view_exploitables = TRUE

/datum/antagonist/changeling
	view_exploitables = TRUE

/datum/antagonist/obsessed
	view_exploitables = TRUE

/datum/antagonist/ninja
	view_exploitables = TRUE

/datum/antagonist/wizard
	view_exploitables = TRUE

/datum/antagonist/brother
	view_exploitables = TRUE

/datum/antagonist/malf_ai
	view_exploitables = TRUE

/datum/antagonist/revenant
	view_exploitables = TRUE

/datum/antagonist/traitor
	view_exploitables = TRUE

/datum/antagonist/pirate
	view_exploitables = TRUE // pirates are flexible antags, not strictly bound by their objective. i could see this working

/datum/antagonist/rev/head
	view_exploitables = TRUE // heads only. while all revs having exploitables would be fine, i feel this would complement the "leaders leading the masses" stuff rev naturally makes

/*/datum/antagonist/cortical_borer // come back to borer when its not as new
	view_exploitables = TRUE */

/datum/antagonist/cult // cult is adminbus only... im not sure about this but im doing it anyway
	view_exploitables = TRUE

/*/datum/antagonist/abductor // maybe?
	view_exploitables = TRUE */
