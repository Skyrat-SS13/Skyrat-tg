/obj/item/clothing/shoes/jackboots/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/suitstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/suitstep2.ogg'=1), 40, falloff_exponent = SOUND_FALLOFF_EXPONENT)
