/datum/uplink_item/explosives/goosenade
	name = "Flock of Geese"
	desc = "Our intern was showing us a funny video about geese attacking people. Do you want some?"
	cost = 4
	progression_minimum = 10 MINUTES
	item = /obj/item/grenade/clusterbuster/spawner_goose

/obj/item/grenade/clusterbuster/spawner_goose
	name = "Flock of Geese"
	payload = /obj/item/grenade/spawnergrenade/goose

/obj/item/grenade/spawnergrenade/goose
	name = "goose delivery grenade"
	spawner_type = /mob/living/simple_animal/hostile/retaliate/goose/territorial

/mob/living/simple_animal/hostile/retaliate/goose/territorial
	name = "territorial goose"
	faction = list("goose")
	attack_same = FALSE
	taunt_chance = 100
	emote_taunt = list("hisses", "honks")
