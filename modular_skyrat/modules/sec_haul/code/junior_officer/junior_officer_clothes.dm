/obj/item/clothing/head/soft/black/junior_officer
	name = "peacekeeper junior officer cap"
	desc = "A junior officers cap, wearing this increases your robustness, apparently."
	icon = 'modular_skyrat/modules/sec_haul/icons/junior_officer/items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/junior_officer/cap.dmi'
	icon_state = "juniorsoft"
	soft_type = "junior"
	mutant_variants = NONE

/obj/item/clothing/under/rank/security/peacekeeper/junior
	name = "peacekeeper junior officer poloshirt"
	desc = "A sleek peackeeper poloshirt and pants, this one is special. It's for junior officers."
	icon = 'modular_skyrat/modules/sec_haul/icons/junior_officer/items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/junior_officer/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/junior_officer/uniform_digi.dmi'
	icon_state = "junior_officer"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 30, WOUND = 10)

/obj/item/clothing/suit/toggle/labcoat/junior_officer
	name = "junior officer coat"
	desc = "An Armadyne coat that offers very minimal protection."
	icon = 'modular_skyrat/modules/sec_haul/icons/junior_officer/items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/junior_officer/suit.dmi'
	icon_state = "juniorjacket"
	inhand_icon_state = "jacket"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	allowed = list(/obj/item/gun/ballistic/automatic/pistol/pepperball, /obj/item/melee/classic_baton)
	armor = list(MELEE = 15, BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 50, RAD = 0, FIRE = 50, ACID = 50)
	togglename = "zipper"
	mutant_variants = NONE
