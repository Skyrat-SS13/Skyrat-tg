/obj/item/clothing/under/rank/expeditionary_corps
	name = "expeditionary corps uniform"
	icon_state = "exp_corps"
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/uniform.dmi'
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 10, BIO = 10, RAD = 10, FIRE = 30, ACID = 30, WOUND = 10)
	strip_delay = 70
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/storage/belt/military/expeditionary_corps
	name = "expeditionary corps chest rig"
	desc = "A set of tactical webbing worn by expeditionary corps."
	icon_state = "webbing_exp_corps"
	worn_icon_state = "webbing_exp_corps"
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/belt.dmi'

/obj/item/clothing/shoes/combat/expeditionary_corps
	name = "expeditionary corps boots"
	desc = "High speed, low drag combat boots."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/feet.dmi'
	icon_state = "exp_corps"
	inhand_icon_state = "exp_corps"

/obj/item/clothing/gloves/combat/expeditionary_corps
	name = "expeditionary corps gloves"
	icon_state = "exp_corps"
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/hands.dmi'

/obj/item/clothing/gloves/combat/expeditionary_corps
	name = "expeditionary corps gloves"
	icon_state = "exp_corps"
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/hands.dmi'

/obj/item/storage/backpack/duffelbag/expeditionary_corps
	name = "expeditionary corps bag" //SKYRAT EDIT, was "suspicious-looking duffel bag". It's just a black duffel.
	desc = "A large bag for holding extra tactical supplies."
	icon_state = "exp_corps"
	inhand_icon_state = "backpack"
	icon = 'modular_skyrat/modules/exp_corps/icons/backpack.dmi'
	worn_icon = 'modular_skyrat/modules/exp_corps/icons/mob_backpack.dmi'
	slowdown = 0
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/vest/expeditionary_corps
	name = "expeditionary corps armor vest"
	desc = "An armored vest that provides decent protection against most types of damage."
	icon_state = "exp_corps"
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list(MELEE = 40, BULLET = 40, LASER = 20, ENERGY = 40, BOMB = 30, BIO = 40, RAD = 40, FIRE = 80, ACID = 90, WOUND = 10)
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	dog_fashion = null

/obj/item/storage/backpack/duffelbag/syndie/expeditionary_corps
	name = "expeditionary corps duffel bag"
	desc = "A large duffel bag for holding extra expeditionary supplies."
	icon_state = "duffel-syndie"
	inhand_icon_state = "duffel-syndieammo"
	slowdown = 0
	resistance_flags = FIRE_PROOF
	special_desc_requirement = NONE
	special_desc = null

/obj/item/clothing/suit/space/hardsuit/expeditionary_corps
	name = "expeditionary corps hardsuit"
	desc = "An advanced hardsuit designed for exploratory missions."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit-hexp_corps"
	inhand_icon_state = "eng_hardsuit"
	hardsuit_type = "hexp_corps"
	armor = list(MELEE = 40, BULLET = 50, LASER = 30, ENERGY = 40, BOMB = 35, BIO = 100, RAD = 50, FIRE = 50, ACID = 90, WOUND = 25)
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/transforming/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/expeditionary_corps
	jetpack = /obj/item/tank/jetpack/suit
	cell = /obj/item/stock_parts/cell/hyper
	slowdown = 0.5
	hardsuit_tail_colors = list("434", "223", "988")

/obj/item/clothing/head/helmet/space/hardsuit/expeditionary_corps
	name = "expeditionary corps hardsuit helmet"
	desc = "An advanced hardsuit helmet designed for exploratory missions."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit0-hexp_corps"
	inhand_icon_state = "sec_helm"
	hardsuit_type = "hexp_corps"
	armor = list(MELEE = 40, BULLET = 50, LASER = 30, ENERGY = 40, BOMB = 35, BIO = 100, RAD = 50, FIRE = 50, ACID = 90, WOUND = 25)
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags = STOPSPRESSUREDAMAGE
	slowdown = 0.5

/obj/item/clothing/head/helmet/expeditionary_corps
	name = "expeditionary corps helmet"
	desc = "A robust helmet worn by Expeditionary Corps troopers. Alt+click it to toggle the NV system."
	icon_state = "exp_corps"
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	armor = list(MELEE = 35, BULLET = 35, LASER = 30,ENERGY = 40, BOMB = 25, BIO = 0, RAD = 0, FIRE = 50, ACID = 50, WOUND = 10)
	mutant_variants = NONE
	var/nightvision = FALSE
	var/mob/living/carbon/current_user

/obj/item/clothing/head/helmet/expeditionary_corps/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/helmet/expeditionary_corps/equipped(mob/user, slot)
	. = ..()
	current_user = user

/obj/item/clothing/head/helmet/expeditionary_corps/AltClick(mob/user)
	. = ..()
	if(!current_user)
		return
	if(!can_interact(user))
		return
	var/obj/item/organ/eyes/my_eyes = current_user.getorgan(/obj/item/organ/eyes)
	nightvision = !nightvision
	if(nightvision)
		to_chat(user, "<span class='notice'>You flip the NV goggles down.")
		if(my_eyes)
			my_eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
			my_eyes.see_in_dark = 8
			my_eyes.flash_protect = FLASH_PROTECTION_SENSITIVE
		current_user.add_client_colour(/datum/client_colour/glass_colour/lightgreen)
	else
		to_chat(user, "<span class='notice'>You flip the NV goggles up.")
		if(my_eyes)
			my_eyes.lighting_alpha = initial(my_eyes.lighting_alpha)
			my_eyes.see_in_dark = initial(my_eyes.see_in_dark)
			my_eyes.flash_protect = initial(my_eyes.flash_protect)
		current_user.remove_client_colour(/datum/client_colour/glass_colour/lightgreen)
	current_user.update_sight()
	update_appearance()

/obj/item/clothing/head/helmet/expeditionary_corps/dropped(mob/user)
	. = ..()
	if(nightvision)
		var/obj/item/organ/eyes/my_eyes = current_user.getorgan(/obj/item/organ/eyes)
		if(my_eyes)
			my_eyes.lighting_alpha = initial(my_eyes.lighting_alpha)
			my_eyes.see_in_dark = initial(my_eyes.see_in_dark)
			my_eyes.flash_protect = initial(my_eyes.flash_protect)
		current_user.remove_client_colour(/datum/client_colour/glass_colour/lightgreen)
		current_user.update_sight()
	current_user = null

/obj/item/clothing/head/helmet/expeditionary_corps/Destroy()
	if(nightvision)
		var/obj/item/organ/eyes/my_eyes = current_user.getorgan(/obj/item/organ/eyes)
		if(my_eyes)
			my_eyes.lighting_alpha = initial(my_eyes.lighting_alpha)
			my_eyes.see_in_dark = initial(my_eyes.see_in_dark)
			my_eyes.flash_protect = initial(my_eyes.flash_protect)
		current_user.remove_client_colour(/datum/client_colour/glass_colour/lightgreen)
		current_user.update_sight()
	current_user = null
	return ..()

/obj/item/clothing/head/helmet/expeditionary_corps/update_icon_state()
	. = ..()
	if(nightvision)
		icon_state = "exp_corps_on"
	else
		icon_state = "exp_corps"
