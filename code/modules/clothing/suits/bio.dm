//Biosuit complete with shoes (in the item sprite)
/obj/item/clothing/head/bio_hood
	name = "bio hood"
	icon_state = "bio"
	inhand_icon_state = "bio_hood"
	desc = "A hood that protects the head and face from biological contaminants."
	icon = 'icons/obj/clothing/head/bio.dmi'
	worn_icon = 'icons/mob/clothing/head/bio.dmi'
	icon_state = "bio"
	inhand_icon_state = "bio_hood"
	clothing_flags = THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT | SNUG_FIT | STACKABLE_HELMET_EXEMPT | HEADINTERNALS
	armor_type = /datum/armor/head_bio_hood
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE|HIDESNOUT
	resistance_flags = ACID_PROOF
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/obj/item/clothing/head/bio_hood/Initialize(mapload)
	. = ..()
	if(flags_inv & HIDEFACE)
		AddComponent(/datum/component/clothing_fov_visor, FOV_90_DEGREES)

/datum/armor/head_bio_hood
	bio = 100
	fire = 30
	acid = 100

/obj/item/clothing/suit/bio_suit
	name = "bio suit"
	desc = "A suit that protects against biological contamination."
	icon = 'icons/obj/clothing/suits/bio.dmi'
	icon_state = "bio"
	worn_icon = 'icons/mob/clothing/suits/bio.dmi'
	inhand_icon_state = "bio_suit"
	w_class = WEIGHT_CLASS_BULKY
	clothing_flags = THICKMATERIAL
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 0.5
	allowed = list(/obj/item/tank/internals, /obj/item/reagent_containers/dropper, /obj/item/flashlight/pen, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/reagent_containers/cup/beaker, /obj/item/gun/syringe)
	armor_type = /datum/armor/suit_bio_suit
	flags_inv = HIDEGLOVES|HIDEJUMPSUIT|HIDETAIL // SKYRAT EDIT ADDITION - HIDETAIL
	strip_delay = 70
	equip_delay_other = 70
	resistance_flags = ACID_PROOF

//Standard biosuit, orange stripe
/datum/armor/suit_bio_suit
	bio = 100
	fire = 30
	acid = 100

/obj/item/clothing/head/bio_hood/general
	icon_state = "bio"

/obj/item/clothing/suit/bio_suit/general
	icon_state = "bio"

//Virology biosuit, green stripe
/obj/item/clothing/head/bio_hood/virology
	icon_state = "bio_virology"

/obj/item/clothing/suit/bio_suit/virology
	icon_state = "bio_virology"

//Security biosuit, grey with red stripe across the chest
/obj/item/clothing/head/bio_hood/security
	armor_type = /datum/armor/bio_hood_security
	icon_state = "bio_security"

/datum/armor/bio_hood_security
	melee = 25
	bullet = 15
	laser = 25
	energy = 35
	bomb = 25
	bio = 100
	fire = 30
	acid = 100

/obj/item/clothing/suit/bio_suit/security
	armor_type = /datum/armor/bio_suit_security
	icon_state = "bio_security"

/datum/armor/bio_suit_security
	melee = 25
	bullet = 15
	laser = 25
	energy = 35
	bomb = 25
	bio = 100
	fire = 30
	acid = 100

/obj/item/clothing/suit/bio_suit/security/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

//Janitor's biosuit, grey with purple arms
/obj/item/clothing/head/bio_hood/janitor
	icon_state = "bio_janitor"

/obj/item/clothing/suit/bio_suit/janitor
	icon_state = "bio_janitor"

/obj/item/clothing/suit/bio_suit/janitor/Initialize(mapload)
	. = ..()
	allowed += list(/obj/item/storage/bag/trash, /obj/item/reagent_containers/spray)

//Scientist's biosuit, white with a pink-ish hue
/obj/item/clothing/head/bio_hood/scientist
	icon_state = "bio_scientist"

/obj/item/clothing/suit/bio_suit/scientist
	icon_state = "bio_scientist"

//CMO's biosuit, blue stripe
/obj/item/clothing/head/bio_hood/cmo
	icon_state = "bio_cmo"

/obj/item/clothing/suit/bio_suit/cmo
	icon_state = "bio_cmo"

/obj/item/clothing/suit/bio_suit/cmo/Initialize(mapload)
	. = ..()
	allowed += list(/obj/item/melee/baton/telescopic)

//Plague Dr mask can be found in clothing/masks/gasmask.dm
/obj/item/clothing/suit/bio_suit/plaguedoctorsuit
	name = "plague doctor suit"
	desc = "It protected doctors from the Black Death, back then. You bet your arse it's gonna help you against viruses."
	icon_state = "plaguedoctor"
	inhand_icon_state = "bio_suit"
	strip_delay = 40
	equip_delay_other = 20

/obj/item/clothing/suit/bio_suit/plaguedoctorsuit/Initialize(mapload)
	. = ..()
	allowed += list(/obj/item/book/bible, /obj/item/nullrod, /obj/item/cane)
