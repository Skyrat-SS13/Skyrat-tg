/obj/item/melee/tomahawk
	name = "expeditionary tomahawk"
	desc = "A very sharp axe blade upon a short fibremetal handle."
	icon = 'modular_skyrat/modules/exp_corps/icons/tomahawk.dmi'
	icon_state = "tomahawk"
	inhand_icon_state = "tomahawk"
	lefthand_file = 'modular_skyrat/modules/exp_corps/icons/tomahawk_l.dmi'
	righthand_file = 'modular_skyrat/modules/exp_corps/icons/tomahawk_r.dmi'
	worn_icon = 'modular_skyrat/modules/exp_corps/icons/tomahawk_worn.dmi'
	flags_1 = CONDUCT_1
	force = 25
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 25
	throw_speed = 4
	throw_range = 8
	embedding = list("pain_mult" = 6, "embed_chance" = 60, "fall_chance" = 10)
	attack_verb_continuous = list("chops", "tears", "lacerates", "cuts")
	attack_verb_simple = list("chop", "tear", "lacerate", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/melee/tomahawk/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 70, 100)
