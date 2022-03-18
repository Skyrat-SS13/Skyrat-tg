/obj/item/melee/baton
	knockdown_time = 0 SECONDS
	stamina_damage = 20

/obj/item/melee/baton/security
	knockdown_time = 0 SECONDS
	stamina_damage = 20

/obj/item/melee/baton/security/apply_stun_effect_end(mob/living/target)
	return FALSE

/obj/item/melee/baton/telescopic/contractor_baton
	knockdown_time = 2.5 SECONDS
