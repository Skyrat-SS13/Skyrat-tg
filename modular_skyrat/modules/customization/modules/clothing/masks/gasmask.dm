/obj/item/clothing/mask/gas/glass
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	name = "glass gas mask"
	desc = "A face-covering mask that can be connected to an air supply. This one doesn't obscure your face however."
	icon_state = "gas_clear"
	flags_inv = NONE

/obj/item/clothing/mask/gas/atmos/glass
	icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask.dmi'
	name = "advanced gas mask"
	desc = "A face-covering mask that can be connected to an air supply. This one doesn't obscure your face however."
	icon_state = "gas_clear"
	flags_inv = NONE

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

/obj/item/clothing/mask/gas/respirator/examine(mob/user)
	. = ..()
	. += span_notice("You can toggle its ability to muffle your TTS voice with <b>control click</b>.")

/obj/item/clothing/mask/gas/respirator/item_ctrl_click(mob/living/user)
	if(!isliving(user))
		return
	if(user.get_active_held_item() != src)
		to_chat(user, span_warning("You must hold the [src] in your hand to do this!"))
		return
	voice_filter = voice_filter ? null : initial(voice_filter)
	to_chat(user, span_notice("Mask voice muffling [voice_filter ? "enabled" : "disabled"]."))

/obj/item/clothing/mask/gas/clown_hat/vox
	desc = "A true prankster's facial attire. A clown is incomplete without his wig and mask. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_better_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	starting_filter_type = /obj/item/gas_filter/vox

/obj/item/clothing/mask/gas/clown_hat/vox/Initialize(mapload)
	.=..()
	clownmask_designs = list(
		"True Form" = image(icon = src.icon, icon_state = "clown"),
		"The Feminist" = image(icon = src.icon, icon_state = "sexyclown"),
		"The Wizard" = image(icon = src.icon, icon_state = "wizzclown"),
		"The Jester" = image(icon = src.icon, icon_state = "chaos"),
		"The Madman" = image(icon = src.icon, icon_state = "joker"),
		"The Rainbow Color" = image(icon = src.icon, icon_state = "rainbow")
		)

/obj/item/clothing/mask/gas/clown_hat/vox/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated())
		return

	var/list/options = list()
	options["True Form"] = "clown"
	options["The Feminist"] = "sexyclown"
	options["The Wizard"] = "wizzclown"
	options["The Madman"] = "joker"
	options["The Rainbow Color"] = "rainbow"
	options["The Jester"] = "chaos"

	var/choice = show_radial_menu(user,src, clownmask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated() && in_range(user,src))
		icon_state = options[choice]
		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(user, span_notice("Your Clown Mask has now morphed into [choice], all praise the Honkmother!"))
		return TRUE

/obj/item/clothing/mask/gas/mime/vox
	desc = "The traditional mime's mask. It has an eerie facial posture. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_better_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	starting_filter_type = /obj/item/gas_filter/vox

/obj/item/clothing/mask/gas/mime/vox/Initialize(mapload)
	.=..()
	mimemask_designs = list(
		"Blanc" = image(icon = src.icon, icon_state = "mime"),
		"Excité" = image(icon = src.icon, icon_state = "sexymime"),
		"Triste" = image(icon = src.icon, icon_state = "sadmime"),
		"Effrayé" = image(icon = src.icon, icon_state = "scaredmime")
		)

/obj/item/clothing/mask/gas/mime/vox/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated())
		return

	var/list/options = list()
	options["Blanc"] = "mime"
	options["Triste"] = "sadmime"
	options["Effrayé"] = "scaredmime"
	options["Excité"] = "sexymime"

	var/choice = show_radial_menu(user,src, mimemask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)
	if(!choice)
		return FALSE

	if(src && choice && !user.incapacitated() && in_range(user,src))
		var/mob/living/carbon/human/human_user = user
		if(human_user.dna.species.mutant_bodyparts["snout"])
			icon = 'modular_skyrat/master_files/icons/obj/clothing/masks.dmi'
			worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
			var/list/avian_snouts = list("Beak", "Big Beak", "Corvid Beak")
			if(human_user.dna.species.mutant_bodyparts["snout"][MUTANT_INDEX_NAME] in avian_snouts)
				icon_state = "[options[choice]]_b"
		else
			icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
			worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
			icon_state = options[choice]
		icon_state = options[choice]

		user.update_worn_mask()
		update_item_action_buttons()
		to_chat(user, span_notice("Your Mime Mask has now morphed into [choice]!"))
		return TRUE

/obj/item/clothing/mask/gas/atmos/vox
	desc = "Improved gas mask utilized by atmospheric technicians. It's flameproof! This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_better_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	starting_filter_type = /obj/item/gas_filter/vox

/obj/item/clothing/mask/gas/sechailer/vox
	desc = "A standard issue Security gas mask with integrated 'Compli-o-nator 3000' device. Plays over a dozen pre-recorded compliance phrases designed to get scumbags to stand still whilst you tase them. Do not tamper with the device. This one's got an easily accessible feeding port to be more suitable for the Vox crewmembers."
	icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	worn_icon_better_vox = 'modular_skyrat/master_files/icons/mob/clothing/species/vox/mask.dmi'
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS | GAS_FILTERING
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS | GAS_FILTERING
	starting_filter_type = /obj/item/gas_filter/vox
