/obj/effect/mob_spawn/ghost_role/human/black_mesa
	name = "Research Facility Science Team"
	prompt_name = "a research facility scientist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/science_team
	you_are_text = "You are a scientist in a top secret government facility. You blacked out. Now, you have woken up to the horrors that lay within."
	flavour_text = "You are a scientist in a top secret government facility. You blacked out. Now, you have woken up to the horrors that lay within."
	restricted_species = list(/datum/species/human)
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/black_mesa/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.remove_language(/datum/language/common)

/datum/outfit/science_team
	name = "Scientist"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/radio, /obj/item/reagent_containers/glass/beaker)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/science_team

/datum/outfit/science_team/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.faction |= FACTION_BLACKMESA

/datum/id_trim/science_team
	assignment = "Science Team Scientist"
	trim_state = "trim_scientist"
	access = list(ACCESS_SCIENCE)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/guard
	name = "Research Facility Security Guard"
	prompt_name = "a research facility guard"
	outfit = /datum/outfit/security_guard
	you_are_text = "You are a security guard in a top secret government facility. You blacked out. Now, you have woken up to the horrors that lay within. DO NOT TRY TO EXPLORE THE LEVEL. STAY AROUND YOUR AREA."

/obj/effect/mob_spawn/ghost_role/human/black_mesa/guard/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.remove_language(/datum/language/common)

/obj/item/clothing/under/rank/security/peacekeeper/sol/traffic/blackmesa
	name = "security guard uniform"
	desc = "About that beer I owe'd ya!"

/datum/outfit/security_guard
	name = "Security Guard"
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/sol/traffic/blackmesa
	head = /obj/item/clothing/head/helmet/blueshirt
	gloves = /obj/item/clothing/gloves/color/black
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/radio, /obj/item/gun/ballistic/automatic/pistol/g17/mesa, /obj/item/ammo_box/magazine/multi_sprite/g17)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/security_guard

/datum/outfit/security_guard/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.faction |= FACTION_BLACKMESA

/datum/id_trim/security_guard
	assignment = "Security Guard"
	trim_state = "trim_securityofficer"
	access = list(ACCESS_BRIG_ENTRANCE, ACCESS_SECURITY, ACCESS_AWAY_SEC)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu
	name = "HECU"
	prompt_name = "a tactical squad member"
	outfit = /datum/outfit/hecu
	you_are_text = "You are an elite tactical squad deployed into the research facility to contain the infestation."
	flavour_text = "You and four other marines have been selected for a guard duty near one of the Black Mesa's entrances. You haven't heard much from the north-west post, except for the sounds of gunshots, and their radios went silent. On top of that, your escape helicopter was shot down mid-flight, and another one won't arrive so soon; with your machinegunner being shot down with a precise headshot by something, or SOMEONE. You are likely on your own, at least for now."
	important_text = "Do not try to explore the level unless Vanguard is dead or cooperative. Stay around your area. Allowed races are humans and IPCs."
	restricted_species = list(/datum/species/human, /datum/species/robotic/ipc)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.remove_language(/datum/language/common)
	spawned_human.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_MIND)

/obj/item/clothing/under/rank/security/officer/hecu
	name = "urban camouflage BDU"
	desc = "A baggy military camouflage uniform with an ERDL pattern. The range of whites and greys proves useful in urban environments."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "hecu_uniform"
	inhand_icon_state = "r_suit"
	uses_advanced_reskins = FALSE
	unique_reskin = null

/obj/item/storage/backpack/ert/odst/hecu
	name = "hecu backpack"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_digi.dmi'
	icon_state = "hecu_pack"
	worn_icon_state = "hecu_pack"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Olive" = list(
			RESKIN_ICON_STATE = "hecu_pack",
			RESKIN_WORN_ICON_STATE = "hecu_pack"
		),
		"Black" = list(
			RESKIN_ICON_STATE = "hecu_pack_black",
			RESKIN_WORN_ICON_STATE = "hecu_pack_black"
		),
	)

/obj/item/storage/belt/military/assault/hecu
	name = "hecu warbelt"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_digi.dmi'
	icon_state = "hecu_belt"
	worn_icon_state = "hecu_belt"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Olive" = list(
			RESKIN_ICON_STATE = "hecu_belt",
			RESKIN_WORN_ICON_STATE = "hecu_belt"
		),
		"Black" = list(
			RESKIN_ICON_STATE = "hecu_belt_black",
			RESKIN_WORN_ICON_STATE = "hecu_belt_black"
		),
	)

/datum/outfit/hecu
	name = "HECU Grunt"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/military/assault/hecu
	ears = /obj/item/radio/headset/headset_faction
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/reagent_containers/food/drinks/flask
	r_pocket = /obj/item/flashlight/flare
	back = /obj/item/storage/backpack/ert/odst/hecu
	backpack_contents = list(
		/obj/item/storage/box/survival/radio,
		/obj/item/storage/medkit/emergency,
		/obj/item/storage/box/hecu_rations,
		/obj/item/knife/combat,
		/obj/item/armament_points_card/hecu
	)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/hecu
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/datum/outfit/hecu/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.faction |= FACTION_HECU

/datum/id_trim/hecu
	assignment = "HECU Marine"
	trim_state = "trim_securityofficer"
	access = list(ACCESS_BRIG_ENTRANCE, ACCESS_SECURITY, ACCESS_AWAY_SEC)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu/leader
	name = "HECU Squad Leader"
	prompt_name = "a tactical squad's leader"
	outfit = /datum/outfit/hecu/leader
	you_are_text = "You are an elite tactical squad's leader deployed into the research facility to contain the infestation."
	flavour_text = "You and four other marines have been selected for a guard duty near one of the Black Mesa's entrances. Due to the lack of any real briefing, and your briefing officer's death during the landing, you have no clue as to what your objective is, so you and your group have set up a camp here. You haven't heard much from the north-west post, except for the sounds of gunshots, and their radios went silent. On top of that, your escape helicopter was shot down mid-flight, and another one won't arrive so soon; with your machinegunner being shot down with a precise headshot by something, or SOMEONE. You are likely on your own, at least for now."
	important_text = "Keep and sustain marines' morale and discipline. Delegate responsibilities at the best of your abilities. Do not try to explore the level unless Vanguard is dead or cooperative. Stay around your area. Allowed races are humans and IPCs."
	restricted_species = list(/datum/species/human, /datum/species/robotic/ipc)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu/leader/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.grant_language(/datum/language/neorusskya, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.grant_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.remove_language(/datum/language/common)

/datum/outfit/hecu/leader
	name = "HECU Captain"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	head = /obj/item/clothing/head/beret/sec
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	belt = /obj/item/storage/belt/military/assault/hecu
	ears = /obj/item/radio/headset/headset_faction/bowman/captain
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = /obj/item/binoculars
	back = /obj/item/storage/backpack/ert/odst/hecu
	backpack_contents = list(
		/obj/item/storage/box/survival/radio,
		/obj/item/storage/medkit/emergency,
		/obj/item/storage/box/hecu_rations,
		/obj/item/knife/combat,
		/obj/item/armament_points_card/hecu,
		/obj/item/book/granter/martial/cqc
	)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/hecu_leader
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/datum/outfit/hecu/leader/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.faction |= FACTION_HECU

/datum/id_trim/hecu_leader
	assignment = "HECU Captain"
	trim_state = "trim_securityofficer"
	access = list(ACCESS_BRIG_ENTRANCE, ACCESS_SECURITY, ACCESS_AWAY_SEC)
