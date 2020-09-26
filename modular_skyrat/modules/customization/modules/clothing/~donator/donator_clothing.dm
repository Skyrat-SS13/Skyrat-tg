/**************SKYRAT REWARDS**************/
//Donation reward for Random516
/obj/item/clothing/head/drake_skull
	name = "skull of an ashdrake"
	desc = "How did they get this?"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/hats.dmi'
	icon_state = "drake_skull"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/large-worn-icons/32x64/head.dmi'
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

//Donation reward for Random516
/obj/item/clothing/gloves/fingerless/blutigen_wraps
	name = "Blutigen Wraps"
	desc = "The one who wears these had everything and yet lost it all..."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/gloves.dmi'
	icon_state = "blutigen_wraps"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/hands.dmi'

//Donation reward for Random516
/obj/item/clothing/suit/blutigen_kimono
	name = "Blutigen Kimono"
	desc = "For the eyes bestowed upon this shall seek adventure..."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/suits.dmi'
	icon_state = "blutigen_kimono"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	mutant_variants = NONE

//Donation reward for Random516
/obj/item/clothing/under/custom/blutigen_undergarment
	name = "Dragon Undergarments"
	desc = "The Dragon wears the sexy?"
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	icon_state = "blutigen_undergarment"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	mutant_variants = NONE
	fitted = FEMALE_UNIFORM_TOP

//Donation reward for NetraKyram
/obj/item/clothing/under/custom/kilano
	name = "black and gold dress uniform"
	desc = "A light black and gold dress made out some sort of silky material."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/uniform.dmi'
	icon_state = "kilanosuit"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/uniform.dmi'
	mutant_variants = NONE
	fitted = FEMALE_UNIFORM_TOP

//Donation reward for NetraKyram
/obj/item/clothing/gloves/kilano
	name = "black and gold gloves"
	desc = "Some black and gold gloves, It seems like they're made to match something."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/gloves.dmi'
	icon_state = "kilanogloves"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/hands.dmi'

//Donation reward for NetraKyram
/obj/item/clothing/shoes/winterboots/kilano
	name = "black and gold boots"
	desc = "Some heavy furred boots, why would you need fur on a space station? Seems redundant."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/shoes.dmi'
	icon_state = "kilanoboots"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/feet.dmi'
	mutant_variants = NONE


/****************LEGACY REWARDS***************/
//Donation reward for inferno707
/obj/item/clothing/neck/cloak/inferno
	name = "Kiara's Cloak"
	desc = "The design on this seems a little too familiar."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	icon_state = "infcloak"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

//Donation reward for inferno707
/obj/item/clothing/neck/human_petcollar/inferno
	name = "Kiara's Collar"
	desc = "A soft black collar that seems to stretch to fit whoever wears it."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	icon_state = "infcollar"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	tagname = null

//Donation reward for inferno707
/obj/item/clothing/accessory/medal/steele
	name = "Insignia Of Steele"
	desc = "An intricate pendant given to those who help a key member of the Steele Corporation."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	icon_state = "steele"
	medaltype = "medal-silver"

//Donation reward for inferno707
/obj/item/toy/darksabre
	name = "Kiara's Sabre"
	desc = "This blade looks as dangerous as its owner."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	icon_state = "darksabre"
	lefthand_file = 'modular_skyrat/modules/customization/icons/~donator/mob/inhands/donator_left.dmi'
	righthand_file = 'modular_skyrat/modules/customization/icons/~donator/mob/inhands/donator_right.dmi'

/obj/item/toy/darksabre/get_belt_overlay()
	return mutable_appearance('modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi', "darksheath-darksabre")

//Donation reward for inferno707
/obj/item/storage/belt/sabre/darksabre
	name = "Ornate Sheathe"
	desc = "An ornate and rather sinister looking sabre sheathe."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	icon_state = "darksheath"

/obj/item/storage/belt/sabre/darksabre/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.set_holdable(list(
		/obj/item/toy/darksabre
		))

/obj/item/storage/belt/sabre/darksabre/PopulateContents()
	new /obj/item/toy/darksabre(src)
	update_icon()

//Donation reward for inferno707
/obj/item/clothing/suit/armor/vest/darkcarapace
	name = "Dark Armor"
	desc = "A dark, non-functional piece of armor sporting a red and black finish."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/custom.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/custom_w.dmi'
	icon_state = "darkcarapace"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	mutant_variants = NONE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

//Donation reward for inferno707
/obj/item/clothing/mask/hheart
	name = "Hollow Heart"
	desc = "It's an odd ceramic mask. Set in the internal side are several suspicious electronics branded by Steele Tech."
	icon = 'modular_skyrat/modules/customization/icons/~donator/obj/clothing/masks.dmi'
	icon_state = "hheart"
	worn_icon = 'modular_skyrat/modules/customization/icons/~donator/mob/clothing/mask.dmi'
	var/c_color_index = 1
	var/list/possible_colors = list("off", "blue", "red")
	actions_types = list(/datum/action/item_action/hheart)
	mutant_variants = NONE

/obj/item/clothing/mask/hheart/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/mask/hheart/update_icon()
	. = ..()
	icon_state = "hheart-[possible_colors[c_color_index]]"

/datum/action/item_action/hheart
	name = "Toggle Mode"
	desc = "Toggle the color of the hollow heart."

/obj/item/clothing/mask/hheart/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/hheart))
		if(!isliving(user))
			return
		var/mob/living/ooser = user
		var/the = possible_colors.len
		var/index = 0
		if(c_color_index >= the)
			index = 1
		else
			index = c_color_index + 1
		c_color_index = index
		update_icon()
		ooser.update_inv_wear_mask()
		ooser.update_action_buttons_icon()
		to_chat(ooser, "<span class='notice'>You toggle the [src] to [possible_colors[c_color_index]].</span>")
