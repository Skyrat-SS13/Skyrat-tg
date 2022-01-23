/obj/item/clothing/head/flakhelm	//Actually the M1 Helmet
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "flak helmet"
	icon_state = "m1helm"
	inhand_icon_state = "helmet"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0.1, "bio" = 0, "fire" = -10, "acid" = -15, "wound" = 1)
	desc = "A dilapidated helmet used in ancient wars. This one is brittle and essentially useless. An ace of spades is tucked into the band around the outer shell."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/tiny/spacenam	//So you can stuff other things in the elastic band instead of it simply being a fluff thing.
	mutant_variants = NONE

/datum/component/storage/concrete/pockets/tiny/spacenam
	attack_hand_interact = TRUE		//So you can actually see what you stuff in there

/obj/item/clothing/head/cowboyhat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "cowboy hat"
	desc = "A standard brown cowboy hat, yeehaw."
	icon_state = "cowboyhat"
	inhand_icon_state = "cowboyhat"
	mutant_variants = NONE

/obj/item/clothing/head/cowboyhat/black
	name = "black cowboy hat"
	desc = "A black cowboy hat, perfect for any outlaw"
	icon_state = "cowboyhat_black"
	inhand_icon_state= "cowboyhat_black"

/obj/item/clothing/head/cowboyhat/white
	name = "white cowboy hat"
	desc = "A white cowboy hat, perfect for your every day rancher"
	icon_state = "cowboyhat_white"
	inhand_icon_state= "cowboyhat_white"

/obj/item/clothing/head/cowboyhat/pink
	name = "pink cowboy hat"
	desc = "A pink cowboy? more like cowgirl hat, just don't be a buckle bunny."
	icon_state = "cowboyhat_pink"
	inhand_icon_state= "cowboyhat_pink"

/obj/item/clothing/head/cowboyhat/sec
	name = "security cowboy hat"
	desc = "A security cowboy hat, perfect for any true lawman"
	icon_state = "cowboyhat_sec"
	inhand_icon_state= "cowboyhat_sec"

/obj/item/clothing/head/kepi
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "kepi"
	desc = "A white cap with visor. Oui oui, mon capitane!"
	icon_state = "kepi"
	mutant_variants = NONE

/obj/item/clothing/head/kepi/old
	icon_state = "kepi_old"
	desc = "A flat, white circular cap with a visor, that demands some honor from it's wearer."

/obj/item/clothing/head/maid
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "maid headband"
	desc = "Maid in China."
	icon_state = "maid"
	dynamic_hair_suffix = ""
	mutant_variants = NONE


//Cyberpunk PI Costume - Sprites from Eris
/obj/item/clothing/head/fedora/det_hat/cybergoggles //Subset of detective fedora so that detectives dont have to sacrifice candycorns for style
	name = "type-34C semi-enclosed headwear"
	desc = "Civilian model of a popular helmet used by certain law enforcement agencies. It does not have any armor plating, but has a neo-laminated fiber lining."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cyberpunkgoggle"
	mutant_variants = NONE

/obj/item/clothing/head/intern/developer
	name = "\improper Intern beancap"

/obj/item/clothing/head/sec/navywarden/syndicate
	name = "master at arms' beret"
	desc = "Surprisingly stylish, if you lived in a silent impressionist film."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#353535#AAAAAA"
	icon_state = "beret_badge"
	armor = list(MELEE = 40, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 30, ACID = 50, WOUND = 6)
	strip_delay = 60
	mutant_variants = NONE


/obj/item/clothing/head/cowboyhat/blackwide
	name = "wide brimmed black cowboy hat"
	desc = "The Man in Black, he walked the earth but is now six foot under, this hat a stark reminder. Bring your courage, your righteousness... measure it against my resolve, and you will fail."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_black"
	inhand_icon_state= "cowboy_black"


/obj/item/clothing/head/cowboyhat/wide
	name = "wide brimmed cowboy hat"
	desc = "A brown cowboy hat for blocking out the sun. Remember: Justice is truth in action. Let that guide you in the coming days."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_wide"
	inhand_icon_state= "cowboy_wide"

/obj/item/clothing/head/cowboyhat/widesec
	name = "wide brimmed security cowboy hat"
	desc = "A bandit turned sheriff, his enforcement is brutal but effective - whether out of fear or respect is unclear, though not many bodies hang high. A peaceful land, a quiet people."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_black_sec"
	inhand_icon_state= "cowboy_black_sec"


/obj/item/clothing/head/ushanka/sec
	name = "security ushanka"
	desc = "There's more to life than money, with this red ushanka, you can prove it for $19.99."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "ushankared"
	inhand_icon_state = "ushankadown"
	mutant_variants = NONE

/obj/item/clothing/head/ushanka/sec/blue
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "ushankablue"
	inhand_icon_state = "ushankadown"
	mutant_variants = NONE

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

/obj/item/clothing/head/whiterussian
	name = "papakha"
	desc = "A big wooly clump of fur designed to go on your head."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "papakha"
	dog_fashion = null
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	mutant_variants = NONE

/obj/item/clothing/head/whiterussian/white
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "papakha_white"
	dog_fashion = null

/obj/item/clothing/head/whiterussian/black
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "papakha_kuban"
	dog_fashion = null

/obj/item/clothing/head/sec/peacekeeper/sol
	name = "sol police cap"
	desc = "Be a proper boy in blue with this cap, comes with a black visor to block out inconvenient truths."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policeofficercap"
	mutant_variants = NONE

/obj/item/clothing/head/hos/peacekeeper/sol
	name = "sol police chief cap"
	desc = "A blue hat adorned with gold, rumoured to be used to distract Agents with its swag."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policechiefcap"
	mutant_variants = NONE

/obj/item/clothing/head/soltraffic
	name = "sol traffic cop cap"
	desc = "You think that's Shitcurrity? That's just Civil Shitsputes, I'll show you REAL Shitcurrity."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "policetrafficcap"
	mutant_variants = NONE

/obj/item/clothing/head/turb
	name = "turban"
	desc = "A cloth wrap for the head, meant for desert weather."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "turban"
	mutant_variants = NONE
	flags_inv = HIDEEARS|HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/turb/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF"))

/obj/item/clothing/head/keffiyeh
	name = "keffiyeh"
	desc = "My lawyers have advised me not to say anything related to this hat."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "keffiyeh"
	mutant_variants = NONE
	flags_inv = HIDEEARS|HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/keffiyeh/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF", "#EEEEAA", "#FFFFFF"))

/obj/item/clothing/head/hijab
	name = "hijab"
	desc = "A cloth veil traditionally worn for religious reasons."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "hijab"
	mutant_variants = NONE
	flags_inv = HIDEEARS|HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/hijab/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF"))

/obj/item/clothing/head/polyflatc
	name = "poly flat cap"
	desc = "You in the computers son? You work the computers?"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "flat_capw"
	mutant_variants = NONE

/obj/item/clothing/head/polyflatc/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF"))

/obj/item/clothing/head/flowerpin
	name = "flower pin"
	desc = "A small polychromic flower pin"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "flowerpin"
	w_class = WEIGHT_CLASS_SMALL
	mutant_variants = NONE
	var/list/poly_colors = list("#FFFFFF", "#FFFFFF", "#FFFFFF")

/obj/item/clothing/head/flowerpin/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors)


/obj/item/clothing/head/imperial
	name = "naval officer cap"
	desc = "A grey cap with a silver disk in the center."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "impcom"
	mutant_variants = NONE

/obj/item/clothing/head/imperial/hop
	name = "head of personnel's naval officer cap"
	desc = "A olive cap with a silver disk in the center."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "imphop"
	armor = list(MELEE = 25, BULLET = 15, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50)

/obj/item/clothing/head/imperial/hos
	name = "head of security's naval officer cap"
	desc = "A tar black cap with a silver disk in the center."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "imphos"
	armor = list(MELEE = 40, BULLET = 30, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 10, FIRE = 50, ACID = 60, WOUND = 10)
	strip_delay = 80

/obj/item/clothing/head/imperial/grey
	name = "grey naval officer cap"
	desc = "A light grey with a silver disk in the center."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "impcommand"

/obj/item/clothing/head/imperial/cap
	name = "captain's naval officer cap"
	desc = "A white cap with a silver disk in the center."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "impcap"
	armor = list(MELEE = 25, BULLET = 15, LASER = 25, ENERGY = 35, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50, WOUND = 5)
	strip_delay = 60

/obj/item/clothing/head/imperial/ce
	name = "chief engineer's blast helmet"
	desc = "Despite seeming like it's made of metal, it's actually a very cheap plastic.."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	armor = list(MELEE = 15, BULLET = 5, LASER = 20, ENERGY = 10, BOMB = 20, BIO = 10, FIRE = 100, ACID = 50, WOUND = 10)
	clothing_flags = STOPSPRESSUREDAMAGE
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	icon_state = "impce"

/obj/item/clothing/head/imperial/red
	name = "red naval officer cap"
	desc = "A red cap with a silver disk in the center."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "impcap_red"

/obj/item/clothing/head/imperialhelmet
	name = "blast helmet"
	desc = "A sharp helmet with some goggles on the top"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "gblast_helmet"
	mutant_variants = NONE
	var/goggles = FALSE

/obj/item/clothing/head/imperialhelmet/proc/adjust_goggles(mob/living/carbon/user) //using my own donator item as a base omegalul
	if(user?.incapacitated())
		return
	if(goggles)
		icon_state = "gblast_helmet"
		to_chat(user, span_notice("You put all your effort into pulling the goggles up."))
	else
		icon_state = "gblast_helmetv"
		to_chat(user, span_notice("You focus all your willpower to put the goggles down on your eyes."))
	goggles = !goggles
	if(user)
		user.head_update(src, forced = 1)
		user.update_action_buttons_icon()

/obj/item/clothing/head/imperialhelmet/ui_action_click(mob/living/carbon/user, action)
	adjust_goggles(user)

/obj/item/clothing/head/imperialhelmet/attack_self(mob/living/carbon/user)
	adjust_goggles(user)

/obj/item/clothing/head/corgi/en
	name = "E-N suit head"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "enhead"
	mutant_variants = NONE

/obj/item/clothing/head/cowboyhat/sheriff
	name = "winter cowboy hat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "sheriff_hat"
	mutant_variants = NONE
	desc = "A dark hat from the cold wastes of the Frosthill mountains. So it was done, all according to the law. There's a small set of antlers embroidered on the inside."
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR | SHOWSPRITEEARS

/obj/item/clothing/head/cowboyhat/sheriff/alt
	name = "sheriff hat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "sheriff_hat_alt"
	mutant_variants = NONE
	desc = "A dark brown hat with a smell of whiskey. There's a small set of antlers embroidered on the inside."

/obj/item/clothing/head/cowboyhat/deputy
	name = "deputy hat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "deputy_hat"
	mutant_variants = NONE
	desc = "A light brown hat with a smell of iron. There's a small set of antlers embroidered on the inside."

/obj/item/clothing/head/soft/yankee
	name = "fashionable baseball cap"
	desc = "Rimmed and brimmed."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "yankeesoft"
	soft_type = "yankee"
	dog_fashion = /datum/dog_fashion/head/yankee
	mutant_variants = NONE

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
	mutant_variants = NONE

/obj/item/clothing/head/fedora/fedblack
	name = "black fedora"
	desc = "A matte-black fedora. Looks solid enough. It'll only look good on you if you don't have a neckbeard."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "blfedora"
	mutant_variants = NONE

/obj/item/clothing/head/christmas
	name = "red christmas hat"
	desc = "A red Christmas Hat! How festive!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "christmashat"

/obj/item/clothing/head/christmas/green
	name = "green christmas hat"
	desc = "A green Christmas Hat! How festive!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "christmashatg"
