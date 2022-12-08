/*
*	Overwrites all the security icons with our own bluesec versions; this means little to no mapping/spawning conflicts!
*	(Also includes 'old' versions at the bottom of the file, for the purpose of crates/vendors/admin shenanigans. Can't remove them ENTIRELY after all!)
*/

/*
*	PLASMAMEN
*	This goes first due to simultaneously being easy to do, and complex to organize
*/

/obj/item/clothing/under/plasmaman/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/plasmaman.dmi'
	icon_state = "security_envirosuit_new"

/obj/item/clothing/under/plasmaman/security/warden
	icon_state = "warden_envirosuit_new"

/obj/item/clothing/under/plasmaman/security/head_of_security
	icon_state = "hos_envirosuit_new"

/obj/item/clothing/head/helmet/space/plasmaman/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/plasmaman_hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/plasmaman_head.dmi'
	icon_state = "security_envirohelm_new"

/obj/item/clothing/head/helmet/space/plasmaman/security/warden
	icon_state = "warden_envirohelm_new"

/obj/item/clothing/head/helmet/space/plasmaman/security/head_of_security
	icon_state = "hos_envirohelm_new"

/*
* ACCESSORIES
*/
/obj/item/clothing/accessory/armband/deputy
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/accessories.dmi'
	icon_state = "armband_lopland"

/obj/item/clothing/accessory/armband/deputy/lopland
	desc = "A Peacekeeper-blue armband, showing the wearer to be certified by Lopland as a top-of-their-class Security Officer."

/*
* BACKPACKS
*/

/obj/item/storage/backpack/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "backpack_security"

/obj/item/storage/backpack/satchel/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "security_satchel"

/obj/item/storage/backpack/duffelbag/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "security_duffle"

/*
* BELTS
*/
/obj/item/storage/belt/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "belt_security"
	worn_icon_state = "belt_security"

///Enables you to quickdraw weapons from security holsters
/datum/storage/security/open_storage(datum/source, mob/user)
	var/atom/resolve_parent = parent?.resolve()
	if(!resolve_parent)
		return
	if(isobserver(user))
		show_contents(user)
		return

	if(!user.CanReach(resolve_parent))
		resolve_parent.balloon_alert(user, "can't reach!")
		return FALSE

	if(!isliving(user) || user.incapacitated())
		return FALSE

	var/obj/item/gun/gun_to_draw = locate() in real_location?.resolve()
	if(!gun_to_draw)
		return ..()
	resolve_parent.add_fingerprint(user)
	attempt_remove(gun_to_draw, get_turf(user))
	playsound(resolve_parent, 'modular_skyrat/modules/sec_haul/sound/holsterout.ogg', 50, TRUE, -5)
	INVOKE_ASYNC(user, TYPE_PROC_REF(/mob, put_in_hands), gun_to_draw)
	user.visible_message(span_warning("[user] draws [gun_to_draw] from [resolve_parent]!"), span_notice("You draw [gun_to_draw] from [resolve_parent]."))

/*
* GLASSES
*/
/obj/item/clothing/glasses/hud/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "security_hud"
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/security/sunglasses
	icon_state = "security_hud_glasses"
	glass_colour_type = /datum/client_colour/glass_colour/blue

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	icon_state = "security_eyepatch"

/obj/item/clothing/glasses/hud/security/night
	icon_state = "security_hud_nv"
	glass_colour_type = /datum/client_colour/glass_colour/green

/*
* HEAD
*/

//Overrides the bulletproof helm with a non red visor version.
/obj/item/clothing/head/helmet/alt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'

//Standard security helmet
/obj/item/clothing/head/helmet/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_helmet"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	dog_fashion = null

//Normal Cap
/obj/item/clothing/head/soft/sec/lopland
	name = "security cap"
	desc = "It's a robust baseball hat in tasteful white colour."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_cap"

/obj/item/clothing/head/hats/hos
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hoscap_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Cap" = list(
			RESKIN_ICON_STATE = "hoscap_blue",
			RESKIN_WORN_ICON_STATE = "hoscap_blue"
		),
		"Sol Cap" = list(
			RESKIN_ICON_STATE = "policechiefcap",
			RESKIN_WORN_ICON_STATE = "policechiefcap"
		),
		"Sheriff Hat" = list(
			RESKIN_ICON_STATE = "cowboyhat_black",
			RESKIN_WORN_ICON_STATE = "cowboyhat_black"
		),
		"Wide Sheriff Hat" = list(
			RESKIN_ICON_STATE = "cowboy_black",
			RESKIN_WORN_ICON_STATE = "cowboy_black"
		)
	)

//Need to quickly redefine this so the icon doesnt break
/obj/item/clothing/head/hats/hos/syndicate
	icon = 'icons/obj/clothing/head/hats.dmi'
	worn_icon = 'icons/mob/clothing/head/hats.dmi'
	icon_state = "hoscap"
	current_skin = "hoscap" //Prevents reskinning

/*
* NECK
*/
/obj/item/clothing/neck/cloak/hos
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak_blue"

/*
* GLOVES
*/
/obj/item/clothing/gloves/color/black/security
	name = "security gloves"
	desc = "A pair of security gloves."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "gloves_security"

/obj/item/clothing/gloves/tackler/security	//Can't just overwrite tackler, as there's a ton of subtypes that we'd then need to account for. This is easier. MUCH easier.
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "tackle_blue"

/obj/item/clothing/gloves/krav_maga/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "fightgloves_blue"

/*
* SUITS
*/
/obj/item/clothing/suit/armor/vest/alt/sec
	name = "armored security vest"
	desc = "A Type-II-AD-P armored vest that provides decent protection against most types of damage."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_security"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/hos
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Standard Bulletproof Vest
/obj/item/clothing/suit/armor/bulletproof
	desc = "A Type-III-AD-P heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Riot Armor
/obj/item/clothing/suit/armor/riot
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi' //ORION TODO - actually have a unique icon_state overriding it instead of this cop-out it originally had (The original was actually done wrong anyways)

/obj/item/clothing/head/helmet/toggleable/riot
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'

//Warden's Vest
/obj/item/clothing/suit/armor/vest/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_warden"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

//Security Wintercoat (and hood)
/obj/item/clothing/head/hooded/winterhood/security
	desc = "A blue, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes." //God dammit TG stop putting color in the desc of items like this
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_wintercoat_hood"

/obj/item/clothing/suit/hooded/wintercoat/security
	desc = "A blue, armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority.  The zipper tab is a small <b>\"Lopland\"</b> logo."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "security_wintercoat"

/obj/item/clothing/suit/armor/hos/hos_formal
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hosformal_blue"

/*
* UNDER
*/

//Officer
/obj/item/clothing/under/rank/security/officer
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'

//Warden
/obj/item/clothing/under/rank/security/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "warden_black"

//HoS
/obj/item/clothing/under/rank/security/head_of_security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "hos_black"

/obj/item/clothing/under/rank/security/head_of_security/parade
	icon_state = "hos_parade_male_blue"

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	icon_state = "hos_parade_fem_blue"

/obj/item/clothing/under/rank/security/head_of_security/alt
	icon_state = "hosalt_blue"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	icon_state = "hosalt_skirt_blue"

/*
* FEET
*/
//Adds reskins and special footstep noises
/obj/item/clothing/shoes/jackboots/sec
	name = "security jackboots"
	desc = "Lopland's Peacekeeper-issue Security boots fit for just about any scenario. Combat boots are so 2340 anyways."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "security_boots"

//PDA Greyscale Overrides
/obj/item/modular_computer/pda/security
	greyscale_colors = "#2B356D#1E1E1E"

/obj/item/modular_computer/pda/detective
	greyscale_colors = "#90714F#1E1E1E"

/obj/item/modular_computer/pda/warden
	greyscale_colors = "#2F416E#1E1E1E#ACACAC"

/obj/item/modular_computer/pda/heads/hos
	greyscale_colors = "#2B356D#1E1E1E"

/*
*	A bunch of re-overrides so that admins can keep using some redsec stuff; not all of them have this though!
*/

/*
*	EYES
*/

/obj/item/clothing/glasses/hud/security/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhud"
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/security/sunglasses/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "sunhudsec"
	glass_colour_type = /datum/client_colour/glass_colour/darkred
	current_skin = "sunhudsec"	//prevents reskinning; a bit hacky to say its already reskinned but its better than a code rewrite

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"

/obj/item/clothing/glasses/hud/security/night/redsec
	icon = 'icons/obj/clothing/glasses.dmi'
	worn_icon = 'icons/mob/clothing/eyes.dmi'
	icon_state = "securityhudnight"

/*
*	NECK
*/

/obj/item/clothing/neck/cloak/hos/redsec
	icon = 'icons/obj/clothing/cloaks.dmi'
	worn_icon = 'icons/mob/clothing/neck.dmi'
	icon_state = "hoscloak"

/*
*	BACK
*/

/obj/item/storage/backpack/security/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "backpack-security"
	current_skin = "backpack-security" //prevents reskinning

/obj/item/storage/backpack/satchel/sec/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "satchel-security"

/obj/item/storage/backpack/duffelbag/sec/redsec
	icon = 'icons/obj/storage/backpack.dmi'
	worn_icon = 'icons/mob/clothing/back/backpack.dmi'
	icon_state = "duffel-security"
	current_skin = "duffel-security" //prevents reskinning

/*
*	BELT
*/

/obj/item/storage/belt/security/redsec
	icon = 'icons/obj/clothing/belts.dmi'
	worn_icon = 'icons/mob/clothing/belt.dmi'
	icon_state = "security"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	current_skin = "security"	//prevents reskinning

/*
*	HEAD
*/

/obj/item/clothing/head/helmet/sec/redsec
	icon = 'icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'icons/mob/clothing/head/helmet.dmi'
	icon_state = "helmet"
	base_icon_state = "helmet"

/*
*	UNIFORM
*/

/obj/item/clothing/under/rank/security/officer/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "rsecurity"
	current_skin = "rsecurity"	//prevents reskinning

/obj/item/clothing/under/rank/security/warden/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "rwarden"

/obj/item/clothing/under/rank/security/head_of_security/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "rhos"

/obj/item/clothing/under/rank/security/head_of_security/parade/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "hos_parade_male"

/obj/item/clothing/under/rank/security/head_of_security/parade/female/redsec
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	icon_state = "hos_parade_fem"

/*
*	WINTER COAT
*/

/obj/item/clothing/head/hooded/winterhood/security/redsec
	desc = "A red, armour-padded winter hood. Definitely not bulletproof, especially not the part where your face goes."
	icon = 'icons/obj/clothing/head/winterhood.dmi'
	worn_icon = 'icons/mob/clothing/head/winterhood.dmi'
	icon_state = "hood_security"

/obj/item/clothing/suit/hooded/wintercoat/security/redsec
	name = "security winter jacket"
	desc = "A red, armour-padded winter coat. It glitters with a mild ablative coating and a robust air of authority.  The zipper tab is a pair of jingly little handcuffs that get annoying after the first ten seconds."
	icon = 'icons/obj/clothing/suits/wintercoat.dmi'
	worn_icon = 'icons/mob/clothing/suits/wintercoat.dmi'
	icon_state = "coatsecurity"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/redsec

/*
*	ARMOR
*/

/obj/item/clothing/suit/armor/vest/alt/sec/redsec
	desc = "A Type I armored vest that provides decent protection against most types of damage."
	icon = 'icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'icons/mob/clothing/suits/armor.dmi'
	icon_state = "armor_sec"

/*
*	FEET
*/
/obj/item/clothing/shoes/jackboots/sec/redsec
	name = "jackboots"
	desc = "Nanotrasen-issue Security combat boots for combat scenarios or combat situations. All combat, all the time."
	icon_state = "jackboots_sec"
	icon = 'icons/obj/clothing/shoes.dmi'
	worn_icon = 'icons/mob/clothing/feet.dmi'
	current_skin = "jackboots_sec"	//prevents reskinning
