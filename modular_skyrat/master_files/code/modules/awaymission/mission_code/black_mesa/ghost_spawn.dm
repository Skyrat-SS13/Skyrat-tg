/obj/effect/mob_spawn/ghost_role/human/black_mesa
	name = "Research Facility Science Team"
	prompt_name = "a research facility scientist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/science_team
	you_are_text = "You are a scientist in a top secret government facility. You blacked out. Now, you have woken up to the horrors that lay within."
	flavour_text = "You are a scientist in a top secret government facility. You blacked out. Now, you have woken up to the horrors that lay within."
	restricted_species = list(/datum/species/human)

/datum/outfit/science_team
	name = "Scientist"
	uniform = /obj/item/clothing/under/misc/hlscience
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
	access = list(ACCESS_RND)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/guard
	name = "Research Facility Security Guard"
	prompt_name = "a research facility guard"
	outfit = /datum/outfit/security_guard
	you_are_text = "You are a security guard in a top secret government facility. You blacked out. Now, you have woken up to the horrors that lay within. DO NOT TRY TO EXPLORE THE LEVEL. STAY AROUND YOUR AREA."

/obj/item/clothing/under/rank/security/peacekeeper/junior/sol/blackmesa
	name = "security guard uniform"
	desc = "About that beer I owe'd ya!"

/datum/outfit/security_guard
	name = "Security Guard"
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/junior/sol/blackmesa
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
	access = list(ACCESS_SEC_DOORS, ACCESS_SECURITY, ACCESS_AWAY_SEC)

/obj/effect/mob_spawn/ghost_role/human/black_mesa/hecu
	name = "HECU"
	prompt_name = "a tactical squad member"
	outfit = /datum/outfit/hecu
	you_are_text = "You are an elite tactical squad deployed into the research facility to contain the infestation."
	flavour_text = "You and four other marines have been selected for a guard duty near one of the Black Mesa's entrances. You haven't heard much from the north-west post, except for the sounds of gunshots, and their radios went silent. On top of that, your escape helicopter, if any, was shot down mid-flight, and another one won't arrive so soon; with your machinegunner being shot down with a precise headshot by something, or SOMEONE. You are likely on your own, at least for now."
	important_text = "Do not try to explore the level unless Vanguard is dead. Stay around your area. Allowed races are humans and IPCs."
	restricted_species = list(/datum/species/human, /datum/species/robotic/ipc)

/obj/item/clothing/under/rank/security/officer/hecu
	name = "hecu jumpsuit"
	desc = "A tactical HECU fatigues for regular troops complete with USMC belt buckle." ///SIR YES SIR HOORAH
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "hecu_uniform"
	inhand_icon_state = "r_suit"
	uses_advanced_reskins = FALSE
	unique_reskin = null

/obj/item/storage/backpack/ert/odst/hecu
	name = "hecu backpack"

/datum/outfit/hecu
	name = "HECU Grunt"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	head = /obj/item/clothing/head/helmet/space/hev_suit/pcv
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/space/hev_suit/pcv
	suit_store = /obj/item/gun/ballistic/automatic/m16
	belt = /obj/item/storage/belt/military/assault
	ears = /obj/item/radio/headset
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = /obj/item/binoculars
	back = /obj/item/storage/backpack/ert/odst/hecu
	backpack_contents = list(
		/obj/item/storage/box/survival/radio,
		/obj/item/ammo_box/magazine/m16 = 3,
		/obj/item/storage/medkit/emergency,
		/obj/item/storage/box/hecu_rations,
		/obj/item/gun/ballistic/automatic/pistol/g17/mesa,
		/obj/item/ammo_box/magazine/multi_sprite/g17 = 2,
		/obj/item/knife/combat
	)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/hecu

/datum/outfit/hecu/post_equip(mob/living/carbon/human/equipped_human, visualsOnly)
	. = ..()
	equipped_human.faction |= FACTION_HECU

/datum/id_trim/hecu
	assignment = "HECU Soldier"
	trim_state = "trim_securityofficer"
	access = list(ACCESS_SEC_DOORS, ACCESS_SECURITY, ACCESS_AWAY_SEC)
