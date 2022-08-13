/obj/item/clothing/under/rank/civilian
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi' //Anything that was in TG's civilian.dmi, should be in our civilian_digi.dmi

/obj/item/clothing/under/rank/civilian/lawyer/beige	//Some FOOL upstream has this item's worn and object icons seperate. This sucks.
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi'

/obj/item/clothing/under/civilian/retro
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE //Just gonna set it to default for ease


//TG's files separate this into Civilian, Clown/Mime, and Curator. We wont have as many, so all Service goes into this file.
//DO NOT ADD A /obj/item/clothing/under/rank/civilian/lawyer/skyrat. USE /obj/item/clothing/under/suit/skyrat FOR MODULAR SUITS (civilian/suits.dm).

/*
*	HEAD OF PERSONNEL
*/

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/imperial //Rank pins of the Grand Moff
	name = "head of personnel's naval jumpsuit"
	desc = "A pale green naval suit and a rank badge denoting the Personnel Officer. Target, maximum firepower."
	icon_state = "imphop"
	inhand_icon_state = "g_suit"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade
	name = "head of personnel's male formal uniform"
	desc = "A luxurious uniform for the head of personnel, woven in a deep blue. On the lapel is a small pin in the shape of a corgi's head."
	icon_state = "hop_parade_male"
	inhand_icon_state = "hop_parade_male"

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade/female
	name = "head of personnel's female formal uniform"
	icon_state = "hop_parade_female"

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck
	name = "head of personnel's turtleneck"
	desc = "A soft blue turtleneck and black khakis worn by Executives who prefer a bit more comfort over style."
	icon_state = "hopturtle"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck/skirt
	name = "head of personnel's turtleneck skirt"
	desc = "A soft blue turtleneck and black skirt worn by Executives who prefer a bit more comfort over style."
	icon_state = "hopturtle_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/*
*     BARTENDER
*/

/obj/item/clothing/under/civilian/bartender/skyrat/sleeky
    icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
    worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
    name = "Sleek Bartender Suit"
    desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
    icon_state = "sleekbartender"
    supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/under/civilian/bartender/skyrat/sleeky/skirt
    icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
    worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
    name = "Sleek Bartender Skirt"
    desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
    icon_state = "sleekbartender_skirt"
    body_parts_covered = CHEST|GROIN|ARMS
    female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/*
*	RETRO CLOTHES
*/

/obj/item/clothing/under/civilian/rettro/skirt
	name = "Retro Skirt"
	desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "retro_skirt"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE

/obj/item/clothing/under/civilian/rettro/croptop
	name = "Retro Croptop"
	desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "retro_croptop"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/under/civilian/rettro/club
	name = "Retro Club Outfit"
	desc = "A outfit to go to, Da Club."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "retro_club_outfit"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/under/civilian/rettro/dress
	name = "Retro Dress"
	desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "retro_dress"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE

/obj/item/clothing/under/civilian/rettro/flashy/croptop
	name = "Flashy Croptop"
	desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "flashy_croptop"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/under/civilian/rettro/flashy/skirt
	name = "Flash Skirt"
	desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "flashy_skirt"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE

/obj/item/clothing/under/civilian/rettro/fishnet/croptop
	name = "Retro Fishnet Croptop"
	desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "retro_fishnet_croptop"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/under/civilian/rettro/tracksuit
	name = "Retro Tracksuit"
	desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "retro_suit"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_NO_VARIATION

/obj/item/clothing/under/civilian/rettro/skyrat/bouncer
	name = "Retro Bouncer Uniform"
	desc = "A Post-Postmodern take on a Retrofuturistic garment, how innovative!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	icon_state = "retro_bouncer"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_NO_VARIATION
