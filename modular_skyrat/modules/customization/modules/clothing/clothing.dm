//Mutant variants needs to be a property of all items, because all items can be equipped, despite the mob code only expecting clothing items (ugh)
/obj/item
	///Icon file for mob worn overlays, if the user is digi.
	var/icon/worn_icon_digi
	///The config type to use for greyscaled worn sprites for digitigrade characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_digi
	/// Icon file for mob worn overlays, if the user is a vox.
	var/icon/worn_icon_vox
	/// Icon file for mob worn overlays, if the user is a teshari.
	var/icon/worn_icon_teshari
	/// The config type to use for greyscaled worn sprites for Teshari characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_teshari
	/// The config type to use for greyscaled worn sprites for vox characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_vox

	var/worn_icon_taur_snake
	var/worn_icon_taur_paw
	var/worn_icon_taur_hoof
	var/worn_icon_muzzled

	var/greyscale_config_worn_taur_snake
	var/greyscale_config_worn_taur_paw
	var/greyscale_config_worn_taur_hoof

/obj/item/clothing/head
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

/obj/item/clothing/mask
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION | CLOTHING_SNOUTED_VOX_VARIATION

/obj/item/clothing/glasses
	supports_variations_flags = CLOTHING_SNOUTED_VOX_VARIATION

/obj/item/clothing/under
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/shoes
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/engineering/chief_engineer/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/medical/chief_medical_officer/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/chaplain/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/cargo/qm/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/captain/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/chaplain/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/security/officer/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/suit/black/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/rnd/research_director/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/rnd/research_director/alt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/rnd/research_director/turtleneck/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/security/head_of_security/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/security/warden/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/prisoner/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/security/officer/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/syndicate/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/cargo/tech/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/bartender/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/chef/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/hydroponics/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/janitor/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/lawyer/black/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/lawyer/female/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/lawyer/red/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/lawyer/blue/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/mime/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/curator/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/engineering/atmospheric_technician/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/engineering/engineer/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/medical/virologist/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/medical/doctor/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/medical/paramedic/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/rnd/scientist/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/rnd/roboticist/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/rnd/geneticist/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/security/detective/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/security/detective/grey/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/suit/white/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/suit/black/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/suit/black_really/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/syndicate/tacticool/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt
	supports_variations_flags = NONE

/obj/item/clothing/under/costume/draculass
	supports_variations_flags = NONE
