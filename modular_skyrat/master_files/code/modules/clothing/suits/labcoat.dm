/obj/item/clothing/suit/toggle/labcoat
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/labcoat/Initialize(mapload)
	. = ..()
	allowed += list(/obj/item/flashlight, /obj/item/hypospray, /obj/item/storage/hypospraykit)

/obj/item/clothing/suit/toggle/labcoat/skyrat
	name = "SR LABCOAT SUIT DEBUG"
	desc = "REPORT THIS IF FOUND"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/labcoat.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/labcoat.dmi'
	icon_state = null //Keeps this from showing up under the chameleon hat

/obj/item/clothing/suit/toggle/labcoat/skyrat/rd
	name = "research directors labcoat"
	desc = "A Nanotrasen standard labcoat for certified Research Directors. It has an extra plastic-latex lining on the outside for more protection from chemical and viral hazards."
	icon_state = "labcoat_rd_w"
	gets_cropped_on_taurs = FALSE
	body_parts_covered = CHEST|ARMS|LEGS
	armor_type = /datum/armor/skyrat_rd

/datum/armor/skyrat_rd
	melee = 5
	bio = 80
	fire = 80
	acid = 70

/obj/item/clothing/suit/toggle/labcoat/skyrat/regular
	name = "researcher's labcoat"
	desc = "A Nanotrasen standard labcoat for researchers in the scientific field."
	icon_state = "labcoat_regular"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/skyrat/pharmacist
	name = "pharmacist's labcoat"
	desc = "A standard labcoat for chemistry which protects the wearer from acid spills."
	icon_state = "labcoat_pharm"
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/suit/toggle/labcoat/skyrat/highvis
	name = "high vis labcoat"
	desc = "A high visibility vest for emergency responders, intended to draw attention away from the blood."
	icon_state = "labcoat_highvis"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/toggle/labcoat/skyrat/highvis/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", src, alpha = src.alpha)

/obj/item/clothing/suit/toggle/labcoat/hospitalgown //Intended to keep patients modest while still allowing for surgeries
	name = "hospital gown"
	desc = "A complicated drapery with an assortment of velcros and strings, designed to keep a patient modest during medical stay and surgeries."
	icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_colors = "#478294#478294#478294#478294"
	toggle_noun = "drapes"
	body_parts_covered = NONE //Allows surgeries despite wearing it; hiding genitals is handled in /datum/sprite_accessory/genital/is_hidden() (Only place it'd work sadly)
	armor_type = /datum/armor/none
	equip_delay_other = 8

/obj/item/clothing/suit/toggle/labcoat/roboticist
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats
	greyscale_colors = "#2D2D33#88242D#88242D#88242D" //Overwrite the TG Roboticist labcoat to Black and Red (not the Interdyne labcoat though)

/obj/item/clothing/suit/toggle/labcoat/medical //Renamed version of the Genetics labcoat for more generic medical purposes; just a subtype of /labcoat/ for the TG files
	name = "medical labcoat"
	desc = "A suit that protects against minor chemical spills. Has a blue stripe on the shoulder."
	icon_state = "labcoat_job"
	greyscale_config = /datum/greyscale_config/labcoat
	greyscale_config_worn = /datum/greyscale_config/labcoat/worn
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats
	greyscale_colors = "#EEEEEE#4A77A1#4A77A1#7095C2"

/obj/item/clothing/suit/toggle/labcoat/science
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/coroner
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/virologist
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/genetics
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/chemist
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/interdyne
	greyscale_config_worn_teshari = /datum/greyscale_config/labcoat/worn/teshari //tacks teshari override onto labcoats

/obj/item/clothing/suit/toggle/labcoat/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/handheld_soulcatcher,
	)
