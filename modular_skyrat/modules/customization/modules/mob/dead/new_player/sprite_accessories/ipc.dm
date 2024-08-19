
/******************************************
************** IPC SCREENS ****************
*******************************************/
/datum/sprite_accessory/screen
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ipc_screens.dmi'
	color_src = null
	key = MUTANT_SYNTH_SCREEN
	generic = "Screen"
	relevent_layers = list(BODY_FRONT_UNDER_CLOTHES)
	organ_type = /obj/item/organ/external/synth_screen

/datum/sprite_accessory/screen/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = null

/datum/sprite_accessory/screen/blank
	name = "Blank"
	icon_state = "blank"

/datum/sprite_accessory/screen/blank_white
	name = "Blank White"
	icon_state = "blankwhite"

/datum/sprite_accessory/screen/pink
	name = "Pink"
	icon_state = "pink"

/datum/sprite_accessory/screen/green
	name = "Green"
	icon_state = "green"

/datum/sprite_accessory/screen/red
	name = "Red"
	icon_state = "red"

/datum/sprite_accessory/screen/blue
	name = "Blue"
	icon_state = "blue"

/datum/sprite_accessory/screen/yellow
	name = "Yellow"
	icon_state = "yellow"

/datum/sprite_accessory/screen/shower
	name = "Shower"
	icon_state = "shower"

/datum/sprite_accessory/screen/nature
	name = "Nature"
	icon_state = "nature"

/datum/sprite_accessory/screen/eight
	name = "Eight"
	icon_state = "eight"

/datum/sprite_accessory/screen/goggles
	name = "Goggles"
	icon_state = "goggles"

/datum/sprite_accessory/screen/heart
	name = "Heart"
	icon_state = "heart"

/datum/sprite_accessory/screen/monoeye
	name = "Mono Eye"
	icon_state = "monoeye"

/datum/sprite_accessory/screen/breakout
	name = "Breakout"
	icon_state = "breakout"

/datum/sprite_accessory/screen/purple
	name = "Purple"
	icon_state = "purple"

/datum/sprite_accessory/screen/scroll
	name = "Scroll"
	icon_state = "scroll"

/datum/sprite_accessory/screen/console
	name = "Console"
	icon_state = "console"

/datum/sprite_accessory/screen/rgb
	name = "RGB"
	icon_state = "rgb"

/datum/sprite_accessory/screen/golglider
	name = "Gol Glider"
	icon_state = "golglider"

/datum/sprite_accessory/screen/rainbow
	name = "Rainbow"
	icon_state = "rainbow"

/datum/sprite_accessory/screen/sunburst
	name = "Sunburst"
	icon_state = "sunburst"

/datum/sprite_accessory/screen/static
	name = "Static"
	icon_state = "static"

//Oracle Station sprites

/datum/sprite_accessory/screen/bsod
	name = "BSOD"
	icon_state = "bsod"

/datum/sprite_accessory/screen/redtext
	name = "Red Text"
	icon_state = "redtext"
	color_src = 0

/datum/sprite_accessory/screen/sinewave
	name = "Sine Wave"
	icon_state = "sinewave"

/datum/sprite_accessory/screen/squarewave
	name = "Square Wave"
	icon_state = "squarewave"

/datum/sprite_accessory/screen/ecgwave
	name = "ECG Wave"
	icon_state = "ecgwave"

/datum/sprite_accessory/screen/eyes
	name = "Eyes"
	icon_state = "eyes"

/datum/sprite_accessory/screen/textdrop
	name = "Text Drop"
	icon_state = "textdrop"

/datum/sprite_accessory/screen/stars
	name = "Stars"
	icon_state = "stars"


/******************************************
************** IPC Antennas ***************
*******************************************/

/datum/sprite_accessory/antenna
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/ipc_antennas.dmi'
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SECONDARY
	recommended_species = list(SPECIES_SYNTH)
	key = MUTANT_SYNTH_ANTENNA
	generic = "Antenna"
	relevent_layers = list(BODY_ADJ_LAYER)
	genetic = FALSE
	organ_type = /obj/item/organ/external/synth_antenna

/datum/sprite_accessory/antenna/is_hidden(mob/living/carbon/human/wearer)
	if(!wearer.head)
		return FALSE
	if(key in wearer.try_hide_mutant_parts)
		return TRUE
//	Exception for MODs
	if(istype(wearer.head, /obj/item/clothing/head/mod))
		return FALSE
//	Hide accessory if flagged to do so
	if((wearer.head?.flags_inv & HIDEHAIR || wearer.wear_mask?.flags_inv & HIDEHAIR) \
		// This line basically checks if we FORCE accessory-ears to show, for items with earholes like Balaclavas and Luchador masks
		&& ((wearer.head && !(wearer.head.flags_inv & SHOWSPRITEEARS)) || (wearer.wear_mask && !(wearer.wear_mask?.flags_inv & SHOWSPRITEEARS))))
		return TRUE

/datum/sprite_accessory/antenna/none
	name = SPRITE_ACCESSORY_NONE
	icon_state = "None"
	recommended_species = null

/datum/sprite_accessory/antenna/antennae
	name = "Angled Antennae"
	icon_state = "antennae"

/datum/sprite_accessory/antenna/tvantennae
	name = "TV Antennae"
	icon_state = "tvantennae"

/datum/sprite_accessory/antenna/cyberhead
	name = "Cyberhead"
	icon_state = "cyberhead"

/datum/sprite_accessory/antenna/antlers
	name = "Antlers"
	icon_state = "antlers"

/datum/sprite_accessory/antenna/crowned
	name = "Crowned"
	icon_state = "crowned"

//Chasises - snowflake phantom accessory for choosing chassises
/datum/sprite_accessory/synth_chassis
	/// Boolean for if the body is actually dimorphic.
	var/dimorphic = FALSE
	/// If true, allows for digitigrade to be used.
	var/is_digi_compatible = FALSE
	icon = BODYPART_ICON_IPC
	icon_state = "ipc"
	color_src = null
	factual = FALSE
	key = MUTANT_SYNTH_CHASSIS
	generic = "Chassis Type"

/datum/sprite_accessory/synth_chassis/default
	name = "Default Chassis"
	icon_state = "ipc"
	color_src = MUTANT_COLOR //Here it's used to tell apart greyscalling

/datum/sprite_accessory/synth_chassis/synth
	name = "Dark Chassis"
	icon_state = "synth"

/datum/sprite_accessory/synth_chassis/human
	name = "Human Chassis"
	icon = BODYPART_ICON_HUMAN
	icon_state = "human"
	color_src = MUTANT_COLOR
	dimorphic = TRUE

/datum/sprite_accessory/synth_chassis/android
	name = "Android Chassis"
	icon = 'icons/mob/augmentation/augments.dmi'
	icon_state = "robotic"

/datum/sprite_accessory/synth_chassis/mammal
	name = "Mammal Chassis"
	icon = BODYPART_ICON_SYNTHMAMMAL
	icon_state = "synthmammal"
	color_src = MUTANT_COLOR
	dimorphic = TRUE
	is_digi_compatible = TRUE

/datum/sprite_accessory/synth_chassis/lizard
	name = "Lizard Chassis"
	icon = BODYPART_ICON_SYNTHLIZARD
	icon_state = "synthliz"
	color_src = MUTANT_COLOR
	dimorphic = TRUE
	is_digi_compatible = TRUE

/datum/sprite_accessory/synth_chassis/mcgreyscale
	name = "Morpheus Cyberkinetics"
	icon_state = "mcgipc"

/datum/sprite_accessory/synth_chassis/bishopcyberkinetics
	name = "Bishop Cyberkinetics"
	icon_state = "bshipc"

/datum/sprite_accessory/synth_chassis/bishopcyberkinetics2
	name = "Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc"

/datum/sprite_accessory/synth_chassis/hephaestussindustries
	name = "Hephaestus Industries"
	icon_state = "hsiipc"

/datum/sprite_accessory/synth_chassis/hephaestussindustries2
	name = "Hephaestus Industries 2.0"
	icon_state = "hi2ipc"

/datum/sprite_accessory/synth_chassis/shellguardmunitions
	name = "Shellguard Munitions Standard Series"
	icon_state = "sgmipc"

/datum/sprite_accessory/synth_chassis/wardtakahashimanufacturing
	name = "Ward-Takahashi Manufacturing"
	icon_state = "wtmipc"

/datum/sprite_accessory/synth_chassis/xionmanufacturinggroup
	name = "Xion Manufacturing Group"
	icon_state = "xmgipc"

/datum/sprite_accessory/synth_chassis/xionmanufacturinggroup2
	name = "Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc"

/datum/sprite_accessory/synth_chassis/zenghupharmaceuticals
	name = "Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc"

/datum/sprite_accessory/synth_chassis/e3n
	name = "E3N AI"
	icon_state = "e3n"

//Heads - snowflake phantom accessory for choosing IPC heads (hell yeah!)
/datum/sprite_accessory/synth_head
	/// Boolean for if this is actually dimorphic.
	var/dimorphic = FALSE
	icon = BODYPART_ICON_IPC
	icon_state = "ipc"
	color_src = null
	factual = FALSE
	key = MUTANT_SYNTH_HEAD
	generic = "Head Type"

/datum/sprite_accessory/synth_head/default
	name = "Default Head"
	color_src = MUTANT_COLOR

/datum/sprite_accessory/synth_head/synth
	name = "Dark Head"
	icon_state = "synth"

/datum/sprite_accessory/synth_head/human
	name = "Human Head"
	icon = BODYPART_ICON_HUMAN
	icon_state = "human"
	color_src = MUTANT_COLOR
	dimorphic = TRUE

/datum/sprite_accessory/synth_head/android
	name = "Android Head"
	icon = 'icons/mob/augmentation/augments.dmi'
	icon_state = "robotic"

/datum/sprite_accessory/synth_head/mammal
	name = "Mammal Head"
	icon = BODYPART_ICON_SYNTHMAMMAL
	icon_state = "synthmammal"
	color_src = MUTANT_COLOR
	dimorphic = TRUE

/datum/sprite_accessory/synth_head/lizard
	name = "Lizard Head"
	icon = BODYPART_ICON_SYNTHLIZARD
	icon_state = "synthliz"
	color_src = MUTANT_COLOR
	dimorphic = TRUE

/datum/sprite_accessory/synth_head/mcgreyscale
	name = "Morpheus Cyberkinetics (Greyscale)"
	icon_state = "mcgipc"
	color_src = MUTANT_COLOR //Here it's used to tell apart greyscalling

/datum/sprite_accessory/synth_head/bishopcyberkinetics
	name = "Bishop Cyberkinetics"
	icon_state = "bshipc"

/datum/sprite_accessory/synth_head/bishopcyberkinetics2
	name = "Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc"

/datum/sprite_accessory/synth_head/hephaestussindustries
	name = "Hephaestus Industries"
	icon_state = "hsiipc"

/datum/sprite_accessory/synth_head/hephaestussindustries2
	name = "Hephaestus Industries 2.0"
	icon_state = "hi2ipc"

/datum/sprite_accessory/synth_head/shellguardmunitions
	name = "Shellguard Munitions Standard Series"
	icon_state = "sgmipc"

/datum/sprite_accessory/synth_head/wardtakahashimanufacturing
	name = "Ward-Takahashi Manufacturing"
	icon_state = "wtmipc"

/datum/sprite_accessory/synth_head/xionmanufacturinggroup
	name = "Xion Manufacturing Group"
	icon_state = "xmgipc"

/datum/sprite_accessory/synth_head/xionmanufacturinggroup2
	name = "Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc"

/datum/sprite_accessory/synth_head/zenghupharmaceuticals
	name = "Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc"

/datum/sprite_accessory/synth_head/e3n
	name = "E3N AI"
	icon_state = "e3n"
