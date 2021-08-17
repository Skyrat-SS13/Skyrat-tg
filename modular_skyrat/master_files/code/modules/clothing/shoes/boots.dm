/obj/item/clothing/shoes/jackboots/sec
	name = "Security Issue Jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. Has a fancy metal plate built into the heel, to assert your dominance."
	icon_state = "jackboots"
	inhand_icon_state = "jackboots"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	strip_delay = 30
	equip_delay_other = 50
	resistance_flags = NONE
	permeability_coefficient = 0.05 //Thick soles, and covers the ankle
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	can_be_tied = TRUE //Very Important

/obj/item/clothing/shoes/jackboots/sec/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/suitstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/suitstep2.ogg'=1), 40, falloff_exponent = SOUND_FALLOFF_EXPONENT)
