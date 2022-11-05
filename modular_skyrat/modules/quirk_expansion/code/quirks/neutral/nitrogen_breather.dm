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
	lungs_typepath = /obj/item/organ/internal/lungs/nitrogen
	breath_type = "nitrogen"

/datum/quirk/equipping/lungs/nitrogen/on_equip_item(obj/item/equipped, success)
	. = ..()
	var/mob/living/carbon/carbon_holder = quirk_holder
	if (!success || !istype(carbon_holder) || !istype(equipped, /obj/item/tank/internals))
		return
	carbon_holder.internal = equipped
