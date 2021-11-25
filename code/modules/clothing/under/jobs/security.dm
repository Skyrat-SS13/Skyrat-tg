/*
 * Contains:
 * Security
 * Detective
 * Navy uniforms
 */

/*
 * Security
 */

/obj/item/clothing/under/rank/security
	icon = 'icons/obj/clothing/under/security.dmi'
	worn_icon = 'icons/mob/clothing/under/security.dmi'
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 30, ACID = 30, WOUND = 10)
	strip_delay = 50
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/officer
	name = "security jumpsuit"
	desc = "A tactical security jumpsuit for officers complete with Nanotrasen belt buckle."
	icon_state = "rsecurity"
	inhand_icon_state = "r_suit"
	// SKYRAT EDIT ADDITION START
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Basic Security" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rsecurity",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rsecurity"
		),
		"Grey Security" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "security",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "security"
		),
		"Security Jumpskirt" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "secskirt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "secskirt"
		),
		"Formal Security Uniform" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "officerblueclothes",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "officerblueclothes"
		),
		"Blue Shift" = list( // Uses the better sprites for the Blue Shift clothing.
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "barney_uniform",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "barney_uniform"
		),
		"Constable" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "constable",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "constable"
		),
		"Peacekeeper" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "peacekeeper",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "peacekeeper"
		),
		"Tactical Peacekeeper" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "peacekeeper_tac",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "peacekeeper_tac"
		),
		"Blue Peacekeeper" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "bsecurity",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "bsecurity"
		),
		"Junior Peacekeeper" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "junior_officer",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "junior_officer"
		),
		"Battle Dress Uniform" = list(
			RESKIN_ICON = 'modular_skyrat/modules/modular_items/icons/modular_clothing.dmi',
			RESKIN_ICON_STATE = "fatigues",
			RESKIN_WORN_ICON = 'modular_skyrat/modules/modular_items/icons/modular_clothing.dmi',
			RESKIN_WORN_ICON_STATE = "fatigues"
		),
		"Sol" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "policealt",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "policealt"
		),
		"Sol Cadet" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "policecadetalt",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "policecadetalt"
		),
		"Sol Traffic" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "policetrafficalt",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "policetrafficalt"
		),
		"Trousers" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "workpants_red",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "workpants_red"
		),
		"Peacekeeper Trousers" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "workpants_blue",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "workpants_blue"
		),
		"Kilt" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "blackwatch",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "blackwatch"
		)
	)
	/// SKYRAT EDIT ADDITION END
/obj/item/clothing/under/rank/security/officer/grey
	name = "grey security jumpsuit"
	desc = "A tactical relic of years past before Nanotrasen decided it was cheaper to dye the suits red instead of washing out the blood."
	icon_state = "security"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/officer/skirt
	name = "security jumpskirt"
	desc = "A \"tactical\" security jumpsuit with the legs replaced by a skirt."
	icon_state = "secskirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/officer/blueshirt
	name = "blue shirt and tie"
	desc = "I'm a little busy right now, Calhoun."
	icon_state = "blueshift"
	inhand_icon_state = "blueshift"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/officer/formal
	name = "security officer's formal uniform"
	desc = "The latest in fashionable security outfits."
	icon_state = "officerblueclothes"
	inhand_icon_state = "officerblueclothes"

/obj/item/clothing/under/rank/security/constable
	name = "constable outfit"
	desc = "A british looking outfit."
	icon_state = "constable"
	inhand_icon_state = "constable"
	can_adjust = FALSE
	custom_price = PAYCHECK_HARD

/obj/item/clothing/under/rank/security/warden
	name = "security suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	icon_state = "rwarden"
	inhand_icon_state = "r_suit"
	// SKYRAT EDIT ADDITION START
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Basic Warden" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rwarden",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rwarden"
		),
		"Grey Warden" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "warden",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "warden"
		),
		"Warden Jumpskirt" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rwarden_skirt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rwarden_skirt"
		),
		"Formal Warden Uniform" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "wardenblueclothes",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "wardenblueclothes"
		),
		"Peacekeeper" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "peacekeeper_warden",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "peacekeeper_warden"
		),
		"Sol" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "policewardenalt",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "policewardenalt"
		)
	)
	/// SKYRAT EDIT ADDITION END

/obj/item/clothing/under/rank/security/warden/grey
	name = "grey security suit"
	desc = "A formal relic of years past before Nanotrasen decided it was cheaper to dye the suits red instead of washing out the blood."
	icon_state = "warden"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/warden/skirt
	name = "warden's suitskirt"
	desc = "A formal security suitskirt for officers complete with Nanotrasen belt buckle."
	icon_state = "rwarden_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/warden/formal
	desc = "The insignia on this uniform tells you that this uniform belongs to the Warden."
	name = "warden's formal uniform"
	icon_state = "wardenblueclothes"
	inhand_icon_state = "wardenblueclothes"

/*
 * Detective
 */
/obj/item/clothing/under/rank/security/detective
	name = "hard-worn suit"
	desc = "Someone who wears this means business."
	icon_state = "detective"
	inhand_icon_state = "det"

/obj/item/clothing/under/rank/security/detective/skirt
	name = "detective's suitskirt"
	desc = "Someone who wears this means business."
	icon_state = "detective_skirt"
	inhand_icon_state = "det"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/detective/grey
	name = "noir suit"
	desc = "A hard-boiled private investigator's grey suit, complete with tie clip."
	icon_state = "greydet"
	inhand_icon_state = "greydet"

/obj/item/clothing/under/rank/security/detective/grey/skirt
	name = "noir suitskirt"
	desc = "A hard-boiled private investigator's grey suitskirt, complete with tie clip."
	icon_state = "greydet_skirt"
	inhand_icon_state = "greydet"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/*
 * Head of Security
 */
/obj/item/clothing/under/rank/security/head_of_security
	name = "head of security's jumpsuit"
	desc = "A security jumpsuit decorated for those few with the dedication to achieve the position of Head of Security."
	icon_state = "rhos"
	inhand_icon_state = "r_suit"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 50, WOUND = 10)
	strip_delay = 60
	// SKYRAT EDIT ADDITION START
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Basic HoS" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rhos",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rhos"
		),
		"Grey HoS" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hos",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hos"
		),
		"HoS Jumpskirt" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "rhos_skirt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "rhos_skirt"
		),
		"HoS Turtleneck" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hosalt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hosalt"
		),
		"HoS Turtleskirt" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hosalt_skirt",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hosalt_skirt"
		),
		"Parade HoS Uniform" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hos_parade_male",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hos_parade_male"
		),
		"Parade Woman's HoS Uniform" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hos_parade_fem",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hos_parade_fem"
		),
		"Formal HoS Uniform" = list(
			RESKIN_ICON = 'icons/obj/clothing/under/security.dmi',
			RESKIN_ICON_STATE = "hosblueclothes",
			RESKIN_WORN_ICON = 'icons/mob/clothing/under/security.dmi',
			RESKIN_WORN_ICON_STATE = "hosblueclothes"
		),
		"Peacekeeper" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "peacekeeper_hos",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "peacekeeper_hos"
		),
		"Imperial" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi',
			RESKIN_ICON_STATE = "imphos",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi',
			RESKIN_WORN_ICON_STATE = "imphos"
		)
	)
	/// SKYRAT EDIT ADDITION END


/obj/item/clothing/under/rank/security/head_of_security/skirt
	name = "head of security's jumpskirt"
	desc = "A security jumpskirt decorated for those few with the dedication to achieve the position of Head of Security."
	icon_state = "rhos_skirt"
	inhand_icon_state = "r_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/head_of_security/grey
	name = "head of security's grey jumpsuit"
	desc = "There are old men, and there are bold men, but there are very few old, bold men."
	icon_state = "hos"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/under/rank/security/head_of_security/alt
	name = "head of security's turtleneck"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with tactical pants."
	icon_state = "hosalt"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/rank/security/head_of_security/alt/skirt
	name = "head of security's turtleneck skirt"
	desc = "A stylish alternative to the normal head of security jumpsuit, complete with a tactical skirt."
	icon_state = "hosalt_skirt"
	inhand_icon_state = "bl_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/* //SKYRAT EDIT CHANGE - OVERRIDDEN BY modular_skyrat/modules/customization/modules/clothing/under/security.dm
/obj/item/clothing/under/rank/security/head_of_security/parade
	name = "head of security's parade uniform"
	desc = "A male head of security's luxury-wear, for special occasions."
	icon_state = "hos_parade_male"
	inhand_icon_state = "r_suit"
	can_adjust = FALSE
*/

/obj/item/clothing/under/rank/security/head_of_security/parade/female
	name = "head of security's formal uniform"
	desc = "A female head of security's luxury-wear, for special occasions."
	icon_state = "hos_parade_fem"
	inhand_icon_state = "r_suit"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/head_of_security/formal
	desc = "The insignia on this uniform tells you that this uniform belongs to the Head of Security."
	name = "head of security's formal uniform"
	icon_state = "hosblueclothes"
	inhand_icon_state = "hosblueclothes"

/*
 *Spacepol
 */

/obj/item/clothing/under/rank/security/officer/spacepol
	name = "police uniform"
	desc = "Space not controlled by megacorporations, planets, or pirates is under the jurisdiction of Spacepol."
	icon_state = "spacepol"
	inhand_icon_state = "spacepol"
	can_adjust = FALSE

/obj/item/clothing/under/rank/prisoner
	name = "prison jumpsuit"
	desc = "It's standardised Nanotrasen prisoner-wear. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "jumpsuit"
	inhand_icon_state = "jumpsuit"
	greyscale_colors = "#ff8300"
	greyscale_config = /datum/greyscale_config/jumpsuit_prison
	greyscale_config_inhand_left = /datum/greyscale_config/jumpsuit_prison_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/jumpsuit_prison_inhand_right
	greyscale_config_worn = /datum/greyscale_config/jumpsuit_prison_worn
	greyscale_config_worn_digi = /datum/greyscale_config/jumpsuit_prison_worn/digi // SKYRAT EDIT ADD
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/prisoner/skirt
	name = "prison jumpskirt"
	desc = "It's standardised Nanotrasen prisoner-wear. Its suit sensors are stuck in the \"Fully On\" position."
	icon_state = "jumpskirt"
	greyscale_colors = "#ff8300"
	greyscale_config = /datum/greyscale_config/jumpsuit_prison
	greyscale_config_inhand_left = /datum/greyscale_config/jumpsuit_prison_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/jumpsuit_prison_inhand_right
	greyscale_config_worn = /datum/greyscale_config/jumpsuit_prison_worn
	greyscale_config_worn_digi = null // SKYRAT EDIT ADD
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	fitted = FEMALE_UNIFORM_TOP

/obj/item/clothing/under/rank/security/officer/beatcop
	name = "space police uniform"
	desc = "A police uniform often found in the lines at donut shops."
	icon_state = "spacepolice_families"
	inhand_icon_state = "spacepolice_families"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/disco
	name = "superstar cop uniform"
	desc = "Flare cut trousers and a dirty shirt that might have been classy before someone took a piss in the armpits. It's the dress of a superstar."
	icon_state = "jamrock_suit"
	inhand_icon_state = "jamrock_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/kim
	name = "aerostatic suit"
	desc = "A crisp and well-pressed suit; professional, comfortable and curiously authoritative."
	icon_state = "aerostatic_suit"
	inhand_icon_state = "aerostatic_suit"
	can_adjust = FALSE
