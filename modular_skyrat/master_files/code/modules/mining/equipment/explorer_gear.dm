/obj/item/clothing/suit/hooded/cloak/drake
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor_digi.dmi'

/obj/item/clothing/suit/hooded/cloak/goliath
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor_digi.dmi'
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/head/hooded/cloakhood/goliath
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT


/datum/armor/hifl_armor
	melee = 60
	bullet = 15
	laser = 30
	energy = 30
	bomb = 70
	bio = 60
	fire = 100
	acid = 100

/obj/item/clothing/suit/hifl_suit
	name = "\improper H.I.F.L. suit"
	desc = "The High-Impact Fauna Laminate Suit: A suit designed to withstand a wide variety of planetary hazards. There's an engraving on one of it's shoulders: \"Not for use in Hadean-grade planets.\". Cheap higher-ups."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	icon_state = "hifl_suit"
	armor_type = /datum/armor/hifl_armor
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF

	body_parts_covered = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	equip_delay_self = 1.4 SECONDS
	heat_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	supports_variations_flags = DIGITIGRADE_OPTIONAL
	transparent_protection = HIDESUITSTORAGE | HIDEJUMPSUIT
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/suit_digi.dmi'

	allowed = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/resonator,
		/obj/item/mining_scanner,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/gun/energy/recharge/kinetic_accelerator,
		/obj/item/pickaxe
	)
	clothing_flags = THICKMATERIAL
	slowdown = 1.5

/obj/item/clothing/suit/hifl_suit/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, maxamount = 1, upgrade_item = /obj/item/stack/sheet/animalhide/ashdrake) //how dare i assume we have sane argument names
	AddComponent(/datum/component/toggle_attached_clothing, \
		deployable_type = /obj/item/clothing/mask/hifl, \
		equipped_slot = ITEM_SLOT_MASK, \
		action_name = "Toggle Mask", \
		pre_creation_check = CALLBACK(src, PROC_REF(pre_creation_check)), \
		on_deployed = CALLBACK(src, PROC_REF(make_sound)), \
		on_removed = CALLBACK(src, PROC_REF(make_sound)), \
		destroy_on_removal = TRUE \
	)

/obj/item/clothing/suit/hifl_suit/proc/pre_creation_check()
	var/mob/living/user = usr // THIS SUCKS I HATE IT BUT ON_DEPLOYED DOESNT PASS USER
	if(!istype(user))
		return TRUE //assume coder shenanigans

	user.add_movespeed_modifier(/datum/movespeed_modifier/hifl_equip)
	var/success = do_after(user, 1.3 SECONDS, src, IGNORE_USER_LOC_CHANGE | IGNORE_HELD_ITEM)
	user.remove_movespeed_modifier(/datum/movespeed_modifier/hifl_equip)
	return success

/obj/item/clothing/suit/hifl_suit/proc/make_sound()
	playsound(src, 'sound/mecha/mechmove03.ogg', 25, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)

/datum/movespeed_modifier/hifl_equip
	multiplicative_slowdown = 1.5


/obj/item/clothing/mask/hifl
	name = "\improper H.I.F.L. mask"
	desc = "Just like the good ol' days."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	icon_state = "hifl_mask"
	armor_type = /datum/armor/hifl_armor
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF

	cold_protection = HEAD
	flags_cover = MASKCOVERSMOUTH
	flags_inv = HIDEFACIALHAIR | HIDESNOUT
	heat_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'

	clothing_flags = THICKMATERIAL | MASKINTERNALS
	clothing_traits = list(TRAIT_ASHSTORM_IMMUNE) // :3

/obj/item/clothing/mask/hifl/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, type) //closest thing to "facehugger protection" you can have on masks, but jank as FUCK
	AddComponent(/datum/component/armor_plate, maxamount = 1, upgrade_item = /obj/item/stack/sheet/animalhide/ashdrake)
