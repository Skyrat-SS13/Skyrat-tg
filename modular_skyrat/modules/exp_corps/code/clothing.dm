/obj/item/clothing/under/rank/expeditionary_corps
	name = "expeditionary corps uniform"
	icon_state = "exp_corps"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 10, BIO = 10, FIRE = 30, ACID = 30, WOUND = 10)
	strip_delay = 70
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/storage/belt/military/expeditionary_corps
	name = "expeditionary corps chest rig"
	desc = "A set of tactical webbing worn by expeditionary corps."
	icon_state = "webbing_exp_corps"
	worn_icon_state = "webbing_exp_corps"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Webbing" = list(
			RESKIN_ICON_STATE = "webbing_exp_corps",
			RESKIN_WORN_ICON_STATE = "webbing_exp_corps"
		),
		"Belt" = list(
			RESKIN_ICON_STATE = "belt_exp_corps",
			RESKIN_WORN_ICON_STATE = "belt_exp_corps"
		),
	)

/obj/item/storage/belt/military/expeditionary_corps/combat_tech
	name = "combat tech's chest rig"

/obj/item/storage/belt/military/expeditionary_corps/combat_tech/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/military/expeditionary_corps/field_medic
	name = "field medic's chest rig"

/obj/item/storage/belt/military/expeditionary_corps/field_medic/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/circular_saw/field_medic(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/cautery(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/bonesetter(src)

/obj/item/storage/belt/military/expeditionary_corps/pointman
	name = "pointman's chest rig"

/obj/item/storage/belt/military/expeditionary_corps/pointman/PopulateContents()
	new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)
	new /obj/item/stack/sheet/plasteel(src,5)
	new /obj/item/reagent_containers/glass/bottle/morphine(src)

/obj/item/storage/belt/military/expeditionary_corps/marksman
	name = "marksman's chest rig"

/obj/item/storage/belt/military/expeditionary_corps/marksman/PopulateContents()
	new /obj/item/binoculars(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_robust(src)
	new /obj/item/lighter(src)
	new /obj/item/clothing/mask/bandana/skull(src)

/obj/item/clothing/shoes/combat/expeditionary_corps
	name = "expeditionary corps boots"
	desc = "High speed, low drag combat boots."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "exp_corps"
	inhand_icon_state = "exp_corps"
	armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 40, BIO = 0, FIRE = 80, ACID = 100, WOUND = 30)

/obj/item/clothing/gloves/color/black/expeditionary_corps
	name = "expeditionary corps gloves"
	icon_state = "exp_corps"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 50)

/obj/item/clothing/gloves/color/chief_engineer/expeditionary_corps
	name = "expeditionary corps insulated gloves"
	icon_state = "exp_corps_eng"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	worn_icon_state = "exp_corps"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 50)

/obj/item/clothing/gloves/color/latex/nitrile/expeditionary_corps
	name = "expeditionary corps medic gloves"
	icon_state = "exp_corps_med"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	worn_icon_state = "exp_corps"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 50)

/obj/item/storage/backpack/duffelbag/expeditionary_corps
	name = "expeditionary corps bag"
	desc = "A large bag for holding extra tactical supplies."
	icon_state = "exp_corps"
	inhand_icon_state = "backpack"
	icon = 'modular_skyrat/modules/exp_corps/icons/backpack.dmi'
	worn_icon = 'modular_skyrat/modules/exp_corps/icons/mob_backpack.dmi'
	slowdown = 0
	resistance_flags = FIRE_PROOF
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Backpack" = list(
			RESKIN_ICON_STATE = "exp_corps",
			RESKIN_WORN_ICON_STATE = "exp_corps"
		),
		"Belt" = list(
			RESKIN_ICON_STATE = "exp_corps_satchel",
			RESKIN_WORN_ICON_STATE = "exp_corps_satchel"
		),
	)

/obj/item/clothing/suit/armor/vest/expeditionary_corps
	name = "expeditionary corps armor vest"
	desc = "An armored vest that provides decent protection against most types of damage."
	icon_state = "exp_corps"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 40, BIO = 0, FIRE = 80, ACID = 100, WOUND = 30)
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	allowed = list(
		/obj/item/melee,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/knife,
		/obj/item/reagent_containers,
		/obj/item/restraints/handcuffs,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman
		)


/obj/item/clothing/head/helmet/expeditionary_corps
	name = "expeditionary corps helmet"
	desc = "A robust helmet worn by Expeditionary Corps troopers. Alt+click it to toggle the NV system."
	icon_state = "exp_corps"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	armor = list(MELEE = 30, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 30, BIO = 0, FIRE = 80, ACID = 100, WOUND = 30)
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	var/nightvision = FALSE
	var/mob/living/carbon/current_user
	actions_types = list(/datum/action/item_action/toggle_nv)

/datum/action/item_action/toggle_nv
	name = "Toggle Nightvision"

/datum/action/item_action/toggle_nv/Trigger(trigger_flags)
	var/obj/item/clothing/head/helmet/expeditionary_corps/my_helmet = target
	if(!my_helmet.current_user)
		return
	my_helmet.nightvision = !my_helmet.nightvision
	if(my_helmet.nightvision)
		to_chat(owner, span_notice("You flip the NV goggles down."))
		my_helmet.enable_nv()
	else
		to_chat(owner, span_notice("You flip the NV goggles up."))
		my_helmet.disable_nv()
	my_helmet.update_appearance()

/obj/item/clothing/head/helmet/expeditionary_corps/equipped(mob/user, slot)
	. = ..()
	current_user = user

/obj/item/clothing/head/helmet/expeditionary_corps/proc/enable_nv(mob/user)
	if(current_user)
		var/obj/item/organ/eyes/my_eyes = current_user.getorgan(/obj/item/organ/eyes)
		if(my_eyes)
			my_eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
			my_eyes.see_in_dark = 8
			my_eyes.flash_protect = FLASH_PROTECTION_SENSITIVE
		current_user.add_client_colour(/datum/client_colour/glass_colour/lightgreen)

/obj/item/clothing/head/helmet/expeditionary_corps/proc/disable_nv()
	if(current_user)
		var/obj/item/organ/eyes/my_eyes = current_user.getorgan(/obj/item/organ/eyes)
		if(my_eyes)
			my_eyes.lighting_alpha = initial(my_eyes.lighting_alpha)
			my_eyes.see_in_dark = initial(my_eyes.see_in_dark)
			my_eyes.flash_protect = initial(my_eyes.flash_protect)
		current_user.remove_client_colour(/datum/client_colour/glass_colour/lightgreen)
		current_user.update_sight()

/obj/item/clothing/head/helmet/expeditionary_corps/AltClick(mob/user)
	. = ..()
	if(!current_user)
		return
	if(!can_interact(user))
		return

	nightvision = !nightvision
	if(nightvision)
		to_chat(user, span_notice("You flip the NV goggles down."))
		enable_nv()
	else
		to_chat(user, span_notice("You flip the NV goggles up."))
		disable_nv()
	update_appearance()

/obj/item/clothing/head/helmet/expeditionary_corps/dropped(mob/user)
	. = ..()
	disable_nv()
	current_user = null

/obj/item/clothing/head/helmet/expeditionary_corps/Destroy()
	disable_nv()
	current_user = null
	return ..()

/obj/item/clothing/head/helmet/expeditionary_corps/update_icon_state()
	. = ..()
	if(nightvision)
		icon_state = "exp_corps_on"
	else
		icon_state = "exp_corps"
