/obj/item/uplink/old_radio
	name = "old radio"
	desc = "A dusty and old looking radio."

/obj/item/uplink/old_radio/Initialize(mapload, owner, tc_amount = 0)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "old radio"

//Unrestricted MODs
/obj/item/mod/control/pre_equipped/elite/unrestricted
	req_access = null

//Syndie wep charger kit
/obj/item/storage/box/syndie_kit/recharger
	name = "boxed recharger kit"
	desc = "A sleek, sturdy box used to hold all parts to build a weapons recharger."
	icon_state = "syndiebox"

/obj/item/storage/box/syndie_kit/recharger/PopulateContents()
	new /obj/item/circuitboard/machine/recharger(src)
	new /obj/item/stock_parts/capacitor/quadratic(src)
	new /obj/item/stack/sheet/iron/five(src)
	new /obj/item/stack/cable_coil/five(src)
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/wrench(src)

//Back-up space suit
/obj/item/storage/box/syndie_kit/space_suit
	name = "boxed space suit and helmet"
	desc = "A sleek, sturdy box used to hold an emergency spacesuit."
	icon_state = "syndiebox"
	illustration = "syndiesuit"

/obj/item/storage/box/syndie_kit/space_suit/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_BULKY
	atom_storage.max_slots = 2
	atom_storage.set_holdable(list(
		/obj/item/clothing/head/helmet/space/syndicate,
		/obj/item/clothing/suit/space/syndicate,
		))

/obj/item/storage/box/syndie_kit/space_suit/PopulateContents()
	switch(pick(list("red", "green", "dgreen", "blue", "orange", "black")))
		if("green")
			new /obj/item/clothing/head/helmet/space/syndicate/green(src)
			new /obj/item/clothing/suit/space/syndicate/green(src)
		if("dgreen")
			new /obj/item/clothing/head/helmet/space/syndicate/green/dark(src)
			new /obj/item/clothing/suit/space/syndicate/green/dark(src)
		if("blue")
			new /obj/item/clothing/head/helmet/space/syndicate/blue(src)
			new /obj/item/clothing/suit/space/syndicate/blue(src)
		if("red")
			new /obj/item/clothing/head/helmet/space/syndicate(src)
			new /obj/item/clothing/suit/space/syndicate(src)
		if("orange")
			new /obj/item/clothing/head/helmet/space/syndicate/orange(src)
			new /obj/item/clothing/suit/space/syndicate/orange(src)
		if("black")
			new /obj/item/clothing/head/helmet/space/syndicate/black(src)
			new /obj/item/clothing/suit/space/syndicate/black(src)

//Spy
/obj/item/clothing/suit/jacket/det_suit/noir/armoured
	armor_type = /datum/armor/heister

/obj/item/clothing/head/frenchberet/armoured
	armor_type = /datum/armor/cosmetic_sec

/obj/item/clothing/under/suit/black/armoured
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/clothing/under/suit/black/skirt/armoured
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/storage/belt/holster/detective/dark
	name = "dark leather holster"
	icon_state = "syndicate_holster"

//Robohand
/obj/item/storage/backpack/duffelbag/syndie/robohand/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/robohand(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mm(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/clothing/under/pants/track/robohand(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/glasses/sunglasses/robohand(src)
	new /obj/item/clothing/suit/jacket/trenchcoat/gunman(src)
	new /obj/item/autosurgeon/bodypart/r_arm_robotic(src)
	new /obj/item/autosurgeon/syndicate/esword_arm(src)
	new /obj/item/autosurgeon/syndicate/nodrop(src)


/obj/item/storage/box/syndie_kit/gunman_outfit
	name = "gunman clothing bundle"
	desc = "A box filled with armored and stylish clothing for the aspiring gunmans."

/obj/item/clothing/suit/jacket/trenchcoat/gunman
	name = "leather overcoat"
	desc = "An armored leather overcoat, intended as the go-to wear for any aspiring gunman."
	body_parts_covered = CHEST|GROIN|ARMS
	armor_type = /datum/armor/leather_gunman

/datum/armor/leather_gunman
	melee = 45
	bullet = 40
	laser = 40
	energy = 50
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/under/pants/track/robohand
	name = "badass pants"
	desc = "Strangely firm yet soft black pants, these appear to have some armor padding for added protection."
	armor_type = /datum/armor/clothing_under/robohand

/datum/armor/clothing_under/robohand
	melee = 20
	bullet = 20
	laser = 20
	energy = 20
	bomb = 20

/obj/item/clothing/glasses/sunglasses/robohand
	name = "badass sunglasses"
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks flashes. These ones seem to be bulletproof?"
	body_parts_covered = HEAD //What do you mean glasses don't protect your head? Of course they do. Cyberpunk has flying cars(mostly intentional)!
	armor_type = /datum/armor/sunglasses_robohand

/datum/armor/sunglasses_robohand
	melee = 20
	bullet = 60
	laser = 20
	energy = 20
	bomb = 20
	wound = 5

//More items
/obj/item/guardian_creator/tech/choose/traitor/opfor
	allow_changeling = TRUE

/obj/item/codeword_granter
	name = "codeword manual"
	desc = "A black manual with a red S lovingly inscribed on the cover by only the finest of presses from a factory."
	icon = 'modular_skyrat/modules/opposing_force/icons/items.dmi'
	icon_state = "codeword_book"
	/// Number of charges the book has, limits the number of times it can be used.
	var/charges = 1


/obj/item/codeword_granter/attack_self(mob/living/user)
	if(!isliving(user))
		return

	to_chat(user, span_boldannounce("You start skimming through [src], and feel suddenly imparted with the knowledge of the following code words:"))

	user.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_phrase_regex, "blue", src)
	user.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_response_regex, "red", src)
	to_chat(user, "<b>Code Phrases</b>: [jointext(GLOB.syndicate_code_phrase, ", ")]")
	to_chat(user, "<b>Code Responses</b>: [span_red("[jointext(GLOB.syndicate_code_response, ", ")]")]")

	use_charge(user)


/obj/item/codeword_granter/attack(mob/living/attacked_mob, mob/living/user)
	if(!istype(attacked_mob) || !istype(user))
		return

	if(attacked_mob == user)
		attack_self(user)
		return

	playsound(loc, SFX_PUNCH, 25, TRUE, -1)

	if(attacked_mob.stat == DEAD)
		attacked_mob.visible_message(span_danger("[user] smacks [attacked_mob]'s lifeless corpse with [src]."), span_userdanger("[user] smacks your lifeless corpse with [src]."), span_hear("You hear smacking."))
	else
		attacked_mob.visible_message(span_notice("[user] teaches [attacked_mob] by beating [attacked_mob.p_them()] over the head with [src]!"), span_boldnotice("As [user] hits you with [src], you feel suddenly imparted with the knowledge of some [span_red("specific words")]."), span_hear("You hear smacking."))
		attacked_mob.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_phrase_regex, "blue", src)
		attacked_mob.AddComponent(/datum/component/codeword_hearing, GLOB.syndicate_code_response_regex, "red", src)
		to_chat(attacked_mob, span_boldnotice("You feel suddenly imparted with the knowledge of the following code words:"))
		to_chat(attacked_mob, "<b>Code Phrases</b>: [span_blue("[jointext(GLOB.syndicate_code_phrase, ", ")]")]")
		to_chat(attacked_mob, "<b>Code Responses</b>: [span_red("[jointext(GLOB.syndicate_code_response, ", ")]")]")
		use_charge(user)


/obj/item/codeword_granter/proc/use_charge(mob/user)
	charges--

	if(!charges)
		var/turf/src_turf = get_turf(src)
		src_turf.visible_message(span_warning("The cover and contents of [src] start shifting and changing! It slips out of your hands!"))
		new /obj/item/book/manual/random(src_turf)
		qdel(src)


/obj/item/antag_granter
	icon = 'modular_skyrat/modules/opposing_force/icons/items.dmi'
	/// What antag datum to give
	var/antag_datum = /datum/antagonist/traitor
	/// What to tell the user when they use the granter
	var/user_message = ""


/obj/item/antag_granter/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()

	if(target_mob != user) // As long as you're attacking yourself it counts.
		return
	attack_self(user)


/obj/item/antag_granter/attack_self(mob/user, modifiers)
	. = ..()
	if(!isliving(user) || !user.mind)
		return FALSE

	to_chat(user, span_notice(user_message))
	user.mind.add_antag_datum(antag_datum)
	qdel(src)
	return TRUE

/obj/item/antag_granter/changeling
	name = "viral injector"
	desc = "A blue injector filled with some viscous, red substance. It has no markings apart from an orange warning stripe near the large needle."
	icon_state = "changeling_injector"
	antag_datum = /datum/antagonist/changeling
	user_message = "As you inject the substance into yourself, you start to feel... <span class='red'><b>better</b></span>."


/obj/item/antag_granter/heretic
	name = "strange book"
	desc = "A purple book with a green eye on the cover. You swear it's looking at you...."
	icon_state = "heretic_granter"
	antag_datum = /datum/antagonist/heretic
	user_message = "As you open the book, you see a great flash as <span class='hypnophrase'>the world becomes all the clearer for you</span>."

/obj/item/antag_granter/clock_cultist
	name = "brass contraption"
	desc = "A cogwheel-shaped device of brass, with a glass lens floating, suspended in the center."
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	icon_state = "vanguard_cogwheel"
	antag_datum = /datum/antagonist/clock_cultist/solo
	user_message = "A whirring fills your ears as <span class='brass'>knowledge of His Eminence fills your mind</span>."

/obj/item/antag_granter/clock_cultist/attack_self(mob/user, modifiers)
	. = ..()
	if(!.)
		return FALSE

	var/obj/item/clockwork/clockwork_slab/slab = new
	user.put_in_hands(slab, FALSE)
