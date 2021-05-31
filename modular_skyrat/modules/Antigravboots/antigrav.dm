/obj/item/clothing/shoes/antigrav_boots
	desc = "Anti-gravity boots, for those who want to live weightlessly. Comes in cargo colors!"
	name = "anti-gravity boots"
	icon_state = "clown"
	inhand_icon_state = "clown_shoes"
	var/enabled_antigravity = FALSE
	strip_delay = 70
	equip_delay_other = 70
	resistance_flags = FIRE_PROOF
	permeability_coefficient = 0.05
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/shoes/antigrav_boots/verb/toggle()
	set name = "Toggle Anti-gravity Boots"
	set category = "Object"
	set src in usr
	if(!can_use(usr))
		return
	attack_self(usr)

/obj/item/clothing/shoes/antigrav_boots/attack_self(mob/user)
	to_chat(user, "<span class='notice'>You toggle the traction system.</span>")
	enabled_antigravity = !enabled_antigravity
	if (enabled_antigravity == TRUE)
		user.AddElement(/datum/element/forced_gravity, 0)
	else
		user.RemoveElement(/datum/element/forced_gravity, 0)
	user.update_inv_shoes() //so our mob-overlays update
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()
