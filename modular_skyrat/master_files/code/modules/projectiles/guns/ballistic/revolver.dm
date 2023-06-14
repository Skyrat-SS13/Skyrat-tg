/obj/item/gun/ballistic/revolver/russian/shoot_self(mob/living/carbon/human/user, affecting = BODY_ZONE_HEAD)
	. = ..()
	user.set_suicide(TRUE)
	user.final_checkout(src)
