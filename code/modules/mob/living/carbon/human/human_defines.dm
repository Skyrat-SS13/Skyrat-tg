/// Any humanoid (non-Xeno) mob, such as humans, plasmamen, lizards.
/mob/living/carbon/human
	name = "Unknown"
	real_name = "Unknown"
	icon = 'icons/mob/human/human.dmi'
	icon_state = "human_basic"
	appearance_flags = KEEP_TOGETHER|TILE_BOUND|PIXEL_SCALE|LONG_GLIDE
	hud_possible = list(HEALTH_HUD,STATUS_HUD,ID_HUD,WANTED_HUD,IMPLOYAL_HUD,IMPSEC_FIRST_HUD,IMPSEC_SECOND_HUD,ANTAG_HUD,GLAND_HUD,SENTIENT_DISEASE_HUD,FAN_HUD,PERMIT_HUD, DNR_HUD) //SKYRAT EDIT ADDITION - PERMIT_HUD, DNR_HUD
	hud_type = /datum/hud/human
	pressure_resistance = 25
	can_buckle = TRUE
	buckle_lying = 0
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	can_be_shoved_into = TRUE
	initial_language_holder = /datum/language_holder/empty // We get stuff from our species
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	max_grab = GRAB_KILL

	maxHealth = HUMAN_MAXHEALTH //SKYRAT EDIT ADDITION
	health = HUMAN_MAXHEALTH //SKYRAT EDIT ADDITION

	//Hair colour and style
	var/hair_color = COLOR_BLACK
	var/hairstyle = "Bald"

	///Colours used for hair and facial hair gradients.
	var/list/grad_color = list(
		COLOR_BLACK,	//Hair Gradient Color
		COLOR_BLACK,	//Facial Hair Gradient Color
	)
	///Styles used for hair and facial hair gradients.
	var/list/grad_style = list(
		"None",	//Hair Gradient Style
		"None",	//Facial Hair Gradient Style
	)

	//Facial hair colour and style
	var/facial_hair_color = COLOR_BLACK
	var/facial_hairstyle = "Shaved"

	//Eye colour
	var/eye_color_left = COLOR_BLACK
	var/eye_color_right = COLOR_BLACK
	/// Var used to keep track of a human mob having a heterochromatic right eye. To ensure prefs don't overwrite shit
	var/eye_color_heterochromatic = FALSE

	var/skin_tone = "caucasian1" //Skin tone

	var/lip_style = null //no lipstick by default- arguably misleading, as it could be used for general makeup
	var/lip_color = COLOR_WHITE

	var/age = 30 //Player's age
	var/chrono_age = 30 // SKYRAT EDIT ADDITION - Chronological age

	/// Which body type to use
	var/physique = MALE

	//consider updating /mob/living/carbon/human/copy_clothing_prefs() if adding more of these
	var/underwear = "Nude" //Which underwear the player wants
	var/underwear_color = COLOR_BLACK
	var/undershirt = "Nude" //Which undershirt the player wants
	var/socks = "Nude" //Which socks the player wants
	var/backpack = DBACKPACK //Which backpack type the player has chosen.
	var/jumpsuit_style = PREF_SUIT //suit/skirt

	var/datum/scream_type/selected_scream //SKRYAT EDIT ADDITION
	var/datum/laugh_type/selected_laugh //SKYRAT EDIT ADDITION

	//Equipment slots
	var/obj/item/clothing/wear_suit = null
	var/obj/item/clothing/w_uniform = null
	var/obj/item/belt = null
	var/obj/item/wear_id = null
	var/obj/item/r_store = null
	var/obj/item/l_store = null
	var/obj/item/s_store = null

	var/special_voice = "" // For changing our voice. Used by a symptom.

	var/datum/physiology/physiology

	/// What types of mobs are allowed to ride/buckle to this mob
	var/static/list/can_ride_typecache = typecacheof(list(
		/mob/living/basic/parrot,
		/mob/living/carbon/human,
		/mob/living/basic/slime,
	))

	var/account_id

	var/hardcore_survival_score = 0

	/// How many "units of blood" we have on our hands
	var/blood_in_hands = 0

	/// The core temperature of the human compaired to the skin temp of the body
	var/coretemperature = BODYTEMP_NORMAL

	///Exposure to damaging heat levels increases stacks, stacks clean over time when temperatures are lower. Stack is consumed to add a wound.
	var/heat_exposure_stacks = 0

	/// When an braindead player has their equipment fiddled with, we log that info here for when they come back so they know who took their ID while they were DC'd for 30 seconds
	var/list/afk_thefts

	/// Height of the mob
	VAR_PROTECTED/mob_height = HUMAN_HEIGHT_MEDIUM
