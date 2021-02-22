/datum/hud_data
	var/icon              // If set, overrides ui_style.
	var/has_a_intent = TRUE  // Set to draw intent box.
	var/has_m_intent = TRUE  // Set to draw move intent box.
	var/has_warnings = TRUE  // Set to draw environment warnings.
	var/has_pressure = TRUE  // Draw the pressure indicator.
	var/has_nutrition = TRUE // Draw the nutrition indicator.
	var/has_bodytemp = TRUE  // Draw the bodytemp indicator.
	var/has_hands = TRUE     // Set to draw hands.
	var/has_drop = TRUE      // Set to draw drop button.
	var/has_throw = TRUE     // Set to draw throw button.
	var/has_resist = TRUE    // Set to draw resist button.
	var/has_internals = TRUE // Set to draw the internals toggle button.
	var/has_guns	=	TRUE	//Set to draw the gun/aiming toggle buttons
	var/list/equip_slots = list() // Checked by mob_can_equip().
	var/has_healthbar = FALSE	//Big healthbar across top of screen


	// Contains information on the position and tag for all inventory slots
	// to be drawn for the mob. This is fairly delicate, try to avoid messing with it
	// unless you know exactly what it does.
	var/list/gear = list(
		"i_clothing" =   list("loc" = ui_iclothing, "name" = "Uniform",      "slot" = slot_w_uniform, "state" = "center", "toggle" = TRUE),
		"o_clothing" =   list("loc" = ui_oclothing, "name" = "Suit",         "slot" = slot_wear_suit, "state" = "suit",   "toggle" = TRUE),
		"mask" =         list("loc" = ui_mask,      "name" = "Mask",         "slot" = slot_wear_mask, "state" = "mask",   "toggle" = TRUE),
		"gloves" =       list("loc" = ui_gloves,    "name" = "Gloves",       "slot" = slot_gloves,    "state" = "gloves", "toggle" = TRUE),
		"eyes" =         list("loc" = ui_glasses,   "name" = "Glasses",      "slot" = slot_glasses,   "state" = "glasses","toggle" = TRUE),
		"l_ear" =        list("loc" = ui_l_ear,     "name" = "Left Ear",     "slot" = slot_l_ear,     "state" = "ears",   "toggle" = TRUE),
		"r_ear" =        list("loc" = ui_r_ear,     "name" = "Right Ear",    "slot" = slot_r_ear,     "state" = "ears",   "toggle" = TRUE),
		"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = TRUE),
		"shoes" =        list("loc" = ui_shoes,     "name" = "Shoes",        "slot" = slot_shoes,     "state" = "shoes",  "toggle" = TRUE),
		"suit storage" = list("loc" = ui_sstore1,   "name" = "Suit Storage", "slot" = slot_s_store,   "state" = "suitstore"),
		"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id,   "state" = "id"),
		"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		"belt" =         list("loc" = ui_belt,      "name" = "Belt",         "slot" = slot_belt,      "state" = "belt")
		)

/datum/hud_data/New()
	..()
	for(var/slot in gear)
		equip_slots |= gear[slot]["slot"]

	if(has_hands)
		equip_slots |= slot_l_hand
		equip_slots |= slot_r_hand
		equip_slots |= slot_handcuffed

	if(slot_back in equip_slots)
		equip_slots |= slot_in_backpack

	if(slot_w_uniform in equip_slots)
		equip_slots |= slot_tie

	equip_slots |= slot_legcuffed

/datum/hud_data/diona
	has_internals = 0
	gear = list(
		"i_clothing" =   list("loc" = ui_iclothing, "name" = "Uniform",      "slot" = slot_w_uniform, "state" = "center", "toggle" = TRUE),
		"o_clothing" =   list("loc" = ui_shoes,     "name" = "Suit",         "slot" = slot_wear_suit, "state" = "suit",   "toggle" = TRUE),
		"l_ear" =        list("loc" = ui_gloves,    "name" = "Ear",          "slot" = slot_l_ear,     "state" = "ears",   "toggle" = TRUE),
		"head" =         list("loc" = ui_oclothing, "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = TRUE),
		"suit storage" = list("loc" = ui_sstore1,   "name" = "Suit Storage", "slot" = slot_s_store,   "state" = "suitstore"),
		"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id,   "state" = "id"),
		"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		"belt" =         list("loc" = ui_belt,      "name" = "Belt",         "slot" = slot_belt,      "state" = "belt")
		)


/datum/hud_data/nabber
	has_internals = 0
	gear = list(
		"i_clothing" =   list("loc" = ui_iclothing, "name" = "Uniform",      "slot" = slot_w_uniform, "state" = "center", "toggle" = TRUE),
		"o_clothing" =   list("loc" = ui_shoes,     "name" = "Suit",         "slot" = slot_wear_suit, "state" = "suit",   "toggle" = TRUE),
		"l_ear" =        list("loc" = ui_oclothing, "name" = "Ear",          "slot" = slot_l_ear,     "state" = "ears",   "toggle" = TRUE),
		"gloves" =       list("loc" = ui_gloves,    "name" = "Gloves",       "slot" = slot_gloves,    "state" = "gloves", "toggle" = TRUE),
		"suit storage" = list("loc" = ui_sstore1,   "name" = "Suit Storage", "slot" = slot_s_store,   "state" = "suitstore"),
		"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id,   "state" = "id"),
		"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		"belt" =         list("loc" = ui_belt,      "name" = "Belt",         "slot" = slot_belt,      "state" = "belt")
		)

/datum/hud_data/monkey
	gear = list(
		"i_clothing" =   list("loc" = ui_iclothing, "name" = "Uniform",      "slot" = slot_w_uniform, "state" = "center", "toggle" = TRUE),
		"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = TRUE),
		"mask" =         list("loc" = ui_shoes,     "name" = "Mask", "slot" = slot_wear_mask, "state" = "mask",  "toggle" = TRUE),
		"back" =         list("loc" = ui_sstore1,   "name" = "Back", "slot" = slot_back,      "state" = "back"),
		)


/datum/hud_data/necromorph
	gear = list()
	has_internals = FALSE
	has_nutrition = FALSE
	has_guns = FALSE
	has_healthbar = TRUE

/datum/hud_data/necromorph/lurker
	gear = list(
		"back" =         list("loc" = ui_sstore1,   "name" = "Back", "slot" = slot_back,      "state" = "back"),
		)

/datum/hud_data/necromorph/slasher
	gear = list(
		"i_clothing" =   list("loc" = ui_iclothing, "name" = "Uniform",      "slot" = slot_w_uniform, "state" = "center", "toggle" = TRUE),
		//"o_clothing" =   list("loc" = ui_oclothing, "name" = "Suit",         "slot" = slot_wear_suit, "state" = "suit",   "toggle" = TRUE),
		//"mask" =         list("loc" = ui_mask,      "name" = "Mask",         "slot" = slot_wear_mask, "state" = "mask",   "toggle" = TRUE),
		//"gloves" =       list("loc" = ui_gloves,    "name" = "Gloves",       "slot" = slot_gloves,    "state" = "gloves", "toggle" = TRUE),
		//"eyes" =         list("loc" = ui_glasses,   "name" = "Glasses",      "slot" = slot_glasses,   "state" = "glasses","toggle" = TRUE),
		//"l_ear" =        list("loc" = ui_l_ear,     "name" = "Left Ear",     "slot" = slot_l_ear,     "state" = "ears",   "toggle" = TRUE),
		//"r_ear" =        list("loc" = ui_r_ear,     "name" = "Right Ear",    "slot" = slot_r_ear,     "state" = "ears",   "toggle" = TRUE),
		//"head" =         list("loc" = ui_head,      "name" = "Hat",          "slot" = slot_head,      "state" = "hair",   "toggle" = TRUE),
		//"shoes" =        list("loc" = ui_shoes,     "name" = "Shoes",        "slot" = slot_shoes,     "state" = "shoes",  "toggle" = TRUE),
		//"suit storage" = list("loc" = ui_sstore1,   "name" = "Suit Storage", "slot" = slot_s_store,   "state" = "suitstore"),
		//"back" =         list("loc" = ui_back,      "name" = "Back",         "slot" = slot_back,      "state" = "back"),
		"id" =           list("loc" = ui_id,        "name" = "ID",           "slot" = slot_wear_id,   "state" = "id")
		//"storage1" =     list("loc" = ui_storage1,  "name" = "Left Pocket",  "slot" = slot_l_store,   "state" = "pocket"),
		//"storage2" =     list("loc" = ui_storage2,  "name" = "Right Pocket", "slot" = slot_r_store,   "state" = "pocket"),
		//"belt" =         list("loc" = ui_belt,      "name" = "Belt",         "slot" = slot_belt,      "state" = "belt")
		)

/datum/hud_data/necromorph/ubermorph
	has_healthbar = FALSE