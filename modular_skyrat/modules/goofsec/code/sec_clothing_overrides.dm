/////////
// Overwrites all the security icons with our own bluesec versions; this means little to no mapping/spawning conflicts!
/////////

//////////////////////////
//----- BACKPACKS ------//
//////////////////////////
/obj/item/storage/backpack/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "backpack_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "backpack_black",
			RESKIN_WORN_ICON_STATE = "backpack_black"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "backpack_white",
			RESKIN_WORN_ICON_STATE = "backpack_white"
		),
	)

/obj/item/storage/backpack/satchel/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "security_satchel"

/obj/item/storage/backpack/duffelbag/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "security_duffle_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_duffle_blue",
			RESKIN_WORN_ICON_STATE = "security_duffle_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_duffle_white",
			RESKIN_WORN_ICON_STATE = "security_duffle_white"
		),
	)

//////////////////////
//----- BELTS ------//
//////////////////////
/obj/item/storage/belt/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "belt_black"
	worn_icon_state = "belt_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "belt_black",
			RESKIN_WORN_ICON_STATE = "belt_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "belt_blue",
			RESKIN_WORN_ICON_STATE = "belt_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "belt_white",
			RESKIN_WORN_ICON_STATE = "belt_white"
		),
	)
	component_type = /datum/component/storage/concrete/security


///Enables you to quickdraw weapons from security holsters
/datum/component/storage/concrete/security/open_storage(mob/user)
	if(!isliving(user) || !user.CanReach(parent) || user.incapacitated())
		return FALSE
	if(locked)
		to_chat(user, span_warning("[parent] seems to be locked!"))
		return

	var/atom/A = parent

	var/obj/item/gun/gun_to_draw = locate() in real_location()
	if(!gun_to_draw)
		return ..()
	A.add_fingerprint(user)
	remove_from_storage(gun_to_draw, get_turf(user))
	playsound(parent, 'modular_skyrat/modules/sec_haul/sound/holsterout.ogg', 50, TRUE, -5)
	INVOKE_ASYNC(user, /mob/.proc/put_in_hands, gun_to_draw)
	user.visible_message(span_warning("[user] draws [gun_to_draw] from [parent]!"), span_notice("You draw [gun_to_draw] from [parent]."))

/datum/component/storage/concrete/security/mob_item_insertion_feedback(mob/user, mob/M, obj/item/I, override = FALSE)
	if(silent && !override)
		return
	if(rustle_sound)
		if(istype(I, /obj/item/gun))
			playsound(parent, 'modular_skyrat/modules/sec_haul/sound/holsterin.ogg', 50, TRUE, -5)
		else
			playsound(parent, "rustle", 50, TRUE, -5)

	for(var/mob/viewing in viewers(user, null))
		if(M == viewing)
			to_chat(usr, span_notice("You put [I] [insert_preposition]to [parent]."))
		else if(in_range(M, viewing)) //If someone is standing close enough, they can tell what it is...
			viewing.show_message(span_notice("[M] puts [I] [insert_preposition]to [parent]."), MSG_VISUAL)
		else if(I && I.w_class >= 3) //Otherwise they can only see large or normal items from a distance...
			viewing.show_message(span_notice("[M] puts [I] [insert_preposition]to [parent]."), MSG_VISUAL)

////////////////////////
//----- GLASSES ------//
////////////////////////
/obj/item/clothing/glasses/hud/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "security_hud"
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/security/sunglasses
	icon_state = "security_hud_black"
	glass_colour_type = /datum/client_colour/glass_colour/blue
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "security_hud_black",
			RESKIN_WORN_ICON_STATE = "security_hud_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_hud_blue",
			RESKIN_WORN_ICON_STATE = "security_hud_blue"
		),
	)

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	icon_state = "security_eyepatch"

/obj/item/clothing/glasses/hud/security/night
	icon_state = "security_hud_nv"


/////////////////////
//----- HEAD ------//
/////////////////////
//Standard helmet (w/ visor)
/obj/item/clothing/head/helmet/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_helmet"
	toggle_message = "You pull the visor down on"
	alt_toggle_message = "You push the visor up on"
	actions_types = list(/datum/action/item_action/toggle)
	can_toggle = TRUE
	toggle_cooldown = 0
	mutant_variants = STYLE_MUZZLE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

//Need to do some fuckery to make sure the mounted light preserves the current visor instead of throwing a fit sprite-wise
/obj/item/clothing/head/helmet/sec/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags_1 ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			//Functionally our only change; checks if the attached light is on or off
			if(attached_light)
				if(attached_light.on)
					icon_state += "-flight-on" //"security_helmet-flight-on" // "security_helmetup-flight-on"
				else
					icon_state += "-flight" //etc.
			//End of our only change
			to_chat(user, span_notice("[up ? alt_toggle_message : toggle_message] \the [src]."))

			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

/obj/item/clothing/head/helmet/sec/update_icon_state()
	. = ..()
	if(attached_light)
		//This compresses it down nicely. End result is Initial(is the visor toggled)-(is the flashlight on)
		icon_state = "[initial(icon_state)][up ? "up" : ""][attached_light.on ? "-flight-on" : "-flight"]"

//Bulletproof Helmet
/obj/item/clothing/head/helmet/alt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "bulletproof_helmet"

//Beret replacement
/obj/item/clothing/head/security_garrison
	name = "security garrison cap"
	desc = "A robust garrison cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "garrison_black"
	uses_advanced_reskins = TRUE
	armor = list(MELEE = 30, BULLET = 25, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, FIRE = 20, ACID = 50)
	strip_delay = 60
	mutant_variants = NONE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "garrison_black",
			RESKIN_WORN_ICON_STATE = "garrison_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "garrison_blue",
			RESKIN_WORN_ICON_STATE = "garrison_blue"
		),
	)

//Normal Cap
/obj/item/clothing/head/security_cap
	name = "security cap"
	desc = "A robust cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_cap_black"
	uses_advanced_reskins = TRUE
	armor = list(MELEE = 30, BULLET = 25, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, FIRE = 20, ACID = 50)
	strip_delay = 60
	dog_fashion = null
	mutant_variants = NONE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "security_cap_black",
			RESKIN_WORN_ICON_STATE = "security_cap_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_cap_blue",
			RESKIN_WORN_ICON_STATE = "security_cap_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_cap_white",
			RESKIN_WORN_ICON_STATE = "security_cap_white"
		),
	)

/////////////////////
//----- NECK ------//
/////////////////////
//Not technically an override but oh well
/obj/item/clothing/neck/security_cape
	name = "security cape"
	desc = "A fashionable cape worn by security officers."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cape_black"
	inhand_icon_state = "" //no unique inhands
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "cape_black",
			RESKIN_WORN_ICON_STATE = "cape_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "cape_blue",
			RESKIN_WORN_ICON_STATE = "cape_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "cape_white",
			RESKIN_WORN_ICON_STATE = "cape_white"
		),
	)
	///Decides the shoulder it lays on, false = RIGHT, TRUE = LEFT
	var/swapped = FALSE

/obj/item/clothing/neck/security_cape/armplate
	name = "security gauntlet"
	desc = "A fashionable full-arm gauntlet worn by security officers. The gauntlet itself is made of plastic, and provides no protection, but it looks cool as hell."
	icon_state = "armplate_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "armplate_black",
			RESKIN_WORN_ICON_STATE = "armplate_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "armplate_blue",
			RESKIN_WORN_ICON_STATE = "armplate_blue"
		),
		"Capeless Variant" = list(
			RESKIN_ICON_STATE = "armplate",
			RESKIN_WORN_ICON_STATE = "armplate"
		),
	)

/obj/item/clothing/neck/security_cape/AltClick(mob/user)
	. = ..()
	swapped = !swapped
	to_chat(user, span_notice("You swap which arm [src] will lay over."))
	update_appearance()

/obj/item/clothing/neck/security_cape/update_appearance(updates)
	. = ..()
	if(swapped)
		worn_icon_state = icon_state
	else
		worn_icon_state = "[icon_state]_left"

	usr.update_inv_neck()

///////////////////////
//----- GLOVES ------//
///////////////////////
/obj/item/clothing/gloves/color/black/security
	name = "security gloves"
	desc = "A pair of security gloves."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "gloves_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "gloves_black",
			RESKIN_WORN_ICON_STATE = "gloves_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "gloves_blue",
			RESKIN_WORN_ICON_STATE = "gloves_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "gloves_white",
			RESKIN_WORN_ICON_STATE = "gloves_white"
		),
	)

/obj/item/clothing/gloves/tackler/security	//Can't just overwrite tackler, as there's a ton of subtypes that we'd then need to account for. This is easier. MUCH easier.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "tackle_blue"

/obj/item/clothing/gloves/krav_maga/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "fightgloves_blue"

//////////////////////
//----- SUITS ------//
//////////////////////
//Not technically an override but oh well; it cant be, else everyone can randomly get the uniquely designed vest
/obj/item/clothing/suit/armor/vest/security
	name = "armored security vest"
	desc = "An armored vest designed for use in combat, used by security personnel."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "vest_black",
			RESKIN_WORN_ICON_STATE = "vest_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "vest_blue",
			RESKIN_WORN_ICON_STATE = "vest_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "vest_white",
			RESKIN_WORN_ICON_STATE = "vest_white"
		),
		"Peacekeeper Variant" = list(
			RESKIN_ICON_STATE = "peacekeeper_armor",
			RESKIN_WORN_ICON_STATE = "peacekeeper"
		)
	)

//Standard Bulletproof Vest
/obj/item/clothing/suit/armor/bulletproof
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_bulletproof"
	body_parts_covered = CHEST|GROIN|ARMS // Our sprite has groin and arm protections, so we get it too.

//Warden's Vest
/obj/item/clothing/suit/armor/vest/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_warden"

//Security Wintercoat (and hood)
/obj/item/clothing/head/hooded/winterhood/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_wintercoat_hood"

/obj/item/clothing/suit/hooded/wintercoat/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "security_wintercoat"

//////////////////////
//----- UNDER ------//
//////////////////////
//Officer
/obj/item/clothing/under/rank/security/officer
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "security_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Black Variant" = list(
			RESKIN_ICON_STATE = "security_black",
			RESKIN_WORN_ICON_STATE = "security_black"
		),
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_blue",
			RESKIN_WORN_ICON_STATE = "security_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_white",
			RESKIN_WORN_ICON_STATE = "security_white"
		),
	)

//Warden
/obj/item/clothing/under/rank/security/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "warden_black"

//HoS
/obj/item/clothing/under/rank/security/head_of_security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "hos_black"

/////////////////////
//----- FEET ------//
/////////////////////
//Not technically an override but oh well; it cant be, security gets their special footstep noise from it
/obj/item/clothing/shoes/jackboots/security
	name = "security jackboots"
	desc = "Lopland's Peacekeeper-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "security_boots"
	inhand_icon_state = "security_boots"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	clothing_traits = list(TRAIT_SILENT_FOOTSTEPS) // We have other footsteps.
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_boots",
			RESKIN_WORN_ICON_STATE = "security_boots"
		),
		"White-Trimmed Variant" = list(
			RESKIN_ICON_STATE = "security_boots_white",
			RESKIN_WORN_ICON_STATE = "security_boots_white"
		),
		"Full White Variant" = list(
			RESKIN_ICON_STATE = "security_boots_fullwhite",
			RESKIN_WORN_ICON_STATE = "security_boots_fullwhite"
		),
	)

/obj/item/clothing/shoes/jackboots/security/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/footstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/footstep2.ogg'=1, 'modular_skyrat/master_files/sound/effects/footstep3.ogg'=1), 100)


//
// This code overrides security's jumpskirt preference, as we're not going to be giving them jumpskirts
//
/datum/outfit/job/security/pre_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.jumpsuit_style == PREF_SKIRT)
		to_chat(H, span_alertwarning("Lopland Peacekeeper uniforms don't include a Skirt variant! You've been equipped with a jumpsuit instead."))
		uniform = /obj/item/clothing/under/rank/security/officer
