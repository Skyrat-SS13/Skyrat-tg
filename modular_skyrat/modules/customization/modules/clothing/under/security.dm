// MODULAR SECURITY WEAR

// HEAD OF SECURITY

/obj/item/clothing/under/rank/security/head_of_security/parade
	name = "head of security's male formal uniform"
	desc = "A luxurious uniform for the head of security, woven in a deep red. On the lapel is a small pin in the shape of a deer's head."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "hos_parade_male"
	inhand_icon_state = "hos_parade_male"
	can_adjust = FALSE

/obj/item/clothing/suit/armor/hos/parade
	name = "head of security's parade jacket"
	desc = "A luxurious deep red jacket for the head of security, woven with a golden trim. It smells of gunpowder and authority."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "hos_parade"
	inhand_icon_state = "hos_parade"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper/sol
	name = "sol chief of police uniform"
	desc = "A white satin shirt with a leather belt, the belt buckle is a large NT."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "policechiefalt"

// DETECTIVE

/obj/item/clothing/under/rank/security/detective/undersuit
	name = "detective's undersuit"
	desc = "A cool beige undersuit for the discerning PI."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "det_undersuit"
	inhand_icon_state = "det_undersuit"
	mutant_variants = NONE
	can_adjust = FALSE

/obj/item/clothing/suit/det_bomber
	name = "detective's bomber jacket"
	desc = "A classic bomber jacket in a deep red. It has a clip on the breast to attach your badge."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "det_bomber"
	inhand_icon_state = "det_bomber"
	body_parts_covered = CHEST|ARMS
	armor = list(MELEE = 25, BULLET = 10, LASER = 25, ENERGY = 35, BOMB = 0, BIO = 0, FIRE = 0, ACID = 45)
	cold_protection = CHEST|ARMS
	mutant_variants = NONE
	heat_protection = CHEST|ARMS

/obj/item/clothing/under/rank/security/detective/cowboy
	name = "blond cowboy uniform"
	desc = "A blue shirt with some cool cowboy socks. You dig."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "cowboy_uniform"
	mutant_variants = NONE
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/detective/cowboy/armorless
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 0, ACID = 0)

/obj/item/clothing/suit/cowboyvest
	name = "blonde cowboy vest"
	desc = "A white cream vest lined with... fur, of all things, for desert weather. There's a small deer head logo sewn into the vest."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "cowboy_vest"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	mutant_variants = NONE
	heat_protection = CHEST|ARMS

/obj/item/clothing/suit/det_suit/cowboyvest
	name = "blonde cowboy vest"
	desc = "A white cream vest lined with... fur, of all things, for desert weather. There's a small deer head logo sewn into the vest."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "cowboy_vest"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	mutant_variants = NONE
	heat_protection = CHEST|ARMS

/obj/item/clothing/under/rank/security/detective/runner
	name = "runner sweater"
	desc = "<i>\"You look lonely.\"</i>"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "runner"
	mutant_variants = NONE
	can_adjust = FALSE

/// SEC GENERAL

/// PRISONER
/obj/item/clothing/under/rank/prisoner/protcust
	name = "protective custody prisoner jumpsuit"
	desc = "A mustard coloured prison jumpsuit, often worn by former Security members, informants and former CentComm employees. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FFB600"

/obj/item/clothing/under/rank/prisoner/skirt/protcust
	name = "protective custody prisoner jumpskirt"
	desc = "A mustard coloured prison jumpskirt, often worn by former Security members, informants and former CentComm employees. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FFB600"
	mutant_variants = NONE

/obj/item/clothing/under/rank/prisoner/lowsec
	name = "low security prisoner jumpsuit"
	desc = "A pale, almost creamy prison jumpsuit, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#AB9278"

/obj/item/clothing/under/rank/prisoner/skirt/lowsec
	name = "low security prisoner jumpskirt"
	desc = "A pale, almost creamy prison jumpskirt, this one denotes a low security prisoner, things like fraud and anything white collar. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#AB9278"
	mutant_variants = NONE

/obj/item/clothing/under/rank/prisoner/highsec
	name = "high risk prisoner jumpsuit"
	desc = "A bright red prison jumpsuit, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FF3400"

/obj/item/clothing/under/rank/prisoner/skirt/highsec
	name = "high risk prisoner jumpskirt"
	desc = "A bright red prison jumpskirt, depending on who sees it, either a badge of honour or a sign to avoid. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#FF3400"
	mutant_variants = NONE

/obj/item/clothing/under/rank/prisoner/supermax
	name = "supermax prisoner jumpsuit"
	desc = "A dark crimson red prison jumpsuit, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#992300"

/obj/item/clothing/under/rank/prisoner/skirt/supermax
	name = "supermax prisoner jumpskirt"
	desc = "A dark crimson red prison jumpskirt, for the worst of the worst, or the Clown. Its suit sensors are stuck in the \"Fully On\" position."
	greyscale_colors = "#992300"
	mutant_variants = NONE

/obj/item/clothing/under/rank/prisoner/classic
	name = "classic prisoner jumpsuit"
	desc = "A black and white striped jumpsuit, like something out of a movie."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "prisonerclassic"
	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

///CDO
/obj/item/clothing/under/rank/security/peacekeeper/junior/sol
	name = "sol police cadet uniform"
	desc = "A light blue shirt with navy pants, perfect for pretending you matter."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "policecadetalt"

/obj/item/clothing/under/rank/security/peacekeeper/junior/sol/traffic
	name = "sol traffic police uniform"
	desc = "A light blue shirt with navy pants, perfect for standing and shouting at cars."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "policetrafficalt"
///OFFICERS
/obj/item/clothing/under/rank/security/peacekeeper/sol
	name = "sol police uniform"
	desc = "A light blue shirt with navy pants, perfect for opressing the Underclasses, like Catgirls."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "policealt"

///WARDEN
/obj/item/clothing/under/rank/security/warden/peacekeeper/sol
	name = "sol warden uniform"
	desc = "A light blue shirt with navy pants, this one seems to have been modified for fat asses, like yourself."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "policewardenalt"

///SECMED
/obj/item/clothing/under/rank/medical/doctor/red
	name = "security medic scrubs"
	desc = "It's made of a special fiber that provides minor protection against biohazards and acid. This one is in a deep red."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "scrubsred"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 30, ACID = 30, WOUND = 10)



