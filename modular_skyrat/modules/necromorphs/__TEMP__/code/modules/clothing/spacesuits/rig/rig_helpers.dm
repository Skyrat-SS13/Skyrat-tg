/*
	This proc has two goals:

	1. To transfer over all possible rig modules from source to target
		-Where there are conflicting module series (like normal and advanced kinesis),
			the target rig will end up with the superior option of the two, and the inferior one placed in source


	2. To replace source with target.
		-In most use cases, source will start off worn by a human.
			So the source will be undeployed and unequipped, then target will be equipped and deployed on that same mob

	All parameters are optional except target
		If no source is passed, we're transferring loose modules into a rig
		If no user is passed, we take user from source if possible, in order to do equipping
		extra_modules is a list of loose modules which we will attempt to install into target
			in either case, any leftover modules will go into source if possible
		dump is the place that leftover modules go after that. If none is provided they'll be dropped on the ground somewhere
*/
/proc/transfer_rig(var/obj/item/weapon/rig/target, var/obj/item/weapon/rig/source, var/list/extra_modules, var/atom/dump, var/mob/living/carbon/human/user)

	//to_chat(world, "Transfer T:[target]	S:[source]	Mod:[extra_modules]	D:[dump]	U:[user]")
	//This is required
	if (!istype(target))
		return



	//The dump location is where we'll put any modules that can't fit into either rig
	if (!dump)
		if (source)
			dump = get_turf(source)
		else
			dump = get_turf(target)

	//Remove source from user and register them if applicable
	if (source && source.is_worn())
		if (!user)
			user = source.loc
		source.instant_unequip()


	//Primary pool to hold modules
	var/list/primary = list()
	if (extra_modules)
		primary += extra_modules

	//Also create this secondary pool for later
	var/list/secondary = list()

	//Fallback, should not be needed
	var/list/failed = list()

	//Now lets succ all the modules out of both rigs and put them into a pool
	if (source)

		for (var/obj/item/rig_module/RM as anything in source.installed_modules)
			source.uninstall(RM, FALSE, user)
			primary += RM

	for (var/obj/item/rig_module/RM as anything in target.installed_modules)
		target.uninstall(RM, FALSE, user)
		primary += RM



	//Next up, we're going to try to put every single module into the target.
	for (var/obj/item/rig_module/RM as anything in primary)
		var/list/result = target.attempt_install(RM, user = null, force = FALSE, instant = TRUE, delete_replaced = FALSE, selfchecks = FALSE)
		//to_chat(world, "Installing [RM] into [target], result [result] ")

		//If result is false, RM failed to go in, toss it in the secondary list
		if (!result)
			secondary += RM

		//If result is a list, it contained the modules which were removed to make room for RM. Put those into secondary
		else if (islist(result))
			secondary += result

		//Otherwise, result is true, it went in without problems


	//Now the target rig has been populated, lets put the leftover/inferior modules into the old/source rig, if there is one
	if (source)
		for (var/obj/item/rig_module/RM as anything in secondary)
			var/list/result = source.attempt_install(RM, user = null, force = FALSE, instant = TRUE, delete_replaced = FALSE, selfchecks = FALSE)

			//If result is false, RM failed to go in, toss it in the failed list
			if (!result)
				failed += RM

			//If result is a list, it contained the modules which were removed to make room for RM. Put those into secondary
			else if (islist(result))
				failed += result

			//Otherwise, result is true, it went in without problems

	//Cleanup time,

	//any failed modules are stored in the dump site
	//This might be putting them inside a container, or maybe just dropping them in a floor, the dump decides
	for (var/atom/movable/A in failed)
		if (A.loc)
			A.loc.remove_item(A)

		dump.store_item(A)


	//Lets swap over accounts if there were any
	if (source && target)
		var/buffer_account = source.account
		source.account = target.account
		target.account = buffer_account


	//Alright now the last part, lets put the target rig onto the user, if it isn't already

	if (user)
		target.instant_equip(user)
	else
		dump.store_item(target)



/obj/item/weapon/rig/proc/instant_unequip()
	var/mob/living/carbon/human/user = loc

	if (!canremove && istype(user))
		var/cached_seal_delay = seal_delay
		seal_delay = 0

		if (active)
			toggle_seals(loc, TRUE)
		else
			retract()

		seal_delay = cached_seal_delay

	user.drop_from_inventory(src, get_turf(user))

//Future TODO: Add a force var that, if true, will unequip any blocking hats/gloves/boots/suits so deployment will succeed
/obj/item/weapon/rig/proc/instant_equip(var/mob/living/carbon/human/target, var/deploy = TRUE)
	var/cached_seal_delay = seal_delay
	seal_delay = 0
	if (wearer == target || target.equip_to_slot_if_possible(src, desired_slot, del_on_fail = FALSE, disable_warning = TRUE, redraw_mob = FALSE, force = TRUE)\
	&& deploy)
		if (!active)
			toggle_seals(target, TRUE)

	seal_delay = cached_seal_delay
