//Use this to add item variations

/obj/item/uplink/opfor
	name = "old radio"
	desc = "A dusty and old looking radio."

/obj/item/uplink/opfor/Initialize(mapload, owner, tc_amount = 0)
	. = ..()
	var/datum/component/uplink/hidden_uplink = GetComponent(/datum/component/uplink)
	hidden_uplink.name = "old radio"

/obj/item/reagent_containers/cup/rag/large
	volume = 30
	amount_per_transfer_from_this = 30
	desc = "A damp rag made from a highly absorbant materials. Can hold up to 30u liquids. You can also clean up messes I guess."


/obj/item/storage/box/syndie_kit/gunman_outfit
	name = "gunman clothing bundle"
	desc = "A box filled with armored and stylish clothing for the aspiring gunmans."

/obj/item/clothing/suit/armor/vest/leather/gunman
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

/obj/item/storage/box/syndie_kit/gunman_outfit/PopulateContents() // 45, 40 armor on general without a helmet.
	new /obj/item/clothing/under/pants/black/robohand(src)
	new /obj/item/clothing/glasses/sunglasses/robohand(src)
	new /obj/item/clothing/suit/armor/vest/leather/gunman(src)
	new /obj/item/clothing/shoes/combat(src)

/obj/item/autosurgeon/syndicate/hackerman
	starting_organ = /obj/item/organ/internal/cyberimp/arm/hacker

/obj/item/storage/box/syndie_kit/insurgent
	name = "syndicate insurgent bundle"
	desc = "A box containing everything you need to LARP as your favorite syndicate operative!"

/obj/item/storage/box/syndie_kit/insurgent/PopulateContents()
	new /obj/item/clothing/under/syndicate(src)
	new /obj/item/clothing/gloves/tackler/combat(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/mask/gas/sechailer/swat(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/card/id/advanced/chameleon(src)
	new /obj/item/mod/control/pre_equipped/nuclear(src)

/obj/item/guardiancreator/tech/choose/traitor/opfor
	allowling = TRUE

/obj/item/clothing/suit/toggle/lawyer/black/better/heister
	name = "armored suit jacket"
	desc = "A professional suit jacket, it feels much heavier than a regular jacket. A label on the inside reads \"Nanite-based Self-repairing Kevlar weave\"."
	armor_type = /datum/armor/better_heister
	/// How many hits we can take before the armor breaks, PAYDAY style
	var/armor_stacks = 2

/datum/armor/better_heister
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/toggle/lawyer/black/better/heister/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/shielded/suit, max_charges = armor_stacks, recharge_start_delay = 8 SECONDS, charge_increment_delay = 1 SECONDS, \
	charge_recovery = armor_stacks, lose_multiple_charges = FALSE, starting_charges = armor_stacks, shield_icon_file = null, shield_icon = null)

/obj/item/clothing/suit/toggle/lawyer/black/better/heister/equipped(mob/living/user, slot)
	. = ..()
	if(!(slot & ITEM_SLOT_OCLOTHING))
		return
	RegisterSignal(user, COMSIG_HUMAN_CHECK_SHIELDS, PROC_REF(armor_reaction))

/obj/item/clothing/suit/toggle/lawyer/black/better/heister/proc/armor_reaction(mob/living/carbon/human/owner, atom/movable/hitby, damage = 0, attack_text = "the attack", attack_type = MELEE_ATTACK, armour_penetration = 0)
	if(SEND_SIGNAL(src, COMSIG_ITEM_HIT_REACT, owner, hitby, attack_text, 0, damage, attack_type) & COMPONENT_HIT_REACTION_BLOCK)
		return SHIELD_BLOCK
	return NONE

/obj/item/clothing/gloves/latex/nitrile/heister
	desc = "Pricy sterile gloves that are thicker than latex. Perfect for hiding fingerprints."
	clothing_traits = null
	siemens_coefficient = 0

/obj/item/storage/backpack/duffelbag/heister
	name = "lightweight duffel"
	desc = "A large duffel bag for holding extra things. This one seems to be stitched with extra-light fabric, enabling easier movement."
	slowdown = 0
	resistance_flags = FIRE_PROOF

/obj/item/storage/backpack/duffelbag/heister/PopulateContents()
	var/list/non_cursed_masks = subtypesof(/obj/item/clothing/mask/animal) - /obj/item/clothing/mask/animal/small //abstract
	non_cursed_masks.Remove(GLOB.cursed_animal_masks)
	var/obj/picked_mask = pick(non_cursed_masks)
	var/obj/item/clothing/mask/animal/new_mask = new picked_mask(src)
	new_mask.clothing_flags = VOICEBOX_DISABLED
	new_mask.set_armor(new_mask.get_armor().generate_new_with_specific(list(
		MELEE = 30,
		BULLET = 25,
		LASER = 25,
		ENERGY = 25,
		BOMB = 0,
		BIO = 0,
		FIRE = 100,
		ACID = 100,
	)))
	new /obj/item/clothing/gloves/latex/nitrile/heister(src)
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/suit/toggle/lawyer/black/better/heister(src)
	new /obj/item/restraints/handcuffs/cable/zipties(src)
	new /obj/item/restraints/handcuffs/cable/zipties(src)


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
