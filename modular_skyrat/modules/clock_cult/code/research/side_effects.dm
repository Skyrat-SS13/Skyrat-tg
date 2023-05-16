/datum/hallucination/delusion/preset/clock
	random_hallucination_weight = 0
	dynamic_icon = TRUE
	delusion_name = "Clock Cultist"
	affects_others = TRUE
	affects_us = TRUE

/datum/hallucination/delusion/preset/clock/make_delusion_image(mob/over_who)
	delusion_icon_file = getFlatIcon(get_dynamic_human_appearance(
		mob_spawn_path = pick(
			/obj/effect/mob_spawn/corpse/human/clock_cultist,
			/obj/effect/mob_spawn/corpse/human/clock_cultist/armored,
			/obj/effect/mob_spawn/corpse/human/clock_cultist/support,
		),
		r_hand = pick(
			/obj/item/clockwork/weapon/brass_battlehammer,
			/obj/item/clockwork/weapon/brass_spear,
			/obj/item/clockwork/weapon/brass_sword,
			/obj/item/clockwork/replica_fabricator,
		),
	))

	return ..()
