/obj/item/clothing/glasses	//Code to let you switch the side your eyepatch is on! Woo! Just an explanation, this is added to the base glasses so it works on eyepatch-huds too
	var/can_switch_eye = FALSE	//Having this default to false means that its easy to make sure this doesnt apply to any pre-existing items


/obj/item/clothing/glasses/examine(mob/user)
	. = ..()
	if(can_switch_eye)
		. += "Use in hands to wear it over your [icon_state == base_icon_state ? "left" : "right"] eye."


/* ---------- Items Below ----------*/

/obj/item/clothing/glasses/eyepatch	//Re-defined here for ease with the left/right switch
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "eyepatch"
	base_icon_state = "eyepatch"
	can_switch_eye = TRUE

/obj/item/clothing/glasses/eyepatch/wrap
	name = "eye wrap"
	desc = "A glorified bandage. At least this one's actually made for your head..."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "eyewrap"
	base_icon_state = "eyewrap"

/obj/item/clothing/glasses/eyepatch/white
	name = "white eyepatch"
	desc = "This is what happens when a pirate gets a PhD."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "eyepatch_white"
	base_icon_state = "eyepatch_white"

///GLASSSES
/obj/item/clothing/glasses/thin
	name = "thin glasses"
	desc = "Often seen staring down at someone taking a book."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_thin"
	inhand_icon_state = "glasses"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/regular/betterunshit
	name = "modern glasses"
	desc = "After Nerd. Co went bankrupt for tax evasion and invasion, they were bought out by Dork.Co, who revamped their classic design."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "glasses_alt"
	inhand_icon_state = "glasses"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/kim
	name = "binoclard lenses"
	desc = "Stylish round lenses subtly shaded for your protection and criminal discomfort."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "binoclard_lenses"
	inhand_icon_state = "glasses"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

/obj/item/clothing/glasses/trickblindfold/hamburg
	name = "thief visor"
	desc = "Perfect for stealing hamburgers from innocent multinational capitalist monopolies."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "thiefmask"

///GOGGLES
/obj/item/clothing/glasses/biker
	name = "biker goggles"
	desc = "Brown leather riding gear, You can leave, just give us the gas."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	icon_state = "biker"
	inhand_icon_state = "welding-g"
	clothing_traits = list(TRAIT_NEARSIGHTED_CORRECTED)

// Like sunglasses, but without any protection
/obj/item/clothing/glasses/fake_sunglasses
	name = "low-UV sunglasses"
	desc = "A cheaper brand of sunglasses rated for much lower UV levels. Offers the user no protection against bright lights."
	icon_state = "sun"
	inhand_icon_state = "sunglasses"
