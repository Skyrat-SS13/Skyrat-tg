
/obj/item/mod/module/baton_holster
	name = "MOD baton holster module"
	desc = "A module installed into the chest of a MODSuit, this allows you \
		to retrieve an inserted baton from the suit at will. Insert a baton \
		by hitting the module, while it is removed from the suit, with the baton. \
		Remove an inserted baton with a wrench."
	icon_state = "holster"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'
	complexity = 3
	incompatible_modules = list(/obj/item/mod/module/baton_holster)
	module_type = MODULE_USABLE
	/// Ref to the baton
	var/obj/item/melee/baton/telescopic/contractor_baton/stored_batong
	/// If the baton is out or not
	var/deployed = FALSE

// doesn't give a shit if it's deployed or not
/obj/item/mod/module/baton_holster/on_select()
	on_use()
	SEND_SIGNAL(mod, COMSIG_MOD_MODULE_SELECTED, src)

/obj/item/mod/module/baton_holster/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(!istype(attacking_item, /obj/item/melee/baton/telescopic/contractor_baton) || stored_batong)
		return
	balloon_alert(user, "[attacking_item] inserted")
	attacking_item.forceMove(src)
	stored_batong = attacking_item
	stored_batong.holster = src

/obj/item/mod/module/baton_holster/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!stored_batong)
		return
	balloon_alert(user, "[stored_batong] removed")
	stored_batong.forceMove(get_turf(src))
	stored_batong.holster = null
	stored_batong = null
	tool.play_tool_sound(src)

/obj/item/mod/module/baton_holster/Destroy()
	if(stored_batong)
		stored_batong.forceMove(get_turf(src))
		stored_batong.holster = null
		stored_batong = null
	. = ..()

/obj/item/mod/module/baton_holster/on_use()
	if(!deployed)
		deploy(mod.wearer)
	else
		undeploy(mod.wearer)

/obj/item/mod/module/baton_holster/proc/deploy(mob/living/user)
	if(!(stored_batong in src))
		return
	if(!user.put_in_hands(stored_batong))
		to_chat(user, span_warning("You need a free hand to hold [stored_batong]!"))
		return
	deployed = TRUE
	balloon_alert(user, "[stored_batong] deployed")

/obj/item/mod/module/baton_holster/proc/undeploy(mob/living/user)
	if(QDELETED(stored_batong))
		return
	stored_batong.forceMove(src)
	deployed = FALSE
	balloon_alert(user, "[stored_batong] retracted")

/obj/item/mod/module/baton_holster/preloaded

/obj/item/mod/module/baton_holster/preloaded/Initialize(mapload)
	. = ..()
	stored_batong = new/obj/item/melee/baton/telescopic/contractor_baton/upgraded(src)
	stored_batong.holster = src



/obj/item/mod/module/chameleon
	name = "MOD chameleon module"
	desc = "An illegal module that lets you disguise your MODsuit as any other kind with the help of chameleon technology. However, due to technological challenges, the module only functions when the MODsuit is undeployed."
	icon_state = "chameleon"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'
	module_type = MODULE_USABLE
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.25
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/chameleon)
	cooldown_time = 0.5 SECONDS
	/// All of these below are the stored MODsuit original stats
	var/chameleon_type = /obj/item/mod/control
	var/chameleon_name
	var/chameleon_desc
	var/chameleon_icon_state
	var/chameleon_icon
	var/chameleon_worn_icon
	var/chameleon_left
	var/chameleon_right
	/// MODsuit controllers that aren't allowed
	var/list/chameleon_blacklist = list()
	/// List of MODsuits that can be used
	var/list/chameleon_list = list()
	/// If the module's in use or not
	var/on = FALSE

/obj/item/mod/module/chameleon/on_select()
	if(!length(chameleon_list))
		init_chameleon_list()
	for(var/obj/item/part as anything in mod.mod_parts)
		if(!(part.loc == mod.wearer))
			continue
		balloon_alert(mod.wearer, "parts cannot be deployed to use this!")
		playsound(mod, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	on_use()
	SEND_SIGNAL(mod, COMSIG_MOD_MODULE_SELECTED, src)

/obj/item/mod/module/chameleon/on_use()
	var/obj/item/picked_item
	var/picked_name = tgui_input_list(mod.wearer, "Select [chameleon_name] to change into", "Chameleon Settings", sort_list(chameleon_list, /proc/cmp_typepaths_asc))
	if(isnull(picked_name) || isnull(chameleon_list[picked_name]))
		return
	picked_item = chameleon_list[picked_name]
	update_look(mod.wearer, picked_item)

/obj/item/mod/module/chameleon/on_install()
	chameleon_name = mod.name
	chameleon_desc = mod.desc
	chameleon_icon_state = "[mod.skin]-[initial(mod.icon_state)]"
	chameleon_icon = mod.icon
	chameleon_worn_icon = initial(mod.worn_icon)
	chameleon_left = initial(mod.lefthand_file)
	chameleon_right = initial(mod.righthand_file)
	RegisterSignal(mod, COMSIG_MOD_ACTIVATE, .proc/reset_chameleon)

/obj/item/mod/module/chameleon/on_uninstall(deleting = FALSE)
	UnregisterSignal(mod, COMSIG_MOD_ACTIVATE)
	reset_chameleon()

/obj/item/mod/module/chameleon/proc/reset_chameleon()
	if(on)
		balloon_alert(mod.wearer, "chameleon module disabled!")
	for(var/obj/item/mod/module/storage/syndicate/synd_store in mod.modules)
		synd_store.name = initial(synd_store.name)
		synd_store.chameleon_disguised = FALSE
	on = FALSE
	mod.name = chameleon_name
	mod.desc = chameleon_desc
	mod.icon_state = chameleon_icon_state
	mod.icon = chameleon_icon
	mod.worn_icon = chameleon_worn_icon
	mod.lefthand_file = chameleon_left
	mod.righthand_file = chameleon_right

/obj/item/mod/module/chameleon/proc/update_look(mob/living/user, obj/item/picked_item)
	if(!isliving(user))
		return
	if(user.stat != CONSCIOUS)
		return

	update_item(picked_item)
	for(var/obj/item/mod/module/storage/syndicate/synd_store in mod.modules)
		synd_store.name = "MOD expanded storage module"
		synd_store.chameleon_disguised = TRUE
	var/obj/item/thing = mod
	thing.update_slot_icon()
	on = TRUE

/obj/item/mod/module/chameleon/proc/update_item(obj/item/picked_item)
	var/obj/item/mod/control/modsuit = new picked_item()
	mod.name = modsuit.name
	mod.desc = modsuit.desc
	mod.icon_state = modsuit.icon_state
	mod.worn_icon = modsuit.worn_icon
	mod.lefthand_file = modsuit.lefthand_file
	mod.righthand_file = modsuit.righthand_file
	if(modsuit.greyscale_colors)
		if(modsuit.greyscale_config_worn)
			mod.worn_icon = SSgreyscale.GetColoredIconByType(modsuit.greyscale_config_worn, modsuit.greyscale_colors)
		if(modsuit.greyscale_config_inhand_left)
			mod.lefthand_file = SSgreyscale.GetColoredIconByType(modsuit.greyscale_config_inhand_left, modsuit.greyscale_colors)
		if(modsuit.greyscale_config_inhand_right)
			mod.righthand_file = SSgreyscale.GetColoredIconByType(modsuit.greyscale_config_inhand_right, modsuit.greyscale_colors)
	mod.worn_icon_state = modsuit.worn_icon_state
	mod.inhand_icon_state = modsuit.inhand_icon_state
	if(modsuit.greyscale_config && modsuit.greyscale_colors)
		mod.icon = SSgreyscale.GetColoredIconByType(modsuit.greyscale_config, modsuit.greyscale_colors)
	else
		mod.icon = modsuit.icon
	update_slot_icon()
	qdel(modsuit)

/obj/item/mod/module/chameleon/proc/init_chameleon_list()
	for(var/obj/item/modsuit as anything in typesof(chameleon_type))
		if(chameleon_blacklist[modsuit] || (initial(modsuit.item_flags) & ABSTRACT) || !initial(modsuit.icon_state))
			continue
		var/chameleon_item_name = "[modsuit]"
		chameleon_list[chameleon_item_name] = modsuit

/obj/item/mod/module/chameleon/Initialize(mapload)
	. = ..()
	init_chameleon_list()



/obj/item/mod/module/armor_booster/contractor // Much flatter distribution because contractor suit gets a shitton of armor already
	armor_values = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20)
	added_slowdown = 0.5 //Bulky as shit
	desc = "An embedded set of armor plates, allowing the suit's already extremely high protection \
		to be increased further. However, the plating, while deployed, will slow down the user \
		and make the suit unable to vacuum seal so this extra armor provides zero ability for extravehicular activity while deployed."

/obj/item/mod/module/springlock/contractor
	name = "MOD magnetic deployment module"
	desc = "A much more modern version of a springlock system. \
	This is a module that uses magnets to speed up the deployment and retraction time of your MODsuit."
	icon_state = "magnet"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'

/obj/item/mod/module/springlock/on_suit_activation() // This module is actually *not* a death trap
	return

/obj/item/mod/module/springlock/on_suit_deactivation(deleting = FALSE)
	return


/obj/item/mod/module/storage/syndicate
	var/chameleon_disguised = FALSE

/obj/item/mod/module/storage/syndicate/on_uninstall(deleting = FALSE)
	if(chameleon_disguised)
		name = initial(name)
		chameleon_disguised = FALSE
	. = ..()
