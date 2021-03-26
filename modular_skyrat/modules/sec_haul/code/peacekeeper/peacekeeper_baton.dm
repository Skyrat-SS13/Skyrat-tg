/obj/item/melee/classic_baton/peacekeeper
	name = "nightstick"
	desc = "A metal-plastic bat, looks like it would REALLY hurt."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	icon_state = "peacekeeper_baton"
	inhand_icon_state = "peacekeeper_baton"
	worn_icon_state = "classic_baton"
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 10
	w_class = WEIGHT_CLASS_NORMAL
	cooldown = 1.5 SECONDS

/obj/item/melee/baton/peacekeeper
	name = "stunstick"
	desc = "An upgraded version of the nightstick, this one has nasty electrical prongs on the end, batteries not included."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	icon_state = "stunbaton"
	attack_verb_continuous = list("whaps")
	attack_verb_simple = list("whap")
	throw_stun_chance = 20
	cell_hit_cost = 1000
	attack_cooldown = 1.5 SECONDS
	stamina_loss_amt = 40
	convertible = FALSE
