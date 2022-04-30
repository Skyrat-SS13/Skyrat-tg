
//PEACEKEEPER HELMET
/obj/item/clothing/head/helmet/sec/peacekeeper
	name = "peacekeeper helmet"
	desc = "A standard issue combat helmet for peacekeeper operators. Has decent tensile strength and armor. Keep your head down."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "peacekeeper_helmet"
	worn_icon_state = "peacekeeper"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/beret/sec/peacekeeper
	name = "peacekeeper beret"
	desc = "A robust beret with the peacekeeper insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	icon_state = "beret_badge"
	greyscale_colors = "#3F3C40#375989"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/beret/sec/peacekeeper/white
	greyscale_config = /datum/greyscale_config/beret
	greyscale_config_worn = /datum/greyscale_config/beret/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/beret/worn/teshari
	icon_state = "beret"
	greyscale_colors = "#EAEAEA"



/obj/item/clothing/head/sec/peacekeeper/sergeant
	name = "peacekeeper sergeant hat"
	desc = "A drill sergeants cap, wearing this increases your loudness. So they say."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "peacekeeper_sergeant_cap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hos/beret/peacekeeper
	name = "head of security's peacekeeper beret"
	desc = "A special beret with the Head of Security's insignia emblazoned on it. A symbol of excellence, a badge of courage, a mark of distinction."
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/beret/sec/navywarden/peacekeeper
	name = "warden's peacekeeper beret"
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3F3C40#FF0000#00AEEF"
	icon_state = "beret_badge_fancy_twist"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper
	name = "peacekeeper hud glasses"
	icon_state = "peacekeeperglasses"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'

//PEACEKEEPER UNIFORM
/obj/item/clothing/under/rank/security/peacekeeper
	name = "peacekeeper uniform"
	desc = "A sleek peacekeeper uniform, made to a price."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "peacekeeper"
	can_adjust = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/peacekeeper/tactical
	name = "tactical peacekeeper uniform"
	desc = "A tactical peacekeeper uniform, woven with a lightweight layer of kevlar to provide minor ballistic and stab protection."
	icon_state = "peacekeeper_tac"

/obj/item/clothing/under/rank/security/peacekeeper/sergeant
	name = "peacekeeper sergeant uniform"
	desc = "A sleek peackeeper uniform, signifying the rank of Sergeant."
	icon_state = "peacekeeper_sergeant"

/obj/item/clothing/under/rank/security/warden/peacekeeper
	name = "peacekeeper wardens suit"
	desc = "A formal security suit for officers complete with Armadyne belt buckle."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "peacekeeper_warden"
	inhand_icon_state = "peacekeeper_warden"

/obj/item/clothing/under/rank/security/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper
	name = "head of security's peacekeeper jumpsuit"
	desc = "A security jumpsuit decorated for those few with the dedication to achieve the position of Head of Security."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "peacekeeper_hos"
	inhand_icon_state = "peacekeeper_hos"

//PEACEKEEPER ARMOR
/obj/item/clothing/suit/armor/vest/peacekeeper
	name = "peacekeeper armor vest"
	desc = "A standard issue peacekeeper armor vest, versatile, lightweight, and most importantly, cheap."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "peacekeeper_armor"
	worn_icon_state = "peacekeeper"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/peacekeeper/black
	name = "black peacekeeper vest"
	icon_state = "peacekeeper_black"
	worn_icon_state = "peacekeeper_black"

/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper
	name = "armored peacekeeper trenchcoat"
	desc = "A trenchcoat enhanced with a special lightweight kevlar. The epitome of tactical plainclothes."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "peacekeeper_trench_hos"
	inhand_icon_state = "hostrench"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/warden/peacekeeper
	name = "warden's peacekeeper jacket"
	desc = "A white jacket with blue  rank pips and body armor strapped on top."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "peacekeeper_trench_warden"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/hooded/wintercoat/security/peacekeeper
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "coatpeacekeeper"
	inhand_icon_state = "coatpeacekeeper"
	desc = "A greyish-blue, armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority.  The zipper tab is a pair of jingly little handcuffs that get annoying after the first ten seconds."
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/peacekeeper

/obj/item/clothing/head/hooded/winterhood/security/peacekeeper
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_peacekeeper"
	desc = "A greyish-blue, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes."

/obj/item/clothing/suit/armor/vest/peacekeeper/spacecoat
	name = "peacekeeper sleek coat"
	desc = "An incredibly stylish and heavy black coat made of synthetic kangaroo leather, padded with durathread and lined with kevlar."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "peacekeeper_spacecoat"
	worn_icon_state = "peacekeeper_spacecoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//PEACEKEEPER GLOVES
/obj/item/clothing/gloves/combat/peacekeeper
	name = "peacekeeper gloves"
	desc = "These tactical gloves are fireproof."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "peacekeeper_gloves"
	worn_icon_state = "peacekeeper"
	siemens_coefficient = 0.5
	permeability_coefficient = 1
	strip_delay = 20
	cold_protection = 0
	min_cold_protection_temperature = null
	heat_protection = 0
	max_heat_protection_temperature = null
	resistance_flags = FLAMMABLE
	armor = null
	cut_type = null

/obj/item/clothing/gloves/tackler/peacekeeper
	name = "peacekeeper gripper gloves"
	desc = "Special gloves that manipulate the blood vessels in the wearer's hands, granting them the ability to launch headfirst into walls."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "peacekeeper_gripper_gloves"

/obj/item/clothing/gloves/krav_maga/sec/peacekeeper
	name = "peacekeeper krav maga gloves"
	desc = "These gloves can teach you to perform Krav Maga using nanochips."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "peacekeeper_gripper_gloves"

//PEACEKEEPER BELTS
/obj/item/storage/belt/security/peacekeeper
	name = "peacekeeper belt"
	desc = "This belt can hold security gear like handcuffs and flashes. It has a holster for a gun."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "peacekeeperbelt"
	worn_icon_state = "peacekeeperbelt"
	content_overlays = FALSE
	component_type = /datum/component/storage/concrete/peacekeeper

/datum/component/storage/concrete/peacekeeper/open_storage(mob/user)
	if(!isliving(user) || !user.CanReach(parent) || user.incapacitated())
		return FALSE
	if(locked)
		to_chat(user, span_warning("[parent] seems to be locked!"))
		return

	var/atom/A = parent

	var/obj/item/gun/ballistic/automatic/pistol/gun_to_draw = locate() in real_location()
	if(!gun_to_draw)
		return ..()
	A.add_fingerprint(user)
	remove_from_storage(gun_to_draw, get_turf(user))
	playsound(parent, 'modular_skyrat/modules/sec_haul/sound/holsterout.ogg', 50, TRUE, -5)
	INVOKE_ASYNC(user, /mob/.proc/put_in_hands, gun_to_draw)
	user.visible_message(span_warning("[user] draws [gun_to_draw] from [parent]!"), span_notice("You draw [gun_to_draw] from [parent]."))


/datum/component/storage/concrete/peacekeeper/mob_item_insertion_feedback(mob/user, mob/M, obj/item/I, override = FALSE)
	if(silent && !override)
		return
	if(rustle_sound)
		if(istype(I, /obj/item/gun/ballistic/automatic/pistol))
			playsound(parent, 'modular_skyrat/modules/sec_haul/sound/holsterin.ogg', 50, TRUE, -5)
		else
			playsound(parent, SFX_RUSTLE, 50, TRUE, -5)

	for(var/mob/viewing in viewers(user, null))
		if(M == viewing)
			to_chat(usr, span_notice("You put [I] [insert_preposition]to [parent]."))
		else if(in_range(M, viewing)) //If someone is standing close enough, they can tell what it is...
			viewing.show_message(span_notice("[M] puts [I] [insert_preposition]to [parent]."), MSG_VISUAL)
		else if(I && I.w_class >= 3) //Otherwise they can only see large or normal items from a distance...
			viewing.show_message(span_notice("[M] puts [I] [insert_preposition]to [parent]."), MSG_VISUAL)

/obj/item/storage/belt/security/peacekeeper/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/disabler,
		/obj/item/melee/baton,
		/obj/item/melee/baton,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/food/donut,
		/obj/item/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/melee/baton/telescopic,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/holosign_creator/security
		))

/obj/item/storage/belt/security/peacekeeper/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	update_icon()

/obj/item/storage/belt/security/webbing/peacekeeper
	name = "peacekeeper webbing"
	desc = "A tactical chest rig issued to peacekeepers; slow is smooth, smooth is fast. Has a notable lack of a holster that fits energy-based weapons."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "peacekeeper_webbing"
	worn_icon_state = "peacekeeper_webbing"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_CREW * 3
	component_type = /datum/component/storage/concrete/peacekeeper

/obj/item/storage/belt/security/webbing/peacekeeper/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 7
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/melee/baton,
		/obj/item/melee/baton,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/food/donut,
		/obj/item/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/melee/baton/telescopic,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/holosign_creator/security
		))

//BOOTS
/obj/item/clothing/shoes/combat/peacekeeper
	name = "peacekeeper boots"
	desc = "High speed, low drag combat boots."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "peacekeeper_boots"
	inhand_icon_state = "jackboots"
	worn_icon_state = "peacekeeper"
	armor = null
	strip_delay = 30
	equip_delay_other = 50
	resistance_flags = NONE
	permeability_coefficient = 0.05 //Thick soles, and covers the ankle
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	can_be_tied = FALSE

/obj/item/clothing/suit/armor/riot/peacekeeper
	name = "peacekeeper riotsuit"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "peacekeeper_riot"
