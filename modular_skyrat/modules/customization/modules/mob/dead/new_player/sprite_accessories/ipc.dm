
/******************************************
************** IPC SCREENS ****************
*******************************************/
/datum/sprite_accessory/screen
	icon = 'modular_skyrat/modules/customization/icons/mob/sprite_accessory/ipc_screens.dmi'
	color_src = null
	key = "ipc_screen"
	generic = "Screen"
	relevent_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/screen/blank
	name = "Blank"
	icon_state = "blank"
	color_src = 1

/datum/sprite_accessory/screen/pink
	name = "Pink"
	icon_state = "pink"
	color_src = 1

/datum/sprite_accessory/screen/green
	name = "Green"
	icon_state = "green"
	color_src = 1

/datum/sprite_accessory/screen/red
	name = "Red"
	icon_state = "red"
	color_src = 1

/datum/sprite_accessory/screen/blue
	name = "Blue"
	icon_state = "blue"
	color_src = 1

/datum/sprite_accessory/screen/yellow
	name = "Yellow"
	icon_state = "yellow"
	color_src = 1

/datum/sprite_accessory/screen/shower
	name = "Shower"
	icon_state = "shower"
	color_src = 1

/datum/sprite_accessory/screen/nature
	name = "Nature"
	icon_state = "nature"
	color_src = 1

/datum/sprite_accessory/screen/eight
	name = "Eight"
	icon_state = "eight"
	color_src = 1

/datum/sprite_accessory/screen/goggles
	name = "Goggles"
	icon_state = "goggles"
	color_src = 1

/datum/sprite_accessory/screen/heart
	name = "Heart"
	icon_state = "heart"
	color_src = 1

/datum/sprite_accessory/screen/monoeye
	name = "Mono eye"
	icon_state = "monoeye"
	color_src = 1

/datum/sprite_accessory/screen/breakout
	name = "Breakout"
	icon_state = "breakout"
	color_src = 1

/datum/sprite_accessory/screen/purple
	name = "Purple"
	icon_state = "purple"
	color_src = 1

/datum/sprite_accessory/screen/scroll
	name = "Scroll"
	icon_state = "scroll"
	color_src = 1

/datum/sprite_accessory/screen/console
	name = "Console"
	icon_state = "console"
	color_src = 1

/datum/sprite_accessory/screen/rgb
	name = "RGB"
	icon_state = "rgb"


/datum/sprite_accessory/screen/golglider
	name = "Gol Glider"
	icon_state = "golglider"
	color_src = 1

/datum/sprite_accessory/screen/rainbow
	name = "Rainbow"
	icon_state = "rainbow"

/datum/sprite_accessory/screen/sunburst
	name = "Sunburst"
	icon_state = "sunburst"
	color_src = 1

/datum/sprite_accessory/screen/static
	name = "Static"
	icon_state = "static"
	color_src = 1

//Oracle Station sprites

/datum/sprite_accessory/screen/bsod
	name = "BSOD"
	icon_state = "bsod"
	color_src = 1

/datum/sprite_accessory/screen/redtext
	name = "Red Text"
	icon_state = "retext"

/datum/sprite_accessory/screen/sinewave
	name = "Sine wave"
	icon_state = "sinewave"
	color_src = 1

/datum/sprite_accessory/screen/squarewave
	name = "Square wave"
	icon_state = "squarwave"
	color_src = 1

/datum/sprite_accessory/screen/ecgwave
	name = "ECG wave"
	icon_state = "ecgwave"
	color_src = 1

/datum/sprite_accessory/screen/eyes
	name = "Eyes"
	icon_state = "eyes"
	color_src = 1

/datum/sprite_accessory/screen/textdrop
	name = "Text drop"
	icon_state = "textdrop"
	color_src = 1

/datum/sprite_accessory/screen/stars
	name = "Stars"
	icon_state = "stars"
	color_src = 1


/******************************************
************** IPC Antennas ***************
*******************************************/

/datum/sprite_accessory/antenna
	icon = 'modular_skyrat/modules/customization/icons/mob/sprite_accessory/ipc_antennas.dmi'
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SECONDARY
	recommended_species = list("ipc")
	key = "ipc_antenna"
	generic = "Antenna"
	relevent_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/antenna/none
	name = "None"
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
/datum/sprite_accessory/ipc_chassis
	icon = null
	icon_state = "ipc"
	color_src = null
	factual = FALSE
	key = "ipc_chassis"
	generic = "Chassis Type"

/datum/sprite_accessory/ipc_chassis/mcgreyscale
	name = "Morpheus Cyberkinetics(Greyscale)"
	icon_state = "mcgipc"
	color_src = 1 //Here it's used to tell apart greyscalling

/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics
	name = "Bishop Cyberkinetics"
	icon_state = "bshipc"
	color_src = 1

/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics2
	name = "Bishop Cyberkinetics 2.0"
	icon_state = "bs2ipc"
	color_src = 1

/datum/sprite_accessory/ipc_chassis/hephaestussindustries
	name = "Hephaestus Industries"
	icon_state = "hsiipc"
	color_src = 1

/datum/sprite_accessory/ipc_chassis/hephaestussindustries2
	name = "Hephaestus Industries 2.0"
	icon_state = "hi2ipc"
	color_src = 1

/datum/sprite_accessory/ipc_chassis/shellguardmunitions
	name = "Shellguard Munitions Standard Series"
	icon_state = "sgmipc"
	color_src = 1

/datum/sprite_accessory/ipc_chassis/wardtakahashimanufacturing
	name = "Ward-Takahashi Manufacturing"
	icon_state = "wtmipc"
	color_src = 1

/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup
	name = "Xion Manufacturing Group"
	icon_state = "xmgipc"
	color_src = 1

/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup2
	name = "Xion Manufacturing Group 2.0"
	icon_state = "xm2ipc"
	color_src = 1

/datum/sprite_accessory/ipc_chassis/zenghupharmaceuticals
	name = "Zeng-Hu Pharmaceuticals"
	icon_state = "zhpipc"
	color_src = 1
