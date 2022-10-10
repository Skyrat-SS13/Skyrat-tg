/obj/item/clothing/head/hats/flakhelm	//Actually the M1 Helmet
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "flak helmet"
	icon_state = "m1helm"
	inhand_icon_state = "helmet"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0.1, "bio" = 0, "fire" = -10, "acid" = -15, "wound" = 1)
	desc = "A dilapidated helmet used in ancient wars. This one is brittle and essentially useless. An ace of spades is tucked into the band around the outer shell."
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/flakhelm/Initialize(mapload)
	. = ..()

	create_storage(type = /datum/storage/pockets/tiny/spacenam)

/datum/storage/pockets/tiny/spacenam
	attack_hand_interact = TRUE		//So you can actually see what you stuff in there

/obj/item/clothing/head/costume/cowboyhat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "cowboy hat"
	desc = "A standard brown cowboy hat, yeehaw."
	icon_state = "cowboyhat"
	inhand_icon_state = "cowboyhat"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/costume/cowboyhat/black
	name = "black cowboy hat"
	desc = "A black cowboy hat, perfect for any outlaw"
	icon_state = "cowboyhat_black"
	inhand_icon_state = "cowboyhat_black"

/obj/item/clothing/head/costume/cowboyhat/white
	name = "white cowboy hat"
	desc = "A white cowboy hat, perfect for your every day rancher"
	icon_state = "cowboyhat_white"
	inhand_icon_state = "cowboyhat_white"

/obj/item/clothing/head/costume/cowboyhat/pink
	name = "pink cowboy hat"
	desc = "A pink cowboy? more like cowgirl hat, just don't be a buckle bunny."
	icon_state = "cowboyhat_pink"
	inhand_icon_state = "cowboyhat_pink"

/obj/item/clothing/head/costume/cowboyhat/sec
	name = "security cowboy hat"
	desc = "A security cowboy hat, perfect for any true lawman"
	icon_state = "cowboyhat_black"
	inhand_icon_state = "cowboyhat_black"
	// same armour as the sec beret
	armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 20, ACID = 50, WOUND = 4)

/obj/item/clothing/head/costume/kepi
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "kepi"
	desc = "A white cap with visor. Oui oui, mon capitane!"
	icon_state = "kepi"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/costume/kepi/old
	icon_state = "kepi_old"
	desc = "A flat, white circular cap with a visor, that demands some honor from it's wearer."

/obj/item/clothing/head/costume/maid
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "maid headband"
	desc = "Maid in China."
	icon_state = "maid"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON


//Cyberpunk PI Costume - Sprites from Eris
/obj/item/clothing/head/fedora/det_hat/cybergoggles //Subset of detective fedora so that detectives dont have to sacrifice candycorns for style
	name = "type-34C semi-enclosed headwear"
	desc = "Civilian model of a popular helmet used by certain law enforcement agencies. It does not have any armor plating, but has a neo-laminated fiber lining."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cyberpunkgoggle"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/intern/developer
	name = "intern beancap"

/obj/item/clothing/head/beret/sec/navywarden/syndicate
	name = "master at arms' beret"
	desc = "Surprisingly stylish, if you lived in a silent impressionist film."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#353535#AAAAAA"
	icon_state = "beret_badge"
	armor = list(MELEE = 40, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 30, ACID = 50, WOUND = 6)
	strip_delay = 60
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON


/obj/item/clothing/head/costume/cowboyhat/blackwide
	name = "wide brimmed black cowboy hat"
	desc = "The Man in Black, he walked the earth but is now six foot under, this hat a stark reminder. Bring your courage, your righteousness... measure it against my resolve, and you will fail."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_black"
	inhand_icon_state= "cowboy_black"


/obj/item/clothing/head/costume/cowboyhat/wide
	name = "wide-brimmed cowboy hat"
	desc = "A brown cowboy hat for blocking out the sun. Remember: Justice is truth in action. Let that guide you in the coming days."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_wide"
	inhand_icon_state= "cowboy_wide"

/obj/item/clothing/head/costume/cowboyhat/wide/sec
	name = "wide-brimmed security cowboy hat"
	desc = "A bandit turned sheriff, his enforcement is brutal but effective - whether out of fear or respect is unclear, though not many bodies hang high. A peaceful land, a quiet people."
	icon_state = "cowboy_black"
	inhand_icon_state= "cowboy_black"
	// same armour as the sec beret
	armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 20, ACID = 50, WOUND = 4)

/obj/item/clothing/head/costume/cowboyhat/sheriff
	name = "winter cowboy hat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "sheriff_hat"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	desc = "A dark hat from the cold wastes of the Frosthill mountains. So it was done, all according to the law. There's a small set of antlers embroidered on the inside."
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR | SHOWSPRITEEARS

/obj/item/clothing/head/costume/cowboyhat/sheriff/alt
	name = "sheriff hat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "sheriff_hat_alt"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	desc = "A dark brown hat with a smell of whiskey. There's a small set of antlers embroidered on the inside."
	flags_inv = SHOWSPRITEEARS

/obj/item/clothing/head/costume/cowboyhat/deputy
	name = "deputy hat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "deputy_hat"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON
	desc = "A light brown hat with a smell of iron. There's a small set of antlers embroidered on the inside."

/obj/item/clothing/head/costume/ushanka/sec
	name = "security ushanka"
	desc = "There's more to life than money, with this red ushanka, you can prove it for $19.99."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "ushankared"
	inhand_icon_state = "ushankadown"
	upsprite = "ushankaredup"
	downsprite = "ushankared"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON


/obj/item/clothing/head/costume/ushanka/sec/blue
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	desc = "There's more to life than money, with this blue ushanka, you can prove it for $19.99."
	icon_state = "ushankablue"
	inhand_icon_state = "ushankadown"
	upsprite = "ushankablueup"
	downsprite = "ushankablue"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/enclave
	name = "neo american cap"
	desc = "If worn in the battlefield or at a baseball game, it's still a rather scary hat."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "enclavesoft"
	soft_type = "enclave"
	dog_fashion = null

/obj/item/clothing/head/soft/enclaveo
	name = "neo american officer cap"
	desc = "It blocks out the sun and laser bolts from executions."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "enclaveosoft"
	soft_type = "enclaveo"
	dog_fashion = null

/obj/item/clothing/head/costume/whiterussian
	name = "papakha"
	desc = "A big wooly clump of fur designed to go on your head."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "papakha"
	dog_fashion = null
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/costume/whiterussian/white
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "papakha_white"
	dog_fashion = null

/obj/item/clothing/head/costume/whiterussian/black
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "papakha_kuban"
	dog_fashion = null

/obj/item/clothing/head/hats/sec/peacekeeper/sol
	name = "sol police cap"
	desc = "Be a proper boy in blue with this cap, comes with a black visor to block out inconvenient truths."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policeofficercap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/hos/peacekeeper/sol
	name = "sol police chief cap"
	desc = "A blue hat adorned with gold, rumoured to be used to distract Agents with its swag."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policechiefcap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/sec/peacekeeper/sol/traffic
	name = "sol traffic cop cap"
	desc = "You think that's Shitcurrity? That's just Civil Shitsputes, I'll show you REAL Shitcurrity."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policetrafficcap"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/colourable_flatcap
	name = "colourable flat cap"
	desc = "You in the computers son? You work the computers?"
	icon_state = "flatcap"
	greyscale_config = /datum/greyscale_config/flatcap
	greyscale_config_worn = /datum/greyscale_config/flatcap/worn
	greyscale_colors = "#79684c"
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/costume/flowerpin
	name = "flower pin"
	desc = "A small, colourable flower pin"
	icon_state = "flowerpin"
	greyscale_config = /datum/greyscale_config/flowerpin
	greyscale_config_worn = /datum/greyscale_config/flowerpin/worn
	greyscale_colors = "#FF0000"
	flags_1 = IS_PLAYER_COLORABLE_1
	w_class = WEIGHT_CLASS_SMALL
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/imperial
	name = "grey naval officer cap"
	desc = "A grey naval cap with a silver disk in the center."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "impcom"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/imperial/grey
	name = "dark grey naval officer cap"
	desc = "A dark grey naval cap with a silver disk in the center."
	icon_state = "impcommand"

/obj/item/clothing/head/hats/imperial/red
	name = "red naval officer cap"
	desc = "A red naval cap with a silver disk in the center."
	icon_state = "impcap_red"

/obj/item/clothing/head/hats/imperial/white
	name = "white naval officer cap"
	desc = "A white naval cap with a silver disk in the center."
	icon_state = "impcap"

/obj/item/clothing/head/hats/imperial/cap
	name = "captain's naval officer cap"
	desc = "A white naval cap with a silver disk in the center."
	icon_state = "impcap"

/obj/item/clothing/head/hats/imperial/hop
	name = "head of personnel's naval officer cap"
	desc = "An olive naval cap with a silver disk in the center."
	icon_state = "imphop"

/obj/item/clothing/head/hats/imperial/hos
	name = "head of security's naval officer cap"
	desc = "A tar black naval cap with a silver disk in the center."
	icon_state = "imphos"
/obj/item/clothing/head/hats/imperial/cmo
	name = "chief medical officer's naval cap"
	desc = "A teal naval cap with a silver disk in the center."
	icon_state = "impcmo"

/obj/item/clothing/head/hats/imperial/ce
	name = "chief engineer's blast helmet"
	desc = "Despite seeming like it's made of metal, it's actually a very cheap plastic.."
	armor = list(MELEE = 15, BULLET = 5, LASER = 20, ENERGY = 10, BOMB = 20, BIO = 10, FIRE = 100, ACID = 50, WOUND = 10)
	clothing_flags = STOPSPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	icon_state = "impce"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT


/obj/item/clothing/head/hats/imperial/helmet
	name = "blast helmet"
	desc = "A sharp helmet with some goggles on the top. Unfortunately, both those and the helmet itself are made of flimsy plastic." //No armor moment
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "blast_helmet"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hats/imperial/helmet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "goggles")

/obj/item/clothing/head/corgi/en
	name = "E-N suit head"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "enhead"
	supports_variations_flags = NONE

/obj/item/clothing/head/soft/yankee
	name = "fashionable baseball cap"
	desc = "Rimmed and brimmed."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "yankeesoft"
	soft_type = "yankee"
	dog_fashion = /datum/dog_fashion/head/yankee
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/soft/yankee/rimless
	name = "rimless fashionable baseball cap"
	desc = "Rimless for her pleasure."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "yankeenobrimsoft"
	soft_type = "yankeenobrim"

/obj/item/clothing/head/fedora/fedbrown
	name = "brown fedora"
	desc = "A noir-inspired fedora. Covers the eyes. Makes you look menacing, assuming you don't have a neckbeard."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "brfedora"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/fedora/fedblack
	name = "black fedora"
	desc = "A matte-black fedora. Looks solid enough. It'll only look good on you if you don't have a neckbeard."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "blfedora"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/costume/christmas
	name = "red christmas hat"
	desc = "A red Christmas Hat! How festive!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "christmashat"

/obj/item/clothing/head/costume/christmas/green
	name = "green christmas hat"
	desc = "A green Christmas Hat! How festive!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "christmashatg"
