/obj/item/organ/genital
	color = "#fcccb3"
	organ_flags = ORGAN_EDIBLE | ORGAN_NO_DISMEMBERMENT
	///Size value of the genital, needs to be translated to proper lengths/diameters/cups
	var/genital_size = 1
	///Type of the genital. For penises tapered/horse/human etc. for breasts quadruple/sixtuple etc...
	var/genital_type = "human"
	///Used for determining what sprite is being used, derrives from size and type
	var/sprite_suffix 
	///Used for input from the user whether to show a genital through clothing or not, always or never etc.
	var/visibility_preference = GENITAL_HIDDEN_BY_CLOTHES

//This translates the float size into a sprite string
/obj/item/organ/genital/proc/get_sprite_size_string()
	return 0

//This translates the float size into a sprite string
/obj/item/organ/genital/proc/update_sprite_suffix()
	sprite_suffix = "[genital_type]_[get_sprite_size_string()]"

/obj/item/organ/genital/proc/get_description_string()
	return "genitals"

/obj/item/organ/genital/proc/set_size(size)
	genital_size = size
	update_sprite_suffix()

/obj/item/organ/genital/penis
	name = "penis"
	desc = "A male reproductive organ."
	icon_state = "penis"
	icon = 'modular_skyrat/icons/obj/genitals/penis.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_PENIS

/obj/item/organ/genital/testicles
	name = "testicles"
	desc = "A male reproductive organ."
	icon_state = "testicles"
	icon = 'modular_skyrat/icons/obj/genitals/testicles.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES

/obj/item/organ/genital/vagina
	name = "vagina"
	icon = 'modular_skyrat/icons/obj/genitals/vagina.dmi'
	icon_state = "vagina"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA

/obj/item/organ/genital/womb
	name = "womb"
	desc = "A female reproductive organ."
	icon = 'modular_skyrat/icons/obj/genitals/vagina.dmi'
	icon_state = "womb"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_WOMB
	visibility_preference = GENITAL_SKIP_VISIBILITY

/obj/item/organ/genital/breasts
	name = "breasts"
	desc = "Female milk producing organs."
	icon_state = "breasts"
	icon = 'modular_skyrat/icons/obj/genitals/breasts.dmi'
	genital_type = "pair"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS

/obj/item/organ/genital/breasts/get_sprite_size_string()
	var/max_size = 5
	if(genital_type == "pair")
		max_size = 16
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0 
	else if (current_size > max_size)
		current_size = max_size
	return current_size
