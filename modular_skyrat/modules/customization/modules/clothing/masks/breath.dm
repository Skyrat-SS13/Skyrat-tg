/obj/item/clothing/mask/breath/vox
	desc = "A close-fitting mask that can be connected to an air supply. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	name = "vox breath mask"
	actions_types = list()
	flags_cover = NONE

/obj/item/clothing/mask/gas/glass
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	name = "glass gas mask"
	desc = "A face-covering mask that can be connected to an air supply. This one doesn't obscure your face however."
	icon_state = "gas_clear"
	flags_inv = HIDEEYES

/obj/item/clothing/mask/gas/alt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	icon_state = "gas_alt2"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'

/obj/item/clothing/mask/balaclavaadjust
	name = "adjustable balaclava"
	desc = "Wider eyed and made of an elastic based material, this one seems like it can contort more."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	w_class = WEIGHT_CLASS_SMALL
	var/open = 0 //0 = full, 1 = head only, 2 = face only

/obj/item/clothing/mask/balaclavaadjust/proc/adjust_mask(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(!user.incapacitated())
		switch(open)
			if (0)
				flags_inv = HIDEHAIR
				icon_state = initial(icon_state) + "_open"
				to_chat(user, "You put the balaclava away, revealing your face.")
				open = 1
			if (1)
				flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
				icon_state = initial(icon_state) + "_mouth"
				to_chat(user, "You adjust the balaclava up to cover your mouth.")
				open = 2
			else
				flags_inv = HIDEFACE|HIDEHAIR
				icon_state = initial(icon_state)
				to_chat(user, "You pull the balaclava up to cover your whole head.")
				open = 0
		user.update_body_parts()
		user.update_inv_ears(0)
		user.update_worn_mask() //Updates mob icons

/obj/item/clothing/mask/balaclavaadjust/attack_self(mob/user)
	adjust_mask(user)

/obj/item/clothing/mask/balaclavaadjust/verb/toggle()
		set category = "Object"
		set name = "Adjust Balaclava"
		set src in usr
		adjust_mask(usr)


/obj/item/clothing/mask/balaclava/threehole
	name = "three hole balaclava"
	desc = "Tiocfaidh ar la."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "balaclavam"
	inhand_icon_state = "balaclava"

/obj/item/clothing/mask/balaclava/threehole/green
	name = "three hole green balaclava"
	desc = "Tiocfaidh ar la."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "swatclavam"
	inhand_icon_state = "balaclava"

/obj/item/clothing/mask/gas/german
	name = "black gas mask"
	desc = "A black gas mask. Are you my Mummy?"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "m38_mask"

/obj/item/clothing/mask/gas/hecu1
	name = "modern gas mask"
	desc = "MY. ASS. IS. HEAVY."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "hecu"

/obj/item/clothing/mask/gas/hecu2
	name = "M40 gas mask"
	desc = "A deprecated field protective mask developed during the 20th century in Sol-3. It's designed to protect from chemical agents, biological agents, and nuclear fallout particles. It does not protect the user from ammonia or from lack of oxygen, though the filter can be replaced with a tube for any air tank."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "hecu2"

/obj/item/clothing/mask/gas/hecu2/mob_can_equip(mob/living/M, slot, disable_warning, bypass_equip_delay_self, ignore_equipped)
	if(is_species(M, /datum/species/teshari))
		to_chat(M, span_warning("[src] is far too big for you!"))
		return FALSE
	return ..()

/obj/item/clothing/mask/gas/soviet
	name = "soviet gas mask"
	desc = "A white gas mask with a green filter, there's a small sticker attached saying it's not got Asbestos anymore."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "gp5_mask"

/obj/item/clothing/mask/muzzle/ball
	name = "ballgag"
	desc = "I'm pretty fuckin far from okay."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "ballgag"

/obj/item/clothing/mask/muzzle/ring
	name = "ring gag"
	desc = "A mouth wrap seemingly designed to hold the mouth open."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "ringgag"

/obj/item/clothing/mask/gas/clown_colourable
	name = "colourable clown mask"
	desc = "The face of pure evil, now multicoloured."
	icon_state = "gags_mask"
	clothing_flags = MASKINTERNALS
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	species_exception = list(/datum/species/golem/bananium)
	has_fov = FALSE
	greyscale_config = /datum/greyscale_config/clown_mask
	greyscale_config_worn = /datum/greyscale_config/clown_mask/worn
	greyscale_colors = "#FFFFFF#F20018#0000FF#00CC00"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/mask/gas/clownbald
	name = "bald clown mask"
	desc = "HE'S BALD, HE'S FUCKIN' BALDIN!"
	clothing_flags = MASKINTERNALS
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "baldclown"
	inhand_icon_state = "clown_hat"
	flags_cover = MASKCOVERSEYES
	resistance_flags = FLAMMABLE
	species_exception = list(/datum/species/golem/bananium)

/obj/item/clothing/mask/gas/respirator
	name = "half mask respirator"
	desc = "A half mask respirator that's really just a standard gas mask with the glass taken off."
	icon = 'modular_skyrat/modules/GAGS/icons/masks.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/masks.dmi'
	icon_state = "respirator"
	inhand_icon_state = "sechailer"
	w_class = WEIGHT_CLASS_SMALL
	has_fov = FALSE
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACIALHAIR|HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#2E3333"
	greyscale_config = /datum/greyscale_config/respirator
	greyscale_config_worn = /datum/greyscale_config/respirator/worn
	//NIGHTMARE NIGHTMARE NIGHTMARE
	greyscale_config_worn_digi = /datum/greyscale_config/respirator/worn/snouted
	greyscale_config_worn_better_vox = /datum/greyscale_config/respirator/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/respirator/worn/vox
	greyscale_config_worn_teshari = /datum/greyscale_config/respirator/worn/teshari

/obj/item/clothing/mask/surgical/greyscale
	icon = 'modular_skyrat/modules/GAGS/icons/masks.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/masks.dmi'
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#AAE4DB"
	greyscale_config = /datum/greyscale_config/sterile_mask
	greyscale_config_worn = /datum/greyscale_config/sterile_mask/worn
	greyscale_config_worn_digi = /datum/greyscale_config/sterile_mask/worn/snouted
	greyscale_config_worn_better_vox = /datum/greyscale_config/sterile_mask/worn/better_vox
	greyscale_config_worn_vox = /datum/greyscale_config/sterile_mask/worn/vox
	greyscale_config_worn_teshari = /datum/greyscale_config/sterile_mask/worn/teshari
