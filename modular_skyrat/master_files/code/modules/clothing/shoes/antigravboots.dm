///This file houses the antigravity boots item and research node/design, for ease of access
/obj/item/clothing/shoes/antigrav_boots
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	desc = "Anti-gravity boots, for those who want to live weightlessly. Control Click to toggle anti-gravity functions."
	name = "anti-gravity boots"
	icon_state = "walkboots" //Haha funny reused sprite
	var/enabled_antigravity = FALSE

/obj/item/clothing/shoes/antigrav_boots/equipped(mob/user, slot)
	. = ..()
	if(!slot == ITEM_SLOT_FEET)
		return
	if(enabled_antigravity)
		user.AddElement(/datum/element/forced_gravity, 0)

/obj/item/clothing/shoes/antigrav_boots/dropped(mob/user)
	. = ..()
	user.RemoveElement(/datum/element/forced_gravity, 0)

/obj/item/clothing/shoes/antigrav_boots/CtrlClick(mob/living/user)
	if(!isliving(user))
		return
	if(user.get_active_held_item() != src)
		to_chat(user, "<span class='warning'>You must hold the [src] in your hand to do this!</span>")
		return
	if (enabled_antigravity)
		to_chat(user, "<span class='notice'>You switch off the antigravity!</span>")
		enabled_antigravity = FALSE
	else
		to_chat(user, "<span class='notice'>You switch on the antigravity!</span>")
		enabled_antigravity = TRUE

///Techweb Node///
/datum/techweb_node/adv_cargo
	id = "adv_cargo"
	display_name = "Advanced Supply And Delivery"
	description = "Utilizing our understanding of physics and manipulation to harness advanced cargo technology."
	prereq_ids = list("adv_engi")
	design_ids = list("antigravboots")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

//Design//
/datum/design/antigravboots
	name = "Anti-gravity Boots"
	desc = "Anti-gravity boots, to ensure the wearer isn't weighed down by items they carry."
	id = "antigravboots"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 9000, /datum/material/silver = 3000, /datum/material/gold = 5000) //Twice as expensive as magboots.
	build_path = /obj/item/clothing/shoes/antigrav_boots
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_CARGO
