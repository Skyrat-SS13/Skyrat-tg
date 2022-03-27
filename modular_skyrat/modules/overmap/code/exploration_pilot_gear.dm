/obj/item/clothing/under/exp_pilot
	name = "shuttle crew flight suit"
	desc = "A shuttle pilot's flight suit made to regulation standards, mildly resistant to shrapnel and will not burn off in a fire."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "exp_pilot"
	inhand_icon_state = "miner"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	armor = list(MELEE = 0, BULLET = 10, LASER = 10,ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	can_adjust = FALSE

/obj/item/clothing/suit/armor/vest/exp_pilot
	name = "shuttle crew flak vest"
	desc = "Produced by the same people who make mining's exploration suits, just with the legs and arms removed and painted a snazzy black and orange."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "exp_pilot"
	inhand_icon_state = "armor"
	clothing_flags = THICKMATERIAL
	armor = list(MELEE = 20, BULLET = 30, LASER = 0, ENERGY = 10, BOMB = 40, BIO = 0, FIRE = 50, ACID = 50, WOUND = 20)
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	resistance_flags = FIRE_PROOF | ACID_PROOF
	// Todo: Make a suit extinguisher component upstream
	var/next_extinguish = 0
	var/extinguish_cooldown = 10 SECONDS
	var/extinguishes_left = 5

/obj/item/clothing/suit/armor/vest/exp_pilot/examine(mob/user)
	. = ..()
	. += span_notice("There are [extinguishes_left] extinguisher charges left in this suit.")

/obj/item/clothing/suit/armor/vest/exp_pilot/proc/Extinguish(mob/living/carbon/human/human_mob)
	if(!istype(human_mob))
		return

	if(human_mob.on_fire)
		if(extinguishes_left)
			if(next_extinguish > world.time)
				return
			next_extinguish = world.time + extinguish_cooldown
			extinguishes_left--
			human_mob.visible_message(span_warning("[human_mob]'s suit automatically extinguishes [human_mob.p_them()]!"),span_warning("Your suit automatically extinguishes you."))
			human_mob.extinguish_mob()
			new /obj/effect/particle_effect/water(get_turf(human_mob))

/obj/item/clothing/suit/armor/vest/exp_pilot/attackby(obj/item/ext_refill, mob/user, params)
	..()
	if (istype(ext_refill, /obj/item/extinguisher_refill))
		if (extinguishes_left == 5)
			to_chat(user, span_notice("The inbuilt extinguisher is full."))
		else
			extinguishes_left = 5
			to_chat(user, span_notice("You refill the suit's built-in extinguisher, using up the cartridge."))
			qdel(ext_refill)

/obj/item/clothing/head/helmet/exp_pilot
	name = "shuttle pilot flight helmet"
	desc = "A bulky flight helmet meant to protect a pilot's head from impacts, shrapnel, and harsh words, warranty void if the last use case happens."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "exp_pilot"
	inhand_icon_state = "helmetalt"
	clothing_flags = THICKMATERIAL
	flash_protect = FLASH_PROTECTION_FLASH
	armor = list(MELEE = 20, BULLET = 30, LASER = 0, ENERGY = 10, BOMB = 40, BIO = 0, FIRE = 50, ACID = 50, WOUND = 20)
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT_OFF
	resistance_flags = FIRE_PROOF | ACID_PROOF
	dog_fashion = null

/obj/item/clothing/head/helmet/exp_pilot/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_HEAD)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		ADD_TRAIT(user, TRAIT_DIAGNOSTIC_HUD, HELMET_TRAIT)
		hud.add_hud_to(user)
		balloon_alert(user, "helmet diagnostic hud enabled")

/obj/item/clothing/head/helmet/exp_pilot/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user
	if(human_user.get_item_by_slot(ITEM_SLOT_HEAD) == src && !QDELETED(src)) //This can be called as a part of destroy
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		REMOVE_TRAIT(human_user, TRAIT_DIAGNOSTIC_HUD, HELMET_TRAIT)
		hud.remove_hud_from(human_user)
		balloon_alert(human_user, "helmet diagnostic hud disabled")

/obj/item/clothing/gloves/color/black/expeditionary_corps/exp_pilot
	name = "shuttle crew PSC gloves"
	desc = "Temperature insulated black gloves with a mounted PSC, or personal survival computer, provides instructions on several skills for emergencies."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "exp_pilot"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	clothing_traits = list(TRAIT_QUICK_CARRY, TRAIT_FASTMED, TRAIT_QUICK_BUILD)

/obj/item/clothing/shoes/combat/exp_pilot
	name = "shuttle crew armored boots"
	desc = "Similar in construction to jackboots, but with added thin sheets of plasteel to keep those feet safe from getting crushed by several tons of titanium in a crash."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "exp_pilot"
	inhand_icon_state = "exp_corps"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list(MELEE = 20, BULLET = 30, LASER = 0, ENERGY = 10, BOMB = 40, BIO = 0, FIRE = 50, ACID = 50, WOUND = 20)

/obj/item/storage/belt/military/exp_pilot
	name = "shuttle crew chest rig"
	desc = "A series of small pouches and mounts for equipment a shuttle's crew could need, especially in times of emergency."
	icon_state = "explorer2"
	worn_icon_state = "explorer2"

/obj/item/storage/belt/military/exp_pilot/PopulateContents()
	. = ..()
	new /obj/item/storage/belt/storage_pouch/emergency_tools(src)
	new /obj/item/storage/belt/storage_pouch/emergency_supplies(src)
	new /obj/item/knife/combat/survival(src)
	new /obj/item/wrench(src)
	new /obj/item/crowbar/red(src)
	new /obj/item/weldingtool/mini(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)

/obj/item/storage/belt/storage_pouch/emergency_tools
	name = "specialized toolkit pouch"

/obj/item/storage/belt/storage_pouch/emergency_tools/PopulateContents()
	. = ..()
	new /obj/item/flashlight/seclite(src)
	new /obj/item/stock_parts/cell/crank(src)
	new /obj/item/analyzer(src)
	new /obj/item/gps/mining(src)
	new /obj/item/mining_scanner(src)
	new /obj/item/lighter(src)

/obj/item/storage/belt/storage_pouch/emergency_supplies
	name = "medical and food supply pouch"

/obj/item/storage/belt/storage_pouch/emergency_supplies/PopulateContents()
	. = ..()
	new /obj/item/stack/medical/suture(src)
	new /obj/item/stack/medical/mesh(src)
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/storage/pill_bottle/iron(src)
	new /obj/item/food/sustenance_bar/wonka(src)
	new /obj/item/reagent_containers/food/drinks/waterbottle/large(src)

/obj/item/storage/belt/storage_pouch/emergency_communication
	name = "communication and location supply pouch"

/obj/item/storage/belt/storage_pouch/emergency_communication/PopulateContents()
	. = ..()
	new /obj/item/clothing/mask/whistle(src)
	new /obj/item/radio(src)
	new /obj/item/stack/cable_coil/five(src)
	new /obj/item/circuitboard/machine/spaceship_navigation_beacon(src)
	new /obj/item/stack/sheet/iron/five(src)
	new /obj/item/screwdriver(src)

/obj/item/storage/backpack/ert/exp_pilot
	name = "shuttle crew expedition backpack"
	desc = "A modified security backpack, made to withstand the potentially harsh environments of the exoplanets known to be near the station."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "exp_pilot"
	worn_icon_state = "exp_pilot"
	inhand_icon_state = "securitypack"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/backpack/ert/exp_pilot/PopulateContents()
	. = ..()
	new /obj/item/storage/belt/storage_pouch/emergency_communication(src)

/obj/item/clothing/head/beret/cargo/exp_pilot
	name = "shuttle crew beret"
	desc = "A beret that marks someone as being a part of a shuttle crew, though this usually does not mean much."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	icon_state = "beret_badge"
	greyscale_colors = "#91744D#E6E6E6"

/obj/item/storage/bag/garment/exp_pilot
	name = "shuttle pilot's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to a shuttle's pilot."

/obj/item/storage/bag/garment/exp_pilot/PopulateContents()
	new /obj/item/storage/backpack/ert/exp_pilot(src)
	new /obj/item/storage/belt/military/exp_pilot(src)
	new /obj/item/clothing/shoes/combat/exp_pilot(src)
	new /obj/item/clothing/gloves/color/black/expeditionary_corps/exp_pilot(src)
	new /obj/item/clothing/head/helmet/exp_pilot(src)
	new /obj/item/clothing/suit/armor/vest/exp_pilot(src)
	new /obj/item/clothing/under/exp_pilot(src)
	new /obj/item/clothing/glasses/meson/engine(src)
	new /obj/item/clothing/mask/gas/glass(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)

/obj/item/storage/bag/garment/exp_crew
	name = "shuttle crew's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to a shuttle's crew member."

/obj/item/storage/bag/garment/exp_crew/PopulateContents()
	new /obj/item/storage/backpack/ert/exp_pilot(src)
	new /obj/item/storage/belt/military/exp_pilot(src)
	new /obj/item/clothing/shoes/combat/exp_pilot(src)
	new /obj/item/clothing/gloves/color/black/expeditionary_corps/exp_pilot(src)
	new /obj/item/clothing/head/beret/cargo/exp_pilot(src)
	new /obj/item/clothing/suit/armor/vest/exp_pilot(src)
	new /obj/item/clothing/under/exp_pilot(src)
	new /obj/item/clothing/glasses/meson/engine(src)
	new /obj/item/clothing/mask/gas/glass(src)
	new /obj/item/tank/internals/emergency_oxygen/double(src)

/// Fawkes bawkes
/obj/structure/closet/crate/cardboard/fops
	name = "\improper Hightail Fleet box"
	desc = "Presumably for holding foxes, but the instructions manual didn't come with it."
	icon = 'modular_skyrat/modules/overmap/icons/cardboard_crate.dmi'
	icon_state = "cardboard_fox"
