/datum/quirk/equipping
	abstract_parent_type = /datum/quirk/equipping
	/// the items that will be equipped, formatted in the way of [item_path = list of slots it can be equipped to], will not equip over nodrop items
	var/list/items = list()
	/// the items that will be forcefully equipped, formatted in the way of [item_path = list of slots it can be equipped to], will equip over nodrop items
	var/list/forced_items = list()

/datum/quirk/equipping/add_unique()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if (!items || !carbon_holder)
		return
	var/list/equipped_items = list()
	var/list/all_items = forced_items|items
	for (var/obj/item/item_path as anything in all_items)
		if (!ispath(item_path))
			continue
		var/item = new item_path(carbon_holder.loc)
		var/success = FALSE
		// Checking for nodrop and seeing if there's an empty slot
		for (var/slot as anything in all_items[item_path])
			success = force_equip_item(carbon_holder, item, slot, check_item = FALSE)
			if (success)
				break
		// Checking for nodrop
		for (var/slot as anything in all_items[item_path])
			success = force_equip_item(carbon_holder, item, slot)
			if (success)
				break

		if ((item_path in forced_items) && !success)
			// Checking for nodrop failed, shove it into the first available slot, even if it has nodrop
			for (var/slot as anything in all_items[item_path])
				success = force_equip_item(carbon_holder, item, slot, FALSE)
				if (success)
					break
		equipped_items[item] = success
	for (var/item as anything in equipped_items)
		on_equip_item(item, equipped_items[item])

/datum/quirk/equipping/proc/force_equip_item(mob/living/carbon/target, obj/item/item, slot, check_nodrop = TRUE, check_item = TRUE)
	var/obj/item/item_in_slot = target.get_item_by_slot(slot)
	if (check_item && item_in_slot)
		if (check_nodrop && HAS_TRAIT(item_in_slot, TRAIT_NODROP))
			return FALSE
		target.dropItemToGround(item_in_slot, force = TRUE)
	return target.equip_to_slot_if_possible(item, slot, disable_warning = TRUE) // this should never not work tbh

/datum/quirk/equipping/proc/on_equip_item(obj/item/equipped, success)
	return

/datum/quirk/equipping/lungs
	abstract_parent_type = /datum/quirk/equipping/lungs
	var/obj/item/organ/lungs/lungs_holding
	var/obj/item/organ/lungs/lungs_added
	var/lungs_typepath = /obj/item/organ/lungs
	items = list(/obj/item/clothing/accessory/breathing = list(ITEM_SLOT_BACKPACK))
	var/breath_type = "oxygen"

/datum/quirk/equipping/lungs/add()
	var/mob/living/carbon/human/carbon_holder = quirk_holder
	if (!istype(carbon_holder) || !lungs_typepath)
		return
	var/current_lungs = carbon_holder.getorganslot(ORGAN_SLOT_LUNGS)
	if (istype(current_lungs, lungs_typepath))
		return
	lungs_holding = current_lungs
	lungs_holding.organ_flags |= ORGAN_FROZEN
	lungs_added = new lungs_typepath
	lungs_added.Insert(carbon_holder)
	lungs_holding.moveToNullspace()

/datum/quirk/equipping/lungs/remove()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if (!istype(carbon_holder) || !lungs_holding)
		return
	var/obj/item/organ/lungs/lungs = carbon_holder.getorganslot(ORGAN_SLOT_LUNGS)
	if (lungs != lungs_added && lungs != lungs_holding)
		qdel(lungs_holding)
		return
	lungs_holding.Insert(carbon_holder, drop_if_replaced = FALSE)
	lungs_holding.organ_flags &= ~ORGAN_FROZEN
	carbon_holder.update_internals_hud_icon(1)

/datum/quirk/equipping/lungs/on_equip_item(obj/item/equipped, success)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if (!istype(equipped, /obj/item/clothing/accessory/breathing))
		return
	var/obj/item/clothing/accessory/breathing/acc = equipped
	acc.breath_type = breath_type
	if (acc.can_attach_accessory(human_holder?.w_uniform))
		acc.attach(human_holder.w_uniform, human_holder)

/obj/item/clothing/accessory/breathing
	name = "breathing dogtag"
	desc = "Dogtag that lists what you breathe."
	icon_state = "allergy"
	above_suit = FALSE
	minimize_when_attached = TRUE
	attachment_slot = CHEST
	var/breath_type

/obj/item/clothing/accessory/breathing/examine(mob/user)
	. = ..()
	. += "The dogtag reads: I breathe [breath_type]."

/obj/item/clothing/accessory/breathing/on_uniform_equip(obj/item/clothing/under/uniform, user)
	. = ..()
	RegisterSignal(uniform, COMSIG_PARENT_EXAMINE, .proc/on_examine)

/obj/item/clothing/accessory/breathing/on_uniform_dropped(obj/item/clothing/under/uniform, user)
	. = ..()
	UnregisterSignal(uniform, COMSIG_PARENT_EXAMINE)

/obj/item/clothing/accessory/breathing/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += "The dogtag reads: I breathe [breath_type]."

/datum/quirk/equipping/lungs/nitrogen
	name = "Nitrogen Breather"
	desc = "You breathe nitrogen, even if you might not normally breathe it. Oxygen is poisonous."
	icon = "lungs"
	medical_record_text = "Patient can only breathe nitrogen."
	gain_text = "<span class='danger'>You suddenly have a hard time breathing anything but nitrogen."
	lose_text = "<span class='notice'>You suddenly feel like you aren't bound to nitrogen anymore."
	value = 0
	forced_items = list(
		/obj/item/clothing/mask/breath = list(ITEM_SLOT_MASK),
		/obj/item/tank/internals/nitrogen/belt/full = list(ITEM_SLOT_HANDS, ITEM_SLOT_LPOCKET, ITEM_SLOT_RPOCKET))
	lungs_typepath = /obj/item/organ/lungs/nitrogen
	breath_type = "nitrogen"

/datum/quirk/equipping/lungs/nitrogen/on_equip_item(obj/item/equipped, success)
	. = ..()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if (!success || !istype(carbon_holder) || !istype(equipped, /obj/item/tank/internals))
		return
	carbon_holder.internal = equipped
	carbon_holder.update_internals_hud_icon(1)
