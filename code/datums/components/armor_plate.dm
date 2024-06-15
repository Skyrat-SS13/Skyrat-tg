/datum/component/armor_plate
	/// The current number of upgrades applied to the parent via this component.
	var/amount = 0
	/// The maximum number of upgarde items that can be applied. Once var/amount reaches this value, no more upgrades can be applied
	var/maxamount = 3
	/// THe path for our upgrade item. Each one is expended to improve the parent's armor values.
	var/upgrade_item = /obj/item/stack/sheet/animalhide/goliath_hide
	/// THe armor datum path for our upgrade values. This value is added per upgrade item applied
	var/datum/armor/armor_mod = /datum/armor/armor_plate
	/// The name of the upgrade item.
	var/upgrade_name
	/// Adds a prefix to the item, demonstrating that it is upgraded in some way.
	var/upgrade_prefix = "reinforced"
	/// Tracks whether or not we've received an upgrade or not.
	var/have_upgraded = FALSE

/datum/armor/armor_plate
	melee = 10

/datum/component/armor_plate/Initialize(maxamount, obj/item/upgrade_item, datum/armor/armor_mod, upgrade_prefix = "reinforced")
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(examine))
	RegisterSignal(parent, COMSIG_ATOM_ATTACKBY, PROC_REF(applyplate))
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(dropplates))
	if(istype(parent, /obj/vehicle/sealed/mecha/ripley))
		RegisterSignal(parent, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(apply_mech_overlays))

	if(maxamount)
		src.maxamount = maxamount
	if(upgrade_item)
		src.upgrade_item = upgrade_item
	if(armor_mod)
		src.armor_mod = armor_mod
	if(upgrade_prefix)
		src.upgrade_prefix = upgrade_prefix
	var/obj/item/typecast = upgrade_item
	src.upgrade_name = initial(typecast.name)

/datum/component/armor_plate/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	//upgrade_item could also be typecast here instead
	if(ismecha(parent))
		if(amount)
			if(amount < maxamount)
				examine_list += span_notice("Its armor is enhanced with [amount] [upgrade_name].")
			else
				examine_list += span_notice("It's wearing a fearsome carapace entirely composed of [upgrade_name] - its pilot must be an experienced monster hunter.")
		else
			examine_list += span_notice("It has attachment points for strapping monster hide on for added protection.")
	else
		if(amount)
			examine_list += span_notice("It has been strengthened with [amount]/[maxamount] [upgrade_name].")
		else
			examine_list += span_notice("It can be strengthened with up to [maxamount] [upgrade_name].")

/datum/component/armor_plate/proc/applyplate(datum/source, obj/item/our_upgrade_item, mob/user, params)
	SIGNAL_HANDLER

	if(!istype(our_upgrade_item, upgrade_item))
		return
	if(amount >= maxamount)
		to_chat(user, span_warning("You can't improve [parent] any further!"))
		return

	if(istype(our_upgrade_item, /obj/item/stack))
		our_upgrade_item.use(1)
	else
		if(length(our_upgrade_item.contents))
			to_chat(user, span_warning("[our_upgrade_item] cannot be used for armoring while there's something inside!"))
			return
		qdel(our_upgrade_item)

	var/obj/target_for_upgrading = parent
	amount++
	target_for_upgrading.set_armor(target_for_upgrading.get_armor().add_other_armor(armor_mod))

	if(ismecha(target_for_upgrading))
		var/obj/vehicle/sealed/mecha/mecha_for_upgrading = target_for_upgrading
		mecha_for_upgrading.update_appearance()
		to_chat(user, span_info("You strengthen [mecha_for_upgrading], improving its resistance against attacks."))
	else
		SEND_SIGNAL(target_for_upgrading, COMSIG_ARMOR_PLATED, amount, maxamount)
		if(upgrade_prefix && !have_upgraded)
			target_for_upgrading.name = "[upgrade_prefix] [target_for_upgrading.name]"
			have_upgraded = TRUE
		to_chat(user, span_info("You strengthen [target_for_upgrading], improving its resistance against attacks."))

/datum/component/armor_plate/proc/dropplates(datum/source, force)
	SIGNAL_HANDLER

	if(ismecha(parent)) //items didn't drop the plates before and it causes erroneous behavior for the time being with collapsible helmets
		for(var/i in 1 to amount)
			new upgrade_item(get_turf(parent))

/datum/component/armor_plate/proc/apply_mech_overlays(obj/vehicle/sealed/mecha/mech, list/overlays)
	SIGNAL_HANDLER

	if(amount)
		var/overlay_string = "ripley-g"
		if(amount >= 3)
			overlay_string += "-full"
		if(!LAZYLEN(mech.occupants))
			overlay_string += "-open"
		overlays += overlay_string
