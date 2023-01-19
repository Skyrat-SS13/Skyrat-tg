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
	worn_icon_teshari = 'modular_skyrat/master_files/icons/mob/clothing/species/teshari/mask.dmi'
	icon_state = "hecu2"

/obj/item/clothing/mask/gas/soviet
	name = "soviet gas mask"
	desc = "A white gas mask with a green filter, there's a small sticker attached saying it's not got Asbestos anymore."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	icon_state = "gp5_mask"

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
	inhand_icon_state = null
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

/obj/item/clothing/mask/gas/clown_hat/vox
	desc = "A true prankster's facial attire. A clown is incomplete without his wig and mask. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	starting_filter_type = /obj/item/gas_filter/vox
	
/obj/item/clothing/mask/gas/mime/vox
	desc = "The traditional mime's mask. It has an eerie facial posture. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	starting_filter_type = /obj/item/gas_filter/vox
	
/obj/item/clothing/mask/gas/atmos/vox
	desc = "Improved gas mask utilized by atmospheric technicians. It's flameproof! This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	starting_filter_type = /obj/item/gas_filter/vox

/obj/item/clothing/mask/gas/sechailer/vox
	desc = "A standard issue Security gas mask with integrated 'Compli-o-nator 3000' device. Plays over a dozen pre-recorded compliance phrases designed to get scumbags to stand still whilst you tase them. Do not tamper with the device. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS | GAS_FILTERING
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS | GAS_FILTERING
	starting_filter_type = /obj/item/gas_filter/vox
