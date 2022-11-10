/obj/item/clothing/suit/hooded/wintercoat
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/hooded/wintercoat/paramedic
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "paramedic winter coat"
	desc = "A winter coat with blue markings. Warm, but probably won't protect from biological agents. For the cozy doctor on the go."
	icon_state = "coatparamed"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/cup/bottle, /obj/item/reagent_containers/cup/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "fire" = 0, "acid" = 45, "wound" = 3)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/paramedic

/obj/item/clothing/head/hooded/winterhood/paramedic
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	desc = "A white winter coat hood with blue markings."
	icon_state = "winterhood_paramed"

/obj/item/clothing/suit/hooded/wintercoat/robotics
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "robotics winter coat"
	desc = "A black winter coat with a badass flaming robotic skull for the zipper tab. This one has bright red designs and a few useless buttons."
	icon_state = "coatrobotics"
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/melee/baton/telescopic, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/screwdriver, /obj/item/crowbar, /obj/item/wrench, /obj/item/stack/cable_coil, /obj/item/weldingtool, /obj/item/multitool)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 10, "bio" = 0, "fire" = 0, "acid" = 0, "wound" = 0)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/robotics

/obj/item/clothing/head/hooded/winterhood/robotics
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	desc = "A black winter coat hood. You can pull it down over your eyes and pretend that you're an outdated, late 1980s interpretation of a futuristic mechanized police force. They'll fix you. They fix everything."
	icon_state = "winterhood_robotics"

/obj/item/clothing/suit/hooded/wintercoat/aformal
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "assistant's formal winter coat"
	desc = "A black button up winter coat."
	icon_state = "coataformal"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter,/obj/item/clothing/gloves/color/yellow)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/aformal

/obj/item/clothing/head/hooded/winterhood/aformal
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	desc = "A black winter coat hood."
	icon_state = "winterhood_aformal"

/obj/item/clothing/suit/hooded/wintercoat/ratvar
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "ratvarian winter coat"
	desc = "A brass-plated button up winter coat. Instead of a zipper tab, it has a brass cog with a tiny red gemstone inset."
	icon_state = "coatratvar"
	armor = list("melee" = 30, "bullet" = 45, "laser" = -10, "energy" = 0, "bomb" = 30, "bio" = 0, "fire" = 60, "acid" = 60, "wound" = 10)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/ratvar

/obj/item/clothing/head/hooded/winterhood/ratvar
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_ratvar"
	desc = "A brass-plated winter hood that glows softly, hinting at its divinity."
	light_range = 3
	light_power = 1
	light_color = "#B18B25" //clockwork slab background top color

/obj/item/clothing/suit/hooded/wintercoat/narsie
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "narsian winter coat"
	desc = "A somber button-up in tones of grey entropy and a wicked crimson zipper. When pulled all the way up, the zipper looks like a bloody gash. The zipper pull looks like a single drop of blood."
	icon_state = "coatnarsie"
	armor = list("melee" = 30, "bullet" = 20, "laser" = 30,"energy" = 10, "bomb" = 30, "bio" = 10, "fire" = 30, "acid" = 30, "wound" = 10)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter, /obj/item/restraints/legcuffs/bola/cult,/obj/item/melee/cultblade,/obj/item/melee/cultblade/dagger,/obj/item/reagent_containers/cup/beaker/unholywater,/obj/item/cult_shift,/obj/item/flashlight/flare/culttorch,/obj/item/melee/cultblade/halberd)
	hoodtype = /obj/item/clothing/head/hooded/winterhood/narsie

/obj/item/clothing/head/hooded/winterhood/narsie
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	desc = "A black winter hood full of whispering secrets that only She shall ever know."
	icon_state = "winterhood_narsie"

/obj/item/clothing/suit/hooded/wintercoat/ratvar/fake
	name = "brass winter coat"
	desc = "A brass-plated button up winter coat. Instead of a zipper tab, it has a brass cog with a tiny red piece of plastic as an inset."
	icon_state = "coatratvar"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0, "wound" = 0)

/obj/item/clothing/suit/hooded/wintercoat/narsie/fake
	name = "runed winter coat"
	desc = "A dusty button up winter coat in the tones of oblivion and ash. The zipper pull looks like a single drop of blood."
	icon_state = "coatnarsie"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy, /obj/item/storage/fancy/cigarettes, /obj/item/lighter)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0, "wound" = 0)

/obj/item/clothing/suit/flakjack
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "flak jacket"
	desc = "A dilapidated jacket made of a supposedly bullet-proof material (Hint: It isn't.). Smells faintly of napalm."
	icon_state = "flakjack"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST
	resistance_flags = NONE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 5, "bio" = 0, "fire" = -5, "acid" = -15, "wound" = 0) //nylon sucks against acid
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/hooded/cloak/david
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	name = "red cloak"
	icon_state = "goliath_cloak"
	desc = "Ever wanted to look like a badass without ANY effort? Try this nanotrasen brand red cloak, perfect for kids"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/david
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/hooded/cloakhood/david
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	name = "red cloak hood"
	icon_state = "golhood"
	desc = "conceal your face in shame with this nanotrasen brand hood"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/urban
	name = "urban coat"
	desc = "A coat built for urban life."
	icon_state = "urban_coat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/urban_coat
	greyscale_config_worn = /datum/greyscale_config/urban_coat/worn
	greyscale_colors = "#252e5a#938060#66562b"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/deckard
	name = "runner coat"
	desc = "They say you overused reference. Tell them you're eating in this lovely coat, a long flowing brown one."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "deckard"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	inhand_icon_state = "det_suit"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list(MELEE = 25, BULLET = 10, LASER = 25, ENERGY = 35, BOMB = 0, BIO = 0, FIRE = 0, ACID = 45)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/jacket/leather/colourable
	desc = "Now with more color!"
	icon_state = "leather_jacket"
	greyscale_config = /datum/greyscale_config/leather_jacket
	greyscale_config_worn = /datum/greyscale_config/leather_jacket/worn
	greyscale_colors = "#FFFFFF"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/duster
	name = "duster"
	desc = "This station ain't big enough for the both of us."
	icon_state = "duster"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/duster
	greyscale_config_worn = /datum/greyscale_config/duster/worn
	greyscale_colors = "#954b21"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/peacoat
	name = "peacoat"
	desc = "The way you guys are blending in with the local colour. I mean, Flag Girl was bad enough, but U-Boat Captain?"
	icon_state = "peacoat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/peacoat
	greyscale_config_worn = /datum/greyscale_config/peacoat/worn
	greyscale_colors = "#61618a"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/suit/toggle/lawyer/black/better
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "suitjacket_black"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/costume/poncho
    supports_variations_flags = STYLE_TAUR_ALL

/obj/item/clothing/suit/apron
    supports_variations_flags = STYLE_TAUR_ALL

/obj/item/clothing/suit/toggle/lawyer/white
	name = "white suit jacket"
	desc = "A very versatile part of a suit ensable. Oddly in fashion with mobsters."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "suitjacket_white"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/hooded/wintercoat/christmas
	name = "red christmas coat"
	desc = "A festive red Christmas coat! Smells like Candy Cane!"
	icon_state = "christmascoatr"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	hoodtype = /obj/item/clothing/head/hooded/winterhood/christmas

/obj/item/clothing/head/hooded/winterhood/christmas
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "christmashoodr"

/obj/item/clothing/suit/hooded/wintercoat/christmas/green
	name = "green christmas coat"
	desc = "A festive green Christmas coat! Smells like Candy Cane!"
	icon_state = "christmascoatg"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	hoodtype = /obj/item/clothing/head/hooded/winterhood/christmas/green

/obj/item/clothing/head/hooded/winterhood/christmas/green
	icon_state = "christmashoodg"

/obj/item/clothing/suit/hooded/wintercoat/christmas/gamerpc
	name = "red and green christmas coat"
	desc = "A festive red and green Christmas coat! Smells like Candy Cane!"
	icon_state = "christmascoatrg"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/christmas/gamerpc

/obj/item/clothing/head/hooded/winterhood/christmas/gamerpc
	icon_state = "christmashoodrg"

/obj/item/clothing/suit/armor/vest/det_suit/runner
	name = "joyful coat"
	desc = "<i>\"You look like a good Joe.\"</i>"
	icon_state = "bladerunner_neue"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	heat_protection = CHEST|ARMS|GROIN|LEGS
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	blood_overlay_type = "coat"

/obj/item/clothing/suit/croptop
	name = "black crop top turtleneck"
	desc = "A comfy looking turtleneck that exposes your midriff, fashionable but makes the point of a sweater moot."
	icon_state = "croptop_black"
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/varsity
	name = "varsity jacket"
	desc = "A simple varsity jacket with no obvious sources."
	icon_state = "varsity_jacket"
	greyscale_config = /datum/greyscale_config/varsity
	greyscale_config_worn = /datum/greyscale_config/varsity/worn
	greyscale_colors = "#553022#a67a5b#2d2d33"
	body_parts_covered = CHEST|GROIN|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/hooded/leather
	name = "hooded leather coat"
	desc = "A simple leather coat with a hoodie underneath it, not really hooded is it?"
	icon_state = "leatherhoodie"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	hoodtype = /obj/item/clothing/head/hooded/leather

/obj/item/clothing/head/hooded/leather
	name = "jacket hood"
	desc = "A hood attached to a hoodie, nothing special."
	icon_state = "leatherhood"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	flags_inv = HIDEHAIR
