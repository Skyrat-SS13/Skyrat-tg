/datum/uplink_item/explosives/goosenade
	name = "Flock of Geese"
	desc = "Our intern was showing us a funny video about geese attacking people. Do you want some?"
	cost = 4
	progression_minimum = 10 MINUTES
	item = /obj/item/grenade/clusterbuster/spawner_goose

/obj/item/grenade/clusterbuster/spawner_goose
	name = "flock of geese"
	payload = /obj/item/grenade/spawnergrenade/goose

/obj/item/grenade/spawnergrenade/goose
	name = "goose delivery grenade"
	spawner_type = /mob/living/simple_animal/hostile/retaliate/goose/territorial
	deliveryamt = 3

/mob/living/simple_animal/hostile/retaliate/goose/territorial
	name = "territorial goose"
	faction = list("goose")
	attack_same = FALSE
	taunt_chance = 100
	emote_taunt = list("hisses", "honks")
	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
