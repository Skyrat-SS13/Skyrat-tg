
/datum/eldritch_knowledge/summon/ashy
	name = "Ashen Ritual"
	gain_text = "I combined my principle of hunger with my desire for destruction. And the Nightwatcher knew my name."
	desc = "You can now summon an Ash Man by transmutating a pile of ash, a stomach, and a book."
	cost = 1
	required_atoms = list(/obj/effect/decal/cleanable/ash,/obj/item/organ/stomach,/obj/item/book)
	mob_to_summon = /mob/living/simple_animal/hostile/eldritch/ash_spirit
	next_knowledge = list(/datum/eldritch_knowledge/summon/stalker,/datum/eldritch_knowledge/spell/flame_birth)
