/obj/item/cane/crutch
	name = "crutch"
	desc = "A crutch usually employed by those recovering from a leg injury."
	icon = 'modular_skyrat/master_files/icons/obj/staff.dmi'
	icon_state = "crutch"
	inhand_icon_state = "crutch"
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/melee_righthand.dmi'

// stupid DM inheritance, we have to remove our icon overrides for subtypes
/obj/item/cane/crutch/wood
	icon = 'icons/obj/weapons/staff.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
