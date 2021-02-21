/obj/effect/mob_spawn/robot
	mob_type = /mob/living/silicon/robot
	assignedrole = "Ghost Role"

/obj/effect/mob_spawn/robot/Initialize()
	. = ..()

/obj/effect/mob_spawn/robot/equip(mob/living/silicon/robot/R)
	. = ..()

/obj/effect/mob_spawn/robot/ghostcafe
	name = "Cafe Robotic Storage"
	uses = -1
	icon = 'modular_skyrat/modules/ghostcafe/icons/obj/machines/robot_storage.dmi'
	icon_state = "robostorage"
	mob_name = "a cafe robot"
	roundstart = FALSE
	anchored = TRUE
	density = FALSE
	death = FALSE
	assignedrole = "Cafe Robot"
	short_desc = "You are a Cafe Robot!"
	flavour_text = "Who could have thought? This awesome local cafe accepts cyborgs too!"
	mob_type = /mob/living/silicon/robot/model/roleplay

/obj/effect/mob_spawn/robot/ghostcafe/special(mob/living/silicon/robot/new_spawn)
	if(new_spawn.client)
		new_spawn.updatename(new_spawn.client)
		new_spawn.gender = NEUTER
		var/area/A = get_area(src)
		//new_spawn.AddElement(/datum/element/ghost_role_eligibility, free_ghosting = TRUE) SKYRAT PORT -- Needs to be completely rewritten
		new_spawn.AddElement(/datum/element/dusts_on_catatonia)
		new_spawn.AddElement(/datum/element/dusts_on_leaving_area,list(A.type, /area/hilbertshotel, /area/centcom/holding/cafe, /area/centcom/holding/cafewar, /area/centcom/holding/cafebotany,
		/area/centcom/holding/cafebuild, /area/centcom/holding/cafevox, /area/centcom/holding/cafedorms, /area/centcom/holding/cafepark))