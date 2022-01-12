// Interface for humans.
/obj/item/weapon/rig/verb/RIG_interface()

	set name = "Open RIG Interface"
	set desc = "Open the RIG system interface."
	set category = "RIG"
	set src in usr.contents

	if(wearer?.wearing_rig == src)
		tgui_interact(usr)
	else
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")

/obj/item/weapon/rig/verb/toggle_vision()

	set name = "Toggle Visor"
	set desc = "Turns your rig visor off or on."
	set category = "RIG"
	set src = usr.contents

	if(!visor)
		to_chat(usr, "<span class='warning'>The RIG does not have a configurable visor.</span>")
		return

	if(canremove)
		to_chat(usr, "<span class='warning'>The suit is not active.</span>")
		return

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	if(!check_suit_access(usr))
		return

	if(!check_power_cost(usr, visor.use_power_cost, visor.active_power_cost, 0, visor))
		return

	if(!visor.active)
		visor.activate()
	else
		visor.deactivate()

/obj/item/weapon/rig/proc/toggle_helmet_verb()

	set name = "Toggle Helmet"
	set desc = "Deploys or retracts your helmet."
	set category = "RIG"
	set src = usr.contents

	if(!check_suit_access(usr))
		return

	toggle_piece("helmet",usr)


/obj/item/weapon/rig/proc/toggle_helmet(var/mob/user, var/ignore_access = FALSE, var/duration = 0)

	set name = "Toggle Helmet"
	set desc = "Deploys or retracts your helmet."
	set category = "RIG"
	set src = usr.contents

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	if(!ignore_access && !check_suit_access(usr))
		return

	//If a duration is passed, we have a do-mob check, user and wearer need to stay still
	if (duration && !do_after(user = user , target = wearer, delay = duration))
		return

	toggle_piece("helmet",user)

/obj/item/weapon/rig/proc/toggle_chest()

	set name = "Toggle Chestpiece"
	set desc = "Deploys or retracts your chestpiece."
	set category = "RIG"
	set src = usr.contents

	if(!check_suit_access(usr))
		return

	toggle_piece("chest",wearer)

/obj/item/weapon/rig/proc/toggle_gauntlets()

	set name = "Toggle Gauntlets"
	set desc = "Deploys or retracts your gauntlets."
	set category = "RIG"
	set src = usr.contents

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	if(!check_suit_access(usr))
		return

	toggle_piece("gauntlets",wearer)

/obj/item/weapon/rig/proc/toggle_boots()

	set name = "Toggle Boots"
	set desc = "Deploys or retracts your boots."
	set category = "RIG"
	set src = usr.contents

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	if(!check_suit_access(usr))
		return

	toggle_piece("boots",wearer)

/obj/item/weapon/rig/verb/deploy_suit()

	set name = "Deploy RIG"
	set desc = "Deploys helmet, gloves and boots."
	set category = "RIG"
	set src = usr.contents

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	if(!check_suit_access(usr))
		return

	if(!check_power_cost(usr))
		return

	deploy(wearer)

/obj/item/weapon/rig/verb/toggle_seals_verb()

	set name = "Toggle RIG"
	set desc = "Activates or deactivates your rig."
	set category = "RIG"
	set src = usr.contents

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	if(!check_suit_access(usr))
		return

	toggle_seals(wearer)

/obj/item/weapon/rig/verb/switch_vision_mode()

	set name = "Switch Vision Mode"
	set desc = "Switches between available vision modes."
	set category = "RIG"
	set src = usr.contents

	if(!visor)
		to_chat(usr, "<span class='warning'>The RIG does not have a configurable visor.</span>")
		return

	if(malfunction_check(usr))
		return

	if(canremove)
		to_chat(usr, "<span class='warning'>The suit is not active.</span>")
		return

	if(!check_power_cost(usr, visor.use_power_cost, visor.active_power_cost, 0, visor, 0))
		return

	if(!visor.active)
		visor.activate()

	if(!visor.active)
		to_chat(usr, "<span class='warning'>The visor is suffering a hardware fault and cannot be configured.</span>")
		return

	visor.engage()

/obj/item/weapon/rig/verb/alter_voice()

	set name = "Configure Voice Synthesiser"
	set desc = "Toggles or configures your voice synthesizer."
	set category = "RIG"
	set src = usr.contents

	if(malfunction_check(usr))
		return

	if(canremove)
		to_chat(usr, "<span class='warning'>The suit is not active.</span>")
		return

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	if(!speech)
		to_chat(usr, "<span class='warning'>The RIG does not have a speech synthesiser.</span>")
		return

	speech.engage()

/obj/item/weapon/rig/verb/select_module()

	set name = "Select Module"
	set desc = "Selects a module as your primary system."
	set category = "RIG"
	set src = usr.contents

	if(malfunction_check(usr))
		return

	if(canremove)
		to_chat(usr, "<span class='warning'>The suit is not active.</span>")
		return

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	var/list/selectable = list()
	for(var/obj/item/rig_module/module in installed_modules)
		if(module.selectable)
			selectable |= module

	var/obj/item/rig_module/module = input("Which module do you wish to select?") as null|anything in selectable

	if(!istype(module))
		selected_module = null
		to_chat(usr, "<font color='blue'><b>Primary system is now: deselected.</b></font>")
		return

	if(!check_power_cost(usr, module.use_power_cost, module.active_power_cost, 0, module, 0))
		return

	selected_module = module
	to_chat(usr, "<font color='blue'><b>Primary system is now: [selected_module.interface_name].</b></font>")

/obj/item/weapon/rig/verb/toggle_module()

	set name = "Toggle Module"
	set desc = "Toggle a system module."
	set category = "RIG"
	set src = usr.contents

	if(malfunction_check(usr))
		return

	if(canremove)
		to_chat(usr, "<span class='warning'>The suit is not active.</span>")
		return

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	var/list/selectable = list()
	for(var/obj/item/rig_module/module in installed_modules)
		if(module.toggleable)
			selectable |= module

	var/obj/item/rig_module/module = input("Which module do you wish to toggle?") as null|anything in selectable

	if(!istype(module))
		return

	if(module.active)
		to_chat(usr, "<font color='blue'><b>You attempt to deactivate \the [module.interface_name].</b></font>")
		module.deactivate()
	else
		if(check_power_cost(usr, module.use_power_cost, module.active_power_cost, 0, module, 0))
			to_chat(usr, "<font color='blue'><b>You attempt to activate \the [module.interface_name].</b></font>")
			module.activate()

/obj/item/weapon/rig/verb/engage_module()

	set name = "Engage Module"
	set desc = "Engages a system module."
	set category = "RIG"
	set src = usr.contents

	if(malfunction_check(usr))
		return

	if(canremove)
		to_chat(usr, "<span class='warning'>The suit is not active.</span>")
		return

	if(!wearer?.wearing_rig == src)
		to_chat(usr, "<span class='warning'>The RIG is not being worn.</span>")
		return

	var/list/selectable = list()
	for(var/obj/item/rig_module/module in installed_modules)
		if(module.usable)
			selectable |= module

	var/obj/item/rig_module/module = input("Which module do you wish to engage?") as null|anything in selectable

	if(!istype(module))
		return

	if(!check_power_cost(usr, module.use_power_cost, module.active_power_cost, 0, module, 0))
		return

	to_chat(usr, "<font color='blue'><b>You attempt to engage the [module.interface_name].</b></font>")
	module.engage()