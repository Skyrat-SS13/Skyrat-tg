/obj/item/forging/reagent_weapon
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_items.dmi'
	var/list/imbued_reagent = list()

/obj/item/forging/reagent_weapon/Initialize()
	. = ..()
	create_reagents(500, INJECTABLE | REFILLABLE)

/obj/item/forging/reagent_weapon/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag)
		return
	if(isliving(target) && imbued_reagent)
		var/mob/living/livingMob = target
		for(var/reagentList in imbued_reagent)
			livingMob.reagents.add_reagent(reagentList, 3)

/obj/item/forging/reagent_weapon/sword
	name = "reagent sword"
	desc = "A sword that can be imbued with a reagent."
	force = 20
	icon_state = "sword"
	inhand_icon_state = "sword"
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED

/obj/item/forging/reagent_weapon/staff
	name = "reagent staff"
	desc = "A staff that can be imbued with a reagent."
	force = 0
	icon_state = "staff"
	inhand_icon_state = "staff"
	lefthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_l.dmi'
	righthand_file = 'modular_skyrat/modules/reagent_forging/icons/mob/forge_weapon_r.dmi'
	throwforce = 0
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF
	attack_verb_continuous = list("bonks", "bashes", "whacks", "pokes", "prods")
	attack_verb_simple = list("bonk", "bash", "whack", "poke", "prod")
