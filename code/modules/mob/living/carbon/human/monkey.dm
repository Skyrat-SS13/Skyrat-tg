/mob/living/carbon/human/species/monkey
	icon_state = "monkey" //for mapping
	race = /datum/species/monkey
	ai_controller = /datum/ai_controller/monkey

/mob/living/carbon/human/species/monkey/Initialize(mapload, cubespawned = FALSE, mob/spawner)
	ADD_TRAIT(src, TRAIT_BORN_MONKEY, INNATE_TRAIT)
	if (cubespawned)
		var/cap = CONFIG_GET(number/monkeycap)
		if (LAZYLEN(SSmobs.cubemonkeys) > cap)
			if (spawner)
				to_chat(spawner, span_warning("Bluespace harmonics prevent the spawning of more than [cap] monkeys on the station at one time!"))
			return INITIALIZE_HINT_QDEL
		SSmobs.cubemonkeys += src
	return ..()

/mob/living/carbon/human/species/monkey/Destroy()
	SSmobs.cubemonkeys -= src
	return ..()

/mob/living/carbon/human/species/monkey/angry
	ai_controller = /datum/ai_controller/monkey/angry

/mob/living/carbon/human/species/monkey/angry/Initialize(mapload, cubespawned = FALSE, mob/spawner)
	. = ..()
	if(prob(10))
		INVOKE_ASYNC(src, PROC_REF(give_ape_escape_helmet))

/// Gives our funny monkey an Ape Escape hat reference
/mob/living/carbon/human/species/monkey/angry/proc/give_ape_escape_helmet()
	var/obj/item/clothing/head/helmet/toggleable/justice/escape/helmet = new(src)
	equip_to_slot_or_del(helmet, ITEM_SLOT_HEAD)
	helmet.attack_self(src) // todo encapsulate toggle

GLOBAL_DATUM(the_one_and_only_punpun, /mob/living/carbon/human/species/monkey/punpun)

/mob/living/carbon/human/species/monkey/punpun
	name = "Pun Pun" //C A N O N
	unique_name = FALSE
	use_random_name = FALSE
	ai_controller = /datum/ai_controller/monkey/pun_pun
	/// If we had one of the rare names in a past life
	var/ancestor_name
	/// The number of times Pun Pun has died since he was last gibbed
	var/ancestor_chain = 1
	var/relic_hat //Note: these two are paths
	var/relic_mask
	var/memory_saved = FALSE

/mob/living/carbon/human/species/monkey/punpun/Initialize(mapload)
	Read_Memory()

	var/name_to_use = name

	if(ancestor_name)
		name_to_use = ancestor_name
		if(ancestor_chain > 1)
			name_to_use += " \Roman[ancestor_chain]"
	else if(prob(10))
		name_to_use = pick(list("Professor Bobo", "Deempisi's Revenge", "Furious George", "King Louie", "Dr. Zaius", "Jimmy Rustles", "Dinner", "Lanky"))
		if(name_to_use == "Furious George")
			ai_controller = /datum/ai_controller/monkey/angry //hes always mad

	. = ..()

	if(!GLOB.the_one_and_only_punpun && mapload)
		GLOB.the_one_and_only_punpun = src
	// 1 Pun Pun should exist
	REGISTER_REQUIRED_MAP_ITEM(1, 1)

	fully_replace_character_name(real_name, name_to_use)

	//These have to be after the parent new to ensure that the monkey
	//bodyparts are actually created before we try to equip things to
	//those slots
	if(ancestor_chain > 1)
		generate_fake_scars(rand(ancestor_chain, ancestor_chain * 4))
	if(relic_hat)
		equip_to_slot_or_del(new relic_hat, ITEM_SLOT_HEAD)
	if(relic_mask)
		equip_to_slot_or_del(new relic_mask, ITEM_SLOT_MASK)
	equip_to_slot_or_del(new /obj/item/clothing/under/suit/waiter(src), ITEM_SLOT_ICLOTHING)

/mob/living/carbon/human/species/monkey/punpun/Destroy()
	if(GLOB.the_one_and_only_punpun == src)
		GLOB.the_one_and_only_punpun = null

	return ..()

/mob/living/carbon/human/species/monkey/punpun/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	if(!stat && SSticker.current_state == GAME_STATE_FINISHED && !memory_saved)
		Write_Memory(FALSE, FALSE)
		memory_saved = TRUE

	return ..()

/mob/living/carbon/human/species/monkey/punpun/death(gibbed)
	if(!memory_saved)
		Write_Memory(TRUE, gibbed)

	return ..()

/mob/living/carbon/human/species/monkey/punpun/proc/Read_Memory()
	if(fexists("data/npc_saves/Punpun.sav")) //legacy compatability to convert old format to new
		var/savefile/S = new /savefile("data/npc_saves/Punpun.sav")
		S["ancestor_name"] >> ancestor_name
		S["ancestor_chain"] >> ancestor_chain
		S["relic_hat"] >> relic_hat
		S["relic_mask"] >> relic_mask
		fdel("data/npc_saves/Punpun.sav")
	else
		var/json_file = file("data/npc_saves/Punpun.json")
		if(!fexists(json_file))
			return
		var/list/json = json_decode(file2text(json_file))
		ancestor_name = json["ancestor_name"]
		ancestor_chain = json["ancestor_chain"]
		relic_hat = json["relic_hat"]
		relic_mask = json["relic_hat"]

/mob/living/carbon/human/species/monkey/punpun/Write_Memory(dead, gibbed)
	. = ..()
	if(!.)
		return
	var/json_file = file("data/npc_saves/Punpun.json")
	var/list/file_data = list()
	if(gibbed)
		file_data["ancestor_name"] = null
		file_data["ancestor_chain"] = null
		file_data["relic_hat"] = null
		file_data["relic_mask"] = null
	else
		file_data["ancestor_name"] = ancestor_name ? ancestor_name : real_name
		file_data["ancestor_chain"] = dead ? ancestor_chain + 1 : ancestor_chain
		file_data["relic_hat"] = head ? head.type : null
		file_data["relic_mask"] = wear_mask ? wear_mask.type : null
	fdel(json_file)
	WRITE_FILE(json_file, json_encode(file_data))
