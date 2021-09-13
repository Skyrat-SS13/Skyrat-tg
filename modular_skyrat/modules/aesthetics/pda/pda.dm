/obj/item/pda
	icon = 'modular_skyrat/modules/aesthetics/pda/pda.dmi'

/obj/item/cartridge
	icon = 'modular_skyrat/modules/aesthetics/pda/pda.dmi'

/obj/item/cartridge/signal
	icon_state = "cart-sig"

/obj/item/cartridge/detective
	icon_state = "cart-det"

/obj/item/cartridge/lawyer
	name = "\improper S.P.A.M. cartridge"
	icon_state = "cart-spam"

/obj/item/cartridge/curator
	icon_state = "cart-lib"

/obj/item/cartridge/roboticist
	icon_state = "cart-robo"

//greyscale config
/datum/greyscale_config/pda/aesthetics
	icon_file = 'modular_skyrat/modules/aesthetics/pda/pda.dmi'
	json_config = 'code/datums/greyscale/json_configs/pda.json'

/datum/greyscale_config/pda/aesthetics/chaplain
	json_config = 'code/datums/greyscale/json_configs/pda_chaplain.json'
/*Disabled as it's haven't been use yet
/datum/greyscale_config/pda/aesthetics/clown
	json_config = 'code/datums/greyscale/json_configs/pda_clown.json'
*/
/datum/greyscale_config/pda/aesthetics/head
	json_config = 'code/datums/greyscale/json_configs/pda_head.json'

/datum/greyscale_config/pda/aesthetics/mime
	json_config = 'code/datums/greyscale/json_configs/pda_mime.json'

/datum/greyscale_config/pda/aesthetics/stripe_split
	json_config = 'code/datums/greyscale/json_configs/pda_stripe_split.json'

/datum/greyscale_config/pda/aesthetics/stripe_thick
	json_config = 'code/datums/greyscale/json_configs/pda_stripe_thick.json'

/datum/greyscale_config/pda/aesthetics/stripe_thick/head
	json_config = 'code/datums/greyscale/json_configs/pda_stripe_thick_head.json'

//PDA GAGS
/obj/item/pda
	greyscale_config = /datum/greyscale_config/pda/aesthetics
	greyscale_colors = "#a2b4cf#6ab73b"

/obj/item/pda/medical
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#d6d9e0#262d99#65c9ff"

/obj/item/pda/viro
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_split
	greyscale_colors = "#d6d9e0#6ab73b#6df782"

/obj/item/pda/engineering
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#dab424#2a3198#a22626"

/obj/item/pda/security
	greyscale_colors = "#d13c3c#6ab73b"

/obj/item/pda/detective
	greyscale_colors = "#c66a42#262d99"

/obj/item/pda/warden
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#d13c3c#6ab73b#ffc900"

/obj/item/pda/janitor
	greyscale_colors = "#bda2cf#d13c3c"

/obj/item/pda/toxins
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#d6d9e0#262d99#c28be5"

/obj/item/pda/heads
	greyscale_config = /datum/greyscale_config/pda/aesthetics/head
	greyscale_colors = "#a2b4cf#262d99"

/obj/item/pda/heads/hop
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick/head
	greyscale_colors = "#a2b4cf#262d99#65c9ff"

/obj/item/pda/heads/hos
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick/head
	greyscale_colors = "#d13c3c#262d99#65c9ff"

/obj/item/pda/heads/ce
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick/head
	greyscale_colors = "#dab424#262d99#65c9ff"

/obj/item/pda/heads/cmo
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick/head
	greyscale_colors = "#d6d9e0#262d99#65c9ff"

/obj/item/pda/heads/rd
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick/head
	greyscale_colors = "#d6d9e0#262d99#c28be5"

/obj/item/pda/captain
	icon_state = "pda-captain"
	greyscale_config = null
	greyscale_colors = null
	//greyscale_colors = "#fff8b9#262d99"

/obj/item/pda/cargo
	greyscale_colors = "#e39751#a92323"

/obj/item/pda/quartermaster
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#e39751#a92323#a23e3e"

/obj/item/pda/shaftminer
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#e4c774#9d2525#c28be5"

/obj/item/pda/syndicate
	greyscale_colors = "#9d2525#262d99"

/obj/item/pda/chaplain
	greyscale_config = /datum/greyscale_config/pda/aesthetics/chaplain
	greyscale_colors = "#6d6a81#262d99"

/obj/item/pda/lawyer//add split stripe
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_split
	greyscale_colors = "#c3b9c8#ffff84#fff284"
	//greyscale_colors = "#c3b9c8#ffff84"

/obj/item/pda/botanist
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#95c47f#ffc900#6df782"

/obj/item/pda/roboticist
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_split
	greyscale_colors = "#6d6a81#9d2525#ff9112"

/obj/item/pda/curator
	overlays_x_offset = 0
/*
	icon_state = "pda-library"
	greyscale_config = null
	greyscale_colors = null

/obj/item/pda/clear
	icon_state = "pda-clear"
	greyscale_config = null
	greyscale_colors = null
*/
/obj/item/pda/cook//add split stripe
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_split
	greyscale_colors = "#d6d9e0#9d2525#d13c3c"
	//greyscale_colors = "#d6d9e0#9d2525"

/obj/item/pda/bar//add split stripe
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_split
	greyscale_colors = "#6d6a81#d6d9e0#d6d9e0"
	//greyscale_colors = "#6d6a81#d6d9e0"

/obj/item/pda/atmos
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#dab424#2a3198#3daaf0"

/obj/item/pda/chemist
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#d6d9e0#262d99#ff9112"

/obj/item/pda/geneticist
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_split
	greyscale_colors = "#d6d9e0#262d99#4049e0"

/obj/item/pda/blueshield
	name = "blueshield PDA"
	default_cartridge = /obj/item/cartridge/hos
	greyscale_config = /datum/greyscale_config/pda/aesthetics/stripe_thick
	greyscale_colors = "#a2b4cf#6ab73b#3399cc"

/obj/item/pda/mime
	greyscale_config = /datum/greyscale_config/pda/aesthetics/mime
	greyscale_colors = "#d6d9e0#9d2525"
/*
/obj/item/pda/clown
	icon_state = "pda-clown"
	greyscale_config = null
	greyscale_config = null
*/
