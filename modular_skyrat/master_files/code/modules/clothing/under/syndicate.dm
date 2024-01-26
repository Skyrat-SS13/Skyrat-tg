#define RESKIN_CHARCOAL "Charcoal"
#define RESKIN_NT "NT Blue"
#define RESKIN_SYNDIE "Syndicate Red"

/obj/item/clothing/under/syndicate
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate_digi.dmi' // Anything that was in the syndicate.dmi, should be in the syndicate_digi.dmi

/obj/item/clothing/under/syndicate/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	//These are pre-set for ease and reference, as syndie under items SHOULDNT have sensors and should have similar stats; also its better to start with adjust = false
	has_sensor = NO_SENSORS
	can_adjust = FALSE

//Related files:
// modular_skyrat\modules\Syndie_edits\code\syndie_edits.dm (this has the Overalls and non-Uniforms)
// modular_skyrat\modules\novaya_ert\code\uniform.dm (NRI uniform(s))

/*
*	TACTICOOL
*/

//This is an overwrite, not a fully new item, but still fits best here.

/obj/item/clothing/under/syndicate/tacticool //Overwrites the 'fake' one. Zero armor, sensors, and default blue. More Balanced to make station-available.
	name = "tacticool turtleneck"
	desc = "A snug turtleneck, in fabulous Nanotrasen-blue. Just looking at it makes you want to buy a NT-certifed coffee, go into the office, and -work-."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/syndicate.dmi' //Since its an overwrite it needs new icon linking. Woe.
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/syndicate.dmi'
	icon_state = "tactifool_blue"
	inhand_icon_state = "b_suit"
	can_adjust = TRUE
	has_sensor = HAS_SENSORS
	armor_type = /datum/armor/clothing_under/none
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	unique_reskin = list(
		RESKIN_NT = "tactifool_blue",
		RESKIN_CHARCOAL = "tactifool"
	)
	resistance_flags = FLAMMABLE

/obj/item/clothing/under/syndicate/tacticool/reskin_obj(mob/M)
	..()
	if(current_skin && current_skin == RESKIN_CHARCOAL)
		desc = "Just looking at it makes you want to buy an SKS, go into the woods, and -operate-." //Default decription of the normal tacticool
		inhand_icon_state = "bl_suit" //May as well, while we're updating it

/obj/item/clothing/under/syndicate/tacticool/skirt //Overwrites the 'fake' one. Zero armor, sensors, and default blue. More Balanced to make station-available.
	name = "tacticool skirtleneck"
	desc = "A snug skirtleneck, in fabulous Nanotrasen-blue. Just looking at it makes you want to buy a NT-certifed coffee, go into the office, and -work-."
	icon_state = "tactifool_blue_skirt"
	armor_type = /datum/armor/clothing_under/none
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		RESKIN_NT = "tactifool_blue_skirt",
		RESKIN_CHARCOAL = "tactifool_skirt"
	)

/obj/item/clothing/under/syndicate/bloodred/sleepytime/sensors //Halloween-only
	has_sensor = HAS_SENSORS
	armor_type = /datum/armor/clothing_under/none
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/skyrat/baseball
	name = "syndicate baseball tee"
	desc = "Aaand the Syndicate Snakes are up to bat, ready for one of their signature nuclear home-runs! Lets show these corpos a good time." //NT pitches their plasma/bluespace(something)
	icon_state = "syndicate_baseball"

/*
*	TACTICAL (Real)
*/
//The red alts, for BLATANTLY syndicate stuff (Like DS2)
// (Multiple non-syndicate things use the base tactical turtleneck, they cant have it red nor reskinnable. OUR version, however, can be.)
/obj/item/clothing/under/syndicate/skyrat/tactical
	name = "tactical turtleneck"
	desc = "A snug syndicate-red turtleneck with charcoal-black cargo pants. Good luck arguing allegiance with this on."
	icon_state = "syndicate_red"
	inhand_icon_state = "r_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE
	armor_type = /datum/armor/clothing_under/syndicate
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	unique_reskin = list(
		RESKIN_SYNDIE = "syndicate_red",
		RESKIN_CHARCOAL = "syndicate"
	)

/obj/item/clothing/under/syndicate/skyrat/tactical/reskin_obj(mob/M)
	..()
	if(current_skin && current_skin == RESKIN_CHARCOAL)
		desc = "A non-descript and slightly suspicious looking turtleneck with digital camouflage cargo pants." //(Digital camo? Brown? What?)
		inhand_icon_state = "bl_suit"

/obj/item/clothing/under/syndicate/skyrat/tactical/skirt
	name = "tactical skirtleneck"
	desc = "A snug syndicate-red skirtleneck with a charcoal-black skirt. Good luck arguing allegiance with this on."
	icon_state = "syndicate_red_skirt"
	inhand_icon_state = "r_suit"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	dying_key = DYE_REGISTRY_JUMPSKIRT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	unique_reskin = list(
		RESKIN_SYNDIE = "syndicate_red_skirt",
		RESKIN_CHARCOAL = "syndicate_skirt"
	)

/obj/item/clothing/under/syndicate/skyrat/tactical/skirt/reskin_obj(mob/M)
	..()
	if(current_skin && current_skin == RESKIN_CHARCOAL)
		desc = "A non-descript and slightly suspicious looking skirtleneck."
		inhand_icon_state = "bl_suit"

/*
*	ENCLAVE
*/
/obj/item/clothing/under/syndicate/skyrat/enclave
	name = "neo-American sergeant uniform"
	desc = "Throughout the stars, rumors of mad scientists and angry drill sergeants run rampant; of creatures in armor black as night, being led by men or women wearing this uniform. They share one thing: a deep, natonalistic zeal of the dream of America."
	icon_state = "enclave"
	can_adjust = TRUE
	armor_type = /datum/armor/clothing_under/none

/obj/item/clothing/under/syndicate/skyrat/enclave/officer
	name = "neo-American officer uniform"
	icon_state = "enclaveo"

/obj/item/clothing/under/syndicate/skyrat/enclave/real
	armor_type = /datum/armor/clothing_under/syndicate

/obj/item/clothing/under/syndicate/skyrat/enclave/real/officer
	name = "neo-American officer uniform"
	icon_state = "enclaveo"

#undef RESKIN_CHARCOAL
#undef RESKIN_NT
#undef RESKIN_SYNDIE
