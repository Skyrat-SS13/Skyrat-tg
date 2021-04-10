/obj/item/clothing/suit/wornshirt
	name = "worn shirt"
	desc = "A worn out (or perhaps just baggy), curiously comfortable t-shirt."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "wornshirt"
	inhand_icon_state = "labcoat"
	body_parts_covered = CHEST|GROIN
	mutant_variants = NONE

/obj/item/clothing/suit/toggle/labcoat/hospitalgown
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "hospital gown"
	desc = "A complicated drapery with an assortment of velcros and strings, designed to keep a patient modest during medical stay and surgeries."
	icon_state = "hgown"
	togglename = "drapes"
	body_parts_covered = NONE
	armor = NONE
	equip_delay_other = 8

/obj/item/clothing/suit/toggle/labcoat/medical
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "medical labcoat"
	desc = "A modest labcoat with medical coloring, meant to distinguish personnel in the line of duty."
	icon_state = "labcoat_gen"

/obj/item/clothing/suit/dutchjacketsr
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "Western Jacket"
	desc = "Botanists screaming of mangos have been rumored to wear this."
	icon_state = "dutchjacket"

/obj/item/clothing/suit/hawaiian_blue
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "blue hawaiian shirt"
	icon_state = "hawaiian_blue"
	desc = "Strangely en vouge with aviator wearing shibas."
	body_parts_covered = CHEST|GROIN
	mutant_variants = NONE


/obj/item/clothing/suit/hawaiian_orange
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "orange hawaiian shirt"
	icon_state = "hawaiian_orange"
	desc = "Strangely en vouge with aviator wearing shibas."
	body_parts_covered = CHEST|GROIN
	mutant_variants = NONE

/obj/item/clothing/suit/hawaiian_purple
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "purple hawaiian shirt"
	icon_state = "hawaiian_purple"
	desc = "Strangely en vouge with aviator wearing shibas."
	body_parts_covered = CHEST|GROIN
	mutant_variants = NONE


/obj/item/clothing/suit/hawaiian_green
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "green hawaiian shirt"
	icon_state = "hawaiian_green"
	desc = "Strangely en vouge with aviator wearing shibas."
	body_parts_covered = CHEST|GROIN
	mutant_variants = NONE


/obj/item/clothing/suit/frenchtrench
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "blue trenchcoat"
	icon_state = "frenchtrench"
	desc = "There's a certain timeless feeling to this coat, like it was once worn by a romantic, broken through his travels, from a schemer who hunted injustice to a traveller, however it arrived in your hands? Who knows?"

/obj/item/clothing/suit/victoriantailcoatbutler
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "caretaker tailcoat"
	desc = "You've ALWAYS been the Caretaker. I ought to know, I've ALWAYS been here."
	icon_state = "victorian_tailcoat"

/obj/item/clothing/suit/koreacoat
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "eastern winter coat"
	desc = "War crimes make people cold, not just on the inside, but on the outside as well, just ask Germany, France, Sweden, Germany again, Russia themselves and Poland, this coat's a touch more eastern, however."
	icon_state = "chi_korea_coat"

/obj/item/clothing/suit/modernwintercoatthing
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "modern winter coat"
	desc = "Warm and comfy, the inner fur seems to be removable, not this one though, someone's sewn it in and left the buttons!"
	icon_state = "modern_winter"

/obj/item/clothing/suit/toggle/jacket/cardigan
	name = "cardigan"
	desc = "It's like, half a jacket."
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "cardigan"
	mutant_variants = NONE

/obj/item/clothing/suit/toggle/jacket/cardigan/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("FFF"))

/obj/item/clothing/suit/discoblazer
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "Disco Ass Blazer"
	desc = "Looks like someone skinned this blazer off some long extinct disco-animal. It has an enigmatic white rectangle on the back and the right sleeve."
	icon_state = "jamrock_blazer"

/obj/item/clothing/suit/kimjacket
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	name = "Aerostatic Bomber Jacket"
	desc = "A jacket once worn by the Air Force during the Antecentennial Revolution, there are quite a few pockets on the inside, mostly for storing notebooks and compasses."
	icon_state = "aerostatic_bomber_jacket"
