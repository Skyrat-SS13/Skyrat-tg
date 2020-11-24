//blueshield's baton
/obj/item/melee/baton/blueshieldprod
	name = "\improper The electrifryer"
	desc = "A non-lethal takedown is always the most silent way to eliminate resistance."
	icon = 'modular_skyrat/modules/blueshield/icons/obj/stunprod.dmi'
	icon_state = "bsprod"
	inhand_icon_state = "bsprod"
	obj_flags = UNIQUE_RENAME
	lefthand_file = 'modular_skyrat/modules/blueshield/icons/mob/inhands/weapons/melee_lefthand.dmi' //pissholder
	righthand_file = 'modular_skyrat/modules/blueshield/icons/mob/inhands/weapons/melee_righthand.dmi' //placeholder fuck#
	cell_hit_cost = 600
	slot_flags = null //you'll have to put it on a belt or whatever
	force = 11
	apply_stun_delay = 1 SECONDS //Buff intead of stamina
	attack_cooldown = 2 SECONDS
	w_class = WEIGHT_CLASS_SMALL //small but packs a PUNCH.
	preload_cell_type = /obj/item/stock_parts/cell/high/plus

/obj/item/melee/baton/blueshieldprod/attack(mob/M, mob/living/carbon/human/user)
	if(!HAS_TRAIT(user, TRAIT_MINDSHIELD))
		to_chat(user, "<span class='danger'>A red light on the baton flashes!</span>")
		return TRUE
	..()
