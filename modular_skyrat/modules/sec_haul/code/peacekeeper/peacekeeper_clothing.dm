
//PEACEKEEPER HELMET
/obj/item/clothing/head/helmet/sec/peacekeeper
	name = "peacekeeper helmet"
	desc = "A standard issue combat helmet for peacekeeper operators. Has decent tensile strength and armor. Keep your head down."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_helmet"
	worn_icon_state = "peacekeeper"
	mutant_variants = NONE

/obj/item/clothing/head/beret/sec/peacekeeper
	name = "peacekeeper beret"
	desc = "A robust beret with the peacekeeper insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_beret"
	mutant_variants = NONE

/obj/item/clothing/head/beret/sec/peacekeeper/white
	icon_state = "peacekeeper_beret_white"

/obj/item/clothing/head/hos/beret/peacekeeper
	name = "head of security's peacekeeper beret"
	desc = "A special beret with the Head of Security's insignia emblazoned on it. A symbol of excellence, a badge of courage, a mark of distinction."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_beret_hos"
	mutant_variants = NONE

/obj/item/clothing/head/beret/sec/navywarden/peacekeeper
	name = "warden's peacekeeper beret"
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_beret_warden"
	mutant_variants = NONE

/obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper
	name = "peacekeeper hud glasses"
	icon_state = "peacekeeperglasses"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'

//PEACEKEEPER UNIFORM
/obj/item/clothing/under/rank/security/peacekeeper
	name = "peacekeeper uniform"
	desc = "A sleek peackeeper uniform, made to a price."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms_digi.dmi'
	icon_state = "peacekeeper"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 30, WOUND = 10) //Don't worry, these are copies.
	can_adjust = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/peacekeeper/tactical
	name = "tactical peacekeeper uniform"
	desc = "A tactical peackeeper uniform, woven with a lightweight layer of kevlar to provide minor ballistic and stab protection."
	icon_state = "peacekeeper_tac"
	armor = list(MELEE = 5, BULLET = 5, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 30, WOUND = 10)

/obj/item/clothing/under/rank/security/peacekeeper/blue
	name = "blue peacekeeper uniform"
	icon_state = "rsecurity"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms_digi.dmi'

/obj/item/clothing/under/rank/security/warden/peacekeeper
	name = "peacekeeper wardens suit"
	desc = "A formal security suit for officers complete with Armadyne belt buckle."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms_digi.dmi'
	icon_state = "peacekeeper_warden"
	inhand_icon_state = "peacekeeper_warden"

/obj/item/clothing/under/rank/security/warden
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms_digi.dmi'

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper
	name = "head of security's peacekeeper jumpsuit"
	desc = "A security jumpsuit decorated for those few with the dedication to achieve the position of Head of Security."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms_digi.dmi'
	icon_state = "peacekeeper_hos"
	inhand_icon_state = "peacekeeper_hos"

//PEACEKEEPER ARMOR
/obj/item/clothing/suit/armor/vest/peacekeeper
	name = "peacekeeper armor vest"
	desc = "A standard issue peacekeeper armor vest, versatile, lightweight, and most importantly, cheap."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_armor"
	worn_icon_state = "peacekeeper"
	mutant_variants = NONE

/obj/item/clothing/suit/armor/vest/peacekeeper/black
	name = "black peacekeeper vest"
	icon_state = "peacekeeper_black"
	worn_icon_state = "peacekeeper_black"

/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper
	name = "armored peacekeeper trenchcoat"
	desc = "A trenchcoat enhanced with a special lightweight kevlar. The epitome of tactical plainclothes."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_trench_hos"
	inhand_icon_state = "hostrench"
	mutant_variants = NONE

/obj/item/clothing/suit/armor/vest/warden/peacekeeper
	name = "warden's peacekeeper jacket"
	desc = "A white jacket with blue  rank pips and body armor strapped on top."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_trench_warden"
	mutant_variants = NONE

/obj/item/clothing/suit/hooded/wintercoat/security/peacekeeper
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "coatpeacekeeper"
	inhand_icon_state = "coatpeacekeeper"
	desc = "A greyish-blue, armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority.  The zipper tab is a pair of jingly little handcuffs that get annoying after the first ten seconds."
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/peacekeeper

/obj/item/clothing/head/hooded/winterhood/security/peacekeeper
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_peacekeeper"
	desc = "A greyish-blue, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes."

//PEACEKEEPER GLOVES
/obj/item/clothing/gloves/combat/peacekeeper
	name = "peacekeeper gloves"
	desc = "These tactical gloves are fireproof."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_gloves.dmi'
	icon_state = "peacekeeper_gloves"
	worn_icon_state = "peacekeeper"
	cut_type = null
	siemens_coefficient = 0.5

/obj/item/clothing/gloves/tackler/peacekeeper
	name = "peacekeeper gripper gloves"
	desc = "Special gloves that manipulate the blood vessels in the wearer's hands, granting them the ability to launch headfirst into walls."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_gloves.dmi'
	icon_state = "peacekeeper_gripper_gloves"

/obj/item/clothing/gloves/krav_maga/sec/peacekeeper
	name = "peacekeeper krav maga gloves"
	desc = "These gloves can teach you to perform Krav Maga using nanochips."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_gloves.dmi'
	icon_state = "peacekeeper_gripper_gloves"

//PEACEKEEPER BELTS
/obj/item/storage/belt/security/peacekeeper
	name = "peacekeeper belt"
	desc = "Can hold security gear like handcuffs and flashes. Has a holster for a gun."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_belts.dmi'
	icon_state = "peacekeeperbelt"
	worn_icon_state = "peacekeeperbelt"
	content_overlays = FALSE
	component_type = /datum/component/storage/concrete/peacekeeper

/datum/component/storage/concrete/peacekeeper/on_alt_click(datum/source, mob/user)
	SIGNAL_HANDLER_DOES_SLEEP

	if(!isliving(user) || !user.CanReach(parent) || user.incapacitated())
		return
	if(locked)
		to_chat(user, "<span class='warning'>[parent] seems to be locked!</span>")
		return

	var/atom/A = parent

	var/obj/item/gun/ballistic/automatic/pistol/P = locate() in real_location()
	if(!P)
		return
	A.add_fingerprint(user)
	remove_from_storage(P, get_turf(user))
	playsound(parent, 'modular_skyrat/modules/sec_haul/sound/holsterout.ogg', 50, TRUE, -5)
	if(!user.put_in_hands(P))
		to_chat(user, "<span class='notice'>You fumble for [P] and it falls on the floor.</span>")
		return
	user.visible_message("<span class='warning'>[user] draws [P] from [parent]!</span>", "<span class='notice'>You draw [P] from [parent].</span>")


/datum/component/storage/concrete/peacekeeper/mob_item_insertion_feedback(mob/user, mob/M, obj/item/I, override = FALSE)
	if(silent && !override)
		return
	if(rustle_sound)
		if(istype(I, /obj/item/gun/ballistic/automatic/pistol))
			playsound(parent, 'modular_skyrat/modules/sec_haul/sound/holsterin.ogg', 50, TRUE, -5)
		else
			playsound(parent, "rustle", 50, TRUE, -5)

	for(var/mob/viewing in viewers(user, null))
		if(M == viewing)
			to_chat(usr, "<span class='notice'>You put [I] [insert_preposition]to [parent].</span>")
		else if(in_range(M, viewing)) //If someone is standing close enough, they can tell what it is...
			viewing.show_message("<span class='notice'>[M] puts [I] [insert_preposition]to [parent].</span>", MSG_VISUAL)
		else if(I && I.w_class >= 3) //Otherwise they can only see large or normal items from a distance...
			viewing.show_message("<span class='notice'>[M] puts [I] [insert_preposition]to [parent].</span>", MSG_VISUAL)

/obj/item/storage/belt/security/peacekeeper/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/melee/baton,
		/obj/item/melee/classic_baton,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/food/donut,
		/obj/item/kitchen/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/melee/classic_baton/telescopic,
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
	desc = "Unique and versatile chest rig, can hold security gear."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_belts.dmi'
	icon_state = "peacekeeper_webbing"
	worn_icon_state = "peacekeeper_webbing"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_HARD * 2
	component_type = /datum/component/storage/concrete/peacekeeper

/obj/item/storage/belt/security/webbing/peacekeeper/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 7
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/melee/baton,
		/obj/item/melee/classic_baton,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/food/donut,
		/obj/item/kitchen/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/melee/classic_baton/telescopic,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/holosign_creator/security
		))

//BOOTS
/obj/item/clothing/shoes/combat/peacekeeper
	name = "peacekeeper boots"
	desc = "High speed, low drag combat boots."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_boots.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_boots_digi.dmi'
	icon_state = "peacekeeper_boots"
	inhand_icon_state = "jackboots"
	worn_icon_state = "peacekeeper"

/obj/item/clothing/shoes/combat/peacekeeper/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/suitstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/suitstep2.ogg'=1), 40, falloff_exponent = SOUND_FALLOFF_EXPONENT)

/obj/item/clothing/suit/armor/riot/peacekeeper
	name = "peacekeeper riotsuit"
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_riot"

//HARDSUITS
/obj/item/clothing/head/helmet/space/hardsuit/security_peacekeeper
	name = "Armadyne SS-01 Voidsuit Helmet"
	desc = "An Armadyne brand voidsuit helmet, with a decent layer of armor, this one comes in the peacekeeper colors."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_hardsuit.dmi'
	worn_icon_muzzled = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_hardsuit_digi.dmi'
	icon_state = "hardsuit0-peacekeeper"
	inhand_icon_state = "sec_helm"
	hardsuit_type = "peacekeeper"
	armor = list(MELEE = 40, BULLET = 20, LASER = 35, ENERGY = 45, BOMB = 10, BIO = 100, RAD = 50, FIRE = 90, ACID = 75, WOUND = 20)
	slowdown = 0.7

/obj/item/clothing/suit/space/hardsuit/security_peacekeeper
	icon_state = "hardsuit-sec"
	name = "Armadyne SS-01 Voidsuit"
	desc = "An Armadyne brand voidsuit, with a decent layer of armor, this one comes in the peacekeeper colors."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_hardsuit.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_hardsuit_digi.dmi'
	icon_state = "hardsuit-peacekeeper"
	inhand_icon_state = "sec_hardsuit"
	armor = list(MELEE = 40, BULLET = 20, LASER = 35, ENERGY = 45, BOMB = 10, BIO = 100, RAD = 50, FIRE = 90, ACID = 75, WOUND = 20)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security_peacekeeper
	slowdown = 0.7
	hardsuit_tail_colors = list("BBB", "444", "337")

/obj/machinery/suit_storage_unit/security_peacekeeper
	suit_type = /obj/item/clothing/suit/space/hardsuit/security_peacekeeper
	mask_type = /obj/item/clothing/mask/gas/sechailer

/obj/item/clothing/suit/space/hardsuit/security_peacekeeper/Initialize()
	. = ..()
	allowed = GLOB.security_hardsuit_allowed
