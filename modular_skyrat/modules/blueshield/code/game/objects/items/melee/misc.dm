//blueshield's baton
/obj/item/melee/baton/blueshieldprod
	name = "stun baton"
	desc = "A non-lethal takedown is always the most silent way to eliminate resistance."
	icon = 'modular_skyrat/modules/blueshield/icons/obj/stunprod.dmi'
	icon_state = "bsprod"
	inhand_icon_state = "bsprod"
	obj_flags = UNIQUE_RENAME
	lefthand_file = 'modular_skyrat/modules/blueshield/icons/mob/inhands/weapons/melee_lefthand.dmi' //pissholder
	righthand_file = 'modular_skyrat/modules/blueshield/icons/mob/inhands/weapons/melee_righthand.dmi' //placeholder fuck#
	cell_hit_cost = 400 //SKYRAT EDIT CHANGE: cell_hit_cost = 600
	slot_flags = null //you'll have to put it on a belt or whatever
	force = 11
	//apply_stun_delay = 1 SECONDS //Buff intead of stamina SKYRAT EDIT REMOVAL
	//attack_cooldown = 2 SECONDS SKYRAT EDIT REMOVAL
	w_class = WEIGHT_CLASS_SMALL //small but packs a PUNCH.
	preload_cell_type = /obj/item/stock_parts/cell/high/plus
	convertible = FALSE //SKYRAT EDIT ADDITION
