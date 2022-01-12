/obj/item/weapon/rig/attackby(obj/item/W as obj, mob/user as mob)

	if(!istype(user,/mob/living)) return 0

	if(electrified != 0)
		if(shock(user)) //Handles removing charge from the cell, as well. No need to do that here.
			return

	// Pass repair items on to the chestpiece.
	if(chest && (istype(W,/obj/item/stack/material) || isWelder(W)))
		return chest.attackby(W,user)

	// Lock or unlock the access panel.
	if(W.GetIdCard() && can_modify())
		if(subverted)
			locked = 0
			to_chat(user, "<span class='danger'>It looks like the locking system has been shorted out.</span>")
			return

		if((!req_access || !req_access.len) && (!req_one_access || !req_one_access.len))
			locked = 0
			to_chat(user, "<span class='danger'>\The [src] doesn't seem to have a locking mechanism.</span>")
			return

		if(security_check_enabled && !src.allowed(user))
			to_chat(user, "<span class='danger'>Access denied.</span>")
			return

		locked = !locked
		to_chat(user, "You [locked ? "lock" : "unlock"] \the [src] access panel.")
		return

	else if (iscredits(W))
		if (!handle_credit_chip(W, user))
			return

	else if(isCrowbar(W) && can_modify())

		if(!open && locked)
			to_chat(user, "The access panel is locked shut.")
			return

		open = !open
		to_chat(user, "You [open ? "open" : "close"] the access panel.")
		return

	else if (hotswap && can_modify())
		if(istype(W,/obj/item/rig_module))
			attempt_install(W, user, FALSE)

			return 1

	if(open && can_modify())

		// Hacking.
		if(isWirecutter(W) || isMultitool(W))
			if(open)
				wires.Interact(user)
			else
				to_chat(user, "You can't reach the wiring.")
			return
		// Air tank.
		if(istype(W,/obj/item/weapon/tank)) //Todo, some kind of check for suits without integrated air supplies.

			if(air_supply)
				to_chat(user, "\The [src] already has a tank installed.")
				return

			if(!user.unEquip(W)) return
			air_supply = W
			W.forceMove(src)
			to_chat(user, "You slot [W] into [src] and tighten the connecting valve.")
			return

		// Check if this is a RIG upgrade or a modification.
		else if(istype(W,/obj/item/rig_module))
			attempt_install(W, user, FALSE)

			return 1

		else if(!cell && istype(W,/obj/item/weapon/cell))

			if(!user.unEquip(W)) return
			to_chat(user, "You jack \the [W] into \the [src]'s battery mount.")
			W.forceMove(src)
			src.cell = W
			return

		else if(isWrench(W))

			if(!air_supply)
				to_chat(user, "There is not tank to remove.")
				return

			user.put_in_hands(air_supply)
			to_chat(user, "You detach and remove \the [air_supply].")
			air_supply = null
			return

		else if(isScrewdriver(W))

			var/list/current_mounts = list()
			if(cell) current_mounts   += "cell"
			if(installed_modules && installed_modules.len) current_mounts += "system module"

			var/to_remove = input("Which would you like to modify?") as null|anything in current_mounts
			if(!to_remove)
				return


			switch(to_remove)

				if("cell")

					if(cell)
						to_chat(user, "You detach \the [cell] from \the [src]'s battery mount.")
						for(var/obj/item/rig_module/module in installed_modules)
							module.deactivate()
						user.put_in_hands(cell)
						cell = null
						return
					else
						to_chat(user, "There is nothing loaded in that mount.")

				if("system module")

					var/list/possible_removals = list()
					for(var/obj/item/rig_module/module in installed_modules)
						if(module.permanent)
							continue
						possible_removals[module.name] = module

					if(!possible_removals.len)
						to_chat(user, "There are no installed modules to remove.")
						return

					var/removal_choice = input("Which module would you like to remove?") as null|anything in possible_removals
					if(!removal_choice)
						return

					var/obj/item/rig_module/removed = possible_removals[removal_choice]
					to_chat(user, "You detach \the [removed] from \the [src].")
					uninstall(removed, FALSE, user)
					return

		else if(istype(W,/obj/item/stack/nanopaste)) //EMP repair
			var/obj/item/stack/S = W
			if(malfunctioning || malfunction_delay)
				if(S.use(1))
					to_chat(user, "You pour some of \the [S] over \the [src]'s control circuitry and watch as the nanites do their work with impressive speed and precision.")
					malfunctioning = 0
					malfunction_delay = 0
				else
					to_chat(user, "\The [S] is empty!")
			else
				to_chat(user, "You don't see any use for \the [S].")

			return

	// If we've gotten this far, all we have left to do before we pass off to root procs
	// is check if any of the loaded modules want to use the item we've been given.
	for(var/obj/item/rig_module/module in installed_modules)
		if(module.accepts_item(W,user)) //Item is handled in this proc
			return
	.=..()



/obj/item/weapon/rig/attack_hand(var/mob/user)
	if(electrified != 0)
		if(shock(user)) //Handles removing charge from the cell, as well. No need to do that here.
			return

	//If the rig has a storage module, we can attempt to access it
	if (storage && (is_worn() || is_held()))
		//This will return false if we're done, or true to tell us to keep going and call parent attackhand
		if (!storage.handle_attack_hand(user))
			return
	.=..()


//For those pesky items which incur effects on the rigsuit, an altclick will force them to go in if possible
/obj/item/weapon/rig/AltClick(var/mob/user)
	if (storage && user.get_active_hand())
		if (user == loc || Adjacent(user)) //Rig must be on or near you
			storage.accepts_item(user.get_active_hand())
			return
	.=..()

//When not wearing a rig, you can drag it onto yourself to access the internal storage
/obj/item/weapon/rig/MouseDrop(obj/over_object)
	if (storage && storage.handle_mousedrop(usr, over_object))
		return TRUE
	return ..()

/obj/item/weapon/rig/emag_act(var/remaining_charges, var/mob/user)
	if(!subverted)
		req_access.Cut()
		req_one_access.Cut()
		locked = 0
		subverted = 1
		to_chat(user, "<span class='danger'>You short out the access protocol for the suit.</span>")
		return 1


/*
	Central entrypoint to install Rig modules. All vars optional unless noted
	RM: The module we are installing, required
	User: Who is doing it, if anyone
	force: If true, the module will be installed even if a superior version already exists	//Todo: refactor this
	instant: Skip time delay
*/
/obj/item/weapon/rig/proc/attempt_install(var/obj/item/rig_module/RM, var/mob/user, var/force = FALSE, var/instant = FALSE, var/delete_replaced = FALSE, var/selfchecks = TRUE)

	if(selfchecks && is_worn() && !can_modify() && !force)
		if(user)
			to_chat(user, "<span class='danger'>You can't install a RIG module while the suit is being worn.</span>")
		return FALSE


	var/list/replaced
	if (!RM.can_install(src, null))
		RM.resolve_installation_upgrade(src, FALSE, force)

		//If force is enabled, we check again with conflict detection turned off
		if (!RM.can_install(src, null, !force))
			if(user)
				to_chat(user, "The RIG either already has a module of that class installed, or this is not valid for some other reason.")
			return FALSE

	if (user)
		if (!instant)
			to_chat(user, "You begin installing \the [RM] into \the [src].")
			if(!do_after(user,40,src))
				return	FALSE
		if(!user.unEquip(RM))
			return FALSE
		to_chat(user, "You install \the [RM] into \the [src].")
	install(RM)

	if (replaced && length(replaced))
		return replaced
	return TRUE


//This gives no feedback and cannot fail, do safety checks first
/obj/item/weapon/rig/proc/install(var/obj/item/rig_module/RM)
	installed_modules |= RM
	if (RM.process_with_rig)
		processing_modules |= RM
	RM.forceMove(src)
	RM.installed(src)
	update_icon()


/obj/item/weapon/rig/proc/uninstall(obj/item/rig_module/RM, delete = FALSE, mob/user)
	processing_modules -= RM

	RM.uninstalled(src, user)
	if (delete)
		qdel(RM)
	else
		RM.forceMove(get_turf(src))
		.=RM
	update_icon()


/obj/item/weapon/rig/proc/can_modify()
	if (is_worn() && !hotswap)
		return FALSE


	return TRUE







