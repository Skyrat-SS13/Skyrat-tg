// Lunar Clothes
/obj/item/clothing/under/costume/qipao
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "black qipao"
	desc = "A qipao, traditionally worn in ancient Earth China by women during social events and lunar new years. This one is black."
	icon_state = "qipao"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	supports_variations_flags = NONE

/obj/item/clothing/under/costume/qipao/white
	name = "white qipao"
	desc = "A qipao, traditionally worn in ancient Earth China by women during social events and lunar new years. This one is white."
	icon_state = "qipao_white"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE

/obj/item/clothing/under/costume/deckers/alt
	name = "deckers maskless outfit"
	desc = "A decker jumpsuit with neon blue coloring."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "decking_jumpsuit"
	can_adjust = FALSE

/obj/item/clothing/under/costume/qipao/red
	name = "red qipao"
	desc = "A qipao, traditionally worn in ancient Earth China by women during social events and lunar new years. This one is red."
	icon_state = "qipao_red"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE

/obj/item/clothing/under/costume/cheongsam
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "black cheongsam"
	desc = "A cheongsam, traditionally worn in ancient Earth China by men during social events and lunar new years. This one is black."
	icon_state = "cheong"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	supports_variations_flags = NONE

/obj/item/clothing/under/costume/cheongsam/white
	name = "white cheongsam"
	desc = "A cheongsam, traditionally worn in ancient Earth China by men during social events and lunar new years. This one is white."
	icon_state = "cheongw"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/under/costume/cheongsam/red
	name = "red cheongsam"
	desc = "A cheongsam, traditionally worn in ancient Earth China by men during social events and lunar new years. This one is red.."
	icon_state = "cheongr"
	body_parts_covered = CHEST|GROIN

//Cyberpunk PI Costume - Sprites from Eris, slightly modified
/obj/item/clothing/under/costume/cybersleek
	name = "sleek modern coat"
	desc = "A modern-styled coat typically worn on more urban planets, made with a neo-laminated fiber lining."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "cyberpunksleek"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	supports_variations_flags = NONE
	can_adjust = FALSE

/obj/item/clothing/under/costume/cybersleek/long
	name = "long modern coat"
	icon_state = "cyberpunksleek_long"
//End Cyberpunk PI port

/obj/item/clothing/under/costume/arthur
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "dutch assistant uniform"
	desc = "Dedicate yourself to something better. To loyalty, honour, for it only dies when everyone abandons it."
	icon_state = "arthur_morgan"

/obj/item/clothing/under/pants/tactical
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	name = "tactical pants"
	desc = "A pair of tactical pants, designed for military use."
	icon_state = "tactical_pants"

/obj/item/clothing/under/syndicate/tacticool/sensors
	name = "tacticool turtleneck"
	desc = "A snug turtleneck, supposedly an offbrand version of Nanotrasen's own."
	icon_state = "tactifool"
	inhand_icon_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

/obj/item/clothing/under/syndicate/tacticool/skirt/sensors
	name = "tacticool skirtleneck"
	desc = "A snug turtleneck, supposedly an offbrand version of Nanotrasen's own."
	icon_state = "tactifool_skirt"
	inhand_icon_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT

/obj/item/clothing/under/syndicate/bloodred/sleepytime/sensors
	has_sensor = HAS_SENSORS
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

/obj/item/clothing/under/syndicate/tacticool/CtrlShiftClick(mob/user) //This handles changing the design between new and old for skirtle and turtlenecks
	. = ..()
	if(user.canUseTopic(src, TRUE, FALSE, TRUE, TRUE, FALSE))
		var/style = "tactifool"
		var/choice = tgui_alert(user, "Choose the a reskin for [src]", "Reskin Outfit", list("Black (Original)", "Navy (New)"))
		switch (choice)
			if("Black (Original)")
				if(istype(src, /obj/item/clothing/under/syndicate/tacticool/skirt))
					style = "tactifool_arcade_skirt"
				else
					style = "tactifool_arcade"
			if ("Navy (New)")
				if(istype(src, /obj/item/clothing/under/syndicate/tacticool/skirt))
					style = "tactifool_skirt"
				else
					style = "tactifool"
		if(QDELETED(src))
			return
		icon_state = style
		update_icon()
		to_chat(user, "[src] is now skinned as '[choice]'.")
