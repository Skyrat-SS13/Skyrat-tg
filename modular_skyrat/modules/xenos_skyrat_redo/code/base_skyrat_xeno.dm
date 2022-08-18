/mob/living/carbon/alien/humanoid/skyrat
	name = "rare bugged alien"
	icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/big_xenos.dmi'
	rotate_on_lying = FALSE
	base_pixel_x = -16 //All of the xeno sprites are 64x64, and we want them to be level with the tile they are on, much like oversized quirk users
	var/damage_coeff = 1 //Do we want this xeno to take less damage

/mob/living/carbon/alien/humanoid/skyrat/adjustBruteLoss(amount, updating_health = TRUE, forced = FALSE)
	. = apply_damage(amount * damage_coeff, BRUTE, BODY_ZONE_CHEST)

/mob/living/carbon/alien/humanoid/skyrat/adjustFireLoss(amount, updating_health = TRUE, forced = FALSE)
	. = apply_damage(amount * damage_coeff, BURN, BODY_ZONE_CHEST)

/datum/action/cooldown/alien/skyrat
	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
