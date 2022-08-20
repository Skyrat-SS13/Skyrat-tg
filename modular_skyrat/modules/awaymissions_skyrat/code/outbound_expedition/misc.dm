/obj/machinery/porta_turret/syndicate/scrapper_drone
	name = "rusted turret"
	desc = "A ballistic machine gun auto-turret, it looks thoroughly delapidated, but still seems to work."
	faction = list("scrapper")

/obj/effect/mob_spawn/corpse/human/prisoner
	name = "Prisoner"
	outfit = /datum/outfit/job/prisoner
	icon_state = "corpseminer"

/obj/effect/mob_spawn/corpse/human/clock_cultist
	name = "Clock Cultist"
	outfit = /datum/outfit/clock_cultist/corpse
	icon_state = "corpseminer"

/datum/outfit/clock_cultist/corpse/post_equip(mob/living/carbon/human/equipped, visualsOnly)
	. = ..()
	equipped.faction |= "cult"

/obj/effect/mob_spawn/corpse/human/blood_cultist
	name = "Blood Cultist"
	outfit = /datum/outfit/cultist/corpse
	icon_state = "corpseminer"

/datum/outfit/cultist/corpse
	name = "Cultist (Corpse)"
	r_hand = null
