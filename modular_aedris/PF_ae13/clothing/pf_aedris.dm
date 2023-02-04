/datum/armor/bulletproof/admin/policiafederal
	melee = 80
	bullet = 80
	laser = 80
	energy = 80
	fire = 80
	acid = 80
	wound = 80

/obj/item/clothing/suit/armor/bulletproof/admin/kevlar_pf
	name = "Kevlar PF"
	desc = "Uniforme administrativo da policia federal da aedris 13"
	icon = 'modular_aedris/PF_ae13/clothing/kevlar.dmi'
	armor_type = /datum/armor/bulletproof/admin/policiafederal
	worn_icon = 'modular_aedris/PF_ae13/clothing/kevlar_mob.dmi'
	icon_state = "kevlar"
	worn_icon_state = "policevest"
	body_parts_covered = CHEST|GROIN|ARMS // Our sprite has groin and arm protections, so we get it too.
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/head_of_security/skyrat/kevlar_pf
	icon = 'modular_aedris/PF_ae13/clothing/pf_jumpsuit.dmi'
	icon_state = "combat"
	worn_icon_state = "combat"
	worn_icon = 'modular_aedris/PF_ae13/clothing/pf_jumpsuit_mob.dmi'