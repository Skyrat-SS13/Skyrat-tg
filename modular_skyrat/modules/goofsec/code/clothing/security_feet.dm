/**
 * New security boots.
 *
 * Specific type for approved boot sounds as well as a custom security look.
 */
/obj/item/clothing/shoes/jackboots/security
	name = "security jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "security_boots"
	inhand_icon_state = "security_boots"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'

/obj/item/clothing/shoes/jackboots/security/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/footstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/footstep2.ogg'=1, 'modular_skyrat/master_files/sound/effects/footstep3.ogg'=1), 50, falloff_exponent = 20)
