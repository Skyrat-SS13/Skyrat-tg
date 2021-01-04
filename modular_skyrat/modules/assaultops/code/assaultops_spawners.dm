/obj/effect/mob_spawn/human/syndicate/assops
	name = "Syndicate Assault Guard"
	roundstart = TRUE
	death = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/syndicate_empty
	assignedrole = "Syndicate DS-1 Operative"
	permanent = FALSE
	can_use_alias = TRUE
	any_station_species = TRUE



/obj/effect/mob_spawn/human/syndicate/assops/prison_guard
	name = "Syndicate Prison Guard"
	short_desc = "You are a prison guard aboard the Syndicate facility DS-1."
	flavour_text = "Your job is to keep the prisoners in check and ensure they do not cause trouble. Patrol the prison, DO NOT TAKE ITEMS FROM THE ARMORY."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives."
	outfit = /datum/outfit/syndicate_empty/prison_guard

/datum/outfit/syndicate_empty/prison_guard
	name = "Syndicate Prison Guard"
	head = /obj/item/clothing/head/helmet/swat
	suit = /obj/item/clothing/suit/armor/bulletproof
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	belt = /obj/item/storage/belt/security/full
	implants = list(/obj/item/implant/weapons_auth)
	id = /obj/item/card/id/syndicate

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/loaded
	)

/obj/effect/mob_spawn/human/syndicate/assops/prison_warden
	name = "Syndicate Prison Warden"
	short_desc = "You are a prison warden aboard the Syndicate facility DS-1."
	flavour_text = "Your job is to oversee facility operations and ensure a smooth running prison. You deal with executions and sentencing."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives."
	outfit = /datum/outfit/syndicate_empty/prison_warden

/datum/outfit/syndicate_empty/prison_warden
	name = "Syndicate Prison Warden"
	head = /obj/item/clothing/head/hos/beret/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	belt = /obj/item/storage/belt/security/full
	id = /obj/item/card/id/syndicate

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/loaded
	)

/obj/effect/mob_spawn/human/syndicate/assops/facility_staff
	name = "Syndicate Facility Staff"
	short_desc = "You are a general purpose crewmember aboard the Syndicate facility DS-1."
	flavour_text = "Your job is not combat, but instead is to run the syndicate facilites such as the bar, cooking areas, engineering and janitorial work."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/facility_staff

/datum/outfit/syndicate_empty/facility_staff
	name = "Syndicate Facility Staff"
	suit = /obj/item/clothing/suit/armor/bulletproof
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	id = /obj/item/card/id/syndicate

/obj/effect/mob_spawn/human/syndicate/assops/syndicate_assistant
	name = "Syndicate Assistant"
	short_desc = "You are an assistant aboard the Syndicate facility DS-1."
	flavour_text = "Your job is NOT combat, unless the assault team requires it. Otherwise you are simply there to assist the guards and warden. Or relax."
	important_info = "The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives. DO NOT TOUCH THE ARMORY."
	outfit = /datum/outfit/syndicate_empty/syndicate_assistant

/datum/outfit/syndicate_empty/syndicate_assistant
	name = "Syndicate Assistant"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	ears = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	id = /obj/item/card/id/syndicate



