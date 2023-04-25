/obj/item/clothing/shoes/sneakers/black/tactical
	name = "tactical sneakers"
	desc = "Your standard station sneakers, these ones come with tactical low friction shoelaces!"

/obj/item/clothing/head/soft/junior_officer
	name = "peacekeeper junior officer cap"
	desc = "A junior officers cap, wearing this increases your robustness, apparently."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "juniorsoft"
	soft_type = "junior"

/obj/item/clothing/under/rank/security/peacekeeper/junior
	name = "peacekeeper junior officer poloshirt"
	desc = "A sleek peackeeper poloshirt and pants, this one is special. It's for junior officers."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi'
	icon_state = "junior_officer"

/obj/item/clothing/suit/toggle/labcoat/junior_officer
	name = "junior officer coat"
	desc = "An Armadyne coat that offers very minimal protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "juniorjacket"
	inhand_icon_state = "jacket"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	allowed = list(/obj/item/gun/ballistic/automatic/pistol/pepperball, /obj/item/melee/baton)
	toggle_noun = "zipper"



