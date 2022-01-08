/*
	Weapon check procs
*/

//Organ: When we're using a specific bodypart to do the killing
/datum/extension/execution/proc/weapon_check_organ()
	.=EXECUTION_CONTINUE
	if (!weapon)
		return EXECUTION_CANCEL

	var/obj/item/organ/external/E = weapon
	if (E.is_stump())
		return EXECUTION_CANCEL

	if (E.owner != user || E.loc != user)
		return EXECUTION_CANCEL