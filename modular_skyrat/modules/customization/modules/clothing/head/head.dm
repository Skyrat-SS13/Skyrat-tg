/obj/item/clothing/head/flakhelm	//Actually the M1 Helmet
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	name = "flak helmet"
	icon_state = "m1helm"
	inhand_icon_state = "helmet"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0.1, "bio" = 0, "rad" = 0, "fire" = -10, "acid" = -15, "wound" = 1)
	desc = "A dilapidated helmet used in ancient wars. This one is brittle and essentially useless. An ace of spades is tucked into the band around the outer shell."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/tiny/spacenam	//So you can stuff other things in the elastic band instead of it simply being a fluff thing.
	mutant_variants = NONE

/datum/component/storage/concrete/pockets/tiny/spacenam
	attack_hand_interact = TRUE		//So you can actually see what you stuff in there

/obj/item/clothing/head/cowboyhat
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
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
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	name = "kepi"
	desc = "A white cap with visor. Oui oui, mon capitane!"
	icon_state = "kepi"
	mutant_variants = NONE

/obj/item/clothing/head/kepi/old
	icon_state = "kepi_old"
	desc = "A flat, white circular cap with a visor, that demands some honor from it's wearer."

/obj/item/clothing/head/maid
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	name = "maid headband"
	desc = "Maid in China."
	icon_state = "maid"
	dynamic_hair_suffix = ""
	mutant_variants = NONE

/obj/item/clothing/head/beret/white
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	name = "beret"
	icon_state = "beret_white"

//Cyberpunk PI Costume - Sprites from Eris
/obj/item/clothing/head/fedora/det_hat/cybergoggles //Subset of detective fedora so that detectives dont have to sacrifice candycorns for style
	name = "type-34C semi-enclosed headwear"
	desc = "Civilian model of a popular helmet used by certain law enforcement agencies. It does not have any armor plating, but has a neo-laminated fiber lining."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "cyberpunkgoggle"
	mutant_variants = NONE

/obj/item/clothing/head/intern/developer
	name = "\improper Intern beancap"

/obj/item/clothing/head/warden/syndicate
	name = "master at arms' beret"
	desc = "Surprisingly stylish, if you lived in a silent impressionist film."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "syndwardenberet"
	dog_fashion = null


/obj/item/clothing/head/cowboyhat/blackwide
	name = "wide brimmed black cowboy hat"
	desc = "The Man in Black, he walked the earth but is now six foot under, this hat a stark reminder. Bring your courage, your righteousness... measure it against my resolve, and you will fail."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_black"
	inhand_icon_state= "cowboy_black"


/obj/item/clothing/head/cowboyhat/wide
	name = "wide brimmed cowboy hat"
	desc = "A brown cowboy hat for blocking out the sun. Remember: Justice is truth in action. Let that guide you in the coming days."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_wide"
	inhand_icon_state= "cowboy_wide"

/obj/item/clothing/head/cowboyhat/widesec
	name = "wide brimmed security cowboy hat"
	desc = "A bandit turned Sherriff, his enforcement is brutal but effective, if out of fear or respect, not many bodies hang high. A peaceful land, a quiet people."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_black_sec"
	inhand_icon_state= "cowboy_black_sec"


/obj/item/clothing/head/ushankasec
	name = "security ushanka"
	desc = "There's more to life than money, with this red ushanka, you can prove it for $19.99."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "ushankared"
	inhand_icon_state = "ushankadown"
	flags_inv = HIDEEARS|HIDEHAIR
	var/earflaps = TRUE
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/ushankasec/attack_self(mob/user)
	if(earflaps)
		icon_state = "ushankaredup"
		inhand_icon_state = "ushankaup"
		to_chat(user, "<span class='notice'>You raise the ear flaps on the ushanka.</span>")
	else
		icon_state = "ushankared"
		inhand_icon_state = "ushankadown"
		to_chat(user, "<span class='notice'>You lower the ear flaps on the ushanka.</span>")
	earflaps = !earflaps

/obj/item/clothing/head/soft/enclave
	name = "neo american cap"
	desc = "If worn in the battlefield or at a baseball game, it's still a rather scary hat."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "enclavesoft"
	soft_type = "enclave"
	dog_fashion = null

/obj/item/clothing/head/soft/enclaveo
	name = "neo american officer cap"
	desc = "It blocks out the sun and laser bolts from executions."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "enclaveosoft"
	soft_type = "enclaveo"
	dog_fashion = null
