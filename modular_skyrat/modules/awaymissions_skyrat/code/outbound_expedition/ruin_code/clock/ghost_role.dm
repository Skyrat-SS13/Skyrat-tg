/obj/effect/mob_spawn/ghost_role/human/golem/clock_cult
	name = "inert bronze golem shell"
	desc = "A humanoid, bronze shell of a golem, held together with a unique power."
	prompt_name = "a Ratvar golem"
	you_are_text = "You are a bronze golem. Work with the other cultists to defend your sanctum."
	flavour_text = "You are a golem constructed of Ratvar's holy metal, held together by their will. Their directive rings through your mind, \"Defend my temple at all costs.\""
	can_transfer = FALSE
	mob_species = /datum/species/golem/bronze

/obj/effect/mob_spawn/ghost_role/human/golem/clock_cult/special(mob/living/new_spawn, mob/mob_possessor)
	. = ..()
	new_spawn.faction |= "clock"

/obj/effect/mob_spawn/ghost_role/human/clock_cult
	name = "Clock Cultist"
	prompt_name = "a clock cultist"
	you_are_text = "You are a cultist of Ratvar."
	flavour_text = "You went to sleep with your golem shells, cast away to find a new location so you may bring Ratvar back. Now, you have awoken"
	outfit = /datum/outfit/clock_cultist
	spawner_job_path = /datum/job/clock_cultist

/obj/effect/mob_spawn/ghost_role/human/clock_cult/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	spawned_mob.faction |= "clock"

/datum/job/clock_cultist
	title = ROLE_CLOCK_CULTIST
	policy_index = ROLE_CLOCK_CULTIST

/datum/outfit/clock_cultist
	name = "Clock Cultist"
	uniform = /obj/item/clothing/under/color/orange
	shoes = /obj/item/clothing/shoes/bronze
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/satchel
	l_hand = /obj/item/gun/ballistic/rifle/lionhunter // sue me
	r_hand = /obj/item/ammo_box/a762/lionhunter
	suit = /obj/item/clothing/suit/chaplainsuit/armor/clock
	head = /obj/item/clothing/head/helmet/chaplain/clock

/datum/outfit/clock_cultist/corpse
	name = "Clock Cultist (Corpse)"
	l_hand = null
	r_hand = null
	suit = /obj/item/clothing/suit/costume/bronze
	head = /obj/item/clothing/head/bronze
	gloves = null
