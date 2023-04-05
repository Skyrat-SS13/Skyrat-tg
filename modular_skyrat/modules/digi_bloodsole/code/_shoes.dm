/obj/item/clothing/shoes/worn_overlays(isinhands = FALSE,icon_file,mutant_styles=NONE)
	. = ..()
	if(isinhands)
		return
	if(damaged_clothes)
		. += mutable_appearance('icons/effects/item_damage.dmi', "damagedshoe")
	if(GET_ATOM_BLOOD_DNA(src))
		if (mutant_styles & CLOTHING_DIGITIGRADE_VARIATION)
			if(clothing_flags & LARGE_WORN_ICON)
				. += mutable_appearance('modular_skyrat/modules/digi_bloodsole/icons/64x64.dmi', "shoeblood_large_digi")
			else
				. += mutable_appearance('modular_skyrat/modules/digi_bloodsole/icons/blood.dmi', "shoeblood_digi")
		else
			if(clothing_flags & LARGE_WORN_ICON)
				. += mutable_appearance('icons/effects/64x64.dmi', "shoeblood_large")
			else
				. += mutable_appearance('icons/effects/blood.dmi', "shoeblood")
