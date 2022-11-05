/datum/quirk/equipping/lungs
	abstract_parent_type = /datum/quirk/equipping/lungs
	var/obj/item/organ/internal/lungs/lungs_holding
	var/obj/item/organ/internal/lungs/lungs_added
	var/lungs_typepath = /obj/item/organ/internal/lungs
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
	var/obj/item/organ/internal/lungs/lungs = carbon_holder.getorganslot(ORGAN_SLOT_LUNGS)
	if (lungs != lungs_added && lungs != lungs_holding)
		qdel(lungs_holding)
		return
	lungs_holding.Insert(carbon_holder, drop_if_replaced = FALSE)
	lungs_holding.organ_flags &= ~ORGAN_FROZEN

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
