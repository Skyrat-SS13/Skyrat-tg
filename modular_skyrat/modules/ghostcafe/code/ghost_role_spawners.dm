/obj/effect/mob_spawn/ghost_role/robot
	name = "Ghost Role Robot"
	prompt_name = "a robot"
	you_are_text = "You are a robot. This probably shouldn't be happening."
	flavour_text = "You are a robot. This probably shouldn't be happening."
	mob_type = /mob/living/silicon/robot

/obj/effect/mob_spawn/ghost_role/robot/Initialize()
	. = ..()

/obj/effect/mob_spawn/ghost_role/robot/equip(mob/living/silicon/robot/R)
	. = ..()

/obj/effect/mob_spawn/ghost_role/robot/ghostcafe
	name = "Cafe Robotic Storage"
	prompt_name = "a ghost cafe robot"
	uses = -1
	icon = 'modular_skyrat/modules/ghostcafe/icons/robot_storage.dmi'
	icon_state = "robostorage"
	mob_name = "a cafe robot"
	anchored = TRUE
	density = FALSE
	you_are_text = "You are a Cafe Robot!"
	flavour_text = "Who could have thought? This awesome local cafe accepts cyborgs too!"
	mob_type = /mob/living/silicon/robot/model/roleplay

/obj/effect/mob_spawn/ghost_role/robot/ghostcafe/special(mob/living/silicon/robot/new_spawn)
	. = ..()
	if(new_spawn.client)
		new_spawn.custom_name = null
		new_spawn.updatename(new_spawn.client)
		new_spawn.gender = NEUTER
		var/area/A = get_area(src)
		//new_spawn.AddElement(/datum/element/ghost_role_eligibility, free_ghosting = TRUE) SKYRAT PORT -- Needs to be completely rewritten
		new_spawn.AddElement(/datum/element/dusts_on_catatonia)
		new_spawn.AddElement(/datum/element/dusts_on_leaving_area,list(A.type, /area/misc/hilbertshotel, /area/centcom/holding/cafe, /area/centcom/holding/cafewar, /area/centcom/holding/cafebotany,
		/area/centcom/holding/cafebuild, /area/centcom/holding/cafevox, /area/centcom/holding/cafedorms, /area/centcom/holding/cafepark, /area/centcom/holding/cafeplumbing))
		ADD_TRAIT(new_spawn, TRAIT_SIXTHSENSE, GHOSTROLE_TRAIT)
		ADD_TRAIT(new_spawn, TRAIT_FREE_GHOST, GHOSTROLE_TRAIT)
		to_chat(new_spawn,span_warning("<b>Ghosting is free!</b>"))
		var/datum/action/toggle_dead_chat_mob/D = new(new_spawn)
		D.Grant(new_spawn)

/obj/effect/mob_spawn/ghost_role/human/ghostcafe
	name = "Cafe Sleeper"
	prompt_name = "a ghost cafe human"
	uses = -1
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_name = "a cafe visitor"
	density = FALSE
	outfit = /datum/outfit
	you_are_text = "You are a Cafe Visitor!"
	flavour_text = "You are off-duty and have decided to visit your favourite cafe. Enjoy yourself."
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/ghostcafe/special(mob/living/carbon/human/new_spawn)
	. = ..()
	if(new_spawn.client)
		var/area/A = get_area(src)
		new_spawn.AddElement(/datum/element/dusts_on_catatonia)
		new_spawn.AddElement(/datum/element/dusts_on_leaving_area,list(A.type, /area/misc/hilbertshotel, /area/centcom/holding/cafe, /area/centcom/holding/cafewar, /area/centcom/holding/cafebotany,
		/area/centcom/holding/cafebuild, /area/centcom/holding/cafevox, /area/centcom/holding/cafedorms, /area/centcom/holding/cafepark, /area/centcom/holding/cafeplumbing))
		ADD_TRAIT(new_spawn, TRAIT_SIXTHSENSE, GHOSTROLE_TRAIT)
		ADD_TRAIT(new_spawn, TRAIT_FREE_GHOST, GHOSTROLE_TRAIT)
		to_chat(new_spawn,span_warning("<b>Ghosting is free!</b>"))
		var/datum/action/toggle_dead_chat_mob/D = new(new_spawn)
		new_spawn.put_in_hands(new /obj/item/storage/box/syndie_kit/chameleon/ghostcafe, LEFT_HANDS, forced = TRUE)
		new_spawn.equip_outfit_and_loadout(/datum/outfit/ghostcafe, new_spawn.client.prefs, FALSE, null)
		SSquirks.AssignQuirks(new_spawn, new_spawn.client, TRUE, TRUE, null, FALSE, new_spawn)
		D.Grant(new_spawn)

/datum/outfit/ghostcafe
	name = "ID, jumpsuit and shoes"
	uniform = /obj/item/clothing/under/color/random
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/advanced/ghost_cafe

/datum/action/toggle_dead_chat_mob
	icon_icon = 'icons/mob/mob.dmi'
	button_icon_state = "ghost"
	name = "Toggle deadchat"
	desc = "Turn off or on your ability to hear ghosts."

/datum/action/toggle_dead_chat_mob/Trigger(trigger_flags)
	if(!..())
		return 0
	var/mob/M = target
	if(HAS_TRAIT_FROM(M,TRAIT_SIXTHSENSE,GHOSTROLE_TRAIT))
		REMOVE_TRAIT(M,TRAIT_SIXTHSENSE,GHOSTROLE_TRAIT)
		to_chat(M,span_notice("You're no longer hearing deadchat."))
	else
		ADD_TRAIT(M,TRAIT_SIXTHSENSE,GHOSTROLE_TRAIT)
		to_chat(M,span_notice("You're once again hearing deadchat."))

/obj/item/storage/box/syndie_kit/chameleon/ghostcafe
	name = "cafe costuming kit"
	desc = "Look just the way you did in life - or better!"

/obj/item/storage/box/syndie_kit/chameleon/ghostcafe/PopulateContents() // Doesn't contain a PDA, for isolation reasons.
	new /obj/item/clothing/under/chameleon(src)
	new /obj/item/clothing/suit/chameleon(src)
	new /obj/item/clothing/gloves/chameleon(src)
	new /obj/item/clothing/shoes/chameleon(src)
	new /obj/item/clothing/glasses/chameleon(src)
	new /obj/item/clothing/head/chameleon(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/clothing/neck/chameleon(src)
	new /obj/item/storage/backpack/chameleon(src)
	new /obj/item/storage/belt/chameleon(src)
	new /obj/item/card/id/advanced/chameleon(src)

/obj/item/card/id/advanced/ghost_cafe
	name = "\improper Cafe ID"
	desc = "An ID straight from God."
	icon_state = "card_centcom"
	worn_icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	registered_age = null
	trim = /datum/id_trim/admin
	wildcard_slots = WILDCARD_LIMIT_ADMIN

